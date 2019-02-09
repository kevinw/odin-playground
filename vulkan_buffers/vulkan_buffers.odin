package vulkan_buffers

// Thanks to the Vulkan Tutorial "Drawing a triangle" at
// https://vulkan-tutorial.com/Drawing_a_triangle/

// TODO: @Perf investigate "dedicated allocation extension" for framebuffers

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:bits"

import vk "./vulkan_bindings"
import "./vk_util"
import "shared:odin-stb/stbi"

import "shared:odin-glfw"
import glfw_bindings "shared:odin-glfw/bindings"
import tinyobj "../tinyobjloader_c"

import "../path"

// not included in the GLFW bindings, interacts with vulkan types
@(default_calling_convention="c", link_prefix="glfw")
foreign {
    CreateWindowSurface :: proc "c" (instance:vk.Instance, window: glfw.Window_Handle, allocator: ^vk.Allocation_Callbacks, surface: ^vk.Surface_KHR) -> vk.Result ---;
}

when os.OS == "windows" {
    import "core:sys/win32"
    vulkan_hmodule: win32.Hmodule;
    exit :: proc (ret_code: int = -1) { win32.exit_process(cast(u32)ret_code); }
}


check_vk_success :: inline proc (res: vk.Result, message: string) {
    if res != vk.Result.Success do err_exit(message);
}

NUM_VIEWPORTS :: 1;
WINDOW_TITLE := "vulkan_buffers";
VALIDATION_LAYERS_ENABLED :: true;
MAX_FRAMES_IN_FLIGHT :: 2;
WIDTH :: 1280;
HEIGHT :: 720;
MODEL_PATH :: "vulkan_buffers/models/chalet.obj";
TEXTURE_PATH :: "vulkan_buffers/textures/chalet.jpg";

@(private)
LOGICAL_DEVICE_FEATURES := vk.Physical_Device_Features {
    sampler_anisotropy = true,
    multi_viewport = true,
};


Vertex :: struct #packed {
    // an example of "interleaving vertex attributes"
    pos: math.Vec3,
    color: math.Vec3,
    tex_coord: math.Vec2,
}

// java-ish hashing of float[]
Vertex_hash :: inline proc(a: ^Vertex) -> int {
    floats := mem.slice_ptr(cast(^f32)a, 8);
    h := 1;
    for i := 0; i < len(floats); i += 1 {
        float_as_int:int = (cast(^int)(&floats[i]))^;
        h = 31 * h + float_as_int;
    }
    h = h ~ ((h >> 20) ~ (h >> 12));
    return h ~ (h >> 7) ~ (h >> 4);
}

Vertex_eq :: inline proc(a: ^Vertex, b: ^Vertex) -> bool {
    return a.pos == b.pos && a.color == b.color && a.tex_coord == b.tex_coord;
}

Vertex_binding_description :: proc() -> vk.Vertex_Input_Binding_Description {
    return vk.Vertex_Input_Binding_Description {
        binding = 0,
        stride = size_of(Vertex),
        input_rate = vk.Vertex_Input_Rate.Vertex,
    };
}

Uniform_Buffer_Object :: struct #packed {
    model, view, proj: [NUM_VIEWPORTS]math.Mat4,
}

framebuffer_resize_callback :: proc "c" (window: glfw.Window_Handle, width, height: i32) {
    framebuffer_resized = true;
}

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}

vulkan_init_helper :: proc(resx := 1280, resy := 720, title := "Window title", samples := 0) -> glfw.Window_Handle {
    error_callback :: proc"c"(error: i32, desc: cstring) {
        fmt.printf_err("Error code %d: %s\n", error, desc);
    }
    glfw_bindings.SetErrorCallback(error_callback);

    if glfw_bindings.Init() == glfw_bindings.FALSE do return nil;

    if samples > 0 do glfw_bindings.WindowHint(glfw_bindings.SAMPLES, i32(samples));

    glfw_bindings.WindowHint(i32(glfw.CLIENT_API), i32(glfw.NO_API));
    glfw_bindings.WindowHint(i32(glfw.RESIZABLE), i32(glfw.TRUE));

    return glfw.create_window(int(resx), int(resy), title, nil, nil);
}

required_device_extensions := []cstring {
    "VK_KHR_swapchain",
};

create_shader_module :: proc(device: vk.Device, code: []u8) -> (vk.Result, vk.Shader_Module) {
    info: vk.Shader_Module_Create_Info = {
        s_type = vk.Structure_Type.Shader_Module_Create_Info,
        code_size = len(code),
        code = auto_cast &code[0],
    };

    shader_module: vk.Shader_Module;
    result := vk.create_shader_module(device, &info, nil, &shader_module);

    return result, shader_module;
}

is_device_suitable :: proc(device: vk.Physical_Device, surface: vk.Surface_KHR) -> bool {
    // return true if the device has all the required_device_extensions
    extension_count: u32 = ---;
    vk.enumerate_device_extension_properties(device, nil, &extension_count, nil);

    available_extensions := make([]vk.Extension_Properties, extension_count);
    defer delete(available_extensions);

    vk.enumerate_device_extension_properties(device, nil, &extension_count, mem.raw_data(available_extensions));

    for required_extension in required_device_extensions {
        found := false;
        for _, i in available_extensions {
            if required_extension == cstring(&available_extensions[i].extension_name[0]) do found = true;
        }
        if !found do return false;
    }

    support_details := query_swap_chain_support(device, surface);
    defer SwapChainSupportDetails_delete(&support_details);
    if len(support_details.formats) == 0 || len(support_details.present_modes) == 0 do return false;

    // make sure we have anisotropy
    supported_features: vk.Physical_Device_Features = ---;
    vk.get_physical_device_features(device, &supported_features);
    if !supported_features.sampler_anisotropy do return false;

    // make sure we have multiple viewports
    if !supported_features.multi_viewport do return false;

    return true;
}

SwapChainSupportDetails :: struct {
    capabilities: vk.Surface_Capabilities_KHR,
    formats: []vk.Surface_Format_KHR,
    present_modes: []vk.Present_Mode_KHR,
}

SwapChainSupportDetails_delete :: proc(using s: ^SwapChainSupportDetails) {
    delete(formats);
    delete(present_modes);
}

query_swap_chain_support :: proc(device: vk.Physical_Device, surface: vk.Surface_KHR) -> SwapChainSupportDetails {
    details: SwapChainSupportDetails;

    vk.get_physical_device_surface_capabilities_khr(device, surface, &details.capabilities);

    format_count: u32 = ---;
    vk.get_physical_device_surface_formats_khr(device, surface, &format_count, nil);
    if format_count != 0 {
        details.formats = make([]vk.Surface_Format_KHR, int(format_count));
        vk.get_physical_device_surface_formats_khr(device, surface, &format_count, mem.raw_data(details.formats));
    }

    present_mode_count: u32 = ---;
    vk.get_physical_device_surface_present_modes_khr(device, surface, &present_mode_count, nil);
    if present_mode_count != 0 {
        details.present_modes = make([]vk.Present_Mode_KHR, int(present_mode_count));
        vk.get_physical_device_surface_present_modes_khr(device, surface, &present_mode_count, mem.raw_data(details.present_modes));
    }

    return details;
}

choose_swap_present_mode :: proc(available_present_modes: []vk.Present_Mode_KHR) -> vk.Present_Mode_KHR  {
    best_mode := vk.Present_Mode_KHR.Fifo;

    for mode in available_present_modes {
        if mode == vk.Present_Mode_KHR.Mailbox do return mode; // triple buffering
        else if mode == vk.Present_Mode_KHR.Immediate do best_mode = mode;
    }

    return best_mode;
}

choose_swap_extent :: proc(window: glfw.Window_Handle, capabilities: ^vk.Surface_Capabilities_KHR) -> vk.Extent2D {
    if capabilities.current_extent.width != bits.U32_MAX do return capabilities.current_extent;

    width, height := glfw.get_framebuffer_size(window);
    assert(width >= 0 && height >= 0);

    actual_extent := vk.Extent2D { u32(width), u32(height) };

    return vk.Extent2D {
        max(capabilities.min_image_extent.width, min(capabilities.max_image_extent.width, actual_extent.width)),
        max(capabilities.min_image_extent.height, min(capabilities.max_image_extent.height, actual_extent.height))
    };
}

choose_swap_surface_format :: proc(available_formats: []vk.Surface_Format_KHR) -> vk.Surface_Format_KHR {
    // See if our preferred format is here.
    for available_format in available_formats {
        if available_format.format == vk.Format.B8G8R8A8_Unorm && available_format.color_space == vk.Color_Space_KHR.Srgb_Nonlinear {
            return vk.Surface_Format_KHR { vk.Format.B8G8R8A8_Unorm, vk.Color_Space_KHR.Srgb_Nonlinear };
        }
    }

    return available_formats[0];
}

err_exit :: inline proc(message: string, return_code:int = -1) -> int {
    fmt.println_err("Error:", message);
    exit(return_code);
    return -1;
}


// TODO: expand into a series of structs
device: vk.Device;
swapchain: vk.Swapchain_KHR;
physical_device: vk.Physical_Device;
surface: vk.Surface_KHR;
graphics_family_index: u32;
present_family_index: u32;
graphics_queue: vk.Queue;
present_queue: vk.Queue;
command_pool : vk.Command_Pool;
command_buffers: []vk.Command_Buffer;
render_pass : vk.Render_Pass;
swapchain_images: []vk.Image;
swapchain_framebuffers: []vk.Framebuffer;
swapchain_imageviews: []vk.Image_View;
swapchain_image_format: vk.Format;
swapchain_extent: vk.Extent2D;
graphics_pipeline : vk.Pipeline;

depth_image: vk.Image;
depth_image_memory: vk.Device_Memory;
depth_image_view: vk.Image_View;

pipeline_layout : vk.Pipeline_Layout;
framebuffer_resized := false;
vertex_buffer: vk.Buffer;
vertex_buffer_memory: vk.Device_Memory;
index_buffer: vk.Buffer;
index_buffer_memory: vk.Device_Memory;
uniform_buffers: []vk.Buffer;
uniform_buffers_memory: []vk.Device_Memory;

descriptor_set_layout: vk.Descriptor_Set_Layout;
descriptor_pool: vk.Descriptor_Pool;
descriptor_sets: []vk.Descriptor_Set;

mip_levels: u32;
texture_image: vk.Image;
texture_image_memory: vk.Device_Memory;
texture_image_view: vk.Image_View;
texture_sampler: vk.Sampler;

vertices : [dynamic]Vertex;
indices : []u32;

msaa_samples : vk.Sample_Count_Flag;
max_push_constants_size: u32;

color_image: vk.Image;
color_image_memory: vk.Device_Memory;
color_image_view: vk.Image_View;

cleanup_swapchain :: proc() {
    vk.destroy_image_view(device, color_image_view, nil);
    vk.destroy_image(device, color_image, nil);
    vk.free_memory(device, color_image_memory, nil);

    vk.destroy_image_view(device, depth_image_view, nil);
    vk.destroy_image(device, depth_image, nil);
    vk.free_memory(device, depth_image_memory, nil);

    for framebuffer in swapchain_framebuffers {
        vk.destroy_framebuffer(device, framebuffer, nil);
    }

    if len(command_buffers) > 0 {
        vk.free_command_buffers(device, command_pool, u32(len(command_buffers)), &command_buffers[0]);
    }

    vk.destroy_pipeline(device, graphics_pipeline, nil);
    vk.destroy_pipeline_layout(device, pipeline_layout, nil);
    vk.destroy_render_pass(device, render_pass, nil);
    for imageview in swapchain_imageviews {
        vk.destroy_image_view(device, imageview, nil);
    }

    vk.destroy_swapchain_khr(device, swapchain, nil);
}

recreate_swapchain :: proc(window: glfw.Window_Handle, first_run:bool = false) {
    {
        width, height: int;
        for {
            if width > 0 && height > 0 do break;

            width, height = glfw.get_framebuffer_size(window);

            glfw.wait_events();
        }
    }

    vk.device_wait_idle(device);

    cleanup_swapchain();

    // Create swap chain
    {
        swap_chain_support := query_swap_chain_support(physical_device, surface);
        using swap_chain_support;

        defer SwapChainSupportDetails_delete(&swap_chain_support);

        surface_format := choose_swap_surface_format(formats);
        present_mode := choose_swap_present_mode(present_modes);

        swapchain_extent = choose_swap_extent(window, &capabilities);

        image_count := capabilities.min_image_count + 1;
        if capabilities.max_image_count > 0 && image_count > capabilities.max_image_count { // zero means no limit
            image_count = capabilities.max_image_count;
        }

        swapchain_image_format = surface_format.format;

        swapchain_create_info := vk.Swapchain_Create_Info_KHR {
            s_type = vk.Structure_Type.Swapchain_Create_Info_KHR,
            surface = surface,
            min_image_count = image_count,
            image_format = surface_format.format,
            image_color_space = surface_format.color_space,
            image_extent = swapchain_extent,
            image_array_layers = 1, // TODO: STEREOSCOPIC or MULTIVIEW HERE
            image_usage = {vk.Image_Usage_Flag.Color_Attachment},

            pre_transform = capabilities.current_transform,
            composite_alpha = {vk.Composite_Alpha_Flags_KHR.Opaque},
            present_mode = present_mode,
            clipped = true,
            old_swapchain = nil,
        };

        if graphics_family_index != present_family_index {
            queue_family_indices := [2]u32 {graphics_family_index, present_family_index};

            swapchain_create_info.image_sharing_mode = vk.Sharing_Mode.Concurrent;
            swapchain_create_info.queue_family_index_count = 2;
            swapchain_create_info.queue_family_indices = &queue_family_indices[0];
        } else {
            swapchain_create_info.image_sharing_mode = vk.Sharing_Mode.Exclusive;
            swapchain_create_info.queue_family_index_count = 0;
            swapchain_create_info.queue_family_indices = nil;
        }

        check_vk_success(vk.create_swapchain_khr(device, &swapchain_create_info, nil, &swapchain),
            "Failed to create swap chain.");
    }

    // retrieve swapchain images
    {
        image_count: u32 = ---;
        vk.get_swapchain_images_khr(device, swapchain, &image_count, nil);
        swapchain_images = make([]vk.Image, image_count);
        defer delete(swapchain_images);
        vk.get_swapchain_images_khr(device, swapchain, &image_count, mem.raw_data(swapchain_images));

        // create image views
        {
            swapchain_imageviews = make([]vk.Image_View, len(swapchain_images));
            for _, i in swapchain_images {
                swapchain_imageviews[i] = vk_util.create_image_view(device, swapchain_images[i], swapchain_image_format, {vk.Image_Aspect_Flag.Color}, 1);
                /* TODO: If you were working on a stereographic 3D
                * application, then you would create a swap chain with
                * multiple layers. You could then create multiple image
                * views for each image representing the views for the left
                * and right eyes by accessing different layers.
                */
            }
        }
    }

    // create render pass
    {
        dependency := vk.Subpass_Dependency {
            src_subpass = vk.SUBPASS_EXTERNAL,
            dst_subpass = 0,
            src_stage_mask = {vk.Pipeline_Stage_Flag.Color_Attachment_Output},
            src_access_mask = {},

            dst_stage_mask = {vk.Pipeline_Stage_Flag.Color_Attachment_Output},
            dst_access_mask = {vk.Access_Flag.Color_Attachment_Read, vk.Access_Flag.Color_Attachment_Write},

        };

        color_attachment := vk.Attachment_Description {
            format = swapchain_image_format,
            samples = {msaa_samples},

            load_op = vk.Attachment_Load_Op.Clear,
            store_op = vk.Attachment_Store_Op.Store,
            stencil_load_op = vk.Attachment_Load_Op.Dont_Care,
            stencil_store_op = vk.Attachment_Store_Op.Dont_Care,
            initial_layout = vk.Image_Layout.Undefined,
            final_layout = vk.Image_Layout.Color_Attachment_Optimal,
        };

        // subpasses
        color_attachment_ref := vk.Attachment_Reference {
            attachment = 0, // layout(location = 0) out vec4 outColor 
            layout = vk.Image_Layout.Color_Attachment_Optimal,
        };

        depth_attachment := vk.Attachment_Description {
            format = vk_util.find_depth_format(physical_device),
            samples = {msaa_samples},
            load_op = vk.Attachment_Load_Op.Clear,
            store_op = vk.Attachment_Store_Op.Dont_Care, // depth won't be read after drawing is finished, may allow additional optimizations
            stencil_load_op = vk.Attachment_Load_Op.Dont_Care,
            stencil_store_op = vk.Attachment_Store_Op.Dont_Care,
            initial_layout = vk.Image_Layout.Undefined,
            final_layout = vk.Image_Layout.Depth_Stencil_Attachment_Optimal,
        };

        depth_attachment_ref := vk.Attachment_Reference {
            attachment = 1,
            layout = vk.Image_Layout.Depth_Stencil_Attachment_Optimal,
        };

        color_attachment_resolve := vk.Attachment_Description {
            format = swapchain_image_format,
            samples = {vk.Sample_Count_Flag._1},
            load_op = vk.Attachment_Load_Op.Dont_Care,
            store_op = vk.Attachment_Store_Op.Store,
            stencil_load_op = vk.Attachment_Load_Op.Dont_Care,
            stencil_store_op = vk.Attachment_Store_Op.Dont_Care,
            initial_layout = vk.Image_Layout.Undefined,
            final_layout = vk.Image_Layout.Present_Src_KHR,
        };

        color_attachment_resolve_ref := vk.Attachment_Reference {
            attachment = 2,
            layout = vk.Image_Layout.Color_Attachment_Optimal,
        };

        subpass := vk.Subpass_Description {
            pipeline_bind_point = vk.Pipeline_Bind_Point.Graphics,
            color_attachment_count = 1,
            color_attachments = &color_attachment_ref,
            depth_stencil_attachment = &depth_attachment_ref,
            resolve_attachments = &color_attachment_resolve_ref,
            //input_attachments
            //preserve_attachments
        };

        attachments := [3]vk.Attachment_Description {
            color_attachment, depth_attachment, color_attachment_resolve };

        render_pass_info := vk.Render_Pass_Create_Info {
            s_type = vk.Structure_Type.Render_Pass_Create_Info,
            attachment_count = len(attachments),
            attachments = &attachments[0],
            subpass_count = 1,
            subpasses = &subpass,
            dependency_count = 1,
            dependencies = &dependency,
        };

        check_vk_success(vk.create_render_pass(device, &render_pass_info, nil, &render_pass),
            "Failed to create render pass.");
    }

    // create uniform buffers
    if (first_run) {
        uniform_buffers = make([]vk.Buffer, len(swapchain_images));
        uniform_buffers_memory = make([]vk.Device_Memory, len(swapchain_images));

        for _, i in swapchain_images {
            create_buffer(
                size_of(Uniform_Buffer_Object),
                {vk.Buffer_Usage_Flag.Uniform_Buffer},
                {vk.Memory_Property_Flag.Host_Visible, vk.Memory_Property_Flag.Host_Coherent},
                &uniform_buffers[i],
                &uniform_buffers_memory[i]);
        }
    }

    if (first_run) {
        // create descriptor set layout
        ubo_layout_binding := vk.Descriptor_Set_Layout_Binding {
            binding = 0,
            descriptor_type = vk.Descriptor_Type.Uniform_Buffer,
            descriptor_count = 1,
            stage_flags = {vk.Shader_Stage_Flag.Vertex},
        };

        
        // create sampler descriptor set layout
        sampler_layout_binding := vk.Descriptor_Set_Layout_Binding {
            binding = 1,
            descriptor_count = 1,
            descriptor_type = vk.Descriptor_Type.Combined_Image_Sampler,
            immutable_samplers = nil,
            stage_flags = {vk.Shader_Stage_Flag.Fragment},
        };

        bindings : []vk.Descriptor_Set_Layout_Binding = {ubo_layout_binding, sampler_layout_binding};
        assert(len(bindings) == 2);

        layout_info := vk.Descriptor_Set_Layout_Create_Info {
            s_type = vk.Structure_Type.Descriptor_Set_Layout_Create_Info,
            binding_count = u32(len(bindings)),
            bindings = &bindings[0],
        };

        check_vk_success(vk.create_descriptor_set_layout(device, &layout_info, nil, &descriptor_set_layout),
            "Failed to create descriptor set layout.");
    }

    // create descriptor pool and sets
    if (first_run) {
        num_swapchain_images := u32(len(swapchain_images));

        pool_sizes : [2]vk.Descriptor_Pool_Size;
        assert(len(pool_sizes) == 2);

        pool_sizes[0].type = vk.Descriptor_Type.Uniform_Buffer;
        pool_sizes[0].descriptor_count = num_swapchain_images;

        pool_sizes[1].type = vk.Descriptor_Type.Combined_Image_Sampler;
        pool_sizes[1].descriptor_count = num_swapchain_images;

        pool_info := vk.Descriptor_Pool_Create_Info {
            s_type = vk.Structure_Type.Descriptor_Pool_Create_Info,
            pool_size_count = len(pool_sizes),
            pool_sizes = &pool_sizes[0],
            max_sets = num_swapchain_images,
        };
        check_vk_success(vk.create_descriptor_pool(device, &pool_info, nil, &descriptor_pool),
            "Failed to create descriptor pool.");

        layouts := make([]vk.Descriptor_Set_Layout, num_swapchain_images);
        defer delete(layouts);
        for i := u32(0); i < num_swapchain_images; i += 1 {
            layouts[i] = descriptor_set_layout;
        }

        alloc_info := vk.Descriptor_Set_Allocate_Info {
            s_type = vk.Structure_Type.Descriptor_Set_Allocate_Info,
            descriptor_pool = descriptor_pool,
            descriptor_set_count = num_swapchain_images,
            set_layouts = &layouts[0],
        };

        descriptor_sets = make([]vk.Descriptor_Set, num_swapchain_images);
        check_vk_success(vk.allocate_descriptor_sets(device, &alloc_info, &descriptor_sets[0]),
            "Failed to allocate descriptor sets.");

        for i := u32(0); i < num_swapchain_images; i += 1 {
            buffer_info := vk.Descriptor_Buffer_Info {
                buffer = uniform_buffers[i],
                offset = 0,
                range = size_of(Uniform_Buffer_Object),
            };

            image_info := vk.Descriptor_Image_Info {
                image_layout = vk.Image_Layout.Shader_Read_Only_Optimal,
                image_view = texture_image_view,
                sampler = texture_sampler,
            };

            descriptor_writes : [2]vk.Write_Descriptor_Set;

            descriptor_writes[0] = vk.Write_Descriptor_Set {
                s_type = vk.Structure_Type.Write_Descriptor_Set,
                dst_set = descriptor_sets[i],
                dst_binding = 0,
                dst_array_element = 0,
                descriptor_type = vk.Descriptor_Type.Uniform_Buffer,
                descriptor_count = 1,
                buffer_info = &buffer_info,
                image_info = nil,
                texel_buffer_view = nil,
            };

            descriptor_writes[1] = vk.Write_Descriptor_Set {
                s_type = vk.Structure_Type.Write_Descriptor_Set,
                dst_set = descriptor_sets[i],
                dst_binding = 1,
                dst_array_element = 0,
                descriptor_type = vk.Descriptor_Type.Combined_Image_Sampler,
                descriptor_count = 1,
                image_info = &image_info
            };

            vk.update_descriptor_sets(device, u32(len(descriptor_writes)), &descriptor_writes[0], 0, nil);
        }
    }

    // create graphics pipeline
    {
        vert_filename := fmt.tprint(path.dir_name(#file), "/shaders/shader.vert.spv");
        frag_filename := fmt.tprint(path.dir_name(#file), "/shaders/shader.frag.spv");

        vert_shader_code, success1 := os.read_entire_file(vert_filename);
        if !success1 do err_exit("Could not read vertex shader");

        frag_shader_code, success2 := os.read_entire_file(frag_filename);
        if !success2 do err_exit("Error: Could not fragment shader");

        success3, vert_shader_module := create_shader_module(device, vert_shader_code);
        check_vk_success(success3, "Could not create a shader module for the vertex shader.");
        defer vk.destroy_shader_module(device, vert_shader_module, nil);

        res4, frag_shader_module := create_shader_module(device, frag_shader_code);
        check_vk_success(res4, "Could not create a shader module for the fragment shader.");
        defer vk.destroy_shader_module(device, frag_shader_module, nil);

        vert_shader_stage_info := vk.Pipeline_Shader_Stage_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Shader_Stage_Create_Info,
            stage = {vk.Shader_Stage_Flag.Vertex},
            module = vert_shader_module,
            name = "main",
            specialization_info = nil, // TODO: use this to make shader variants
        };

        frag_shader_stage_info := vk.Pipeline_Shader_Stage_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Shader_Stage_Create_Info,
            stage = {vk.Shader_Stage_Flag.Fragment},
            module = frag_shader_module,
            name = "main",
        };

        shader_stages := []vk.Pipeline_Shader_Stage_Create_Info { vert_shader_stage_info, frag_shader_stage_info, };

        binding_description := Vertex_binding_description();

        attribute_descriptions := [3]vk.Vertex_Input_Attribute_Description {
            {
                binding = 0,
                location = 0,
                format = vk.Format.R32G32B32_Sfloat,
                offset = cast(u32)offset_of(Vertex, pos),
            },
            {
                binding = 0,
                location = 1,
                format = vk.Format.R32G32B32_Sfloat,
                offset = cast(u32)offset_of(Vertex, color),
            },
            {
                binding = 0,
                location = 2,
                format = vk.Format.R32G32_Sfloat,
                offset = cast(u32)offset_of(Vertex, tex_coord),
            },
        };

        vertex_input_info := vk.Pipeline_Vertex_Input_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Vertex_Input_State_Create_Info,
            vertex_binding_description_count = 1,
            vertex_binding_descriptions = &binding_description,
            vertex_attribute_description_count = len(attribute_descriptions),
            vertex_attribute_descriptions = &attribute_descriptions[0],
        };

        input_assembly := vk.Pipeline_Input_Assembly_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Input_Assembly_State_Create_Info,
            topology = vk.Primitive_Topology.Triangle_List,
            primitive_restart_enable = false,
        };

        viewport := vk.Viewport {
            x=0, y=0, width=f32(swapchain_extent.width), height=f32(swapchain_extent.height),
            min_depth = 0, max_depth = 1};

        scissor := vk.Rect2D { offset = {0, 0}, extent = swapchain_extent, };

        viewport_state := vk.Pipeline_Viewport_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Viewport_State_Create_Info,
            viewport_count = 1,
            viewports = &viewport,
            scissor_count = 1,
            scissors = &scissor,
        };

        rasterizer := vk.Pipeline_Rasterization_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Rasterization_State_Create_Info,
            depth_clamp_enable = false, // clamp fragments to near and far planes (requires a gpu feature enabled)
            rasterizer_discard_enable = false,
            polygon_mode = vk.Polygon_Mode.Fill,
            //polygon_mode = vk.Polygon_Mode.Line, // requires gpu feature
            //polygon_mode = vk.Polygon_Mode.Point, // requires gpu feature
            line_width = 1,
            cull_mode = {vk.Cull_Mode_Flag.Back},
            front_face = vk.Front_Face.Counter_Clockwise,

            depth_bias_enable = false,
            depth_bias_constant_factor = 0, //optional
            depth_bias_clamp = 0, //optional
            depth_bias_slope_factor = 0, //optional
        };

        multisampling := vk.Pipeline_Multisample_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Multisample_State_Create_Info,
            sample_shading_enable = false,
            rasterization_samples = {msaa_samples},
            min_sample_shading = 1,
            sample_mask = nil,
            alpha_to_coverage_enable = false,
            alpha_to_one_enable = false,
        };

        color_blend_attachment := vk.Pipeline_Color_Blend_Attachment_State {
            color_write_mask = { vk.Color_Component_Flag.R, vk.Color_Component_Flag.G, vk.Color_Component_Flag.B, vk.Color_Component_Flag.A },
            blend_enable = false,

            src_color_blend_factor = vk.Blend_Factor.One,
            dst_color_blend_factor = vk.Blend_Factor.Zero,

            color_blend_op = vk.Blend_Op.Add,

            src_alpha_blend_factor = vk.Blend_Factor.One,
            dst_alpha_blend_factor = vk.Blend_Factor.Zero,

            alpha_blend_op = vk.Blend_Op.Add,
        };
        /*
        ^^^^^^^ equivalent to
        if (blendEnable) {
            finalColor.rgb = (srcColorBlendFactor * newColor.rgb) <colorBlendOp> (dstColorBlendFactor * oldColor.rgb);
            finalColor.a = (srcAlphaBlendFactor * newColor.a) <alphaBlendOp> (dstAlphaBlendFactor * oldColor.a);
        } else {
            finalColor = newColor;
        }
        finalColor &= colorWriteMask;
        */

        color_blending := vk.Pipeline_Color_Blend_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Color_Blend_State_Create_Info,
            logic_op_enable = false,
            logic_op = vk.Logic_Op.Copy, // optional
            attachment_count = 1,
            attachments = &color_blend_attachment,
            blend_constants = {0, 0, 0, 0}, // optional
        };

        dynamic_states := [2]vk.Dynamic_State {
            vk.Dynamic_State.Viewport,
            vk.Dynamic_State.Scissor,
        };

        dynamic_state := vk.Pipeline_Dynamic_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Dynamic_State_Create_Info,
            dynamic_state_count = u32(len(dynamic_states)),
            dynamic_states = &dynamic_states[0],
        };

        /*
        push_constant_range := vk.Push_Constant_Range {
            stage_flags = {vk.Shader_Stage_Flag.Vertex},
            offset := 0,
            size := 0,
        };
        */

        pipeline_layout_info := vk.Pipeline_Layout_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Layout_Create_Info,
            set_layout_count = 1,
            set_layouts = &descriptor_set_layout,
            push_constant_range_count = 0, //optional
            push_constant_ranges = nil, // optional
        };


        check_vk_success(vk.create_pipeline_layout(device, &pipeline_layout_info, nil, &pipeline_layout),
            "Failed to create pipeline layout.");

        depth_stencil := vk.Pipeline_Depth_Stencil_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Depth_Stencil_State_Create_Info,
            depth_test_enable = true,
            depth_write_enable = true,
            depth_compare_op = vk.Compare_Op.Less, // lower depth = closer, so depth of new fragments should be LESS
            depth_bounds_test_enable = false,
            min_depth_bounds = 0, // optional
            max_depth_bounds = 1, // optional

            stencil_test_enable = false,
            front = {}, //optional
            back = {}, //optional
        };

        graphics_pipeline_info := vk.Graphics_Pipeline_Create_Info {
            s_type = vk.Structure_Type.Graphics_Pipeline_Create_Info,
            stage_count = 2,
            stages = &shader_stages[0],

            vertex_input_state = &vertex_input_info,
            input_assembly_state = &input_assembly,

            viewport_state = &viewport_state,
            rasterization_state = &rasterizer,
            multisample_state = &multisampling,
            depth_stencil_state = &depth_stencil,
            color_blend_state = &color_blending,
            dynamic_state = &dynamic_state, // optional
            layout = pipeline_layout,
            render_pass = render_pass,
            subpass = 0,
            base_pipeline_handle = nil, //optional
            base_pipeline_index = -1, //optional
        };

        check_vk_success(vk.create_graphics_pipelines(device, nil, 1, &graphics_pipeline_info, nil, &graphics_pipeline),
            "Failed to create graphics pipeline.");
    }

    // create color resources
    {
        color_format: vk.Format = swapchain_image_format;
        vk_util.create_image(
            device, physical_device,
            swapchain_extent.width, swapchain_extent.height, 1,
            msaa_samples, color_format,
            vk.Image_Tiling.Optimal,
            {vk.Image_Usage_Flag.Transient_Attachment, vk.Image_Usage_Flag.Color_Attachment},
            {vk.Memory_Property_Flag.Device_Local},
            &color_image,
            &color_image_memory);

        color_image_view = vk_util.create_image_view(
            device, color_image, color_format,
            {vk.Image_Aspect_Flag.Color}, 1);

        transition_image_layout(color_image, color_format, vk.Image_Layout.Undefined, vk.Image_Layout.Color_Attachment_Optimal, 1);
    }

    
    // create depth resources
    {
        depth_format := vk_util.find_depth_format(physical_device);
        vk_util.create_image(device, physical_device, swapchain_extent.width, swapchain_extent.height, 1,
            msaa_samples,
            depth_format,
            vk.Image_Tiling.Optimal,
            {vk.Image_Usage_Flag.Depth_Stencil_Attachment},
            {vk.Memory_Property_Flag.Device_Local},
            &depth_image,
            &depth_image_memory);

        depth_image_view = vk_util.create_image_view(device, depth_image, depth_format, {vk.Image_Aspect_Flag.Depth}, 1);
        transition_image_layout(depth_image, depth_format, vk.Image_Layout.Undefined, vk.Image_Layout.Depth_Stencil_Attachment_Optimal, 1);
    }

    // create framebuffers
    {
        swapchain_framebuffers = make([]vk.Framebuffer, len(swapchain_imageviews));
        for i := 0; i < len(swapchain_imageviews); i += 1 {
            // The color attachment differs for every swap chain image, but the
            // same depth image can be used by all of them because only a
            // single subpass is running at the same time due to our
            // semaphores.
            attachments := [3]vk.Image_View {
                color_image_view,
                depth_image_view,
                swapchain_imageviews[i],
            };

            framebuffer_info := vk.Framebuffer_Create_Info {
                s_type = vk.Structure_Type.Framebuffer_Create_Info,
                render_pass = render_pass,
                attachment_count = len(attachments),
                attachments = &attachments[0],
                width = swapchain_extent.width,
                height = swapchain_extent.height,
                layers = 1, // number of images in image arrays
            };

            check_vk_success(vk.create_framebuffer(device, &framebuffer_info, nil, &swapchain_framebuffers[i]),
                "Failed to create framebuffer.");
        }
    }

    // create command buffers
    {
        command_buffers = make([]vk.Command_Buffer, len(swapchain_framebuffers));

        alloc_info := vk.Command_Buffer_Allocate_Info {
            s_type = vk.Structure_Type.Command_Buffer_Allocate_Info,
            command_pool = command_pool,
            level = vk.Command_Buffer_Level.Primary,
            command_buffer_count = u32(len(command_buffers)),
        };

        check_vk_success(vk.allocate_command_buffers(device, &alloc_info, &command_buffers[0]), "Failed to allocate command buffers.");
    }

    // start command buffer recording
    {
        for command_buffer, i in command_buffers {
            begin_info := vk.Command_Buffer_Begin_Info {
                s_type = vk.Structure_Type.Command_Buffer_Begin_Info,
                flags = {vk.Command_Buffer_Usage_Flag.Simultaneous_Use},
                inheritance_info = nil, // optional for secondary command buffers
            };
            check_vk_success(vk.begin_command_buffer(command_buffer, &begin_info),
                "Failed to begin recording command buffer");
            defer check_vk_success(vk.end_command_buffer(command_buffer), "Failed to record command buffer.");

            // TODO: when odin's raw_union support is fixed, just use vk.Clear_Value here.
            // see https://gist.github.com/kevinw/122fb7d711ecfde75661e5d7b67d523e
            Clear_Value_Fix :: struct { r, g, b, a: f32 } // for depth buffers, {r=Depth, g=Stencil}
            clear_values : [2]Clear_Value_Fix; // len has to match number of framebuffer attachments
            clear_values[0] = {0, 0, 0, 1};
            clear_values[1] = {1, 0, 0, 0};

            render_pass_info := vk.Render_Pass_Begin_Info {
                s_type = vk.Structure_Type.Render_Pass_Begin_Info,
                render_pass = render_pass,
                framebuffer = swapchain_framebuffers[i],
                render_area = {
                    offset = {0, 0}, // @Perf: should match attachment sizes for best performance
                    extent = swapchain_extent,
                },
                clear_value_count = u32(len(clear_values)),
                clear_values = cast(^vk.Clear_Value)(&clear_values[0]),
            };

            // Draw the triangle
            vk.cmd_begin_render_pass(command_buffer, &render_pass_info, vk.Subpass_Contents.Inline);
            defer vk.cmd_end_render_pass(command_buffer);

            // Setup viewport/scissor
            w, h := cast(f32)swapchain_extent.width, cast(f32)swapchain_extent.height;
            viewport_width: f32 = w / cast(f32)NUM_VIEWPORTS;
            viewports := [NUM_VIEWPORTS]vk.Viewport {
                { 0, 0, viewport_width, h, 0, 1 },
                //{ 0, 0, viewport_width, h, 0, 1 },
            };
            scissors := [NUM_VIEWPORTS]vk.Rect2D {
                { offset = {i32(0 * viewport_width), 0}, extent = {cast(u32)viewport_width, swapchain_extent.height} },
                //{ offset = {i32(1 * viewport_width), 0}, extent = {cast(u32)viewport_width, swapchain_extent.height}, },
            };
            vk.cmd_set_viewport(command_buffer, 0, NUM_VIEWPORTS, &viewports[0]);
            vk.cmd_set_scissor(command_buffer, 0, NUM_VIEWPORTS, &scissors[0]);

            vk.cmd_bind_pipeline(command_buffer, vk.Pipeline_Bind_Point.Graphics, graphics_pipeline);

            {
                vertex_buffers := [1]vk.Buffer { vertex_buffer };
                offsets := [1]vk.Device_Size {0};
                vk.cmd_bind_vertex_buffers(command_buffer, 0, 1, &vertex_buffers[0], &offsets[0]);
                vk.cmd_bind_index_buffer(command_buffer, index_buffer, 0, vk.Index_Type.Uint32); // TODO: make a compile-time func to select Uint32 or Uint16
            }

            vk.cmd_bind_descriptor_sets(command_buffer, vk.Pipeline_Bind_Point.Graphics, pipeline_layout, 0, 1, &descriptor_sets[i], 0, nil);
            vk.cmd_draw_indexed(command_buffer, u32(len(indices)), 1, 0, 0, 0);
        }
    }

}

create_buffer :: proc(
    size: vk.Device_Size,
    usage: vk.Buffer_Usage_Flags,
    properties: vk.Memory_Property_Flags,
    buffer: ^vk.Buffer,
    buffer_memory: ^vk.Device_Memory,
)
{
    buffer_info := vk.Buffer_Create_Info {
        s_type = vk.Structure_Type.Buffer_Create_Info,
        size = size,
        usage = usage,
        sharing_mode = vk.Sharing_Mode.Exclusive,
    };
    check_vk_success(vk.create_buffer(device, &buffer_info, nil, buffer),
        "Failed to create vertex buffer.");

    mem_requirements: vk.Memory_Requirements = ---;
    vk.get_buffer_memory_requirements(device, buffer^, &mem_requirements);

    alloc_info := vk.Memory_Allocate_Info {
        s_type = vk.Structure_Type.Memory_Allocate_Info,
        allocation_size = mem_requirements.size,
        memory_type_index = vk_util.find_memory_type(physical_device, mem_requirements.memory_type_bits, properties),
    };

    check_vk_success(vk.allocate_memory(device, &alloc_info, nil, buffer_memory),
        "Failed to allocate vertex buffer memory.");

    vk.bind_buffer_memory(device, buffer^, buffer_memory^, 0);
}

begin_single_time_commands :: proc() -> vk.Command_Buffer {
    // TODO: create a separate command pool for short-lived command buffers
    // like this one, and use VK_COMMAND_POOL_CREATE_TRANSIENT_BIT

    alloc_info := vk.Command_Buffer_Allocate_Info {
        s_type = vk.Structure_Type.Command_Buffer_Allocate_Info,
        level = vk.Command_Buffer_Level.Primary,
        command_pool = command_pool,
        command_buffer_count = 1,
    };

    command_buffer: vk.Command_Buffer;
    vk.allocate_command_buffers(device, &alloc_info, &command_buffer);

    begin_info := vk.Command_Buffer_Begin_Info {
        s_type = vk.Structure_Type.Command_Buffer_Begin_Info,
        flags = {vk.Command_Buffer_Usage_Flag.One_Time_Submit},
    };

    vk.begin_command_buffer(command_buffer, &begin_info);

    return command_buffer;
}

end_single_time_commands_and_wait :: proc(command_buffer: vk.Command_Buffer) {
    vk.end_command_buffer(command_buffer);

    submit_info := vk.Submit_Info {
        s_type = vk.Structure_Type.Submit_Info,
        command_buffer_count = 1,
        command_buffers = &command_buffer,
    };

    vk.queue_submit(graphics_queue, 1, &submit_info, nil);
    vk.queue_wait_idle(graphics_queue); // TODO @Perf: remove this wait_idle and have the caller do it (if there are multiple copies)

    vk.free_command_buffers(device, command_pool, 1, &command_buffer);
}

copy_buffer_and_wait :: proc(src_buffer: vk.Buffer, dst_buffer: vk.Buffer, size: vk.Device_Size) {
    command_buffer := begin_single_time_commands();
    defer end_single_time_commands_and_wait(command_buffer);

    copy_region := vk.Buffer_Copy { size = size };
    vk.cmd_copy_buffer(command_buffer, src_buffer, dst_buffer, 1, &copy_region);
}

/*
	GLM_FUNC_QUALIFIER mat<4, 4, T, defaultp> perspectiveRH_ZO(T fovy, T aspect, T zNear, T zFar)
	{
		assert(abs(aspect - std::numeric_limits<T>::epsilon()) > static_cast<T>(0));

		T const tanHalfFovy = tan(fovy / static_cast<T>(2));

		mat<4, 4, T, defaultp> Result(static_cast<T>(0));
		Result[0][0] = static_cast<T>(1) / (aspect * tanHalfFovy);
		Result[1][1] = static_cast<T>(1) / (tanHalfFovy);
		Result[2][2] = zFar / (zNear - zFar);
		Result[2][3] = - static_cast<T>(1);
		Result[3][2] = -(zFar * zNear) / (zFar - zNear);
		return Result;
	}
*/

perspective_vulkan :: proc(fovy, aspect, near, far: f32) -> math.Mat4 {
	m: math.Mat4;
	tan_half_fovy := math.tan(0.5 * fovy);

	m[0][0] = 1.0 / (aspect*tan_half_fovy);
	m[1][1] = 1.0 / (tan_half_fovy);
	m[2][2] = far / (near - far);
	m[2][3] = -1.0;
	m[3][2] = -(far * near) / (far - near);
	return m;
}

transition_image_layout :: proc(image: vk.Image, format: vk.Format, old_layout: vk.Image_Layout, new_layout: vk.Image_Layout, mip_levels: u32) {
    command_buffer := begin_single_time_commands();
    defer end_single_time_commands_and_wait(command_buffer);

    barrier := vk.Image_Memory_Barrier {
        s_type = vk.Structure_Type.Image_Memory_Barrier,
        old_layout = old_layout,
        new_layout = new_layout,
        src_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        dst_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        image = image,
        subresource_range = {
            //aspect_mask = {vk.Image_Aspect_Flag.Color},
            base_mip_level = 0,
            level_count = mip_levels,
            base_array_layer = 0,
            layer_count = 1,
        },
    };

    if new_layout == vk.Image_Layout.Depth_Stencil_Attachment_Optimal {
        barrier.subresource_range.aspect_mask = {vk.Image_Aspect_Flag.Depth};
        if vk_util.has_stencil_component(format) {
            barrier.subresource_range.aspect_mask |= {vk.Image_Aspect_Flag.Stencil};
        }
    } else {
        barrier.subresource_range.aspect_mask = {vk.Image_Aspect_Flag.Color};
    }

    source_stage, destination_stage: vk.Pipeline_Stage_Flags;

    if old_layout == vk.Image_Layout.Undefined && new_layout == vk.Image_Layout.Transfer_Dst_Optimal {
        barrier.src_access_mask = {};
        barrier.dst_access_mask = {vk.Access_Flag.Transfer_Write};

        source_stage = {vk.Pipeline_Stage_Flag.Top_Of_Pipe}; // earliest possible stage
        destination_stage = {vk.Pipeline_Stage_Flag.Transfer};
    } else if old_layout == vk.Image_Layout.Transfer_Dst_Optimal && new_layout == vk.Image_Layout.Shader_Read_Only_Optimal {
        barrier.src_access_mask = {vk.Access_Flag.Transfer_Write};
        barrier.dst_access_mask = {vk.Access_Flag.Shader_Read};

        source_stage = {vk.Pipeline_Stage_Flag.Transfer};
        destination_stage = {vk.Pipeline_Stage_Flag.Fragment_Shader};
    } else if old_layout == vk.Image_Layout.Undefined && new_layout == vk.Image_Layout.Depth_Stencil_Attachment_Optimal {
        barrier.src_access_mask = {};
        barrier.dst_access_mask = {vk.Access_Flag.Depth_Stencil_Attachment_Read, vk.Access_Flag.Depth_Stencil_Attachment_Write};

        source_stage = {vk.Pipeline_Stage_Flag.Top_Of_Pipe}; // earliest possible stage
        destination_stage = {vk.Pipeline_Stage_Flag.Early_Fragment_Tests};
    } else if old_layout == vk.Image_Layout.Undefined && new_layout == vk.Image_Layout.Color_Attachment_Optimal {
        barrier.src_access_mask = {};
        barrier.dst_access_mask = {vk.Access_Flag.Color_Attachment_Read, vk.Access_Flag.Color_Attachment_Write};

        source_stage = {vk.Pipeline_Stage_Flag.Top_Of_Pipe};
        destination_stage = {vk.Pipeline_Stage_Flag.Color_Attachment_Output};
    } else {
        err_exit("Unsupported layout transition.");
    }

    vk.cmd_pipeline_barrier(command_buffer,
        source_stage, destination_stage,
        {},
        0, nil,
        0, nil,
        1, &barrier);
}

copy_buffer_to_image :: proc(buffer: vk.Buffer, image: vk.Image, width, height: u32) {
    command_buffer := begin_single_time_commands();
    defer end_single_time_commands_and_wait(command_buffer);

    region := vk.Buffer_Image_Copy {
        buffer_offset = 0,
        buffer_row_length = 0,
        buffer_image_height = 0,

        image_subresource = {
            aspect_mask = {vk.Image_Aspect_Flag.Color},
            mip_level = 0,
            base_array_layer = 0,
            layer_count = 1
        },

        image_offset = {0, 0, 0},
        image_extent = {width, height, 1},
    };

    // Assumes the image has already been transitioned to the layout that is
    // optimal for copying pixels to.
    vk.cmd_copy_buffer_to_image(
        command_buffer,
        buffer,
        image,
        vk.Image_Layout.Transfer_Dst_Optimal,
        1,
        &region);
}

generate_mipmaps :: proc(image: vk.Image, image_format: vk.Format, tex_width: i32, tex_height: i32, mip_levels: u32) {
    // check if image format supports linear blitting
    format_properties : vk.Format_Properties = ---;
    vk.get_physical_device_format_properties(physical_device, image_format, &format_properties);
    if !(vk.Format_Feature_Flag.Sampled_Image_Filter_Linear in format_properties.optimal_tiling_features) {
        err_exit("Texture image format does not support linear blitting.");
    }

    command_buffer := begin_single_time_commands();
    defer end_single_time_commands_and_wait(command_buffer);

    barrier := vk.Image_Memory_Barrier {
        s_type = vk.Structure_Type.Image_Memory_Barrier,
        image = image,
        src_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        dst_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        subresource_range = {
            aspect_mask = {vk.Image_Aspect_Flag.Color},
            base_array_layer = 0,
            layer_count = 1,
            level_count = 1
        }
    };

    mip_width := tex_width;
    mip_height := tex_height;

    for i := u32(1); i < mip_levels; i += 1 {
        barrier.subresource_range.base_mip_level = i - 1;
        barrier.old_layout = vk.Image_Layout.Transfer_Dst_Optimal;
        barrier.new_layout = vk.Image_Layout.Transfer_Src_Optimal;
        barrier.src_access_mask = {vk.Access_Flag.Transfer_Write};
        barrier.dst_access_mask = {vk.Access_Flag.Transfer_Read};

        vk.cmd_pipeline_barrier(command_buffer,
            {vk.Pipeline_Stage_Flag.Transfer}, {vk.Pipeline_Stage_Flag.Transfer}, {},
            0, nil,
            0, nil,
            1, &barrier);

        blit := vk.Image_Blit {
            src_offsets = {
                { 0, 0, 0, },
                { mip_width, mip_height, 1 },
            },
            src_subresource = {
                aspect_mask = {vk.Image_Aspect_Flag.Color},
                mip_level = i - 1,
                base_array_layer = 0,
                layer_count = 1,
            },
            dst_offsets = {
                { 0, 0, 0, },
                { mip_width > 1 ? mip_width / 2 : 1, mip_height > 1 ? mip_height / 2 : 1, 1 },
            },
            dst_subresource = {
                aspect_mask = {vk.Image_Aspect_Flag.Color},
                mip_level = i,
                base_array_layer = 0,
                layer_count = 1,
            },
        };

        vk.cmd_blit_image(command_buffer,
            image, vk.Image_Layout.Transfer_Src_Optimal,
            image, vk.Image_Layout.Transfer_Dst_Optimal,
            1, &blit,
            vk.Filter.Linear,
        );

        barrier.old_layout = vk.Image_Layout.Transfer_Src_Optimal;
        barrier.new_layout = vk.Image_Layout.Shader_Read_Only_Optimal;
        barrier.src_access_mask = {vk.Access_Flag.Transfer_Read};
        barrier.dst_access_mask = {vk.Access_Flag.Shader_Read};

        vk.cmd_pipeline_barrier(command_buffer,
            {vk.Pipeline_Stage_Flag.Transfer}, {vk.Pipeline_Stage_Flag.Fragment_Shader}, {},
            0, nil,
            0, nil,
            1, &barrier);

        if mip_width > 1 do mip_width /= 2;
        if mip_height > 1 do mip_height /= 2;
    }

    barrier.subresource_range.base_mip_level = mip_levels - 1;
    barrier.old_layout = vk.Image_Layout.Transfer_Dst_Optimal;
    barrier.new_layout = vk.Image_Layout.Shader_Read_Only_Optimal;
    barrier.src_access_mask = {vk.Access_Flag.Transfer_Write};
    barrier.dst_access_mask = {vk.Access_Flag.Shader_Read};

    vk.cmd_pipeline_barrier(command_buffer,
        {vk.Pipeline_Stage_Flag.Transfer}, {vk.Pipeline_Stage_Flag.Fragment_Shader}, {},
        0, nil,
        0, nil,
        1, &barrier);
}

run :: proc() -> int {
    window := vulkan_init_helper(WIDTH, HEIGHT, WINDOW_TITLE);
    if window == nil do return err_exit("GLFW could not create window.");

    defer glfw.terminate();
    defer glfw.destroy_window(window);

    glfw.set_framebuffer_size_callback(window, framebuffer_resize_callback);
    glfw.set_key_callback(window, key_callback);
    //glfw.set_input_mode(window, glfw.CURSOR, auto_cast glfw.CURSOR_DISABLED);
    glfw.set_input_mode(window, glfw.STICKY_KEYS, 1);

    last_time := glfw.get_time();

    total_elapsed_time : f64;
    frame_count := 0;

    when os.OS == "windows" {
        vulkan_hmodule = win32.load_library_a("vulkan-1");
        set_proc_address :: proc(p: rawptr, instance: vk.Instance, name: cstring) {
            (cast(^rawptr)p)^ = win32.get_proc_address(vulkan_hmodule, name);
        }
    }

    vk.load_loader_proc_addresses(set_proc_address);

    // validation layers

    validation_layers := []cstring {
        "VK_LAYER_LUNARG_standard_validation"
    };

    if (VALIDATION_LAYERS_ENABLED) {
        layer_count : u32 = ---;
        vk.enumerate_instance_layer_properties(&layer_count, nil);

        available_layers := make([]vk.Layer_Properties, layer_count);
        defer delete(available_layers);

        vk.enumerate_instance_layer_properties(&layer_count, &available_layers[0]);

        for layer_name in validation_layers {
            layer_found := false;
            for _, i in available_layers {
                layer_properties := &available_layers[i];
                if cstring(&layer_properties.layer_name[0]) == layer_name do layer_found = true; // @Leak maybe?
            }

            if !layer_found {
                fmt.println_err("validation layer not available:", layer_name);
                return -1;
            }
        }
    }

    // extensions

    extension_count : u32 = ---;
    vk.enumerate_instance_extension_properties(nil, &extension_count, nil);
    fmt.println(extension_count, "extensions supported");

    app_info := vk.Application_Info {
        s_type = vk.Structure_Type.Application_Info,
        application_name = "kev's vulkan test",
        engine_name = "loco",
        api_version = vk.API_VERSION_1_0,
    };

    glfw_extension_count : u32 = 0;
    glfw_extensions := glfw_bindings.GetRequiredInstanceExtensions(&glfw_extension_count);

    extensions : [dynamic]cstring;

    for r in 0..int(glfw_extension_count) - 1 {
        extension_cstring := mem.ptr_offset(glfw_extensions, r);
        append(&extensions, cstring(extension_cstring^));
    }

    if VALIDATION_LAYERS_ENABLED {
        // Debug report extension when using validation layers
        append(&extensions, cstring("VK_EXT_debug_utils"));
    }

    instance_create_info := vk.Instance_Create_Info {
        s_type = vk.Structure_Type.Instance_Create_Info,
        application_info = &app_info,
        enabled_extension_count = cast(u32)len(extensions),
        enabled_extension_names = &extensions[0],
    };

    if (VALIDATION_LAYERS_ENABLED) {
        instance_create_info.enabled_layer_count = u32(len(validation_layers));
        instance_create_info.enabled_layer_names = &validation_layers[0];
    } else {
        instance_create_info.enabled_layer_count = 0;
    }

    // actually create the vulkan instance
    vulkan_instance : vk.Instance;
    result := vk.create_instance(&instance_create_info, nil, &vulkan_instance);
    check_vk_success(result, "Unable to create a Vulkan instance.");

    defer vk.destroy_instance(vulkan_instance, nil);

    vk.load_instance_proc_addresses(vulkan_instance, set_proc_address);
    vk.load_device_proc_addresses(vulkan_instance, set_proc_address);

    callback : vk.Debug_Utils_Messenger_EXT;
    if (VALIDATION_LAYERS_ENABLED) {
        // register the debug messenger callback

        debugCallback : vk.PFN_DebugUtilsMessengerCallbackEXT : proc "c" (
            message_severity : vk.Debug_Utils_Message_Severity_Flags_EXT,
            message_types : vk.Debug_Utils_Message_Type_Flags_EXT,
            callback_data : ^vk.Debug_Utils_Messenger_Callback_Data_EXT,
            user_data : rawptr
        ) -> b32 {
            fmt.println_err("validation layer:", callback_data.message);
            return b32(false);
        }

        messenger_create_info: vk.Debug_Utils_Messenger_Create_Info_EXT = {
            s_type = vk.Structure_Type.Debug_Utils_Messenger_Create_Info_EXT,
            message_severity = {
                vk.Debug_Utils_Message_Severity_Flag_EXT.Verbose,
                vk.Debug_Utils_Message_Severity_Flag_EXT.Warning,
                vk.Debug_Utils_Message_Severity_Flag_EXT.Error,
            },
            message_type = {
                vk.Debug_Utils_Message_Type_Flag_EXT.General,
                vk.Debug_Utils_Message_Type_Flag_EXT.Validation,
                vk.Debug_Utils_Message_Type_Flag_EXT.Performance,
            },
            user_callback = debugCallback,
            user_data = nil
        };

        res := vk.create_debug_utils_messenger_ext(vulkan_instance, &messenger_create_info, nil, &callback);
        check_vk_success(res, "vkCreateDebugUtilsMessengerEXT failed.");
    }
    defer if (callback != nil) do vk.destroy_debug_utils_messenger_ext(vulkan_instance, callback, nil);

    // create a surface
    check_vk_success(CreateWindowSurface(vulkan_instance, window, nil, &surface),
        "Failed to create window surface.");
    defer vk.destroy_surface_khr(vulkan_instance, surface, nil);

    // pick a device
    {
        device_count: u32 = ---;
        vk.enumerate_physical_devices(vulkan_instance, &device_count, nil);
        if (device_count == 0) do err_exit("No devices with Vulkan support found.");
        devices := make([]vk.Physical_Device, device_count);
        defer delete(devices);
        vk.enumerate_physical_devices(vulkan_instance, &device_count, &devices[0]);

        found_physical_device := false;
        for _, i in devices {
            physical_device_properties: vk.Physical_Device_Properties = ---;
            vk.get_physical_device_properties(devices[i], &physical_device_properties);
            physical_device_name := cstring(&physical_device_properties.device_name[0]);
            if !found_physical_device && is_device_suitable(devices[i], surface) {
                physical_device = devices[i];
                msaa_samples = vk_util.get_max_usable_sample_count(physical_device_properties);
                max_push_constants_size = physical_device_properties.limits.max_push_constants_size;
                found_physical_device = true;
                fmt.println("device:", physical_device_name, "<-- USING THIS DEVICE");
            } else {
                fmt.println("device:", physical_device_name);
            }
        }

        fmt.println("max push constants size:", max_push_constants_size); // spec requires 128 bytes[

        {
            queue_family_count: u32 = ---;
            vk.get_physical_device_queue_family_properties(physical_device, &queue_family_count, nil);
            queue_family_properties := make([]vk.Queue_Family_Properties, queue_family_count);
            defer delete(queue_family_properties);
            vk.get_physical_device_queue_family_properties(physical_device, &queue_family_count, &queue_family_properties[0]);

            found_graphics := false;
            found_present := false;

            for _, i in queue_family_properties {
                if !found_graphics && queue_family_properties[i].queue_count > 0 && vk.Queue_Flag.Graphics in queue_family_properties[i].queue_flags {
                    graphics_family_index = u32(i);
                    found_graphics = true;
                }

                if !found_present {
                    present_support : b32 = false;
                    vk.get_physical_device_surface_support_khr(physical_device, u32(i), surface, &present_support);
                    if queue_family_properties[i].queue_count > 0 && present_support {
                        present_family_index = u32(i);
                        found_present = true;
                    }
                }
            }
            if !found_graphics do err_exit("No Vulkan graphics queue found.");;
            if !found_present do err_exit("No Vulkan present queue found.");
        }

        // specify queues to be created
        queue_create_infos: [dynamic]vk.Device_Queue_Create_Info;
        defer delete(queue_create_infos);
        {
            wanted_queues : [2]u32 = {graphics_family_index, present_family_index};

            unique_queues: [dynamic]u32;
            defer delete(unique_queues);

            for wanted_queue in wanted_queues {
                found := false; // TODO: make this a unique $T function
                for seen in unique_queues {
                    if seen == wanted_queue {
                        found = true;
                        break;
                    }
                }

                if !found do append(&unique_queues, wanted_queue);
            }

            queue_priority : f32 = 1;
            for queue_family in unique_queues {
                append(&queue_create_infos, vk.Device_Queue_Create_Info {
                    s_type = vk.Structure_Type.Device_Queue_Create_Info,
                    queue_family_index = queue_family,
                    queue_count = 1,
                    queue_priorities = &queue_priority,
                });
            }
        }

        // Create the logical device
        device_create_info := vk.Device_Create_Info {
            s_type = vk.Structure_Type.Device_Create_Info,
            queue_create_infos = mem.raw_data(queue_create_infos),
            queue_create_info_count = u32(len(queue_create_infos)),

            enabled_extension_count = u32(len(required_device_extensions)),
            enabled_extension_names = mem.raw_data(required_device_extensions),

            enabled_features = &LOGICAL_DEVICE_FEATURES,
        };

        if (VALIDATION_LAYERS_ENABLED) {
            device_create_info.enabled_layer_count = u32(len(validation_layers));
            device_create_info.enabled_layer_names = mem.raw_data(validation_layers);
        } else {
            device_create_info.enabled_layer_count = 0;
        }

        check_vk_success(vk.create_device(physical_device, &device_create_info, nil, &device),
            "Failed to create a logical device.");
    }
    defer if (device != nil) {
        vk.destroy_device(device, nil);
    }

    vk.get_device_queue(device, graphics_family_index, 0, &graphics_queue);
    vk.get_device_queue(device, present_family_index, 0, &present_queue);

    // create command pool
    {
        pool_info := vk.Command_Pool_Create_Info {
            s_type = vk.Structure_Type.Command_Pool_Create_Info,
            queue_family_index = graphics_family_index,
            //flags = 0, // optional
        };
        check_vk_success(vk.create_command_pool(device, &pool_info, nil, &command_pool),
            "Failed to create command pool.");
    }
    defer vk.destroy_command_pool(device, command_pool, nil);

    // load model
    {
        model_data, ok := os.read_entire_file(MODEL_PATH);
        if !ok do err_exit("Could not load model data.");

        using tinyobj;

        attrib: Attrib;
        shapes: []Shape;
        materials: []Material;
        flags := FLAG_TRIANGULATE;
        result := parse(&attrib, &shapes, &materials, model_data, flags); 
        if result != SUCCESS {
            fmt.println("tinyobj error: %v", result);
            err_exit("Error parsing OBJ file.");
        }

        assert(len(attrib.faces) % 3 == 0); // assume triangulation
        assert(len(shapes) == 1); // TODO: handle multiple shapes
        num_faces := len(attrib.faces);

        vertices = make([dynamic]Vertex);
        indices = make([]u32, num_faces);

        unique_vertices := make(map[int]u32);
        defer delete(unique_vertices);

        vertex_index := u32(0);

        for indices_index := 0; indices_index < num_faces; indices_index += 1 {
            idx := &attrib.faces[indices_index];
            v := 3 * idx.v_idx;
            t := 2 * idx.vt_idx;
            new_vertex := Vertex {
                { attrib.vertices[v], attrib.vertices[v + 1], attrib.vertices[v + 2], },
                { 1, 1, 1, },
                { attrib.texcoords[t], 1.0 - attrib.texcoords[t + 1], },
            };

            hashed_vertex := Vertex_hash(&new_vertex);
            if seen_pos, found := unique_vertices[hashed_vertex]; found {
                indices[indices_index] = seen_pos;
            } else {
                append(&vertices, new_vertex);
                indices[indices_index] = vertex_index;
                unique_vertices[hashed_vertex] = vertex_index;
                vertex_index += 1;
            }

        }
    }

    // create vertex buffer
    /* TODO @Perf
        Driver developers recommend that you also store multiple buffers, like
        the vertex and index buffer, into a single VkBuffer and use offsets in
        commands like vkCmdBindVertexBuffers. The advantage is that your data
        is more cache friendly in that case, because it's closer together. It
        is even possible to reuse the same chunk of memory for multiple
        resources if they are not used during the same render operations,
        provided that their data is refreshed, of course. This is known as
        aliasing and some Vulkan functions have explicit flags to specify that
        you want to do this.
    */
    {
        size := vk.Device_Size(size_of(vertices[0]) * len(vertices));

        staging_buffer : vk.Buffer = ---;
        staging_buffer_memory : vk.Device_Memory = ---;
        create_buffer(
            size,
            {vk.Buffer_Usage_Flag.Transfer_Src},
            {vk.Memory_Property_Flag.Host_Visible, vk.Memory_Property_Flag.Host_Coherent},
            &staging_buffer,
            &staging_buffer_memory);

        defer vk.destroy_buffer(device, staging_buffer, nil);
        defer vk.free_memory(device, staging_buffer_memory, nil);

        {
            data: rawptr = ---;
            check_vk_success(vk.map_memory(device, staging_buffer_memory, 0, size, 0, &data),
                "Failed to map memory for vertices.");
            defer vk.unmap_memory(device, staging_buffer_memory);

            mem.copy(data, &vertices[0], cast(int)size);
        }

        create_buffer(
            size,
            {vk.Buffer_Usage_Flag.Vertex_Buffer, vk.Buffer_Usage_Flag.Transfer_Dst},
            {vk.Memory_Property_Flag.Device_Local},
            &vertex_buffer,
            &vertex_buffer_memory);

        copy_buffer_and_wait(staging_buffer, vertex_buffer, size);
    }


    // create index buffer
    {
        size := vk.Device_Size(size_of(indices[0]) * len(indices));

        staging_buffer : vk.Buffer = ---;
        staging_buffer_memory : vk.Device_Memory = ---;
        create_buffer(
            size,
            {vk.Buffer_Usage_Flag.Transfer_Src},
            {vk.Memory_Property_Flag.Host_Visible, vk.Memory_Property_Flag.Host_Coherent},
            &staging_buffer,
            &staging_buffer_memory);

        defer vk.destroy_buffer(device, staging_buffer, nil);
        defer vk.free_memory(device, staging_buffer_memory, nil);

        {
            data: rawptr = ---;
            check_vk_success(vk.map_memory(device, staging_buffer_memory, 0, size, 0, &data),
                "Failed to map memory for indices.");
            defer vk.unmap_memory(device, staging_buffer_memory);

            mem.copy(data, &indices[0], cast(int)size);
        }

        create_buffer(
            size,
            {vk.Buffer_Usage_Flag.Index_Buffer, vk.Buffer_Usage_Flag.Transfer_Dst},
            {vk.Memory_Property_Flag.Device_Local},
            &index_buffer,
            &index_buffer_memory);

        copy_buffer_and_wait(staging_buffer, index_buffer, size);
    }

    delete(vertices);
    delete(indices);

    // create texture image
    texture_format :: vk.Format.R8G8B8A8_Unorm;
    {
        image_width, image_height, image_channels_in_file : i32;
        image_path := cstring(TEXTURE_PATH);

        REQUESTED_CHANNELS :: 4;

        image_data := stbi.load(cast(^u8)image_path, &image_width, &image_height, &image_channels_in_file, REQUESTED_CHANNELS);
        if image_data == nil || image_width < 1 || image_height < 1 do err_exit("Could not load texture");
        defer stbi.image_free(image_data);

        mip_levels = u32(math.floor(math.log(f32(max(image_width, image_height))))) + 1;

        BYTES_PER_PIXEL :: 4;

        staging_buffer: vk.Buffer = ---;
        staging_buffer_memory: vk.Device_Memory = ---;

        image_size := vk.Device_Size(image_width * image_height * BYTES_PER_PIXEL);
        create_buffer(image_size, {vk.Buffer_Usage_Flag.Transfer_Src},
            {vk.Memory_Property_Flag.Host_Visible, vk.Memory_Property_Flag.Host_Coherent},
            &staging_buffer, &staging_buffer_memory);

        defer vk.destroy_buffer(device, staging_buffer, nil);
        defer vk.free_memory(device, staging_buffer_memory, nil);

        {
            data: rawptr;
            check_vk_success(vk.map_memory(device, staging_buffer_memory, 0, image_size, 0, &data),
                "Failed to map memory for texture.");
            assert(data != nil);
            mem.copy(data, image_data, int(image_size));
            vk.unmap_memory(device, staging_buffer_memory);
        }

        vk_util.create_image(device, physical_device, u32(image_width), u32(image_height), mip_levels,
            vk.Sample_Count_Flag._1,
            texture_format,
            vk.Image_Tiling.Optimal,
            {
                vk.Image_Usage_Flag.Transfer_Src,
                vk.Image_Usage_Flag.Transfer_Dst,
                vk.Image_Usage_Flag.Sampled,
            },
            {
                vk.Memory_Property_Flag.Device_Local,
            },
            &texture_image,
            &texture_image_memory);

        transition_image_layout(texture_image, texture_format, vk.Image_Layout.Undefined, vk.Image_Layout.Transfer_Dst_Optimal, mip_levels);
        copy_buffer_to_image(staging_buffer, texture_image, u32(image_width), u32(image_height));
        generate_mipmaps(texture_image, texture_format, image_width, image_height, mip_levels);
    }

    // create texture image view
    {
        texture_image_view = vk_util.create_image_view(device, texture_image, texture_format, {vk.Image_Aspect_Flag.Color}, mip_levels);
    }

    // create texture sampler
    {
        sampler_info := vk.Sampler_Create_Info {
            s_type = vk.Structure_Type.Sampler_Create_Info,
            mag_filter = vk.Filter.Linear,
            min_filter = vk.Filter.Linear,
            address_mode_u = vk.Sampler_Address_Mode.Repeat,
            address_mode_v = vk.Sampler_Address_Mode.Repeat,
            address_mode_w = vk.Sampler_Address_Mode.Repeat,
            anisotropy_enable = true,
            max_anisotropy = 16, // TODO: @Perf don't always use anisotropy if it's not necessary
            border_color = vk.Border_Color.Int_Opaque_Black,
            unnormalized_coordinates = false,

            compare_enable = false, // used for percentage-closer filtering on shadowmaps
            compare_op = vk.Compare_Op.Always,

            mipmap_mode = vk.Sampler_Mipmap_Mode.Linear,
            mip_lod_bias = 0,
            min_lod = 0,
            max_lod = f32(mip_levels),
        };

        check_vk_success(vk.create_sampler(device, &sampler_info, nil, &texture_sampler),
            "Failed to create texture sampler.");
    }


    recreate_swapchain(window, true);

    image_available_semaphores : []vk.Semaphore;
    render_finished_semaphores : []vk.Semaphore;
    in_flight_fences : []vk.Fence;

    { // create semaphores and fences
        image_available_semaphores = make([]vk.Semaphore, MAX_FRAMES_IN_FLIGHT);
        render_finished_semaphores = make([]vk.Semaphore, MAX_FRAMES_IN_FLIGHT);
        in_flight_fences = make([]vk.Fence, MAX_FRAMES_IN_FLIGHT);

        semaphore_info := vk.Semaphore_Create_Info { s_type = vk.Structure_Type.Semaphore_Create_Info };

        fence_info := vk.Fence_Create_Info {
            s_type = vk.Structure_Type.Fence_Create_Info,
            flags = {vk.Fence_Create_Flag.Signaled},
        };

        for i in 0..MAX_FRAMES_IN_FLIGHT - 1 {
            if vk.Result.Success != vk.create_semaphore(device, &semaphore_info, nil, &image_available_semaphores[i]) ||
                vk.Result.Success != vk.create_semaphore(device, &semaphore_info, nil, &render_finished_semaphores[i]) ||
                vk.Result.Success != vk.create_fence(device, &fence_info, nil, &in_flight_fences[i]) {
                fmt.println_err("Error: Failed to create synchronization objects for frame", i);
                return -1;
            }
        }
    }
    defer for i in 0..MAX_FRAMES_IN_FLIGHT - 1 {
        vk.destroy_semaphore(device, image_available_semaphores[i], nil);
        vk.destroy_semaphore(device, render_finished_semaphores[i], nil);
        vk.destroy_fence(device, in_flight_fences[i], nil);
    }

    current_frame := 0;
    start_time := glfw.get_time();

    camera_pos := math.Vec3{2, 2, 2};
    look_at_target := math.Vec3{0, 0, 0};

    for !glfw.window_should_close(window) {
        frame_count += 1;

        current_time := glfw.get_time();
        delta_time := cast(f32)(current_time - last_time);

        glfw.poll_events();

        // update camera pos
        z_delta:f32 = 0.0;
        speed:f32 = 2.5;
        if glfw.get_key(window, glfw.KEY_W) do z_delta -= speed * delta_time;
        if glfw.get_key(window, glfw.KEY_S) do z_delta += speed * delta_time;
        if z_delta > 0 || z_delta < 0 do camera_pos.y += z_delta;

        // Draw Frame
        {
            // Wait for the previous frame rendering to our imageview to be finished
            vk.wait_for_fences(device, 1, &in_flight_fences[current_frame], true, bits.U64_MAX);

            image_index : u32 = ---;
            wait_for_next_frame := false;

            {
                swapchain_result := vk.acquire_next_image_khr(device, swapchain, bits.U64_MAX, image_available_semaphores[current_frame], nil, &image_index);
                if swapchain_result == vk.Result.Error_Out_Of_Date_KHR {
                    fmt.println("recreating swapchain because we received Error_Out_Of_Date_KHR from aquire_next_image_khr");
                    recreate_swapchain(window);
                    wait_for_next_frame = true;
                } else if swapchain_result != vk.Result.Success && swapchain_result != vk.Result.Suboptimal_KHR {
                    err_exit("Failed to acquire swap chain image.");
                }
            }

            if !wait_for_next_frame {
                wait_semaphores := [1]vk.Semaphore { image_available_semaphores[current_frame] };

                wait_stages : [1]vk.Pipeline_Stage_Flags = {
                    {vk.Pipeline_Stage_Flag.Color_Attachment_Output}
                };

                signal_semaphores := [1]vk.Semaphore { render_finished_semaphores[current_frame] };

                assert(len(signal_semaphores) == 1);

                { // update uniform buffer
                    // TODO: @Perf this is not the most efficient way to pass
                    // frequently changing values to the shader. see "push
                    // constants"
                    using math;
                    time_since_start := current_time - start_time;


                    ubo := Uniform_Buffer_Object {
                        model = mat4_rotate(Vec3{0, 0, 1}, to_radians(90) * f32(time_since_start)),
                        view = look_at(camera_pos, look_at_target, Vec3{0, 0, 1}),
                        proj = perspective_vulkan(45, f32(swapchain_extent.width) / f32(swapchain_extent.height), 0.1, 10.0),
                    };

                    VIEWPORT_N :: 0;

                    ubo.proj[VIEWPORT_N][1][1] *= -1;

                    {
                        data: rawptr;
                        check_vk_success(vk.map_memory(device, uniform_buffers_memory[image_index], 0, size_of(ubo), 0, &data),
                            "Failed to map memory for uniforms.");
                        assert(data != nil);
                        defer vk.unmap_memory(device, uniform_buffers_memory[image_index]);

                        mem.copy(data, &ubo, size_of(ubo));
                    }
                }

                submit_info := vk.Submit_Info {
                    s_type = vk.Structure_Type.Submit_Info,
                    wait_semaphore_count = 1,
                    wait_semaphores = &wait_semaphores[0],
                    wait_dst_stage_mask = &wait_stages[0],
                    command_buffer_count = 1,
                    command_buffers = &command_buffers[image_index],
                    signal_semaphore_count = 1,
                    signal_semaphores = &signal_semaphores[0],
                };

                vk.reset_fences(device, 1, &in_flight_fences[current_frame]);
                check_vk_success(vk.queue_submit(graphics_queue, 1, &submit_info, in_flight_fences[current_frame]),
                    "Failed to submit draw command buffer.");

                swapchains := [1]vk.Swapchain_KHR {swapchain};
                present_info := vk.Present_Info_KHR {
                    s_type = vk.Structure_Type.Present_Info_KHR,
                    wait_semaphore_count = 1,
                    wait_semaphores = &signal_semaphores[0],
                    swapchain_count = 1,
                    swapchains = &swapchains[0],
                    image_indices = &image_index,
                    results = nil, // optional for obtaining individual results
                };
                {
                    present_result := vk.queue_present_khr(present_queue, &present_info);
                    if present_result == vk.Result.Error_Out_Of_Date_KHR
                        || result == vk.Result.Suboptimal_KHR
                        || framebuffer_resized
                    {
                        fmt.println("recreating swapchain");
                        framebuffer_resized = false;
                        recreate_swapchain(window);
                    }
                }
            }
        }

        glfw.calculate_frame_timings(window);

        last_time = current_time;
        total_elapsed_time += f64(delta_time);
        current_frame = (current_frame + 1) % MAX_FRAMES_IN_FLIGHT;
    }

    // wait for frames to finish before cleanup
    vk.wait_for_fences(device, cast(u32)len(in_flight_fences), &in_flight_fences[0], true, bits.U64_MAX);

    cleanup_swapchain();

    vk.destroy_sampler(device, texture_sampler, nil);
    vk.destroy_image_view(device, texture_image_view, nil);
    vk.destroy_image(device, texture_image, nil);
    vk.free_memory(device, texture_image_memory, nil);

    vk.destroy_descriptor_set_layout(device, descriptor_set_layout, nil);

    vk.destroy_descriptor_pool(device, descriptor_pool, nil);

    assert(len(swapchain_images) == len(uniform_buffers));
    assert(len(uniform_buffers) == len(uniform_buffers_memory));

    for _, i in swapchain_images {
        vk.destroy_buffer(device, uniform_buffers[i], nil);
        vk.free_memory(device, uniform_buffers_memory[i], nil);
    }
    delete(uniform_buffers);
    delete(uniform_buffers_memory);

    vk.destroy_buffer(device, vertex_buffer, nil);
    vk.free_memory(device, vertex_buffer_memory, nil);

    vk.destroy_buffer(device, index_buffer, nil);
    vk.free_memory(device, index_buffer_memory, nil);

    return 0;
}


package vulkan_triangle

// Thanks to the Vulkan Tutorial "Drawing a triangle" at
// https://vulkan-tutorial.com/Drawing_a_triangle/

import "core:fmt"
import "core:mem"
import "core:os"
import "core:bits"

import vk "./vulkan_bindings"

import "shared:odin-glfw"
import glfw_bindings "shared:odin-glfw/bindings"

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

WINDOW_TITLE := "vulkan_triangle";
VALIDATION_LAYERS_ENABLED :: true;
MAX_FRAMES_IN_FLIGHT :: 2;
WIDTH :: 1280;
HEIGHT :: 720;

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

check_vk_success :: inline proc (res: vk.Result, message: string) {
    if res != vk.Result.Success do err_exit(message);
}

// TODO: probably should be a struct
device: vk.Device;
swapchain: vk.Swapchain_KHR;
physical_device: vk.Physical_Device;
surface: vk.Surface_KHR;
graphics_family_index: u32;
present_family_index: u32;
command_pool : vk.Command_Pool;
command_buffers: []vk.Command_Buffer;
render_pass : vk.Render_Pass;
swapchain_images: []vk.Image;
swapchain_framebuffers: []vk.Framebuffer;
swapchain_imageviews: []vk.Image_View;
swapchain_image_format: vk.Format;
swapchain_extent: vk.Extent2D;
graphics_pipeline : vk.Pipeline;
pipeline_layout : vk.Pipeline_Layout;
framebuffer_resized := false;

cleanup_swapchain :: proc() {
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

recreate_swapchain :: proc(window: glfw.Window_Handle) {
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
                imageview_create_info := vk.Image_View_Create_Info {
                    s_type = vk.Structure_Type.Image_View_Create_Info,
                    image = swapchain_images[i],
                    view_type = vk.Image_View_Type.D2,
                    format = swapchain_image_format,
                };
                {
                    using imageview_create_info;
                    components.r = vk.Component_Swizzle.Identity;
                    components.g = vk.Component_Swizzle.Identity;
                    components.b = vk.Component_Swizzle.Identity;
                    components.a = vk.Component_Swizzle.Identity;

                    subresource_range.aspect_mask = {vk.Image_Aspect_Flag.Color};
                    subresource_range.base_mip_level = 0;
                    subresource_range.level_count = 1;
                    subresource_range.base_array_layer = 0;
                    subresource_range.layer_count = 1;
                    /* TODO: If you were working on a stereographic 3D
                    * application, then you would create a swap chain with
                    * multiple layers. You could then create multiple image
                    * views for each image representing the views for the left
                    * and right eyes by accessing different layers.
                    */
                }

                check_vk_success(vk.create_image_view(device, &imageview_create_info, nil, &swapchain_imageviews[i]),
                    "Failed to create image view.");
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
            samples = {vk.Sample_Count_Flag._1},
            load_op = vk.Attachment_Load_Op.Clear,
            store_op = vk.Attachment_Store_Op.Store,
            stencil_load_op = vk.Attachment_Load_Op.Dont_Care,
            stencil_store_op = vk.Attachment_Store_Op.Dont_Care,
            initial_layout = vk.Image_Layout.Undefined,
            final_layout = vk.Image_Layout.Present_Src_KHR,
        };

        // subpasses
        color_attachment_ref := vk.Attachment_Reference {
            attachment = 0, // layout(location = 0) out vec4 outColor 
            layout = vk.Image_Layout.Color_Attachment_Optimal,
        };

        subpass := vk.Subpass_Description {
            pipeline_bind_point = vk.Pipeline_Bind_Point.Graphics,
            color_attachment_count = 1,
            color_attachments = &color_attachment_ref,
            //input_attachments
            //resolve_attachments
            //depth_stencil_attachments
            //preserve_attachments
        };

        render_pass_info := vk.Render_Pass_Create_Info {
            s_type = vk.Structure_Type.Render_Pass_Create_Info,
            attachment_count = 1,
            attachments = &color_attachment,
            subpass_count = 1,
            subpasses = &subpass,
            dependency_count = 1,
            dependencies = &dependency,
        };

        check_vk_success(vk.create_render_pass(device, &render_pass_info, nil, &render_pass),
            "Failed to create render pass.");
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

        vertex_input_info := vk.Pipeline_Vertex_Input_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Vertex_Input_State_Create_Info,
            //vertexBindingDescriptionCount = 0,
            //pVertexBindingDescriptions = nil, // Optional
            //vertexAttributeDescriptionCount = 0,
            //pVertexAttributeDescriptions = nil, // Optional
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
            front_face = vk.Front_Face.Clockwise,

            depth_bias_enable = false,
            depth_bias_constant_factor = 0, //optional
            depth_bias_clamp = 0, //optional
            depth_bias_slope_factor = 0, //optional
        };

        multisampling := vk.Pipeline_Multisample_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Multisample_State_Create_Info,
            sample_shading_enable = false,
            rasterization_samples = {vk.Sample_Count_Flag._1},
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

        /*
        dynamic_states := [2]vk.Dynamic_State {
            vk.Dynamic_State.Viewport,
            vk.Dynamic_State.Line_Width,
        };

        dynamic_state := vk.Pipeline_Dynamic_State_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Dynamic_State_Create_Info,
            dynamic_state_count = u32(len(dynamic_states)),
            dynamic_states = &dynamic_states[0],
        };
        */

        pipeline_layout_info := vk.Pipeline_Layout_Create_Info {
            s_type = vk.Structure_Type.Pipeline_Layout_Create_Info,
            set_layout_count = 0, // optional
            set_layouts = nil, // optional
            push_constant_range_count = 0, //optional
            push_constant_ranges = nil, // optional
        };

        check_vk_success(vk.create_pipeline_layout(device, &pipeline_layout_info, nil, &pipeline_layout),
            "Failed to create pipeline layout.");

        graphics_pipeline_info := vk.Graphics_Pipeline_Create_Info {
            s_type = vk.Structure_Type.Graphics_Pipeline_Create_Info,
            stage_count = 2,
            stages = &shader_stages[0],

            vertex_input_state = &vertex_input_info,
            input_assembly_state = &input_assembly,

            viewport_state = &viewport_state,
            rasterization_state = &rasterizer,
            multisample_state = &multisampling,
            depth_stencil_state = nil, // optional
            color_blend_state = &color_blending,
            dynamic_state = nil, // optional
            layout = pipeline_layout,
            render_pass = render_pass,
            subpass = 0,
            base_pipeline_handle = nil, //optional
            base_pipeline_index = -1, //optional
        };

        check_vk_success(vk.create_graphics_pipelines(device, nil, 1, &graphics_pipeline_info, nil, &graphics_pipeline),
            "Failed to create graphics pipeline.");
    }

    // create framebuffers
    {
        swapchain_framebuffers = make([]vk.Framebuffer, len(swapchain_imageviews));
        for i := 0; i < len(swapchain_imageviews); i += 1 {
            attachments := []vk.Image_View { swapchain_imageviews[i] };
            framebuffer_info := vk.Framebuffer_Create_Info {
                s_type = vk.Structure_Type.Framebuffer_Create_Info,
                render_pass = render_pass,
                attachment_count = 1,
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
        for _, i in command_buffers {
            begin_info := vk.Command_Buffer_Begin_Info {
                s_type = vk.Structure_Type.Command_Buffer_Begin_Info,
                flags = {vk.Command_Buffer_Usage_Flag.Simultaneous_Use},
                inheritance_info = nil, // optional for secondary command buffers
            };
            check_vk_success(vk.begin_command_buffer(command_buffers[i], &begin_info),
                "Failed to begin recording command buffer");

            clear_value : vk.Clear_Value;
            clear_value.color.float32 = {0, 0, 0, 1};
            clear_value.depth_stencil = {depth=0, stencil=0};

            render_pass_info := vk.Render_Pass_Begin_Info {
                s_type = vk.Structure_Type.Render_Pass_Begin_Info,
                render_pass = render_pass,
                framebuffer = swapchain_framebuffers[i],
                render_area = {
                    offset = {0, 0}, // @Perf: should match attachment sizes for best performance
                    extent = swapchain_extent,
                },
                clear_value_count = 1,
                clear_values = &clear_value,
            };

            // Draw the triangle
            vk.cmd_begin_render_pass(command_buffers[i], &render_pass_info, vk.Subpass_Contents.Inline);
            vk.cmd_bind_pipeline(command_buffers[i], vk.Pipeline_Bind_Point.Graphics, graphics_pipeline);
            vk.cmd_draw(
                command_buffer=command_buffers[i],
                vertex_count=3,
                instance_count=1,
                first_vertex=0,
                first_instance=0);
            vk.cmd_end_render_pass(command_buffers[i]);

            check_vk_success(vk.end_command_buffer(command_buffers[i]), "Failed to record command buffer.");
        }
    }

}

run :: proc() -> int {
    window := vulkan_init_helper(WIDTH, HEIGHT, WINDOW_TITLE);
    if window == nil do return err_exit("GLFW could not create window.");

    defer glfw.terminate();
    defer glfw.destroy_window(window);

    glfw.set_framebuffer_size_callback(window, framebuffer_resize_callback);
    glfw.set_key_callback(window, key_callback);
    //glfw.set_input_mode(window, glfw.CURSOR, auto_cast glfw.CURSOR_DISABLED);

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
        instance_create_info.enabled_layer_names = cast(^cstring)(&validation_layers[0]);
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
                found_physical_device = true;
                fmt.println("device:", physical_device_name, "<-- USING THIS DEVICE");
            } else {
                fmt.println("device:", physical_device_name);
            }
        }

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
        device_features := vk.Physical_Device_Features {};
        device_create_info := vk.Device_Create_Info {
            s_type = vk.Structure_Type.Device_Create_Info,
            queue_create_infos = mem.raw_data(queue_create_infos),
            queue_create_info_count = u32(len(queue_create_infos)),

            enabled_extension_count = u32(len(required_device_extensions)),
            enabled_extension_names = mem.raw_data(required_device_extensions),

            enabled_features = &device_features,
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
    defer if (device != nil) do vk.destroy_device(device, nil);

    graphics_queue: vk.Queue;
    vk.get_device_queue(device, graphics_family_index, 0, &graphics_queue);

    present_queue: vk.Queue;
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

    recreate_swapchain(window);

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

    for !glfw.window_should_close(window) {
        frame_count += 1;

        current_time := glfw.get_time();
        delta_time := cast(f32)(current_time - last_time);

        glfw.poll_events();

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
                        fmt.println("recreating swapchain because of queue_present_khr result");
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

    return 0;
}


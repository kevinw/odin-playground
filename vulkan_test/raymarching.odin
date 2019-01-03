package vulkan_test

import "shared:odin-glfw"
import glfw_bindings "shared:odin-glfw/bindings"
import "core:fmt"
import "core:mem"
import "core:os"
import "core:bits"
import vk "./vulkan_bindings"

when os.OS == "windows" {
    import "core:sys/win32"
    vulkan_hmodule: win32.Hmodule;
}

// not included in the glfw bindings, interacts with vulkan types
@(default_calling_convention="c", link_prefix="glfw")
foreign {
    CreateWindowSurface :: proc "c" (instance:vk.Instance, window: glfw.Window_Handle, allocator: ^vk.Allocation_Callbacks, surface: ^vk.Surface_KHR) -> vk.Result ---;
}

WINDOW_TITLE := "vulkan_test";

VALIDATION_LAYERS_ENABLED :: true;

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}


vulkan_init_helper :: proc(resx := 1280, resy := 720, title := "Window title", samples := 0) -> glfw.Window_Handle {
    //
    error_callback :: proc"c"(error: i32, desc: cstring) {
        fmt.printf("Error code %d: %s\n", error, desc);
    }
    glfw_bindings.SetErrorCallback(error_callback);

    //
    if glfw_bindings.Init() == glfw_bindings.FALSE do return nil;

    //
    if samples > 0 do glfw_bindings.WindowHint(glfw_bindings.SAMPLES, i32(samples));
    //glfw_bindings.WindowHint(glfw_bindings.DECORATED, 1);

    glfw_bindings.WindowHint(i32(glfw.CLIENT_API), i32(glfw.NO_API));
    glfw_bindings.WindowHint(i32(glfw.RESIZABLE), i32(glfw.FALSE));

    //glfw_bindings.WindowHint(glfw_bindings.CONTEXT_VERSION_MAJOR, i32(version_major));
    //glfw_bindings.WindowHint(glfw_bindings.CONTEXT_VERSION_MINOR, i32(version_minor));
    //glfw_bindings.WindowHint(glfw_bindings.OPENGL_PROFILE, bind.OPENGL_CORE_PROFILE);

    //
    window := glfw.create_window(int(resx), int(resy), title, nil, nil);
    if window == nil do return nil;

    //
    //glfw_bindings.MakeContextCurrent(window);
    //glfw_bindings.SwapInterval(i32(vsync));

    return window;
}

required_device_extensions := []cstring {
    "VK_KHR_swapchain",
};

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

    swap_chain_support_details := query_swap_chain_support(device, surface);
    { 
        using swap_chain_support_details;
        defer SwapChainSupportDetails_delete(&swap_chain_support_details);
        if len(formats) == 0 || len(present_modes) == 0 do return false;
    }

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
        if mode == vk.Present_Mode_KHR.Mailbox { // triple buffering
            return mode;
        } else if mode == vk.Present_Mode_KHR.Immediate {
            best_mode = mode;
        }
    }

    return best_mode;
}

choose_swap_extent :: proc(capabilities: ^vk.Surface_Capabilities_KHR, width: u32, height: u32) -> vk.Extent2D {
    if capabilities.current_extent.width != bits.U32_MAX {
        return capabilities.current_extent;
    }

    actual_extent := vk.Extent2D { width, height };

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

WIDTH :: 800;
HEIGHT :: 600;

run :: proc() -> int {
    window := vulkan_init_helper(WIDTH, HEIGHT, WINDOW_TITLE);
    if window == nil {
        fmt.println_err("error: glfw could not create window");
        return -1;
    }
    defer glfw.terminate();
    defer glfw.destroy_window(window);

    glfw.set_key_callback(window, key_callback);
    glfw.set_input_mode(window, glfw.CURSOR, auto_cast glfw.CURSOR_DISABLED);

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
    if result != vk.Result.Success {
        fmt.println_err("Error: unable to create a Vulkan instance");
        return -1;
    }

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

        if vk.Result.Success != vk.create_debug_utils_messenger_ext(vulkan_instance, &messenger_create_info, nil, &callback) {
            fmt.println_err("error: vkCreateDebugUtilsMessengerEXT failed");
            return -1;
        }
    }
    defer if (callback != nil) do vk.destroy_debug_utils_messenger_ext(vulkan_instance, callback, nil);

    // create a surface
    surface: vk.Surface_KHR;
    if vk.Result.Success != /*glfw*/CreateWindowSurface(vulkan_instance, window, nil, &surface) {
        fmt.println_err("Error: failed to create window surface");
        return -1;
    }
    defer vk.destroy_surface_khr(vulkan_instance, surface, nil);

    // pick a device
    device: vk.Device;
    graphics_family_index: u32;
    present_family_index: u32;
    physical_device: vk.Physical_Device;
    {
        device_count: u32 = ---;
        vk.enumerate_physical_devices(vulkan_instance, &device_count, nil);
        if (device_count == 0) {
            fmt.println_err("Error: No devices with Vulkan support found.");
            return -1;
        }
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
        if !found_graphics {
            fmt.println_err("Error: no Vulkan graphics queue found");
            return -1;
        }
        if !found_present {
            fmt.println_err("Error: no Vulkan present queue found");
            return -1;
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

        if vk.Result.Success != vk.create_device(physical_device, &device_create_info, nil, &device) {
            fmt.println_err("Error: failed to create a logical device");
            return -1;
        }
    }
    defer if (device != nil) do vk.destroy_device(device, nil);

    graphics_queue: vk.Queue;
    vk.get_device_queue(device, graphics_family_index, 0, &graphics_queue);

    present_queue: vk.Queue;
    vk.get_device_queue(device, present_family_index, 0, &present_queue);

    // create swap chain
    swapchain: vk.Swapchain_KHR;
    {
        swap_chain_support := query_swap_chain_support(physical_device, surface);
        using swap_chain_support;

        defer SwapChainSupportDetails_delete(&swap_chain_support);

        surface_format := choose_swap_surface_format(formats);
        present_mode := choose_swap_present_mode(present_modes);
        extent := choose_swap_extent(&capabilities, WIDTH, HEIGHT);

        image_count := capabilities.min_image_count + 1;
        if capabilities.max_image_count > 0 && image_count > capabilities.max_image_count { // zero means no limit
            image_count = capabilities.max_image_count;
        }

        swapchain_create_info := vk.Swapchain_Create_Info_KHR {
            s_type = vk.Structure_Type.Swapchain_Create_Info_KHR,
            surface = surface,
            min_image_count = image_count,
            image_format = surface_format.format,
            image_color_space = surface_format.color_space,
            image_extent = extent,
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

        if vk.Result.Success != vk.create_swapchain_khr(device, &swapchain_create_info, nil, &swapchain) {
            fmt.println_err("Error: failed to create swap chain");
            return -1;
        }
    }
    defer vk.destroy_swapchain_khr(device, swapchain, nil);

    // retrieve swapchain images
    {
        image_count: u32 = ---;
        vk.get_swapchain_images_khr(device, swapchain, &image_count, nil);
        swapchain_images := make([]vk.Image, image_count);
        defer delete(swapchain_images);
        vk.get_swapchain_images_khr(device, swapchain, &image_count, mem.raw_data(swapchain_images));
    }

    for !glfw.window_should_close(window) {
        frame_count += 1;

        //window_width, window_height := glfw.get_window_size(window);

        current_time := glfw.get_time();
        delta_time := cast(f32)(current_time - last_time);

        //glfw.swap_buffers(window);
        glfw.poll_events();
        glfw.calculate_frame_timings(window);

        last_time = current_time;
        total_elapsed_time += f64(delta_time);
    }

    fmt.println("rendered", frame_count, "frames in", total_elapsed_time);

    return 0;
}


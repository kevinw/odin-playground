package vulkan_test

import "shared:odin-glfw"
import glfw_bindings "shared:odin-glfw/bindings"
import "core:fmt"
import "core:mem"
import "core:os"
import vk "./vulkan_bindings"

when os.OS == "windows" {
    import "core:sys/win32"
    vulkan_hmodule: win32.Hmodule;
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

run :: proc() -> int {
    window := vulkan_init_helper(800, 600, WINDOW_TITLE);
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

    // pick a device
    device: vk.Device;
    graphics_family_index: u32;
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

        for _, i in devices {
            physical_device_properties: vk.Physical_Device_Properties = ---;
            vk.get_physical_device_properties(devices[i], &physical_device_properties);
            physical_device_name := cstring(&physical_device_properties.device_name[0]);
            fmt.println("device:", physical_device_name, i == 0 ? "<-- USING THIS DEVICE" : "");
        }

        physical_device := devices[0]; // TODO: actually choose a device based on some metric

        queue_family_count: u32 = ---;
        vk.get_physical_device_queue_family_properties(physical_device, &queue_family_count, nil);
        queue_family_properties := make([]vk.Queue_Family_Properties, queue_family_count);
        defer delete(queue_family_properties);
        vk.get_physical_device_queue_family_properties(physical_device, &queue_family_count, &queue_family_properties[0]);

        found := false;

        for _, i in queue_family_properties {
            if vk.Queue_Flag.Graphics in queue_family_properties[i].queue_flags {
                graphics_family_index = u32(i);
                found = true;
                break;
            }
        }
        if !found {
            fmt.println_err("Error: no Vulkan graphics queue found");
            return -1;
        }

        // specify queues to be created
        queue_priority : f32 = 1;
        queue_create_info := vk.Device_Queue_Create_Info {
            s_type = vk.Structure_Type.Device_Queue_Create_Info,
            queue_family_index = graphics_family_index,
            queue_count = 1,
            queue_priorities = &queue_priority,
        };
        device_features := vk.Physical_Device_Features {};

        device_create_info := vk.Device_Create_Info {
            s_type = vk.Structure_Type.Device_Create_Info,
            queue_create_infos = &queue_create_info,
            queue_create_info_count = 1,
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
    {

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


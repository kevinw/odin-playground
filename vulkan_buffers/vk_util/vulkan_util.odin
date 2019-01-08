package vk_util

import vk "../vulkan_bindings"

import "core:fmt"
import "core:os"

when os.OS == "windows" {
    import "core:sys/win32"
    exit :: proc (ret_code: int = -1) { win32.exit_process(cast(u32)ret_code); }
}

err_exit :: inline proc(message: string, return_code:int = -1) -> int {
    fmt.println_err("Error:", message);
    exit(return_code);
    return -1;
}

check_vk_success :: inline proc (res: vk.Result, message: string) {
    if res != vk.Result.Success do err_exit(message);
}

find_memory_type :: proc(physical_device: vk.Physical_Device, type_filter: u32, properties: vk.Memory_Property_Flags) -> u32 {
    mem_properties: vk.Physical_Device_Memory_Properties = ---;
    vk.get_physical_device_memory_properties(physical_device, &mem_properties);
    for i := u32(0); i < mem_properties.memory_type_count; i += 1 {
        if type_filter & (1 << i) != 0 &&
            (mem_properties.memory_types[i].property_flags & properties) == properties {
            return i;
        }
    }

    err_exit("Failed to find suitable memory type.");
    return 0;
}

create_image :: proc(
    device: vk.Device,
    physical_device: vk.Physical_Device,
    width, height: u32,
    format: vk.Format,
    image_tiling: vk.Image_Tiling,
    usage: vk.Image_Usage_Flags,
    properties: vk.Memory_Property_Flags,
    image: ^vk.Image,
    image_memory: ^vk.Device_Memory)
{
    image_info := vk.Image_Create_Info {
        s_type = vk.Structure_Type.Image_Create_Info,
        image_type = vk.Image_Type.D2,
        extent = { width = width, height = height, depth = 1, },
        mip_levels = 1,
        array_layers = 1,
        format = vk.Format.R8G8B8A8_Unorm,
        tiling = vk.Image_Tiling.Optimal,
        initial_layout = vk.Image_Layout.Undefined,
        usage = {vk.Image_Usage_Flag.Transfer_Dst, vk.Image_Usage_Flag.Sampled},
        sharing_mode = vk.Sharing_Mode.Exclusive,
        samples = {vk.Sample_Count_Flag._1},
        flags = {}, // sparse voxel terrains, etc
    };

    check_vk_success(vk.create_image(device, &image_info, nil, image),
        "Failed to create image.");

    mem_requirements: vk.Memory_Requirements = ---;
    vk.get_image_memory_requirements(device, image^, &mem_requirements);

    alloc_info := vk.Memory_Allocate_Info {
        s_type = vk.Structure_Type.Memory_Allocate_Info,
        allocation_size = mem_requirements.size,
        memory_type_index = find_memory_type(
            physical_device, mem_requirements.memory_type_bits, {vk.Memory_Property_Flag.Device_Local}),
    };

    check_vk_success(vk.allocate_memory(device, &alloc_info, nil, image_memory),
        "Failed to allocate image memory.");

    vk.bind_image_memory(device, image^, image_memory^, 0);
}

create_image_view :: proc(device: vk.Device, image: vk.Image, format: vk.Format) -> vk.Image_View {
    view_info := vk.Image_View_Create_Info {
        s_type = vk.Structure_Type.Image_View_Create_Info,
        image = image,
        view_type = vk.Image_View_Type.D2,
        format = format,
        subresource_range = {
            aspect_mask = {vk.Image_Aspect_Flag.Color},
            base_mip_level = 0,
            level_count = 1,
            base_array_layer = 0,
            layer_count = 1,
        }
    };

    image_view: vk.Image_View = ---;
    check_vk_success(vk.create_image_view(device, &view_info, nil, &image_view),
        "Failed to create texture image view.");
    return image_view;

}
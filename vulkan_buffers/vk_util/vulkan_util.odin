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

get_max_usable_sample_count :: proc(props: vk.Physical_Device_Properties) -> vk.Sample_Count_Flag {
    using props.limits;

    counts : vk.Sample_Count_Flags;
    if framebuffer_color_sample_counts < framebuffer_depth_sample_counts {
        counts = framebuffer_color_sample_counts;
    } else {
        counts = framebuffer_depth_sample_counts;
    }

    if vk.Sample_Count_Flag._64 in counts do return vk.Sample_Count_Flag._64;
    if vk.Sample_Count_Flag._32 in counts do return vk.Sample_Count_Flag._32;
    if vk.Sample_Count_Flag._16 in counts do return vk.Sample_Count_Flag._16;
    if vk.Sample_Count_Flag._8 in counts do return vk.Sample_Count_Flag._8;
    if vk.Sample_Count_Flag._4 in counts do return vk.Sample_Count_Flag._4;
    if vk.Sample_Count_Flag._2 in counts do return vk.Sample_Count_Flag._2;
    return vk.Sample_Count_Flag._1;
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
    mip_levels: u32,
    num_samples: vk.Sample_Count_Flag,
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
        mip_levels = mip_levels,
        array_layers = 1,
        format = format,
        tiling = image_tiling,
        initial_layout = vk.Image_Layout.Undefined,
        usage = usage,
        sharing_mode = vk.Sharing_Mode.Exclusive,
        samples = {num_samples},
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
            physical_device, mem_requirements.memory_type_bits, properties),
    };

    check_vk_success(vk.allocate_memory(device, &alloc_info, nil, image_memory),
        "Failed to allocate image memory.");

    vk.bind_image_memory(device, image^, image_memory^, 0);
}

create_image_view :: proc(
    device: vk.Device,
    image: vk.Image,
    format: vk.Format,
    aspect_flags: vk.Image_Aspect_Flags,
    mip_levels: u32,
) -> vk.Image_View
{
    view_info := vk.Image_View_Create_Info {
        s_type = vk.Structure_Type.Image_View_Create_Info,
        image = image,
        view_type = vk.Image_View_Type.D2,
        format = format,
        subresource_range = {
            aspect_mask = aspect_flags,
            base_mip_level = 0,
            level_count = mip_levels,
            base_array_layer = 0,
            layer_count = 1,
        }
    };
    image_view: vk.Image_View = ---;
    check_vk_success(vk.create_image_view(device, &view_info, nil, &image_view),
        "Failed to create texture image view.");
    return image_view;
}

find_supported_format :: proc(
    physical_device: vk.Physical_Device,
    candidates: []vk.Format,
    tiling: vk.Image_Tiling,
    features: vk.Format_Feature_Flags) -> vk.Format
{
    for format in candidates {
        props: vk.Format_Properties = ---;
        vk.get_physical_device_format_properties(physical_device, format, &props);

        if tiling == vk.Image_Tiling.Linear && (features & props.linear_tiling_features) == features do return format;
        else if tiling == vk.Image_Tiling.Optimal && (features & props.optimal_tiling_features) == features do return format;
    }

    err_exit("Failed to find supported format.");
    return vk.Format.Undefined;
}

find_depth_format :: proc(physical_device: vk.Physical_Device) -> vk.Format {
    return find_supported_format(physical_device,
        {vk.Format.D32_Sfloat, vk.Format.D32_Sfloat_S8_Uint, vk.Format.D24_Unorm_S8_Uint},
        vk.Image_Tiling.Optimal,
        {vk.Format_Feature_Flag.Depth_Stencil_Attachment},
    );
}

has_stencil_component :: proc(format: vk.Format) -> bool {
    return format == vk.Format.D32_Sfloat_S8_Uint || format == vk.Format.D24_Unorm_S8_Uint;
}


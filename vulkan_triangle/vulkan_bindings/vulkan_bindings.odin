//
// Vulkan wrapper generated from "https://raw.githubusercontent.com/KhronosGroup/Vulkan-Docs/master/include/vulkan/vulkan_core.h"
//
package vulkan

import "core:c"
API_VERSION_1_0 :: (1<<22) | (0<<12) | (0);

MAKE_VERSION :: proc(major, minor, patch: u32) -> u32 {
	return (major<<22) | (minor<<12) | (patch);
}

// Base types
Flags       :: distinct u32;
Device_Size :: distinct u64;
Sample_Mask :: distinct u32;

Handle                  :: opaque rawptr;
Non_Dispatchable_Handle :: opaque u64;

Set_Proc_Address_Type :: #type proc(p: rawptr, instance: Instance, name: cstring);


cstring_array :: ^cstring; // Helper Type

// Base constants
LOD_CLAMP_NONE                :: 1000.0;
REMAINING_MIP_LEVELS          :: ~u32(0);
REMAINING_ARRAY_LAYERS        :: ~u32(0);
WHOLE_SIZE                    :: ~u64(0);
ATTACHMENT_UNUSED             :: ~u32(0);
TRUE                          :: true;
FALSE                         :: false;
QUEUE_FAMILY_IGNORED          :: ~u32(0);
SUBPASS_EXTERNAL              :: ~u32(0);
MAX_PHYSICAL_DEVICE_NAME_SIZE :: 256;
UUID_SIZE                     :: 16;
MAX_MEMORY_TYPES              :: 32;
MAX_MEMORY_HEAPS              :: 16;
MAX_EXTENSION_NAME_SIZE       :: 256;
MAX_DESCRIPTION_SIZE          :: 256;
MAX_DEVICE_GROUP_SIZE_KHX     :: 32;
MAX_DEVICE_GROUP_SIZE         :: 32;
LUID_SIZE_KHX                 :: 8;
LUID_SIZE_KHR                 :: 8;
LUID_SIZE                     :: 8;
MAX_DRIVER_NAME_SIZE_KHR      :: 256;
MAX_DRIVER_INFO_SIZE_KHR      :: 256;
MAX_QUEUE_FAMILY_EXTERNAL     :: ~u32(0)-1;

// Vendor Constants
KHR_surface                                         :: 1;
KHR_SURFACE_SPEC_VERSION                            :: 25;
KHR_SURFACE_EXTENSION_NAME                          :: "VK_KHR_surface";
KHR_swapchain                                       :: 1;
KHR_SWAPCHAIN_SPEC_VERSION                          :: 70;
KHR_SWAPCHAIN_EXTENSION_NAME                        :: "VK_KHR_swapchain";
KHR_display                                         :: 1;
KHR_DISPLAY_SPEC_VERSION                            :: 21;
KHR_DISPLAY_EXTENSION_NAME                          :: "VK_KHR_display";
KHR_display_swapchain                               :: 1;
KHR_DISPLAY_SWAPCHAIN_SPEC_VERSION                  :: 9;
KHR_DISPLAY_SWAPCHAIN_EXTENSION_NAME                :: "VK_KHR_display_swapchain";
KHR_sampler_mirror_clamp_to_edge                    :: 1;
KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_SPEC_VERSION       :: 1;
KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_EXTENSION_NAME     :: "VK_KHR_sampler_mirror_clamp_to_edge";
KHR_multiview                                       :: 1;
KHR_MULTIVIEW_SPEC_VERSION                          :: 1;
KHR_MULTIVIEW_EXTENSION_NAME                        :: "VK_KHR_multiview";
KHR_get_physical_device_properties2                 :: 1;
KHR_GET_PHYSICAL_DEVICE_PROPERTIES_2_SPEC_VERSION   :: 1;
KHR_GET_PHYSICAL_DEVICE_PROPERTIES_2_EXTENSION_NAME :: "VK_KHR_get_physical_device_properties2";
KHR_device_group                                    :: 1;
KHR_DEVICE_GROUP_SPEC_VERSION                       :: 3;
KHR_DEVICE_GROUP_EXTENSION_NAME                     :: "VK_KHR_device_group";
KHR_shader_draw_parameters                          :: 1;
KHR_SHADER_DRAW_PARAMETERS_SPEC_VERSION             :: 1;
KHR_SHADER_DRAW_PARAMETERS_EXTENSION_NAME           :: "VK_KHR_shader_draw_parameters";
KHR_maintenance1                                    :: 1;
KHR_MAINTENANCE1_SPEC_VERSION                       :: 2;
KHR_MAINTENANCE1_EXTENSION_NAME                     :: "VK_KHR_maintenance1";
KHR_device_group_creation                           :: 1;
KHR_DEVICE_GROUP_CREATION_SPEC_VERSION              :: 1;
KHR_DEVICE_GROUP_CREATION_EXTENSION_NAME            :: "VK_KHR_device_group_creation";
KHR_external_memory_capabilities                    :: 1;
KHR_EXTERNAL_MEMORY_CAPABILITIES_SPEC_VERSION       :: 1;
KHR_EXTERNAL_MEMORY_CAPABILITIES_EXTENSION_NAME     :: "VK_KHR_external_memory_capabilities";
KHR_external_memory                                 :: 1;
KHR_EXTERNAL_MEMORY_SPEC_VERSION                    :: 1;
KHR_EXTERNAL_MEMORY_EXTENSION_NAME                  :: "VK_KHR_external_memory";
KHR_external_memory_fd                              :: 1;
KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION                 :: 1;
KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME               :: "VK_KHR_external_memory_fd";
KHR_external_semaphore_capabilities                 :: 1;
KHR_EXTERNAL_SEMAPHORE_CAPABILITIES_SPEC_VERSION    :: 1;
KHR_EXTERNAL_SEMAPHORE_CAPABILITIES_EXTENSION_NAME  :: "VK_KHR_external_semaphore_capabilities";
KHR_external_semaphore                              :: 1;
KHR_EXTERNAL_SEMAPHORE_SPEC_VERSION                 :: 1;
KHR_EXTERNAL_SEMAPHORE_EXTENSION_NAME               :: "VK_KHR_external_semaphore";
KHR_external_semaphore_fd                           :: 1;
KHR_EXTERNAL_SEMAPHORE_FD_SPEC_VERSION              :: 1;
KHR_EXTERNAL_SEMAPHORE_FD_EXTENSION_NAME            :: "VK_KHR_external_semaphore_fd";
KHR_push_descriptor                                 :: 1;
KHR_PUSH_DESCRIPTOR_SPEC_VERSION                    :: 2;
KHR_PUSH_DESCRIPTOR_EXTENSION_NAME                  :: "VK_KHR_push_descriptor";
KHR_16bit_storage                                   :: 1;
KHR_16BIT_STORAGE_SPEC_VERSION                      :: 1;
KHR_16BIT_STORAGE_EXTENSION_NAME                    :: "VK_KHR_16bit_storage";
KHR_incremental_present                             :: 1;
KHR_INCREMENTAL_PRESENT_SPEC_VERSION                :: 1;
KHR_INCREMENTAL_PRESENT_EXTENSION_NAME              :: "VK_KHR_incremental_present";
KHR_descriptor_update_template                      :: 1;
KHR_DESCRIPTOR_UPDATE_TEMPLATE_SPEC_VERSION         :: 1;
KHR_DESCRIPTOR_UPDATE_TEMPLATE_EXTENSION_NAME       :: "VK_KHR_descriptor_update_template";
KHR_create_renderpass2                              :: 1;
KHR_CREATE_RENDERPASS_2_SPEC_VERSION                :: 1;
KHR_CREATE_RENDERPASS_2_EXTENSION_NAME              :: "VK_KHR_create_renderpass2";
KHR_shared_presentable_image                        :: 1;
KHR_SHARED_PRESENTABLE_IMAGE_SPEC_VERSION           :: 1;
KHR_SHARED_PRESENTABLE_IMAGE_EXTENSION_NAME         :: "VK_KHR_shared_presentable_image";
KHR_external_fence_capabilities                     :: 1;
KHR_EXTERNAL_FENCE_CAPABILITIES_SPEC_VERSION        :: 1;
KHR_EXTERNAL_FENCE_CAPABILITIES_EXTENSION_NAME      :: "VK_KHR_external_fence_capabilities";
KHR_external_fence                                  :: 1;
KHR_EXTERNAL_FENCE_SPEC_VERSION                     :: 1;
KHR_EXTERNAL_FENCE_EXTENSION_NAME                   :: "VK_KHR_external_fence";
KHR_external_fence_fd                               :: 1;
KHR_EXTERNAL_FENCE_FD_SPEC_VERSION                  :: 1;
KHR_EXTERNAL_FENCE_FD_EXTENSION_NAME                :: "VK_KHR_external_fence_fd";
KHR_maintenance2                                    :: 1;
KHR_MAINTENANCE2_SPEC_VERSION                       :: 1;
KHR_MAINTENANCE2_EXTENSION_NAME                     :: "VK_KHR_maintenance2";
KHR_get_surface_capabilities2                       :: 1;
KHR_GET_SURFACE_CAPABILITIES_2_SPEC_VERSION         :: 1;
KHR_GET_SURFACE_CAPABILITIES_2_EXTENSION_NAME       :: "VK_KHR_get_surface_capabilities2";
KHR_variable_pointers                               :: 1;
KHR_VARIABLE_POINTERS_SPEC_VERSION                  :: 1;
KHR_VARIABLE_POINTERS_EXTENSION_NAME                :: "VK_KHR_variable_pointers";
KHR_get_display_properties2                         :: 1;
KHR_GET_DISPLAY_PROPERTIES_2_SPEC_VERSION           :: 1;
KHR_GET_DISPLAY_PROPERTIES_2_EXTENSION_NAME         :: "VK_KHR_get_display_properties2";
KHR_dedicated_allocation                            :: 1;
KHR_DEDICATED_ALLOCATION_SPEC_VERSION               :: 3;
KHR_DEDICATED_ALLOCATION_EXTENSION_NAME             :: "VK_KHR_dedicated_allocation";
KHR_storage_buffer_storage_class                    :: 1;
KHR_STORAGE_BUFFER_STORAGE_CLASS_SPEC_VERSION       :: 1;
KHR_STORAGE_BUFFER_STORAGE_CLASS_EXTENSION_NAME     :: "VK_KHR_storage_buffer_storage_class";
KHR_relaxed_block_layout                            :: 1;
KHR_RELAXED_BLOCK_LAYOUT_SPEC_VERSION               :: 1;
KHR_RELAXED_BLOCK_LAYOUT_EXTENSION_NAME             :: "VK_KHR_relaxed_block_layout";
KHR_get_memory_requirements2                        :: 1;
KHR_GET_MEMORY_REQUIREMENTS_2_SPEC_VERSION          :: 1;
KHR_GET_MEMORY_REQUIREMENTS_2_EXTENSION_NAME        :: "VK_KHR_get_memory_requirements2";
KHR_image_format_list                               :: 1;
KHR_IMAGE_FORMAT_LIST_SPEC_VERSION                  :: 1;
KHR_IMAGE_FORMAT_LIST_EXTENSION_NAME                :: "VK_KHR_image_format_list";
KHR_sampler_ycbcr_conversion                        :: 1;
KHR_SAMPLER_YCBCR_CONVERSION_SPEC_VERSION           :: 1;
KHR_SAMPLER_YCBCR_CONVERSION_EXTENSION_NAME         :: "VK_KHR_sampler_ycbcr_conversion";
KHR_bind_memory2                                    :: 1;
KHR_BIND_MEMORY_2_SPEC_VERSION                      :: 1;
KHR_BIND_MEMORY_2_EXTENSION_NAME                    :: "VK_KHR_bind_memory2";
KHR_maintenance3                                    :: 1;
KHR_MAINTENANCE3_SPEC_VERSION                       :: 1;
KHR_MAINTENANCE3_EXTENSION_NAME                     :: "VK_KHR_maintenance3";
KHR_draw_indirect_count                             :: 1;
KHR_DRAW_INDIRECT_COUNT_SPEC_VERSION                :: 1;
KHR_DRAW_INDIRECT_COUNT_EXTENSION_NAME              :: "VK_KHR_draw_indirect_count";
KHR_8bit_storage                                    :: 1;
KHR_8BIT_STORAGE_SPEC_VERSION                       :: 1;
KHR_8BIT_STORAGE_EXTENSION_NAME                     :: "VK_KHR_8bit_storage";
KHR_shader_atomic_int64                             :: 1;
KHR_SHADER_ATOMIC_INT64_SPEC_VERSION                :: 1;
KHR_SHADER_ATOMIC_INT64_EXTENSION_NAME              :: "VK_KHR_shader_atomic_int64";
KHR_driver_properties                               :: 1;
KHR_DRIVER_PROPERTIES_SPEC_VERSION                  :: 1;
KHR_DRIVER_PROPERTIES_EXTENSION_NAME                :: "VK_KHR_driver_properties";
KHR_vulkan_memory_model                             :: 1;
KHR_VULKAN_MEMORY_MODEL_SPEC_VERSION                :: 2;
KHR_VULKAN_MEMORY_MODEL_EXTENSION_NAME              :: "VK_KHR_vulkan_memory_model";
EXT_debug_report                                    :: 1;
EXT_DEBUG_REPORT_SPEC_VERSION                       :: 9;
EXT_DEBUG_REPORT_EXTENSION_NAME                     :: "VK_EXT_debug_report";
NV_glsl_shader                                      :: 1;
NV_GLSL_SHADER_SPEC_VERSION                         :: 1;
NV_GLSL_SHADER_EXTENSION_NAME                       :: "VK_NV_glsl_shader";
EXT_depth_range_unrestricted                        :: 1;
EXT_DEPTH_RANGE_UNRESTRICTED_SPEC_VERSION           :: 1;
EXT_DEPTH_RANGE_UNRESTRICTED_EXTENSION_NAME         :: "VK_EXT_depth_range_unrestricted";
AMD_rasterization_order                             :: 1;
AMD_RASTERIZATION_ORDER_SPEC_VERSION                :: 1;
AMD_RASTERIZATION_ORDER_EXTENSION_NAME              :: "VK_AMD_rasterization_order";
AMD_shader_trinary_minmax                           :: 1;
AMD_SHADER_TRINARY_MINMAX_SPEC_VERSION              :: 1;
AMD_SHADER_TRINARY_MINMAX_EXTENSION_NAME            :: "VK_AMD_shader_trinary_minmax";
AMD_shader_explicit_vertex_parameter                :: 1;
AMD_SHADER_EXPLICIT_VERTEX_PARAMETER_SPEC_VERSION   :: 1;
AMD_SHADER_EXPLICIT_VERTEX_PARAMETER_EXTENSION_NAME :: "VK_AMD_shader_explicit_vertex_parameter";
EXT_debug_marker                                    :: 1;
EXT_DEBUG_MARKER_SPEC_VERSION                       :: 4;
EXT_DEBUG_MARKER_EXTENSION_NAME                     :: "VK_EXT_debug_marker";
AMD_gcn_shader                                      :: 1;
AMD_GCN_SHADER_SPEC_VERSION                         :: 1;
AMD_GCN_SHADER_EXTENSION_NAME                       :: "VK_AMD_gcn_shader";
NV_dedicated_allocation                             :: 1;
NV_DEDICATED_ALLOCATION_SPEC_VERSION                :: 1;
NV_DEDICATED_ALLOCATION_EXTENSION_NAME              :: "VK_NV_dedicated_allocation";
EXT_transform_feedback                              :: 1;
EXT_TRANSFORM_FEEDBACK_SPEC_VERSION                 :: 1;
EXT_TRANSFORM_FEEDBACK_EXTENSION_NAME               :: "VK_EXT_transform_feedback";
AMD_draw_indirect_count                             :: 1;
AMD_DRAW_INDIRECT_COUNT_SPEC_VERSION                :: 1;
AMD_DRAW_INDIRECT_COUNT_EXTENSION_NAME              :: "VK_AMD_draw_indirect_count";
AMD_negative_viewport_height                        :: 1;
AMD_NEGATIVE_VIEWPORT_HEIGHT_SPEC_VERSION           :: 1;
AMD_NEGATIVE_VIEWPORT_HEIGHT_EXTENSION_NAME         :: "VK_AMD_negative_viewport_height";
AMD_gpu_shader_half_float                           :: 1;
AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION              :: 1;
AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME            :: "VK_AMD_gpu_shader_half_float";
AMD_shader_ballot                                   :: 1;
AMD_SHADER_BALLOT_SPEC_VERSION                      :: 1;
AMD_SHADER_BALLOT_EXTENSION_NAME                    :: "VK_AMD_shader_ballot";
AMD_texture_gather_bias_lod                         :: 1;
AMD_TEXTURE_GATHER_BIAS_LOD_SPEC_VERSION            :: 1;
AMD_TEXTURE_GATHER_BIAS_LOD_EXTENSION_NAME          :: "VK_AMD_texture_gather_bias_lod";
AMD_shader_info                                     :: 1;
AMD_SHADER_INFO_SPEC_VERSION                        :: 1;
AMD_SHADER_INFO_EXTENSION_NAME                      :: "VK_AMD_shader_info";
AMD_shader_image_load_store_lod                     :: 1;
AMD_SHADER_IMAGE_LOAD_STORE_LOD_SPEC_VERSION        :: 1;
AMD_SHADER_IMAGE_LOAD_STORE_LOD_EXTENSION_NAME      :: "VK_AMD_shader_image_load_store_lod";
NV_corner_sampled_image                             :: 1;
NV_CORNER_SAMPLED_IMAGE_SPEC_VERSION                :: 2;
NV_CORNER_SAMPLED_IMAGE_EXTENSION_NAME              :: "VK_NV_corner_sampled_image";
NV_external_memory_capabilities                     :: 1;
NV_EXTERNAL_MEMORY_CAPABILITIES_SPEC_VERSION        :: 1;
NV_EXTERNAL_MEMORY_CAPABILITIES_EXTENSION_NAME      :: "VK_NV_external_memory_capabilities";
NV_external_memory                                  :: 1;
NV_EXTERNAL_MEMORY_SPEC_VERSION                     :: 1;
NV_EXTERNAL_MEMORY_EXTENSION_NAME                   :: "VK_NV_external_memory";
EXT_validation_flags                                :: 1;
EXT_VALIDATION_FLAGS_SPEC_VERSION                   :: 1;
EXT_VALIDATION_FLAGS_EXTENSION_NAME                 :: "VK_EXT_validation_flags";
EXT_shader_subgroup_ballot                          :: 1;
EXT_SHADER_SUBGROUP_BALLOT_SPEC_VERSION             :: 1;
EXT_SHADER_SUBGROUP_BALLOT_EXTENSION_NAME           :: "VK_EXT_shader_subgroup_ballot";
EXT_shader_subgroup_vote                            :: 1;
EXT_SHADER_SUBGROUP_VOTE_SPEC_VERSION               :: 1;
EXT_SHADER_SUBGROUP_VOTE_EXTENSION_NAME             :: "VK_EXT_shader_subgroup_vote";
EXT_astc_decode_mode                                :: 1;
EXT_ASTC_DECODE_MODE_SPEC_VERSION                   :: 1;
EXT_ASTC_DECODE_MODE_EXTENSION_NAME                 :: "VK_EXT_astc_decode_mode";
EXT_conditional_rendering                           :: 1;
EXT_CONDITIONAL_RENDERING_SPEC_VERSION              :: 1;
EXT_CONDITIONAL_RENDERING_EXTENSION_NAME            :: "VK_EXT_conditional_rendering";
NVX_device_generated_commands                       :: 1;
NVX_DEVICE_GENERATED_COMMANDS_SPEC_VERSION          :: 3;
NVX_DEVICE_GENERATED_COMMANDS_EXTENSION_NAME        :: "VK_NVX_device_generated_commands";
NV_clip_space_w_scaling                             :: 1;
NV_CLIP_SPACE_W_SCALING_SPEC_VERSION                :: 1;
NV_CLIP_SPACE_W_SCALING_EXTENSION_NAME              :: "VK_NV_clip_space_w_scaling";
EXT_direct_mode_display                             :: 1;
EXT_DIRECT_MODE_DISPLAY_SPEC_VERSION                :: 1;
EXT_DIRECT_MODE_DISPLAY_EXTENSION_NAME              :: "VK_EXT_direct_mode_display";
EXT_display_surface_counter                         :: 1;
EXT_DISPLAY_SURFACE_COUNTER_SPEC_VERSION            :: 1;
EXT_DISPLAY_SURFACE_COUNTER_EXTENSION_NAME          :: "VK_EXT_display_surface_counter";
EXT_display_control                                 :: 1;
EXT_DISPLAY_CONTROL_SPEC_VERSION                    :: 1;
EXT_DISPLAY_CONTROL_EXTENSION_NAME                  :: "VK_EXT_display_control";
GOOGLE_display_timing                               :: 1;
GOOGLE_DISPLAY_TIMING_SPEC_VERSION                  :: 1;
GOOGLE_DISPLAY_TIMING_EXTENSION_NAME                :: "VK_GOOGLE_display_timing";
NV_sample_mask_override_coverage                    :: 1;
NV_SAMPLE_MASK_OVERRIDE_COVERAGE_SPEC_VERSION       :: 1;
NV_SAMPLE_MASK_OVERRIDE_COVERAGE_EXTENSION_NAME     :: "VK_NV_sample_mask_override_coverage";
NV_geometry_shader_passthrough                      :: 1;
NV_GEOMETRY_SHADER_PASSTHROUGH_SPEC_VERSION         :: 1;
NV_GEOMETRY_SHADER_PASSTHROUGH_EXTENSION_NAME       :: "VK_NV_geometry_shader_passthrough";
NV_viewport_array2                                  :: 1;
NV_VIEWPORT_ARRAY2_SPEC_VERSION                     :: 1;
NV_VIEWPORT_ARRAY2_EXTENSION_NAME                   :: "VK_NV_viewport_array2";
NVX_multiview_per_view_attributes                   :: 1;
NVX_MULTIVIEW_PER_VIEW_ATTRIBUTES_SPEC_VERSION      :: 1;
NVX_MULTIVIEW_PER_VIEW_ATTRIBUTES_EXTENSION_NAME    :: "VK_NVX_multiview_per_view_attributes";
NV_viewport_swizzle                                 :: 1;
NV_VIEWPORT_SWIZZLE_SPEC_VERSION                    :: 1;
NV_VIEWPORT_SWIZZLE_EXTENSION_NAME                  :: "VK_NV_viewport_swizzle";
EXT_discard_rectangles                              :: 1;
EXT_DISCARD_RECTANGLES_SPEC_VERSION                 :: 1;
EXT_DISCARD_RECTANGLES_EXTENSION_NAME               :: "VK_EXT_discard_rectangles";
EXT_conservative_rasterization                      :: 1;
EXT_CONSERVATIVE_RASTERIZATION_SPEC_VERSION         :: 1;
EXT_CONSERVATIVE_RASTERIZATION_EXTENSION_NAME       :: "VK_EXT_conservative_rasterization";
EXT_swapchain_colorspace                            :: 1;
EXT_SWAPCHAIN_COLOR_SPACE_SPEC_VERSION              :: 3;
EXT_SWAPCHAIN_COLOR_SPACE_EXTENSION_NAME            :: "VK_EXT_swapchain_colorspace";
EXT_hdr_metadata                                    :: 1;
EXT_HDR_METADATA_SPEC_VERSION                       :: 1;
EXT_HDR_METADATA_EXTENSION_NAME                     :: "VK_EXT_hdr_metadata";
EXT_external_memory_dma_buf                         :: 1;
EXT_EXTERNAL_MEMORY_DMA_BUF_SPEC_VERSION            :: 1;
EXT_EXTERNAL_MEMORY_DMA_BUF_EXTENSION_NAME          :: "VK_EXT_external_memory_dma_buf";
EXT_queue_family_foreign                            :: 1;
EXT_QUEUE_FAMILY_FOREIGN_SPEC_VERSION               :: 1;
EXT_QUEUE_FAMILY_FOREIGN_EXTENSION_NAME             :: "VK_EXT_queue_family_foreign";
EXT_debug_utils                                     :: 1;
EXT_DEBUG_UTILS_SPEC_VERSION                        :: 1;
EXT_DEBUG_UTILS_EXTENSION_NAME                      :: "VK_EXT_debug_utils";
EXT_sampler_filter_minmax                           :: 1;
EXT_SAMPLER_FILTER_MINMAX_SPEC_VERSION              :: 1;
EXT_SAMPLER_FILTER_MINMAX_EXTENSION_NAME            :: "VK_EXT_sampler_filter_minmax";
AMD_gpu_shader_int16                                :: 1;
AMD_GPU_SHADER_INT16_SPEC_VERSION                   :: 1;
AMD_GPU_SHADER_INT16_EXTENSION_NAME                 :: "VK_AMD_gpu_shader_int16";
AMD_mixed_attachment_samples                        :: 1;
AMD_MIXED_ATTACHMENT_SAMPLES_SPEC_VERSION           :: 1;
AMD_MIXED_ATTACHMENT_SAMPLES_EXTENSION_NAME         :: "VK_AMD_mixed_attachment_samples";
AMD_shader_fragment_mask                            :: 1;
AMD_SHADER_FRAGMENT_MASK_SPEC_VERSION               :: 1;
AMD_SHADER_FRAGMENT_MASK_EXTENSION_NAME             :: "VK_AMD_shader_fragment_mask";
EXT_inline_uniform_block                            :: 1;
EXT_INLINE_UNIFORM_BLOCK_SPEC_VERSION               :: 1;
EXT_INLINE_UNIFORM_BLOCK_EXTENSION_NAME             :: "VK_EXT_inline_uniform_block";
EXT_shader_stencil_export                           :: 1;
EXT_SHADER_STENCIL_EXPORT_SPEC_VERSION              :: 1;
EXT_SHADER_STENCIL_EXPORT_EXTENSION_NAME            :: "VK_EXT_shader_stencil_export";
EXT_sample_locations                                :: 1;
EXT_SAMPLE_LOCATIONS_SPEC_VERSION                   :: 1;
EXT_SAMPLE_LOCATIONS_EXTENSION_NAME                 :: "VK_EXT_sample_locations";
EXT_blend_operation_advanced                        :: 1;
EXT_BLEND_OPERATION_ADVANCED_SPEC_VERSION           :: 2;
EXT_BLEND_OPERATION_ADVANCED_EXTENSION_NAME         :: "VK_EXT_blend_operation_advanced";
NV_fragment_coverage_to_color                       :: 1;
NV_FRAGMENT_COVERAGE_TO_COLOR_SPEC_VERSION          :: 1;
NV_FRAGMENT_COVERAGE_TO_COLOR_EXTENSION_NAME        :: "VK_NV_fragment_coverage_to_color";
NV_framebuffer_mixed_samples                        :: 1;
NV_FRAMEBUFFER_MIXED_SAMPLES_SPEC_VERSION           :: 1;
NV_FRAMEBUFFER_MIXED_SAMPLES_EXTENSION_NAME         :: "VK_NV_framebuffer_mixed_samples";
NV_fill_rectangle                                   :: 1;
NV_FILL_RECTANGLE_SPEC_VERSION                      :: 1;
NV_FILL_RECTANGLE_EXTENSION_NAME                    :: "VK_NV_fill_rectangle";
EXT_post_depth_coverage                             :: 1;
EXT_POST_DEPTH_COVERAGE_SPEC_VERSION                :: 1;
EXT_POST_DEPTH_COVERAGE_EXTENSION_NAME              :: "VK_EXT_post_depth_coverage";
EXT_image_drm_format_modifier                       :: 1;
EXT_EXTENSION_159_SPEC_VERSION                      :: 0;
EXT_EXTENSION_159_EXTENSION_NAME                    :: "VK_EXT_extension_159";
EXT_IMAGE_DRM_FORMAT_MODIFIER_SPEC_VERSION          :: 1;
EXT_IMAGE_DRM_FORMAT_MODIFIER_EXTENSION_NAME        :: "VK_EXT_image_drm_format_modifier";
EXT_validation_cache                                :: 1;
EXT_VALIDATION_CACHE_SPEC_VERSION                   :: 1;
EXT_VALIDATION_CACHE_EXTENSION_NAME                 :: "VK_EXT_validation_cache";
EXT_descriptor_indexing                             :: 1;
EXT_DESCRIPTOR_INDEXING_SPEC_VERSION                :: 2;
EXT_DESCRIPTOR_INDEXING_EXTENSION_NAME              :: "VK_EXT_descriptor_indexing";
EXT_shader_viewport_index_layer                     :: 1;
EXT_SHADER_VIEWPORT_INDEX_LAYER_SPEC_VERSION        :: 1;
EXT_SHADER_VIEWPORT_INDEX_LAYER_EXTENSION_NAME      :: "VK_EXT_shader_viewport_index_layer";
NV_shading_rate_image                               :: 1;
NV_SHADING_RATE_IMAGE_SPEC_VERSION                  :: 3;
NV_SHADING_RATE_IMAGE_EXTENSION_NAME                :: "VK_NV_shading_rate_image";
NVX_raytracing                                      :: 1;
NVX_RAYTRACING_SPEC_VERSION                         :: 1;
NVX_RAYTRACING_EXTENSION_NAME                       :: "VK_NVX_raytracing";
NV_representative_fragment_test                     :: 1;
NV_REPRESENTATIVE_FRAGMENT_TEST_SPEC_VERSION        :: 1;
NV_REPRESENTATIVE_FRAGMENT_TEST_EXTENSION_NAME      :: "VK_NV_representative_fragment_test";
EXT_global_priority                                 :: 1;
EXT_GLOBAL_PRIORITY_SPEC_VERSION                    :: 2;
EXT_GLOBAL_PRIORITY_EXTENSION_NAME                  :: "VK_EXT_global_priority";
EXT_external_memory_host                            :: 1;
EXT_EXTERNAL_MEMORY_HOST_SPEC_VERSION               :: 1;
EXT_EXTERNAL_MEMORY_HOST_EXTENSION_NAME             :: "VK_EXT_external_memory_host";
AMD_buffer_marker                                   :: 1;
AMD_BUFFER_MARKER_SPEC_VERSION                      :: 1;
AMD_BUFFER_MARKER_EXTENSION_NAME                    :: "VK_AMD_buffer_marker";
EXT_calibrated_timestamps                           :: 1;
EXT_CALIBRATED_TIMESTAMPS_SPEC_VERSION              :: 1;
EXT_CALIBRATED_TIMESTAMPS_EXTENSION_NAME            :: "VK_EXT_calibrated_timestamps";
AMD_shader_core_properties                          :: 1;
AMD_SHADER_CORE_PROPERTIES_SPEC_VERSION             :: 1;
AMD_SHADER_CORE_PROPERTIES_EXTENSION_NAME           :: "VK_AMD_shader_core_properties";
EXT_vertex_attribute_divisor                        :: 1;
EXT_VERTEX_ATTRIBUTE_DIVISOR_SPEC_VERSION           :: 3;
EXT_VERTEX_ATTRIBUTE_DIVISOR_EXTENSION_NAME         :: "VK_EXT_vertex_attribute_divisor";
NV_shader_subgroup_partitioned                      :: 1;
NV_SHADER_SUBGROUP_PARTITIONED_SPEC_VERSION         :: 1;
NV_SHADER_SUBGROUP_PARTITIONED_EXTENSION_NAME       :: "VK_NV_shader_subgroup_partitioned";
NV_compute_shader_derivatives                       :: 1;
NV_COMPUTE_SHADER_DERIVATIVES_SPEC_VERSION          :: 1;
NV_COMPUTE_SHADER_DERIVATIVES_EXTENSION_NAME        :: "VK_NV_compute_shader_derivatives";
NV_mesh_shader                                      :: 1;
NV_MESH_SHADER_SPEC_VERSION                         :: 1;
NV_MESH_SHADER_EXTENSION_NAME                       :: "VK_NV_mesh_shader";
NV_fragment_shader_barycentric                      :: 1;
NV_FRAGMENT_SHADER_BARYCENTRIC_SPEC_VERSION         :: 1;
NV_FRAGMENT_SHADER_BARYCENTRIC_EXTENSION_NAME       :: "VK_NV_fragment_shader_barycentric";
NV_shader_image_footprint                           :: 1;
NV_SHADER_IMAGE_FOOTPRINT_SPEC_VERSION              :: 1;
NV_SHADER_IMAGE_FOOTPRINT_EXTENSION_NAME            :: "VK_NV_shader_image_footprint";
NV_scissor_exclusive                                :: 1;
NV_SCISSOR_EXCLUSIVE_SPEC_VERSION                   :: 1;
NV_SCISSOR_EXCLUSIVE_EXTENSION_NAME                 :: "VK_NV_scissor_exclusive";
NV_device_diagnostic_checkpoints                    :: 1;
NV_DEVICE_DIAGNOSTIC_CHECKPOINTS_SPEC_VERSION       :: 2;
NV_DEVICE_DIAGNOSTIC_CHECKPOINTS_EXTENSION_NAME     :: "VK_NV_device_diagnostic_checkpoints";
EXT_pci_bus_info                                    :: 1;
EXT_PCI_BUS_INFO_SPEC_VERSION                       :: 1;
EXT_PCI_BUS_INFO_EXTENSION_NAME                     :: "VK_EXT_pci_bus_info";
GOOGLE_hlsl_functionality1                          :: 1;
GOOGLE_HLSL_FUNCTIONALITY1_SPEC_VERSION             :: 0;
GOOGLE_HLSL_FUNCTIONALITY1_EXTENSION_NAME           :: "VK_GOOGLE_hlsl_functionality1";
GOOGLE_decorate_string                              :: 1;
GOOGLE_DECORATE_STRING_SPEC_VERSION                 :: 0;
GOOGLE_DECORATE_STRING_EXTENSION_NAME               :: "VK_GOOGLE_decorate_string";

// Handles types
Instance        :: distinct Handle;
Physical_Device :: distinct Handle;
Device          :: distinct Handle;
Queue           :: distinct Handle;
Command_Buffer  :: distinct Handle;
Semaphore                    :: distinct Non_Dispatchable_Handle;
Fence                        :: distinct Non_Dispatchable_Handle;
Device_Memory                :: distinct Non_Dispatchable_Handle;
Buffer                       :: distinct Non_Dispatchable_Handle;
Image                        :: distinct Non_Dispatchable_Handle;
Event                        :: distinct Non_Dispatchable_Handle;
Query_Pool                   :: distinct Non_Dispatchable_Handle;
Buffer_View                  :: distinct Non_Dispatchable_Handle;
Image_View                   :: distinct Non_Dispatchable_Handle;
Shader_Module                :: distinct Non_Dispatchable_Handle;
Pipeline_Cache               :: distinct Non_Dispatchable_Handle;
Pipeline_Layout              :: distinct Non_Dispatchable_Handle;
Render_Pass                  :: distinct Non_Dispatchable_Handle;
Pipeline                     :: distinct Non_Dispatchable_Handle;
Descriptor_Set_Layout        :: distinct Non_Dispatchable_Handle;
Sampler                      :: distinct Non_Dispatchable_Handle;
Descriptor_Pool              :: distinct Non_Dispatchable_Handle;
Descriptor_Set               :: distinct Non_Dispatchable_Handle;
Framebuffer                  :: distinct Non_Dispatchable_Handle;
Command_Pool                 :: distinct Non_Dispatchable_Handle;
Sampler_Ycbcr_Conversion     :: distinct Non_Dispatchable_Handle;
Descriptor_Update_Template   :: distinct Non_Dispatchable_Handle;
Surface_KHR                  :: distinct Non_Dispatchable_Handle;
Swapchain_KHR                :: distinct Non_Dispatchable_Handle;
Display_KHR                  :: distinct Non_Dispatchable_Handle;
Display_Mode_KHR             :: distinct Non_Dispatchable_Handle;
Debug_Report_Callback_EXT    :: distinct Non_Dispatchable_Handle;
Object_Table_NVX             :: distinct Non_Dispatchable_Handle;
Indirect_Commands_Layout_NVX :: distinct Non_Dispatchable_Handle;
Debug_Utils_Messenger_EXT    :: distinct Non_Dispatchable_Handle;
Validation_Cache_EXT         :: distinct Non_Dispatchable_Handle;
Acceleration_Structure_NVX   :: distinct Non_Dispatchable_Handle;



// Enums
Pipeline_Cache_Header_Version :: enum c.int {
	One         = 1,
	Begin_Range = One,
	End_Range   = One,
	Range_Size  = (One-One+1),
}

Result :: enum c.int {
	Success                                            = 0,
	Not_Ready                                          = 1,
	Timeout                                            = 2,
	Event_Set                                          = 3,
	Event_Reset                                        = 4,
	Incomplete                                         = 5,
	Error_Out_Of_Host_Memory                           = -1,
	Error_Out_Of_Device_Memory                         = -2,
	Error_Initialization_Failed                        = -3,
	Error_Device_Lost                                  = -4,
	Error_Memory_Map_Failed                            = -5,
	Error_Layer_Not_Present                            = -6,
	Error_Extension_Not_Present                        = -7,
	Error_Feature_Not_Present                          = -8,
	Error_Incompatible_Driver                          = -9,
	Error_Too_Many_Objects                             = -10,
	Error_Format_Not_Supported                         = -11,
	Error_Fragmented_Pool                              = -12,
	Error_Out_Of_Pool_Memory                           = -1000069000,
	Error_Invalid_External_Handle                      = -1000072003,
	Error_Surface_Lost_KHR                             = -1000000000,
	Error_Native_Window_In_Use_KHR                     = -1000000001,
	Suboptimal_KHR                                     = 1000001003,
	Error_Out_Of_Date_KHR                              = -1000001004,
	Error_Incompatible_Display_KHR                     = -1000003001,
	Error_Validation_Failed_EXT                        = -1000011001,
	Error_Invalid_Shader_NV                            = -1000012000,
	Error_Invalid_Drm_Format_Modifier_Plane_Layout_EXT = -1000158000,
	Error_Fragmentation_EXT                            = -1000161000,
	Error_Not_Permitted_EXT                            = -1000174001,
	Error_Out_Of_Pool_Memory_KHR                       = Error_Out_Of_Pool_Memory,
	Error_Invalid_External_Handle_KHR                  = Error_Invalid_External_Handle,
	Begin_Range                                        = Error_Fragmented_Pool,
	End_Range                                          = Incomplete,
	Range_Size                                         = (Incomplete-Error_Fragmented_Pool+1),
}

Structure_Type :: enum c.int {
	Application_Info                                             = 0,
	Instance_Create_Info                                         = 1,
	Device_Queue_Create_Info                                     = 2,
	Device_Create_Info                                           = 3,
	Submit_Info                                                  = 4,
	Memory_Allocate_Info                                         = 5,
	Mapped_Memory_Range                                          = 6,
	Bind_Sparse_Info                                             = 7,
	Fence_Create_Info                                            = 8,
	Semaphore_Create_Info                                        = 9,
	Event_Create_Info                                            = 10,
	Query_Pool_Create_Info                                       = 11,
	Buffer_Create_Info                                           = 12,
	Buffer_View_Create_Info                                      = 13,
	Image_Create_Info                                            = 14,
	Image_View_Create_Info                                       = 15,
	Shader_Module_Create_Info                                    = 16,
	Pipeline_Cache_Create_Info                                   = 17,
	Pipeline_Shader_Stage_Create_Info                            = 18,
	Pipeline_Vertex_Input_State_Create_Info                      = 19,
	Pipeline_Input_Assembly_State_Create_Info                    = 20,
	Pipeline_Tessellation_State_Create_Info                      = 21,
	Pipeline_Viewport_State_Create_Info                          = 22,
	Pipeline_Rasterization_State_Create_Info                     = 23,
	Pipeline_Multisample_State_Create_Info                       = 24,
	Pipeline_Depth_Stencil_State_Create_Info                     = 25,
	Pipeline_Color_Blend_State_Create_Info                       = 26,
	Pipeline_Dynamic_State_Create_Info                           = 27,
	Graphics_Pipeline_Create_Info                                = 28,
	Compute_Pipeline_Create_Info                                 = 29,
	Pipeline_Layout_Create_Info                                  = 30,
	Sampler_Create_Info                                          = 31,
	Descriptor_Set_Layout_Create_Info                            = 32,
	Descriptor_Pool_Create_Info                                  = 33,
	Descriptor_Set_Allocate_Info                                 = 34,
	Write_Descriptor_Set                                         = 35,
	Copy_Descriptor_Set                                          = 36,
	Framebuffer_Create_Info                                      = 37,
	Render_Pass_Create_Info                                      = 38,
	Command_Pool_Create_Info                                     = 39,
	Command_Buffer_Allocate_Info                                 = 40,
	Command_Buffer_Inheritance_Info                              = 41,
	Command_Buffer_Begin_Info                                    = 42,
	Render_Pass_Begin_Info                                       = 43,
	Buffer_Memory_Barrier                                        = 44,
	Image_Memory_Barrier                                         = 45,
	Memory_Barrier                                               = 46,
	Loader_Instance_Create_Info                                  = 47,
	Loader_Device_Create_Info                                    = 48,
	Physical_Device_Subgroup_Properties                          = 1000094000,
	Bind_Buffer_Memory_Info                                      = 1000157000,
	Bind_Image_Memory_Info                                       = 1000157001,
	Physical_Device_16Bit_Storage_Features                       = 1000083000,
	Memory_Dedicated_Requirements                                = 1000127000,
	Memory_Dedicated_Allocate_Info                               = 1000127001,
	Memory_Allocate_Flags_Info                                   = 1000060000,
	Device_Group_Render_Pass_Begin_Info                          = 1000060003,
	Device_Group_Command_Buffer_Begin_Info                       = 1000060004,
	Device_Group_Submit_Info                                     = 1000060005,
	Device_Group_Bind_Sparse_Info                                = 1000060006,
	Bind_Buffer_Memory_Device_Group_Info                         = 1000060013,
	Bind_Image_Memory_Device_Group_Info                          = 1000060014,
	Physical_Device_Group_Properties                             = 1000070000,
	Device_Group_Device_Create_Info                              = 1000070001,
	Buffer_Memory_Requirements_Info_2                            = 1000146000,
	Image_Memory_Requirements_Info_2                             = 1000146001,
	Image_Sparse_Memory_Requirements_Info_2                      = 1000146002,
	Memory_Requirements_2                                        = 1000146003,
	Sparse_Image_Memory_Requirements_2                           = 1000146004,
	Physical_Device_Features_2                                   = 1000059000,
	Physical_Device_Properties_2                                 = 1000059001,
	Format_Properties_2                                          = 1000059002,
	Image_Format_Properties_2                                    = 1000059003,
	Physical_Device_Image_Format_Info_2                          = 1000059004,
	Queue_Family_Properties_2                                    = 1000059005,
	Physical_Device_Memory_Properties_2                          = 1000059006,
	Sparse_Image_Format_Properties_2                             = 1000059007,
	Physical_Device_Sparse_Image_Format_Info_2                   = 1000059008,
	Physical_Device_Point_Clipping_Properties                    = 1000117000,
	Render_Pass_Input_Attachment_Aspect_Create_Info              = 1000117001,
	Image_View_Usage_Create_Info                                 = 1000117002,
	Pipeline_Tessellation_Domain_Origin_State_Create_Info        = 1000117003,
	Render_Pass_Multiview_Create_Info                            = 1000053000,
	Physical_Device_Multiview_Features                           = 1000053001,
	Physical_Device_Multiview_Properties                         = 1000053002,
	Physical_Device_Variable_Pointer_Features                    = 1000120000,
	Protected_Submit_Info                                        = 1000145000,
	Physical_Device_Protected_Memory_Features                    = 1000145001,
	Physical_Device_Protected_Memory_Properties                  = 1000145002,
	Device_Queue_Info_2                                          = 1000145003,
	Sampler_Ycbcr_Conversion_Create_Info                         = 1000156000,
	Sampler_Ycbcr_Conversion_Info                                = 1000156001,
	Bind_Image_Plane_Memory_Info                                 = 1000156002,
	Image_Plane_Memory_Requirements_Info                         = 1000156003,
	Physical_Device_Sampler_Ycbcr_Conversion_Features            = 1000156004,
	Sampler_Ycbcr_Conversion_Image_Format_Properties             = 1000156005,
	Descriptor_Update_Template_Create_Info                       = 1000085000,
	Physical_Device_External_Image_Format_Info                   = 1000071000,
	External_Image_Format_Properties                             = 1000071001,
	Physical_Device_External_Buffer_Info                         = 1000071002,
	External_Buffer_Properties                                   = 1000071003,
	Physical_Device_Id_Properties                                = 1000071004,
	External_Memory_Buffer_Create_Info                           = 1000072000,
	External_Memory_Image_Create_Info                            = 1000072001,
	Export_Memory_Allocate_Info                                  = 1000072002,
	Physical_Device_External_Fence_Info                          = 1000112000,
	External_Fence_Properties                                    = 1000112001,
	Export_Fence_Create_Info                                     = 1000113000,
	Export_Semaphore_Create_Info                                 = 1000077000,
	Physical_Device_External_Semaphore_Info                      = 1000076000,
	External_Semaphore_Properties                                = 1000076001,
	Physical_Device_Maintenance_3_Properties                     = 1000168000,
	Descriptor_Set_Layout_Support                                = 1000168001,
	Physical_Device_Shader_Draw_Parameter_Features               = 1000063000,
	Swapchain_Create_Info_KHR                                    = 1000001000,
	Present_Info_KHR                                             = 1000001001,
	Device_Group_Present_Capabilities_KHR                        = 1000060007,
	Image_Swapchain_Create_Info_KHR                              = 1000060008,
	Bind_Image_Memory_Swapchain_Info_KHR                         = 1000060009,
	Acquire_Next_Image_Info_KHR                                  = 1000060010,
	Device_Group_Present_Info_KHR                                = 1000060011,
	Device_Group_Swapchain_Create_Info_KHR                       = 1000060012,
	Display_Mode_Create_Info_KHR                                 = 1000002000,
	Display_Surface_Create_Info_KHR                              = 1000002001,
	Display_Present_Info_KHR                                     = 1000003000,
	Xlib_Surface_Create_Info_KHR                                 = 1000004000,
	Xcb_Surface_Create_Info_KHR                                  = 1000005000,
	Wayland_Surface_Create_Info_KHR                              = 1000006000,
	Mir_Surface_Create_Info_KHR                                  = 1000007000,
	Android_Surface_Create_Info_KHR                              = 1000008000,
	Win32_Surface_Create_Info_KHR                                = 1000009000,
	Debug_Report_Callback_Create_Info_EXT                        = 1000011000,
	Pipeline_Rasterization_State_Rasterization_Order_AMD         = 1000018000,
	Debug_Marker_Object_Name_Info_EXT                            = 1000022000,
	Debug_Marker_Object_Tag_Info_EXT                             = 1000022001,
	Debug_Marker_Marker_Info_EXT                                 = 1000022002,
	Dedicated_Allocation_Image_Create_Info_NV                    = 1000026000,
	Dedicated_Allocation_Buffer_Create_Info_NV                   = 1000026001,
	Dedicated_Allocation_Memory_Allocate_Info_NV                 = 1000026002,
	Physical_Device_Transform_Feedback_Features_EXT              = 1000028000,
	Physical_Device_Transform_Feedback_Properties_EXT            = 1000028001,
	Pipeline_Rasterization_State_Stream_Create_Info_EXT          = 1000028002,
	Texture_Lod_Gather_Format_Properties_AMD                     = 1000041000,
	Physical_Device_Corner_Sampled_Image_Features_NV             = 1000050000,
	External_Memory_Image_Create_Info_NV                         = 1000056000,
	Export_Memory_Allocate_Info_NV                               = 1000056001,
	Import_Memory_Win32_Handle_Info_NV                           = 1000057000,
	Export_Memory_Win32_Handle_Info_NV                           = 1000057001,
	Win32_Keyed_Mutex_Acquire_Release_Info_NV                    = 1000058000,
	Validation_Flags_EXT                                         = 1000061000,
	Vi_Surface_Create_Info_Nn                                    = 1000062000,
	Image_View_Astc_Decode_Mode_EXT                              = 1000067000,
	Physical_Device_Astc_Decode_Features_EXT                     = 1000067001,
	Import_Memory_Win32_Handle_Info_KHR                          = 1000073000,
	Export_Memory_Win32_Handle_Info_KHR                          = 1000073001,
	Memory_Win32_Handle_Properties_KHR                           = 1000073002,
	Memory_Get_Win32_Handle_Info_KHR                             = 1000073003,
	Import_Memory_Fd_Info_KHR                                    = 1000074000,
	Memory_Fd_Properties_KHR                                     = 1000074001,
	Memory_Get_Fd_Info_KHR                                       = 1000074002,
	Win32_Keyed_Mutex_Acquire_Release_Info_KHR                   = 1000075000,
	Import_Semaphore_Win32_Handle_Info_KHR                       = 1000078000,
	Export_Semaphore_Win32_Handle_Info_KHR                       = 1000078001,
	D3D12_Fence_Submit_Info_KHR                                  = 1000078002,
	Semaphore_Get_Win32_Handle_Info_KHR                          = 1000078003,
	Import_Semaphore_Fd_Info_KHR                                 = 1000079000,
	Semaphore_Get_Fd_Info_KHR                                    = 1000079001,
	Physical_Device_Push_Descriptor_Properties_KHR               = 1000080000,
	Command_Buffer_Inheritance_Conditional_Rendering_Info_EXT    = 1000081000,
	Physical_Device_Conditional_Rendering_Features_EXT           = 1000081001,
	Conditional_Rendering_Begin_Info_EXT                         = 1000081002,
	Present_Regions_KHR                                          = 1000084000,
	Object_Table_Create_Info_NVX                                 = 1000086000,
	Indirect_Commands_Layout_Create_Info_NVX                     = 1000086001,
	Cmd_Process_Commands_Info_NVX                                = 1000086002,
	Cmd_Reserve_Space_For_Commands_Info_NVX                      = 1000086003,
	Device_Generated_Commands_Limits_NVX                         = 1000086004,
	Device_Generated_Commands_Features_NVX                       = 1000086005,
	Pipeline_Viewport_W_Scaling_State_Create_Info_NV             = 1000087000,
	Surface_Capabilities_2_EXT                                   = 1000090000,
	Display_Power_Info_EXT                                       = 1000091000,
	Device_Event_Info_EXT                                        = 1000091001,
	Display_Event_Info_EXT                                       = 1000091002,
	Swapchain_Counter_Create_Info_EXT                            = 1000091003,
	Present_Times_Info_GOOGLE                                    = 1000092000,
	Physical_Device_Multiview_Per_View_Attributes_Properties_NVX = 1000097000,
	Pipeline_Viewport_Swizzle_State_Create_Info_NV               = 1000098000,
	Physical_Device_Discard_Rectangle_Properties_EXT             = 1000099000,
	Pipeline_Discard_Rectangle_State_Create_Info_EXT             = 1000099001,
	Physical_Device_Conservative_Rasterization_Properties_EXT    = 1000101000,
	Pipeline_Rasterization_Conservative_State_Create_Info_EXT    = 1000101001,
	Hdr_Metadata_EXT                                             = 1000105000,
	Attachment_Description_2_KHR                                 = 1000109000,
	Attachment_Reference_2_KHR                                   = 1000109001,
	Subpass_Description_2_KHR                                    = 1000109002,
	Subpass_Dependency_2_KHR                                     = 1000109003,
	Render_Pass_Create_Info_2_KHR                                = 1000109004,
	Subpass_Begin_Info_KHR                                       = 1000109005,
	Subpass_End_Info_KHR                                         = 1000109006,
	Shared_Present_Surface_Capabilities_KHR                      = 1000111000,
	Import_Fence_Win32_Handle_Info_KHR                           = 1000114000,
	Export_Fence_Win32_Handle_Info_KHR                           = 1000114001,
	Fence_Get_Win32_Handle_Info_KHR                              = 1000114002,
	Import_Fence_Fd_Info_KHR                                     = 1000115000,
	Fence_Get_Fd_Info_KHR                                        = 1000115001,
	Physical_Device_Surface_Info_2_KHR                           = 1000119000,
	Surface_Capabilities_2_KHR                                   = 1000119001,
	Surface_Format_2_KHR                                         = 1000119002,
	Display_Properties_2_KHR                                     = 1000121000,
	Display_Plane_Properties_2_KHR                               = 1000121001,
	Display_Mode_Properties_2_KHR                                = 1000121002,
	Display_Plane_Info_2_KHR                                     = 1000121003,
	Display_Plane_Capabilities_2_KHR                             = 1000121004,
	Ios_Surface_Create_Info_Mvk                                  = 1000122000,
	Macos_Surface_Create_Info_Mvk                                = 1000123000,
	Debug_Utils_Object_Name_Info_EXT                             = 1000128000,
	Debug_Utils_Object_Tag_Info_EXT                              = 1000128001,
	Debug_Utils_Label_EXT                                        = 1000128002,
	Debug_Utils_Messenger_Callback_Data_EXT                      = 1000128003,
	Debug_Utils_Messenger_Create_Info_EXT                        = 1000128004,
	Android_Hardware_Buffer_Usage_Android                        = 1000129000,
	Android_Hardware_Buffer_Properties_Android                   = 1000129001,
	Android_Hardware_Buffer_Format_Properties_Android            = 1000129002,
	Import_Android_Hardware_Buffer_Info_Android                  = 1000129003,
	Memory_Get_Android_Hardware_Buffer_Info_Android              = 1000129004,
	External_Format_Android                                      = 1000129005,
	Physical_Device_Sampler_Filter_Minmax_Properties_EXT         = 1000130000,
	Sampler_Reduction_Mode_Create_Info_EXT                       = 1000130001,
	Physical_Device_Inline_Uniform_Block_Features_EXT            = 1000138000,
	Physical_Device_Inline_Uniform_Block_Properties_EXT          = 1000138001,
	Write_Descriptor_Set_Inline_Uniform_Block_EXT                = 1000138002,
	Descriptor_Pool_Inline_Uniform_Block_Create_Info_EXT         = 1000138003,
	Sample_Locations_Info_EXT                                    = 1000143000,
	Render_Pass_Sample_Locations_Begin_Info_EXT                  = 1000143001,
	Pipeline_Sample_Locations_State_Create_Info_EXT              = 1000143002,
	Physical_Device_Sample_Locations_Properties_EXT              = 1000143003,
	Multisample_Properties_EXT                                   = 1000143004,
	Image_Format_List_Create_Info_KHR                            = 1000147000,
	Physical_Device_Blend_Operation_Advanced_Features_EXT        = 1000148000,
	Physical_Device_Blend_Operation_Advanced_Properties_EXT      = 1000148001,
	Pipeline_Color_Blend_Advanced_State_Create_Info_EXT          = 1000148002,
	Pipeline_Coverage_To_Color_State_Create_Info_NV              = 1000149000,
	Pipeline_Coverage_Modulation_State_Create_Info_NV            = 1000152000,
	Drm_Format_Modifier_Properties_List_EXT                      = 1000158000,
	Drm_Format_Modifier_Properties_EXT                           = 1000158001,
	Physical_Device_Image_Drm_Format_Modifier_Info_EXT           = 1000158002,
	Image_Drm_Format_Modifier_List_Create_Info_EXT               = 1000158003,
	Image_Excplicit_Drm_Format_Modifier_Create_Info_EXT          = 1000158004,
	Image_Drm_Format_Modifier_Properties_EXT                     = 1000158005,
	Validation_Cache_Create_Info_EXT                             = 1000160000,
	Shader_Module_Validation_Cache_Create_Info_EXT               = 1000160001,
	Descriptor_Set_Layout_Binding_Flags_Create_Info_EXT          = 1000161000,
	Physical_Device_Descriptor_Indexing_Features_EXT             = 1000161001,
	Physical_Device_Descriptor_Indexing_Properties_EXT           = 1000161002,
	Descriptor_Set_Variable_Descriptor_Count_Allocate_Info_EXT   = 1000161003,
	Descriptor_Set_Variable_Descriptor_Count_Layout_Support_EXT  = 1000161004,
	Pipeline_Viewport_Shading_Rate_Image_State_Create_Info_NV    = 1000164000,
	Physical_Device_Shading_Rate_Image_Features_NV               = 1000164001,
	Physical_Device_Shading_Rate_Image_Properties_NV             = 1000164002,
	Pipeline_Viewport_Coarse_Sample_Order_State_Create_Info_NV   = 1000164005,
	Raytracing_Pipeline_Create_Info_NVX                          = 1000165000,
	Acceleration_Structure_Create_Info_NVX                       = 1000165001,
	Geometry_Instance_NVX                                        = 1000165002,
	Geometry_NVX                                                 = 1000165003,
	Geometry_Triangles_NVX                                       = 1000165004,
	Geometry_Aabb_NVX                                            = 1000165005,
	Bind_Acceleration_Structure_Memory_Info_NVX                  = 1000165006,
	Descriptor_Acceleration_Structure_Info_NVX                   = 1000165007,
	Acceleration_Structure_Memory_Requirements_Info_NVX          = 1000165008,
	Physical_Device_Raytracing_Properties_NVX                    = 1000165009,
	Hit_Shader_Module_Create_Info_NVX                            = 1000165010,
	Physical_Device_Representative_Fragment_Test_Features_NV     = 1000166000,
	Pipeline_Representative_Fragment_Test_State_Create_Info_NV   = 1000166001,
	Device_Queue_Global_Priority_Create_Info_EXT                 = 1000174000,
	Physical_Device_8Bit_Storage_Features_KHR                    = 1000177000,
	Import_Memory_Host_Pointer_Info_EXT                          = 1000178000,
	Memory_Host_Pointer_Properties_EXT                           = 1000178001,
	Physical_Device_External_Memory_Host_Properties_EXT          = 1000178002,
	Physical_Device_Shader_Atomic_Int64_Features_KHR             = 1000180000,
	Calibrated_Timestamp_Info_EXT                                = 1000184000,
	Physical_Device_Shader_Core_Properties_AMD                   = 1000185000,
	Physical_Device_Vertex_Attribute_Divisor_Properties_EXT      = 1000190000,
	Pipeline_Vertex_Input_Divisor_State_Create_Info_EXT          = 1000190001,
	Physical_Device_Vertex_Attribute_Divisor_Features_EXT        = 1000190002,
	Physical_Device_Driver_Properties_KHR                        = 1000196000,
	Physical_Device_Compute_Shader_Derivatives_Features_NV       = 1000201000,
	Physical_Device_Mesh_Shader_Features_NV                      = 1000202000,
	Physical_Device_Mesh_Shader_Properties_NV                    = 1000202001,
	Physical_Device_Fragment_Shader_Barycentric_Features_NV      = 1000203000,
	Physical_Device_Shader_Image_Footprint_Features_NV           = 1000204000,
	Pipeline_Viewport_Exclusive_Scissor_State_Create_Info_NV     = 1000205000,
	Physical_Device_Exclusive_Scissor_Features_NV                = 1000205002,
	Checkpoint_Data_NV                                           = 1000206000,
	Queue_Family_Checkpoint_Properties_NV                        = 1000206001,
	Physical_Device_Vulkan_Memory_Model_Features_KHR             = 1000211000,
	Physical_Device_Pci_Bus_Info_Properties_EXT                  = 1000212000,
	Imagepipe_Surface_Create_Info_Fuchsia                        = 1000214000,
	Debug_Report_Create_Info_EXT                                 = Debug_Report_Callback_Create_Info_EXT,
	Render_Pass_Multiview_Create_Info_KHR                        = Render_Pass_Multiview_Create_Info,
	Physical_Device_Multiview_Features_KHR                       = Physical_Device_Multiview_Features,
	Physical_Device_Multiview_Properties_KHR                     = Physical_Device_Multiview_Properties,
	Physical_Device_Features_2_KHR                               = Physical_Device_Features_2,
	Physical_Device_Properties_2_KHR                             = Physical_Device_Properties_2,
	Format_Properties_2_KHR                                      = Format_Properties_2,
	Image_Format_Properties_2_KHR                                = Image_Format_Properties_2,
	Physical_Device_Image_Format_Info_2_KHR                      = Physical_Device_Image_Format_Info_2,
	Queue_Family_Properties_2_KHR                                = Queue_Family_Properties_2,
	Physical_Device_Memory_Properties_2_KHR                      = Physical_Device_Memory_Properties_2,
	Sparse_Image_Format_Properties_2_KHR                         = Sparse_Image_Format_Properties_2,
	Physical_Device_Sparse_Image_Format_Info_2_KHR               = Physical_Device_Sparse_Image_Format_Info_2,
	Memory_Allocate_Flags_Info_KHR                               = Memory_Allocate_Flags_Info,
	Device_Group_Render_Pass_Begin_Info_KHR                      = Device_Group_Render_Pass_Begin_Info,
	Device_Group_Command_Buffer_Begin_Info_KHR                   = Device_Group_Command_Buffer_Begin_Info,
	Device_Group_Submit_Info_KHR                                 = Device_Group_Submit_Info,
	Device_Group_Bind_Sparse_Info_KHR                            = Device_Group_Bind_Sparse_Info,
	Bind_Buffer_Memory_Device_Group_Info_KHR                     = Bind_Buffer_Memory_Device_Group_Info,
	Bind_Image_Memory_Device_Group_Info_KHR                      = Bind_Image_Memory_Device_Group_Info,
	Physical_Device_Group_Properties_KHR                         = Physical_Device_Group_Properties,
	Device_Group_Device_Create_Info_KHR                          = Device_Group_Device_Create_Info,
	Physical_Device_External_Image_Format_Info_KHR               = Physical_Device_External_Image_Format_Info,
	External_Image_Format_Properties_KHR                         = External_Image_Format_Properties,
	Physical_Device_External_Buffer_Info_KHR                     = Physical_Device_External_Buffer_Info,
	External_Buffer_Properties_KHR                               = External_Buffer_Properties,
	Physical_Device_Id_Properties_KHR                            = Physical_Device_Id_Properties,
	External_Memory_Buffer_Create_Info_KHR                       = External_Memory_Buffer_Create_Info,
	External_Memory_Image_Create_Info_KHR                        = External_Memory_Image_Create_Info,
	Export_Memory_Allocate_Info_KHR                              = Export_Memory_Allocate_Info,
	Physical_Device_External_Semaphore_Info_KHR                  = Physical_Device_External_Semaphore_Info,
	External_Semaphore_Properties_KHR                            = External_Semaphore_Properties,
	Export_Semaphore_Create_Info_KHR                             = Export_Semaphore_Create_Info,
	Physical_Device_16Bit_Storage_Features_KHR                   = Physical_Device_16Bit_Storage_Features,
	Descriptor_Update_Template_Create_Info_KHR                   = Descriptor_Update_Template_Create_Info,
	Surface_Capabilities2_EXT                                    = Surface_Capabilities_2_EXT,
	Physical_Device_External_Fence_Info_KHR                      = Physical_Device_External_Fence_Info,
	External_Fence_Properties_KHR                                = External_Fence_Properties,
	Export_Fence_Create_Info_KHR                                 = Export_Fence_Create_Info,
	Physical_Device_Point_Clipping_Properties_KHR                = Physical_Device_Point_Clipping_Properties,
	Render_Pass_Input_Attachment_Aspect_Create_Info_KHR          = Render_Pass_Input_Attachment_Aspect_Create_Info,
	Image_View_Usage_Create_Info_KHR                             = Image_View_Usage_Create_Info,
	Pipeline_Tessellation_Domain_Origin_State_Create_Info_KHR    = Pipeline_Tessellation_Domain_Origin_State_Create_Info,
	Physical_Device_Variable_Pointer_Features_KHR                = Physical_Device_Variable_Pointer_Features,
	Memory_Dedicated_Requirements_KHR                            = Memory_Dedicated_Requirements,
	Memory_Dedicated_Allocate_Info_KHR                           = Memory_Dedicated_Allocate_Info,
	Buffer_Memory_Requirements_Info_2_KHR                        = Buffer_Memory_Requirements_Info_2,
	Image_Memory_Requirements_Info_2_KHR                         = Image_Memory_Requirements_Info_2,
	Image_Sparse_Memory_Requirements_Info_2_KHR                  = Image_Sparse_Memory_Requirements_Info_2,
	Memory_Requirements_2_KHR                                    = Memory_Requirements_2,
	Sparse_Image_Memory_Requirements_2_KHR                       = Sparse_Image_Memory_Requirements_2,
	Sampler_Ycbcr_Conversion_Create_Info_KHR                     = Sampler_Ycbcr_Conversion_Create_Info,
	Sampler_Ycbcr_Conversion_Info_KHR                            = Sampler_Ycbcr_Conversion_Info,
	Bind_Image_Plane_Memory_Info_KHR                             = Bind_Image_Plane_Memory_Info,
	Image_Plane_Memory_Requirements_Info_KHR                     = Image_Plane_Memory_Requirements_Info,
	Physical_Device_Sampler_Ycbcr_Conversion_Features_KHR        = Physical_Device_Sampler_Ycbcr_Conversion_Features,
	Sampler_Ycbcr_Conversion_Image_Format_Properties_KHR         = Sampler_Ycbcr_Conversion_Image_Format_Properties,
	Bind_Buffer_Memory_Info_KHR                                  = Bind_Buffer_Memory_Info,
	Bind_Image_Memory_Info_KHR                                   = Bind_Image_Memory_Info,
	Physical_Device_Maintenance_3_Properties_KHR                 = Physical_Device_Maintenance_3_Properties,
	Descriptor_Set_Layout_Support_KHR                            = Descriptor_Set_Layout_Support,
	Begin_Range                                                  = Application_Info,
	End_Range                                                    = Loader_Device_Create_Info,
	Range_Size                                                   = (Loader_Device_Create_Info-Application_Info+1),
}

System_Allocation_Scope :: enum c.int {
	Command     = 0,
	Object      = 1,
	Cache       = 2,
	Device      = 3,
	Instance    = 4,
	Begin_Range = Command,
	End_Range   = Instance,
	Range_Size  = (Instance-Command+1),
}

Internal_Allocation_Type :: enum c.int {
	Executable  = 0,
	Begin_Range = Executable,
	End_Range   = Executable,
	Range_Size  = (Executable-Executable+1),
}

Format :: enum c.int {
	Undefined                                      = 0,
	R4G4_Unorm_Pack8                               = 1,
	R4G4B4A4_Unorm_Pack16                          = 2,
	B4G4R4A4_Unorm_Pack16                          = 3,
	R5G6B5_Unorm_Pack16                            = 4,
	B5G6R5_Unorm_Pack16                            = 5,
	R5G5B5A1_Unorm_Pack16                          = 6,
	B5G5R5A1_Unorm_Pack16                          = 7,
	A1R5G5B5_Unorm_Pack16                          = 8,
	R8_Unorm                                       = 9,
	R8_Snorm                                       = 10,
	R8_Uscaled                                     = 11,
	R8_Sscaled                                     = 12,
	R8_Uint                                        = 13,
	R8_Sint                                        = 14,
	R8_Srgb                                        = 15,
	R8G8_Unorm                                     = 16,
	R8G8_Snorm                                     = 17,
	R8G8_Uscaled                                   = 18,
	R8G8_Sscaled                                   = 19,
	R8G8_Uint                                      = 20,
	R8G8_Sint                                      = 21,
	R8G8_Srgb                                      = 22,
	R8G8B8_Unorm                                   = 23,
	R8G8B8_Snorm                                   = 24,
	R8G8B8_Uscaled                                 = 25,
	R8G8B8_Sscaled                                 = 26,
	R8G8B8_Uint                                    = 27,
	R8G8B8_Sint                                    = 28,
	R8G8B8_Srgb                                    = 29,
	B8G8R8_Unorm                                   = 30,
	B8G8R8_Snorm                                   = 31,
	B8G8R8_Uscaled                                 = 32,
	B8G8R8_Sscaled                                 = 33,
	B8G8R8_Uint                                    = 34,
	B8G8R8_Sint                                    = 35,
	B8G8R8_Srgb                                    = 36,
	R8G8B8A8_Unorm                                 = 37,
	R8G8B8A8_Snorm                                 = 38,
	R8G8B8A8_Uscaled                               = 39,
	R8G8B8A8_Sscaled                               = 40,
	R8G8B8A8_Uint                                  = 41,
	R8G8B8A8_Sint                                  = 42,
	R8G8B8A8_Srgb                                  = 43,
	B8G8R8A8_Unorm                                 = 44,
	B8G8R8A8_Snorm                                 = 45,
	B8G8R8A8_Uscaled                               = 46,
	B8G8R8A8_Sscaled                               = 47,
	B8G8R8A8_Uint                                  = 48,
	B8G8R8A8_Sint                                  = 49,
	B8G8R8A8_Srgb                                  = 50,
	A8B8G8R8_Unorm_Pack32                          = 51,
	A8B8G8R8_Snorm_Pack32                          = 52,
	A8B8G8R8_Uscaled_Pack32                        = 53,
	A8B8G8R8_Sscaled_Pack32                        = 54,
	A8B8G8R8_Uint_Pack32                           = 55,
	A8B8G8R8_Sint_Pack32                           = 56,
	A8B8G8R8_Srgb_Pack32                           = 57,
	A2R10G10B10_Unorm_Pack32                       = 58,
	A2R10G10B10_Snorm_Pack32                       = 59,
	A2R10G10B10_Uscaled_Pack32                     = 60,
	A2R10G10B10_Sscaled_Pack32                     = 61,
	A2R10G10B10_Uint_Pack32                        = 62,
	A2R10G10B10_Sint_Pack32                        = 63,
	A2B10G10R10_Unorm_Pack32                       = 64,
	A2B10G10R10_Snorm_Pack32                       = 65,
	A2B10G10R10_Uscaled_Pack32                     = 66,
	A2B10G10R10_Sscaled_Pack32                     = 67,
	A2B10G10R10_Uint_Pack32                        = 68,
	A2B10G10R10_Sint_Pack32                        = 69,
	R16_Unorm                                      = 70,
	R16_Snorm                                      = 71,
	R16_Uscaled                                    = 72,
	R16_Sscaled                                    = 73,
	R16_Uint                                       = 74,
	R16_Sint                                       = 75,
	R16_Sfloat                                     = 76,
	R16G16_Unorm                                   = 77,
	R16G16_Snorm                                   = 78,
	R16G16_Uscaled                                 = 79,
	R16G16_Sscaled                                 = 80,
	R16G16_Uint                                    = 81,
	R16G16_Sint                                    = 82,
	R16G16_Sfloat                                  = 83,
	R16G16B16_Unorm                                = 84,
	R16G16B16_Snorm                                = 85,
	R16G16B16_Uscaled                              = 86,
	R16G16B16_Sscaled                              = 87,
	R16G16B16_Uint                                 = 88,
	R16G16B16_Sint                                 = 89,
	R16G16B16_Sfloat                               = 90,
	R16G16B16A16_Unorm                             = 91,
	R16G16B16A16_Snorm                             = 92,
	R16G16B16A16_Uscaled                           = 93,
	R16G16B16A16_Sscaled                           = 94,
	R16G16B16A16_Uint                              = 95,
	R16G16B16A16_Sint                              = 96,
	R16G16B16A16_Sfloat                            = 97,
	R32_Uint                                       = 98,
	R32_Sint                                       = 99,
	R32_Sfloat                                     = 100,
	R32G32_Uint                                    = 101,
	R32G32_Sint                                    = 102,
	R32G32_Sfloat                                  = 103,
	R32G32B32_Uint                                 = 104,
	R32G32B32_Sint                                 = 105,
	R32G32B32_Sfloat                               = 106,
	R32G32B32A32_Uint                              = 107,
	R32G32B32A32_Sint                              = 108,
	R32G32B32A32_Sfloat                            = 109,
	R64_Uint                                       = 110,
	R64_Sint                                       = 111,
	R64_Sfloat                                     = 112,
	R64G64_Uint                                    = 113,
	R64G64_Sint                                    = 114,
	R64G64_Sfloat                                  = 115,
	R64G64B64_Uint                                 = 116,
	R64G64B64_Sint                                 = 117,
	R64G64B64_Sfloat                               = 118,
	R64G64B64A64_Uint                              = 119,
	R64G64B64A64_Sint                              = 120,
	R64G64B64A64_Sfloat                            = 121,
	B10G11R11_Ufloat_Pack32                        = 122,
	E5B9G9R9_Ufloat_Pack32                         = 123,
	D16_Unorm                                      = 124,
	X8_D24_Unorm_Pack32                            = 125,
	D32_Sfloat                                     = 126,
	S8_Uint                                        = 127,
	D16_Unorm_S8_Uint                              = 128,
	D24_Unorm_S8_Uint                              = 129,
	D32_Sfloat_S8_Uint                             = 130,
	Bc1_Rgb_Unorm_Block                            = 131,
	Bc1_Rgb_Srgb_Block                             = 132,
	Bc1_Rgba_Unorm_Block                           = 133,
	Bc1_Rgba_Srgb_Block                            = 134,
	Bc2_Unorm_Block                                = 135,
	Bc2_Srgb_Block                                 = 136,
	Bc3_Unorm_Block                                = 137,
	Bc3_Srgb_Block                                 = 138,
	Bc4_Unorm_Block                                = 139,
	Bc4_Snorm_Block                                = 140,
	Bc5_Unorm_Block                                = 141,
	Bc5_Snorm_Block                                = 142,
	Bc6H_Ufloat_Block                              = 143,
	Bc6H_Sfloat_Block                              = 144,
	Bc7_Unorm_Block                                = 145,
	Bc7_Srgb_Block                                 = 146,
	Etc2_R8G8B8_Unorm_Block                        = 147,
	Etc2_R8G8B8_Srgb_Block                         = 148,
	Etc2_R8G8B8A1_Unorm_Block                      = 149,
	Etc2_R8G8B8A1_Srgb_Block                       = 150,
	Etc2_R8G8B8A8_Unorm_Block                      = 151,
	Etc2_R8G8B8A8_Srgb_Block                       = 152,
	Eac_R11_Unorm_Block                            = 153,
	Eac_R11_Snorm_Block                            = 154,
	Eac_R11G11_Unorm_Block                         = 155,
	Eac_R11G11_Snorm_Block                         = 156,
	Astc_4X4_Unorm_Block                           = 157,
	Astc_4X4_Srgb_Block                            = 158,
	Astc_5X4_Unorm_Block                           = 159,
	Astc_5X4_Srgb_Block                            = 160,
	Astc_5X5_Unorm_Block                           = 161,
	Astc_5X5_Srgb_Block                            = 162,
	Astc_6X5_Unorm_Block                           = 163,
	Astc_6X5_Srgb_Block                            = 164,
	Astc_6X6_Unorm_Block                           = 165,
	Astc_6X6_Srgb_Block                            = 166,
	Astc_8X5_Unorm_Block                           = 167,
	Astc_8X5_Srgb_Block                            = 168,
	Astc_8X6_Unorm_Block                           = 169,
	Astc_8X6_Srgb_Block                            = 170,
	Astc_8X8_Unorm_Block                           = 171,
	Astc_8X8_Srgb_Block                            = 172,
	Astc_10X5_Unorm_Block                          = 173,
	Astc_10X5_Srgb_Block                           = 174,
	Astc_10X6_Unorm_Block                          = 175,
	Astc_10X6_Srgb_Block                           = 176,
	Astc_10X8_Unorm_Block                          = 177,
	Astc_10X8_Srgb_Block                           = 178,
	Astc_10X10_Unorm_Block                         = 179,
	Astc_10X10_Srgb_Block                          = 180,
	Astc_12X10_Unorm_Block                         = 181,
	Astc_12X10_Srgb_Block                          = 182,
	Astc_12X12_Unorm_Block                         = 183,
	Astc_12X12_Srgb_Block                          = 184,
	G8B8G8R8_422_Unorm                             = 1000156000,
	B8G8R8G8_422_Unorm                             = 1000156001,
	G8_B8_R8_3Plane_420_Unorm                      = 1000156002,
	G8_B8R8_2Plane_420_Unorm                       = 1000156003,
	G8_B8_R8_3Plane_422_Unorm                      = 1000156004,
	G8_B8R8_2Plane_422_Unorm                       = 1000156005,
	G8_B8_R8_3Plane_444_Unorm                      = 1000156006,
	R10X6_Unorm_Pack16                             = 1000156007,
	R10X6G10X6_Unorm_2Pack16                       = 1000156008,
	R10X6G10X6B10X6A10X6_Unorm_4Pack16             = 1000156009,
	G10X6B10X6G10X6R10X6_422_Unorm_4Pack16         = 1000156010,
	B10X6G10X6R10X6G10X6_422_Unorm_4Pack16         = 1000156011,
	G10X6_B10X6_R10X6_3Plane_420_Unorm_3Pack16     = 1000156012,
	G10X6_B10X6R10X6_2Plane_420_Unorm_3Pack16      = 1000156013,
	G10X6_B10X6_R10X6_3Plane_422_Unorm_3Pack16     = 1000156014,
	G10X6_B10X6R10X6_2Plane_422_Unorm_3Pack16      = 1000156015,
	G10X6_B10X6_R10X6_3Plane_444_Unorm_3Pack16     = 1000156016,
	R12X4_Unorm_Pack16                             = 1000156017,
	R12X4G12X4_Unorm_2Pack16                       = 1000156018,
	R12X4G12X4B12X4A12X4_Unorm_4Pack16             = 1000156019,
	G12X4B12X4G12X4R12X4_422_Unorm_4Pack16         = 1000156020,
	B12X4G12X4R12X4G12X4_422_Unorm_4Pack16         = 1000156021,
	G12X4_B12X4_R12X4_3Plane_420_Unorm_3Pack16     = 1000156022,
	G12X4_B12X4R12X4_2Plane_420_Unorm_3Pack16      = 1000156023,
	G12X4_B12X4_R12X4_3Plane_422_Unorm_3Pack16     = 1000156024,
	G12X4_B12X4R12X4_2Plane_422_Unorm_3Pack16      = 1000156025,
	G12X4_B12X4_R12X4_3Plane_444_Unorm_3Pack16     = 1000156026,
	G16B16G16R16_422_Unorm                         = 1000156027,
	B16G16R16G16_422_Unorm                         = 1000156028,
	G16_B16_R16_3Plane_420_Unorm                   = 1000156029,
	G16_B16R16_2Plane_420_Unorm                    = 1000156030,
	G16_B16_R16_3Plane_422_Unorm                   = 1000156031,
	G16_B16R16_2Plane_422_Unorm                    = 1000156032,
	G16_B16_R16_3Plane_444_Unorm                   = 1000156033,
	Pvrtc1_2Bpp_Unorm_Block_Img                    = 1000054000,
	Pvrtc1_4Bpp_Unorm_Block_Img                    = 1000054001,
	Pvrtc2_2Bpp_Unorm_Block_Img                    = 1000054002,
	Pvrtc2_4Bpp_Unorm_Block_Img                    = 1000054003,
	Pvrtc1_2Bpp_Srgb_Block_Img                     = 1000054004,
	Pvrtc1_4Bpp_Srgb_Block_Img                     = 1000054005,
	Pvrtc2_2Bpp_Srgb_Block_Img                     = 1000054006,
	Pvrtc2_4Bpp_Srgb_Block_Img                     = 1000054007,
	G8B8G8R8_422_Unorm_KHR                         = G8B8G8R8_422_Unorm,
	B8G8R8G8_422_Unorm_KHR                         = B8G8R8G8_422_Unorm,
	G8_B8_R8_3Plane_420_Unorm_KHR                  = G8_B8_R8_3Plane_420_Unorm,
	G8_B8R8_2Plane_420_Unorm_KHR                   = G8_B8R8_2Plane_420_Unorm,
	G8_B8_R8_3Plane_422_Unorm_KHR                  = G8_B8_R8_3Plane_422_Unorm,
	G8_B8R8_2Plane_422_Unorm_KHR                   = G8_B8R8_2Plane_422_Unorm,
	G8_B8_R8_3Plane_444_Unorm_KHR                  = G8_B8_R8_3Plane_444_Unorm,
	R10X6_Unorm_Pack16_KHR                         = R10X6_Unorm_Pack16,
	R10X6G10X6_Unorm_2Pack16_KHR                   = R10X6G10X6_Unorm_2Pack16,
	R10X6G10X6B10X6A10X6_Unorm_4Pack16_KHR         = R10X6G10X6B10X6A10X6_Unorm_4Pack16,
	G10X6B10X6G10X6R10X6_422_Unorm_4Pack16_KHR     = G10X6B10X6G10X6R10X6_422_Unorm_4Pack16,
	B10X6G10X6R10X6G10X6_422_Unorm_4Pack16_KHR     = B10X6G10X6R10X6G10X6_422_Unorm_4Pack16,
	G10X6_B10X6_R10X6_3Plane_420_Unorm_3Pack16_KHR = G10X6_B10X6_R10X6_3Plane_420_Unorm_3Pack16,
	G10X6_B10X6R10X6_2Plane_420_Unorm_3Pack16_KHR  = G10X6_B10X6R10X6_2Plane_420_Unorm_3Pack16,
	G10X6_B10X6_R10X6_3Plane_422_Unorm_3Pack16_KHR = G10X6_B10X6_R10X6_3Plane_422_Unorm_3Pack16,
	G10X6_B10X6R10X6_2Plane_422_Unorm_3Pack16_KHR  = G10X6_B10X6R10X6_2Plane_422_Unorm_3Pack16,
	G10X6_B10X6_R10X6_3Plane_444_Unorm_3Pack16_KHR = G10X6_B10X6_R10X6_3Plane_444_Unorm_3Pack16,
	R12X4_Unorm_Pack16_KHR                         = R12X4_Unorm_Pack16,
	R12X4G12X4_Unorm_2Pack16_KHR                   = R12X4G12X4_Unorm_2Pack16,
	R12X4G12X4B12X4A12X4_Unorm_4Pack16_KHR         = R12X4G12X4B12X4A12X4_Unorm_4Pack16,
	G12X4B12X4G12X4R12X4_422_Unorm_4Pack16_KHR     = G12X4B12X4G12X4R12X4_422_Unorm_4Pack16,
	B12X4G12X4R12X4G12X4_422_Unorm_4Pack16_KHR     = B12X4G12X4R12X4G12X4_422_Unorm_4Pack16,
	G12X4_B12X4_R12X4_3Plane_420_Unorm_3Pack16_KHR = G12X4_B12X4_R12X4_3Plane_420_Unorm_3Pack16,
	G12X4_B12X4R12X4_2Plane_420_Unorm_3Pack16_KHR  = G12X4_B12X4R12X4_2Plane_420_Unorm_3Pack16,
	G12X4_B12X4_R12X4_3Plane_422_Unorm_3Pack16_KHR = G12X4_B12X4_R12X4_3Plane_422_Unorm_3Pack16,
	G12X4_B12X4R12X4_2Plane_422_Unorm_3Pack16_KHR  = G12X4_B12X4R12X4_2Plane_422_Unorm_3Pack16,
	G12X4_B12X4_R12X4_3Plane_444_Unorm_3Pack16_KHR = G12X4_B12X4_R12X4_3Plane_444_Unorm_3Pack16,
	G16B16G16R16_422_Unorm_KHR                     = G16B16G16R16_422_Unorm,
	B16G16R16G16_422_Unorm_KHR                     = B16G16R16G16_422_Unorm,
	G16_B16_R16_3Plane_420_Unorm_KHR               = G16_B16_R16_3Plane_420_Unorm,
	G16_B16R16_2Plane_420_Unorm_KHR                = G16_B16R16_2Plane_420_Unorm,
	G16_B16_R16_3Plane_422_Unorm_KHR               = G16_B16_R16_3Plane_422_Unorm,
	G16_B16R16_2Plane_422_Unorm_KHR                = G16_B16R16_2Plane_422_Unorm,
	G16_B16_R16_3Plane_444_Unorm_KHR               = G16_B16_R16_3Plane_444_Unorm,
	Begin_Range                                    = Undefined,
	End_Range                                      = Astc_12X12_Srgb_Block,
	Range_Size                                     = (Astc_12X12_Srgb_Block-Undefined+1),
}

Image_Type :: enum c.int {
	D1          = 0,
	D2          = 1,
	D3          = 2,
	Begin_Range = D1,
	End_Range   = D3,
	Range_Size  = (D3-D1+1),
}

Image_Tiling :: enum c.int {
	Optimal                 = 0,
	Linear                  = 1,
	Drm_Format_Modifier_EXT = 1000158000,
	Begin_Range             = Optimal,
	End_Range               = Linear,
	Range_Size              = (Linear-Optimal+1),
}

Physical_Device_Type :: enum c.int {
	Other          = 0,
	Integrated_Gpu = 1,
	Discrete_Gpu   = 2,
	Virtual_Gpu    = 3,
	Cpu            = 4,
	Begin_Range    = Other,
	End_Range      = Cpu,
	Range_Size     = (Cpu-Other+1),
}

Query_Type :: enum c.int {
	Occlusion                     = 0,
	Pipeline_Statistics           = 1,
	Timestamp                     = 2,
	Transform_Feedback_Stream_EXT = 1000028004,
	Compacted_Size_NVX            = 1000165000,
	Begin_Range                   = Occlusion,
	End_Range                     = Timestamp,
	Range_Size                    = (Timestamp-Occlusion+1),
}

Sharing_Mode :: enum c.int {
	Exclusive   = 0,
	Concurrent  = 1,
	Begin_Range = Exclusive,
	End_Range   = Concurrent,
	Range_Size  = (Concurrent-Exclusive+1),
}

Image_Layout :: enum c.int {
	Undefined                                      = 0,
	General                                        = 1,
	Color_Attachment_Optimal                       = 2,
	Depth_Stencil_Attachment_Optimal               = 3,
	Depth_Stencil_Read_Only_Optimal                = 4,
	Shader_Read_Only_Optimal                       = 5,
	Transfer_Src_Optimal                           = 6,
	Transfer_Dst_Optimal                           = 7,
	Preinitialized                                 = 8,
	Depth_Read_Only_Stencil_Attachment_Optimal     = 1000117000,
	Depth_Attachment_Stencil_Read_Only_Optimal     = 1000117001,
	Present_Src_KHR                                = 1000001002,
	Shared_Present_KHR                             = 1000111000,
	Shading_Rate_Optimal_NV                        = 1000164003,
	Depth_Read_Only_Stencil_Attachment_Optimal_KHR = Depth_Read_Only_Stencil_Attachment_Optimal,
	Depth_Attachment_Stencil_Read_Only_Optimal_KHR = Depth_Attachment_Stencil_Read_Only_Optimal,
	Begin_Range                                    = Undefined,
	End_Range                                      = Preinitialized,
	Range_Size                                     = (Preinitialized-Undefined+1),
}

Image_View_Type :: enum c.int {
	D1          = 0,
	D2          = 1,
	D3          = 2,
	Cube        = 3,
	D1_Array    = 4,
	D2_Array    = 5,
	Cube_Array  = 6,
	Begin_Range = D1,
	End_Range   = Cube_Array,
	Range_Size  = (Cube_Array-D1+1),
}

Component_Swizzle :: enum c.int {
	Identity    = 0,
	Zero        = 1,
	One         = 2,
	R           = 3,
	G           = 4,
	B           = 5,
	A           = 6,
	Begin_Range = Identity,
	End_Range   = A,
	Range_Size  = (A-Identity+1),
}

Vertex_Input_Rate :: enum c.int {
	Vertex      = 0,
	Instance    = 1,
	Begin_Range = Vertex,
	End_Range   = Instance,
	Range_Size  = (Instance-Vertex+1),
}

Primitive_Topology :: enum c.int {
	Point_List                    = 0,
	Line_List                     = 1,
	Line_Strip                    = 2,
	Triangle_List                 = 3,
	Triangle_Strip                = 4,
	Triangle_Fan                  = 5,
	Line_List_With_Adjacency      = 6,
	Line_Strip_With_Adjacency     = 7,
	Triangle_List_With_Adjacency  = 8,
	Triangle_Strip_With_Adjacency = 9,
	Patch_List                    = 10,
	Begin_Range                   = Point_List,
	End_Range                     = Patch_List,
	Range_Size                    = (Patch_List-Point_List+1),
}

Polygon_Mode :: enum c.int {
	Fill              = 0,
	Line              = 1,
	Point             = 2,
	Fill_Rectangle_NV = 1000153000,
	Begin_Range       = Fill,
	End_Range         = Point,
	Range_Size        = (Point-Fill+1),
}

Front_Face :: enum c.int {
	Counter_Clockwise = 0,
	Clockwise         = 1,
	Begin_Range       = Counter_Clockwise,
	End_Range         = Clockwise,
	Range_Size        = (Clockwise-Counter_Clockwise+1),
}

Compare_Op :: enum c.int {
	Never            = 0,
	Less             = 1,
	Equal            = 2,
	Less_Or_Equal    = 3,
	Greater          = 4,
	Not_Equal        = 5,
	Greater_Or_Equal = 6,
	Always           = 7,
	Begin_Range      = Never,
	End_Range        = Always,
	Range_Size       = (Always-Never+1),
}

Stencil_Op :: enum c.int {
	Keep                = 0,
	Zero                = 1,
	Replace             = 2,
	Increment_And_Clamp = 3,
	Decrement_And_Clamp = 4,
	Invert              = 5,
	Increment_And_Wrap  = 6,
	Decrement_And_Wrap  = 7,
	Begin_Range         = Keep,
	End_Range           = Decrement_And_Wrap,
	Range_Size          = (Decrement_And_Wrap-Keep+1),
}

Logic_Op :: enum c.int {
	Clear         = 0,
	And           = 1,
	And_Reverse   = 2,
	Copy          = 3,
	And_Inverted  = 4,
	No_Op         = 5,
	Xor           = 6,
	Or            = 7,
	Nor           = 8,
	Equivalent    = 9,
	Invert        = 10,
	Or_Reverse    = 11,
	Copy_Inverted = 12,
	Or_Inverted   = 13,
	Nand          = 14,
	Set           = 15,
	Begin_Range   = Clear,
	End_Range     = Set,
	Range_Size    = (Set-Clear+1),
}

Blend_Factor :: enum c.int {
	Zero                     = 0,
	One                      = 1,
	Src_Color                = 2,
	One_Minus_Src_Color      = 3,
	Dst_Color                = 4,
	One_Minus_Dst_Color      = 5,
	Src_Alpha                = 6,
	One_Minus_Src_Alpha      = 7,
	Dst_Alpha                = 8,
	One_Minus_Dst_Alpha      = 9,
	Constant_Color           = 10,
	One_Minus_Constant_Color = 11,
	Constant_Alpha           = 12,
	One_Minus_Constant_Alpha = 13,
	Src_Alpha_Saturate       = 14,
	Src1_Color               = 15,
	One_Minus_Src1_Color     = 16,
	Src1_Alpha               = 17,
	One_Minus_Src1_Alpha     = 18,
	Begin_Range              = Zero,
	End_Range                = One_Minus_Src1_Alpha,
	Range_Size               = (One_Minus_Src1_Alpha-Zero+1),
}

Blend_Op :: enum c.int {
	Add                    = 0,
	Subtract               = 1,
	Reverse_Subtract       = 2,
	Min                    = 3,
	Max                    = 4,
	Zero_EXT               = 1000148000,
	Src_EXT                = 1000148001,
	Dst_EXT                = 1000148002,
	Src_Over_EXT           = 1000148003,
	Dst_Over_EXT           = 1000148004,
	Src_In_EXT             = 1000148005,
	Dst_In_EXT             = 1000148006,
	Src_Out_EXT            = 1000148007,
	Dst_Out_EXT            = 1000148008,
	Src_Atop_EXT           = 1000148009,
	Dst_Atop_EXT           = 1000148010,
	Xor_EXT                = 1000148011,
	Multiply_EXT           = 1000148012,
	Screen_EXT             = 1000148013,
	Overlay_EXT            = 1000148014,
	Darken_EXT             = 1000148015,
	Lighten_EXT            = 1000148016,
	Colordodge_EXT         = 1000148017,
	Colorburn_EXT          = 1000148018,
	Hardlight_EXT          = 1000148019,
	Softlight_EXT          = 1000148020,
	Difference_EXT         = 1000148021,
	Exclusion_EXT          = 1000148022,
	Invert_EXT             = 1000148023,
	Invert_Rgb_EXT         = 1000148024,
	Lineardodge_EXT        = 1000148025,
	Linearburn_EXT         = 1000148026,
	Vividlight_EXT         = 1000148027,
	Linearlight_EXT        = 1000148028,
	Pinlight_EXT           = 1000148029,
	Hardmix_EXT            = 1000148030,
	Hsl_Hue_EXT            = 1000148031,
	Hsl_Saturation_EXT     = 1000148032,
	Hsl_Color_EXT          = 1000148033,
	Hsl_Luminosity_EXT     = 1000148034,
	Plus_EXT               = 1000148035,
	Plus_Clamped_EXT       = 1000148036,
	Plus_Clamped_Alpha_EXT = 1000148037,
	Plus_Darker_EXT        = 1000148038,
	Minus_EXT              = 1000148039,
	Minus_Clamped_EXT      = 1000148040,
	Contrast_EXT           = 1000148041,
	Invert_Ovg_EXT         = 1000148042,
	Red_EXT                = 1000148043,
	Green_EXT              = 1000148044,
	Blue_EXT               = 1000148045,
	Begin_Range            = Add,
	End_Range              = Max,
	Range_Size             = (Max-Add+1),
}

Dynamic_State :: enum c.int {
	Viewport                         = 0,
	Scissor                          = 1,
	Line_Width                       = 2,
	Depth_Bias                       = 3,
	Blend_Constants                  = 4,
	Depth_Bounds                     = 5,
	Stencil_Compare_Mask             = 6,
	Stencil_Write_Mask               = 7,
	Stencil_Reference                = 8,
	Viewport_W_Scaling_NV            = 1000087000,
	Discard_Rectangle_EXT            = 1000099000,
	Sample_Locations_EXT             = 1000143000,
	Viewport_Shading_Rate_Palette_NV = 1000164004,
	Viewport_Coarse_Sample_Order_NV  = 1000164006,
	Exclusive_Scissor_NV             = 1000205001,
	Begin_Range                      = Viewport,
	End_Range                        = Stencil_Reference,
	Range_Size                       = (Stencil_Reference-Viewport+1),
}

Filter :: enum c.int {
	Nearest     = 0,
	Linear      = 1,
	Cubic_Img   = 1000015000,
	Begin_Range = Nearest,
	End_Range   = Linear,
	Range_Size  = (Linear-Nearest+1),
}

Sampler_Mipmap_Mode :: enum c.int {
	Nearest     = 0,
	Linear      = 1,
	Begin_Range = Nearest,
	End_Range   = Linear,
	Range_Size  = (Linear-Nearest+1),
}

Sampler_Address_Mode :: enum c.int {
	Repeat               = 0,
	Mirrored_Repeat      = 1,
	Clamp_To_Edge        = 2,
	Clamp_To_Border      = 3,
	Mirror_Clamp_To_Edge = 4,
	Begin_Range          = Repeat,
	End_Range            = Clamp_To_Border,
	Range_Size           = (Clamp_To_Border-Repeat+1),
}

Border_Color :: enum c.int {
	Float_Transparent_Black = 0,
	Int_Transparent_Black   = 1,
	Float_Opaque_Black      = 2,
	Int_Opaque_Black        = 3,
	Float_Opaque_White      = 4,
	Int_Opaque_White        = 5,
	Begin_Range             = Float_Transparent_Black,
	End_Range               = Int_Opaque_White,
	Range_Size              = (Int_Opaque_White-Float_Transparent_Black+1),
}

Descriptor_Type :: enum c.int {
	Sampler                    = 0,
	Combined_Image_Sampler     = 1,
	Sampled_Image              = 2,
	Storage_Image              = 3,
	Uniform_Texel_Buffer       = 4,
	Storage_Texel_Buffer       = 5,
	Uniform_Buffer             = 6,
	Storage_Buffer             = 7,
	Uniform_Buffer_Dynamic     = 8,
	Storage_Buffer_Dynamic     = 9,
	Input_Attachment           = 10,
	Inline_Uniform_Block_EXT   = 1000138000,
	Acceleration_Structure_NVX = 1000165000,
	Begin_Range                = Sampler,
	End_Range                  = Input_Attachment,
	Range_Size                 = (Input_Attachment-Sampler+1),
}

Attachment_Load_Op :: enum c.int {
	Load        = 0,
	Clear       = 1,
	Dont_Care   = 2,
	Begin_Range = Load,
	End_Range   = Dont_Care,
	Range_Size  = (Dont_Care-Load+1),
}

Attachment_Store_Op :: enum c.int {
	Store       = 0,
	Dont_Care   = 1,
	Begin_Range = Store,
	End_Range   = Dont_Care,
	Range_Size  = (Dont_Care-Store+1),
}

Pipeline_Bind_Point :: enum c.int {
	Graphics       = 0,
	Compute        = 1,
	Raytracing_NVX = 1000165000,
	Begin_Range    = Graphics,
	End_Range      = Compute,
	Range_Size     = (Compute-Graphics+1),
}

Command_Buffer_Level :: enum c.int {
	Primary     = 0,
	Secondary   = 1,
	Begin_Range = Primary,
	End_Range   = Secondary,
	Range_Size  = (Secondary-Primary+1),
}

Index_Type :: enum c.int {
	Uint16      = 0,
	Uint32      = 1,
	Begin_Range = Uint16,
	End_Range   = Uint32,
	Range_Size  = (Uint32-Uint16+1),
}

Subpass_Contents :: enum c.int {
	Inline                    = 0,
	Secondary_Command_Buffers = 1,
	Begin_Range               = Inline,
	End_Range                 = Secondary_Command_Buffers,
	Range_Size                = (Secondary_Command_Buffers-Inline+1),
}

Object_Type :: enum c.int {
	Unknown                        = 0,
	Instance                       = 1,
	Physical_Device                = 2,
	Device                         = 3,
	Queue                          = 4,
	Semaphore                      = 5,
	Command_Buffer                 = 6,
	Fence                          = 7,
	Device_Memory                  = 8,
	Buffer                         = 9,
	Image                          = 10,
	Event                          = 11,
	Query_Pool                     = 12,
	Buffer_View                    = 13,
	Image_View                     = 14,
	Shader_Module                  = 15,
	Pipeline_Cache                 = 16,
	Pipeline_Layout                = 17,
	Render_Pass                    = 18,
	Pipeline                       = 19,
	Descriptor_Set_Layout          = 20,
	Sampler                        = 21,
	Descriptor_Pool                = 22,
	Descriptor_Set                 = 23,
	Framebuffer                    = 24,
	Command_Pool                   = 25,
	Sampler_Ycbcr_Conversion       = 1000156000,
	Descriptor_Update_Template     = 1000085000,
	Surface_KHR                    = 1000000000,
	Swapchain_KHR                  = 1000001000,
	Display_KHR                    = 1000002000,
	Display_Mode_KHR               = 1000002001,
	Debug_Report_Callback_EXT      = 1000011000,
	Object_Table_NVX               = 1000086000,
	Indirect_Commands_Layout_NVX   = 1000086001,
	Debug_Utils_Messenger_EXT      = 1000128000,
	Validation_Cache_EXT           = 1000160000,
	Acceleration_Structure_NVX     = 1000165000,
	Descriptor_Update_Template_KHR = Descriptor_Update_Template,
	Sampler_Ycbcr_Conversion_KHR   = Sampler_Ycbcr_Conversion,
	Begin_Range                    = Unknown,
	End_Range                      = Command_Pool,
	Range_Size                     = (Command_Pool-Unknown+1),
}

Vendor_Id :: enum c.int {
	Viv         = 0x10001,
	Vsi         = 0x10002,
	Kazan       = 0x10003,
	Begin_Range = Viv,
	End_Range   = Kazan,
	Range_Size  = (Kazan-Viv+1),
}

Format_Feature_Flags :: distinct bit_set[Format_Feature_Flag; u32];
Format_Feature_Flag :: enum u32 {
	Sampled_Image                                                               = 0,
	Storage_Image                                                               = 1,
	Storage_Image_Atomic                                                        = 2,
	Uniform_Texel_Buffer                                                        = 3,
	Storage_Texel_Buffer                                                        = 4,
	Storage_Texel_Buffer_Atomic                                                 = 5,
	Vertex_Buffer                                                               = 6,
	Color_Attachment                                                            = 7,
	Color_Attachment_Blend                                                      = 8,
	Depth_Stencil_Attachment                                                    = 9,
	Blit_Src                                                                    = 10,
	Blit_Dst                                                                    = 11,
	Sampled_Image_Filter_Linear                                                 = 12,
	Transfer_Src                                                                = 14,
	Transfer_Dst                                                                = 15,
	Midpoint_Chroma_Samples                                                     = 17,
	Sampled_Image_Ycbcr_Conversion_Linear_Filter                                = 18,
	Sampled_Image_Ycbcr_Conversion_Separate_Reconstruction_Filter               = 19,
	Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit               = 20,
	Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit_Forceable     = 21,
	Disjoint                                                                    = 22,
	Cosited_Chroma_Samples                                                      = 23,
	Sampled_Image_Filter_Cubic_Img                                              = 13,
	Sampled_Image_Filter_Minmax_EXT                                             = 16,
	Transfer_Src_KHR                                                            = Transfer_Src,
	Transfer_Dst_KHR                                                            = Transfer_Dst,
	Midpoint_Chroma_Samples_KHR                                                 = Midpoint_Chroma_Samples,
	Sampled_Image_Ycbcr_Conversion_Linear_Filter_KHR                            = Sampled_Image_Ycbcr_Conversion_Linear_Filter,
	Sampled_Image_Ycbcr_Conversion_Separate_Reconstruction_Filter_KHR           = Sampled_Image_Ycbcr_Conversion_Separate_Reconstruction_Filter,
	Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit_KHR           = Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit,
	Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit_Forceable_KHR = Sampled_Image_Ycbcr_Conversion_Chroma_Reconstruction_Explicit_Forceable,
	Disjoint_KHR                                                                = Disjoint,
	Cosited_Chroma_Samples_KHR                                                  = Cosited_Chroma_Samples,
}

Image_Usage_Flags :: distinct bit_set[Image_Usage_Flag; u32];
Image_Usage_Flag :: enum u32 {
	Transfer_Src             = 0,
	Transfer_Dst             = 1,
	Sampled                  = 2,
	Storage                  = 3,
	Color_Attachment         = 4,
	Depth_Stencil_Attachment = 5,
	Transient_Attachment     = 6,
	Input_Attachment         = 7,
	Shading_Rate_Image_NV    = 8,
}

Image_Create_Flags :: distinct bit_set[Image_Create_Flag; u32];
Image_Create_Flag :: enum u32 {
	Sparse_Binding                        = 0,
	Sparse_Residency                      = 1,
	Sparse_Aliased                        = 2,
	Mutable_Format                        = 3,
	Cube_Compatible                       = 4,
	Alias                                 = 10,
	Split_Instance_Bind_Regions           = 6,
	D2_Array_Compatible                   = 5,
	Block_Texel_View_Compatible           = 7,
	Extended_Usage                        = 8,
	Protected                             = 11,
	Disjoint                              = 9,
	Corner_Sampled_NV                     = 13,
	Sample_Locations_Compatible_Depth_EXT = 12,
	Split_Instance_Bind_Regions_KHR       = Split_Instance_Bind_Regions,
	D2_Array_Compatible_KHR               = D2_Array_Compatible,
	Block_Texel_View_Compatible_KHR       = Block_Texel_View_Compatible,
	Extended_Usage_KHR                    = Extended_Usage,
	Disjoint_KHR                          = Disjoint,
	Alias_KHR                             = Alias,
}

Sample_Count_Flags :: distinct bit_set[Sample_Count_Flag; u32];
Sample_Count_Flag :: enum u32 {
	_1  = 0,
	_2  = 1,
	_4  = 2,
	_8  = 3,
	_16 = 4,
	_32 = 5,
	_64 = 6,
}

Queue_Flags :: distinct bit_set[Queue_Flag; u32];
Queue_Flag :: enum u32 {
	Graphics       = 0,
	Compute        = 1,
	Transfer       = 2,
	Sparse_Binding = 3,
	Protected      = 4,
}

Memory_Property_Flags :: distinct bit_set[Memory_Property_Flag; u32];
Memory_Property_Flag :: enum u32 {
	Device_Local     = 0,
	Host_Visible     = 1,
	Host_Coherent    = 2,
	Host_Cached      = 3,
	Lazily_Allocated = 4,
	Protected        = 5,
}

Memory_Heap_Flags :: distinct bit_set[Memory_Heap_Flag; u32];
Memory_Heap_Flag :: enum u32 {
	Device_Local       = 0,
	Multi_Instance     = 1,
	Multi_Instance_KHR = Multi_Instance,
}

Device_Queue_Create_Flags :: distinct bit_set[Device_Queue_Create_Flag; u32];
Device_Queue_Create_Flag :: enum u32 {
	Protected = 0,
}

Pipeline_Stage_Flags :: distinct bit_set[Pipeline_Stage_Flag; u32];
Pipeline_Stage_Flag :: enum u32 {
	Top_Of_Pipe                    = 0,
	Draw_Indirect                  = 1,
	Vertex_Input                   = 2,
	Vertex_Shader                  = 3,
	Tessellation_Control_Shader    = 4,
	Tessellation_Evaluation_Shader = 5,
	Geometry_Shader                = 6,
	Fragment_Shader                = 7,
	Early_Fragment_Tests           = 8,
	Late_Fragment_Tests            = 9,
	Color_Attachment_Output        = 10,
	Compute_Shader                 = 11,
	Transfer                       = 12,
	Bottom_Of_Pipe                 = 13,
	Host                           = 14,
	All_Graphics                   = 15,
	All_Commands                   = 16,
	Transform_Feedback_EXT         = 24,
	Conditional_Rendering_EXT      = 18,
	Command_Process_NVX            = 17,
	Shading_Rate_Image_NV          = 22,
	Raytracing_NVX                 = 21,
	Task_Shader_NV                 = 19,
	Mesh_Shader_NV                 = 20,
}

Image_Aspect_Flags :: distinct bit_set[Image_Aspect_Flag; u32];
Image_Aspect_Flag :: enum u32 {
	Color              = 0,
	Depth              = 1,
	Stencil            = 2,
	Metadata           = 3,
	Plane_0            = 4,
	Plane_1            = 5,
	Plane_2            = 6,
	Memory_Plane_0_EXT = 7,
	Memory_Plane_1_EXT = 8,
	Memory_Plane_2_EXT = 9,
	Memory_Plane_3_EXT = 10,
	Plane_0_KHR        = Plane_0,
	Plane_1_KHR        = Plane_1,
	Plane_2_KHR        = Plane_2,
}

Sparse_Image_Format_Flags :: distinct bit_set[Sparse_Image_Format_Flag; u32];
Sparse_Image_Format_Flag :: enum u32 {
	Single_Miptail         = 0,
	Aligned_Mip_Size       = 1,
	Nonstandard_Block_Size = 2,
}

Sparse_Memory_Bind_Flags :: distinct bit_set[Sparse_Memory_Bind_Flag; u32];
Sparse_Memory_Bind_Flag :: enum u32 {
	Metadata = 0,
}

Fence_Create_Flags :: distinct bit_set[Fence_Create_Flag; u32];
Fence_Create_Flag :: enum u32 {
	Signaled = 0,
}

Query_Pipeline_Statistic_Flags :: distinct bit_set[Query_Pipeline_Statistic_Flag; u32];
Query_Pipeline_Statistic_Flag :: enum u32 {
	Input_Assembly_Vertices                    = 0,
	Input_Assembly_Primitives                  = 1,
	Vertex_Shader_Invocations                  = 2,
	Geometry_Shader_Invocations                = 3,
	Geometry_Shader_Primitives                 = 4,
	Clipping_Invocations                       = 5,
	Clipping_Primitives                        = 6,
	Fragment_Shader_Invocations                = 7,
	Tessellation_Control_Shader_Patches        = 8,
	Tessellation_Evaluation_Shader_Invocations = 9,
	Compute_Shader_Invocations                 = 10,
}

Query_Result_Flags :: distinct bit_set[Query_Result_Flag; u32];
Query_Result_Flag :: enum u32 {
	_64               = 0,
	Wait              = 1,
	With_Availability = 2,
	Partial           = 3,
}

Buffer_Create_Flags :: distinct bit_set[Buffer_Create_Flag; u32];
Buffer_Create_Flag :: enum u32 {
	Sparse_Binding   = 0,
	Sparse_Residency = 1,
	Sparse_Aliased   = 2,
	Protected        = 3,
}

Buffer_Usage_Flags :: distinct bit_set[Buffer_Usage_Flag; u32];
Buffer_Usage_Flag :: enum u32 {
	Transfer_Src                          = 0,
	Transfer_Dst                          = 1,
	Uniform_Texel_Buffer                  = 2,
	Storage_Texel_Buffer                  = 3,
	Uniform_Buffer                        = 4,
	Storage_Buffer                        = 5,
	Index_Buffer                          = 6,
	Vertex_Buffer                         = 7,
	Indirect_Buffer                       = 8,
	Transform_Feedback_Buffer_EXT         = 11,
	Transform_Feedback_Counter_Buffer_EXT = 12,
	Conditional_Rendering_EXT             = 9,
	Raytracing_NVX                        = 10,
}

Pipeline_Create_Flags :: distinct bit_set[Pipeline_Create_Flag; u32];
Pipeline_Create_Flag :: enum u32 {
	Disable_Optimization             = 0,
	Allow_Derivatives                = 1,
	Derivative                       = 2,
	View_Index_From_Device_Index     = 3,
	Dispatch_Base                    = 4,
	Defer_Compile_NVX                = 5,
	View_Index_From_Device_Index_KHR = View_Index_From_Device_Index,
	Dispatch_Base_KHR                = Dispatch_Base,
}

Shader_Stage_Flags :: distinct bit_set[Shader_Stage_Flag; u32];
Shader_Stage_Flag :: enum u32 {
	Vertex                  = 0,
	Tessellation_Control    = 1,
	Tessellation_Evaluation = 2,
	Geometry                = 3,
	Fragment                = 4,
	Compute                 = 5,
	All_Graphics            = 4,
	All                     = 30,
	Raygen_NVX              = 8,
	Any_Hit_NVX             = 9,
	Closest_Hit_NVX         = 10,
	Miss_NVX                = 11,
	Intersection_NVX        = 12,
	Callable_NVX            = 13,
	Task_NV                 = 6,
	Mesh_NV                 = 7,
}

Cull_Mode_Flags :: distinct bit_set[Cull_Mode_Flag; u32];
Cull_Mode_Flag :: enum u32 {
	None           = 0,
	Front          = 0,
	Back           = 1,
	Front_And_Back = 1,
}

Color_Component_Flags :: distinct bit_set[Color_Component_Flag; u32];
Color_Component_Flag :: enum u32 {
	R = 0,
	G = 1,
	B = 2,
	A = 3,
}

Descriptor_Set_Layout_Create_Flags :: distinct bit_set[Descriptor_Set_Layout_Create_Flag; u32];
Descriptor_Set_Layout_Create_Flag :: enum u32 {
	Push_Descriptor_KHR        = 0,
	Update_After_Bind_Pool_EXT = 1,
}

Descriptor_Pool_Create_Flags :: distinct bit_set[Descriptor_Pool_Create_Flag; u32];
Descriptor_Pool_Create_Flag :: enum u32 {
	Free_Descriptor_Set   = 0,
	Update_After_Bind_EXT = 1,
}

Attachment_Description_Flags :: distinct bit_set[Attachment_Description_Flag; u32];
Attachment_Description_Flag :: enum u32 {
	May_Alias = 0,
}

Subpass_Description_Flags :: distinct bit_set[Subpass_Description_Flag; u32];
Subpass_Description_Flag :: enum u32 {
	Per_View_Attributes_NVX      = 0,
	Per_View_Position_X_Only_NVX = 1,
}

Access_Flags :: distinct bit_set[Access_Flag; u32];
Access_Flag :: enum u32 {
	Indirect_Command_Read                 = 0,
	Index_Read                            = 1,
	Vertex_Attribute_Read                 = 2,
	Uniform_Read                          = 3,
	Input_Attachment_Read                 = 4,
	Shader_Read                           = 5,
	Shader_Write                          = 6,
	Color_Attachment_Read                 = 7,
	Color_Attachment_Write                = 8,
	Depth_Stencil_Attachment_Read         = 9,
	Depth_Stencil_Attachment_Write        = 10,
	Transfer_Read                         = 11,
	Transfer_Write                        = 12,
	Host_Read                             = 13,
	Host_Write                            = 14,
	Memory_Read                           = 15,
	Memory_Write                          = 16,
	Transform_Feedback_Write_EXT          = 25,
	Transform_Feedback_Counter_Read_EXT   = 26,
	Transform_Feedback_Counter_Write_EXT  = 27,
	Conditional_Rendering_Read_EXT        = 20,
	Command_Process_Read_NVX              = 17,
	Command_Process_Write_NVX             = 18,
	Color_Attachment_Read_Noncoherent_EXT = 19,
	Shading_Rate_Image_Read_NV            = 23,
	Acceleration_Structure_Read_NVX       = 21,
	Acceleration_Structure_Write_NVX      = 22,
}

Dependency_Flags :: distinct bit_set[Dependency_Flag; u32];
Dependency_Flag :: enum u32 {
	By_Region        = 0,
	Device_Group     = 2,
	View_Local       = 1,
	View_Local_KHR   = View_Local,
	Device_Group_KHR = Device_Group,
}

Command_Pool_Create_Flags :: distinct bit_set[Command_Pool_Create_Flag; u32];
Command_Pool_Create_Flag :: enum u32 {
	Transient            = 0,
	Reset_Command_Buffer = 1,
	Protected            = 2,
}

Command_Pool_Reset_Flags :: distinct bit_set[Command_Pool_Reset_Flag; u32];
Command_Pool_Reset_Flag :: enum u32 {
	Release_Resources = 0,
}

Command_Buffer_Usage_Flags :: distinct bit_set[Command_Buffer_Usage_Flag; u32];
Command_Buffer_Usage_Flag :: enum u32 {
	One_Time_Submit      = 0,
	Render_Pass_Continue = 1,
	Simultaneous_Use     = 2,
}

Query_Control_Flags :: distinct bit_set[Query_Control_Flag; u32];
Query_Control_Flag :: enum u32 {
	Precise = 0,
}

Command_Buffer_Reset_Flags :: distinct bit_set[Command_Buffer_Reset_Flag; u32];
Command_Buffer_Reset_Flag :: enum u32 {
	Release_Resources = 0,
}

Stencil_Face_Flags :: distinct bit_set[Stencil_Face_Flag; u32];
Stencil_Face_Flag :: enum u32 {
	Front                  = 0,
	Back                   = 1,
	Stencil_Front_And_Back = 1,
}

Point_Clipping_Behavior :: enum c.int {
	All_Clip_Planes           = 0,
	User_Clip_Planes_Only     = 1,
	All_Clip_Planes_KHR       = All_Clip_Planes,
	User_Clip_Planes_Only_KHR = User_Clip_Planes_Only,
	Begin_Range               = All_Clip_Planes,
	End_Range                 = User_Clip_Planes_Only,
	Range_Size                = (User_Clip_Planes_Only-All_Clip_Planes+1),
}

Tessellation_Domain_Origin :: enum c.int {
	Upper_Left     = 0,
	Lower_Left     = 1,
	Upper_Left_KHR = Upper_Left,
	Lower_Left_KHR = Lower_Left,
	Begin_Range    = Upper_Left,
	End_Range      = Lower_Left,
	Range_Size     = (Lower_Left-Upper_Left+1),
}

Sampler_Ycbcr_Model_Conversion :: enum c.int {
	Rgb_Identity       = 0,
	Ycbcr_Identity     = 1,
	Ycbcr_709          = 2,
	Ycbcr_601          = 3,
	Ycbcr_2020         = 4,
	Rgb_Identity_KHR   = Rgb_Identity,
	Ycbcr_Identity_KHR = Ycbcr_Identity,
	Ycbcr_709_KHR      = Ycbcr_709,
	Ycbcr_601_KHR      = Ycbcr_601,
	Ycbcr_2020_KHR     = Ycbcr_2020,
	Begin_Range        = Rgb_Identity,
	End_Range          = Ycbcr_2020,
	Range_Size         = (Ycbcr_2020-Rgb_Identity+1),
}

Sampler_Ycbcr_Range :: enum c.int {
	Itu_Full       = 0,
	Itu_Narrow     = 1,
	Itu_Full_KHR   = Itu_Full,
	Itu_Narrow_KHR = Itu_Narrow,
	Begin_Range    = Itu_Full,
	End_Range      = Itu_Narrow,
	Range_Size     = (Itu_Narrow-Itu_Full+1),
}

Chroma_Location :: enum c.int {
	Cosited_Even     = 0,
	Midpoint         = 1,
	Cosited_Even_KHR = Cosited_Even,
	Midpoint_KHR     = Midpoint,
	Begin_Range      = Cosited_Even,
	End_Range        = Midpoint,
	Range_Size       = (Midpoint-Cosited_Even+1),
}

Descriptor_Update_Template_Type :: enum c.int {
	Descriptor_Set       = 0,
	Push_Descriptors_KHR = 1,
	Descriptor_Set_KHR   = Descriptor_Set,
	Begin_Range          = Descriptor_Set,
	End_Range            = Descriptor_Set,
	Range_Size           = (Descriptor_Set-Descriptor_Set+1),
}

Subgroup_Feature_Flags :: distinct bit_set[Subgroup_Feature_Flag; u32];
Subgroup_Feature_Flag :: enum u32 {
	Basic            = 0,
	Vote             = 1,
	Arithmetic       = 2,
	Ballot           = 3,
	Shuffle          = 4,
	Shuffle_Relative = 5,
	Clustered        = 6,
	Quad             = 7,
	Partitioned_NV   = 8,
}

Peer_Memory_Feature_Flags :: distinct bit_set[Peer_Memory_Feature_Flag; u32];
Peer_Memory_Feature_Flag :: enum u32 {
	Copy_Src        = 0,
	Copy_Dst        = 1,
	Generic_Src     = 2,
	Generic_Dst     = 3,
	Copy_Src_KHR    = Copy_Src,
	Copy_Dst_KHR    = Copy_Dst,
	Generic_Src_KHR = Generic_Src,
	Generic_Dst_KHR = Generic_Dst,
}

Memory_Allocate_Flags :: distinct bit_set[Memory_Allocate_Flag; u32];
Memory_Allocate_Flag :: enum u32 {
	Device_Mask     = 0,
	Device_Mask_KHR = Device_Mask,
}

External_Memory_Handle_Type_Flags :: distinct bit_set[External_Memory_Handle_Type_Flag; u32];
External_Memory_Handle_Type_Flag :: enum u32 {
	Opaque_Fd                       = 0,
	Opaque_Win32                    = 1,
	Opaque_Win32_Kmt                = 2,
	D3D11_Texture                   = 3,
	D3D11_Texture_Kmt               = 4,
	D3D12_Heap                      = 5,
	D3D12_Resource                  = 6,
	Dma_Buf_EXT                     = 9,
	Android_Hardware_Buffer_Android = 10,
	Host_Allocation_EXT             = 7,
	Host_Mapped_Foreign_Memory_EXT  = 8,
	Opaque_Fd_KHR                   = Opaque_Fd,
	Opaque_Win32_KHR                = Opaque_Win32,
	Opaque_Win32_Kmt_KHR            = Opaque_Win32_Kmt,
	D3D11_Texture_KHR               = D3D11_Texture,
	D3D11_Texture_Kmt_KHR           = D3D11_Texture_Kmt,
	D3D12_Heap_KHR                  = D3D12_Heap,
	D3D12_Resource_KHR              = D3D12_Resource,
}

External_Memory_Feature_Flags :: distinct bit_set[External_Memory_Feature_Flag; u32];
External_Memory_Feature_Flag :: enum u32 {
	Dedicated_Only     = 0,
	Exportable         = 1,
	Importable         = 2,
	Dedicated_Only_KHR = Dedicated_Only,
	Exportable_KHR     = Exportable,
	Importable_KHR     = Importable,
}

External_Fence_Handle_Type_Flags :: distinct bit_set[External_Fence_Handle_Type_Flag; u32];
External_Fence_Handle_Type_Flag :: enum u32 {
	Opaque_Fd            = 0,
	Opaque_Win32         = 1,
	Opaque_Win32_Kmt     = 2,
	Sync_Fd              = 3,
	Opaque_Fd_KHR        = Opaque_Fd,
	Opaque_Win32_KHR     = Opaque_Win32,
	Opaque_Win32_Kmt_KHR = Opaque_Win32_Kmt,
	Sync_Fd_KHR          = Sync_Fd,
}

External_Fence_Feature_Flags :: distinct bit_set[External_Fence_Feature_Flag; u32];
External_Fence_Feature_Flag :: enum u32 {
	Exportable     = 0,
	Importable     = 1,
	Exportable_KHR = Exportable,
	Importable_KHR = Importable,
}

Fence_Import_Flags :: distinct bit_set[Fence_Import_Flag; u32];
Fence_Import_Flag :: enum u32 {
	Temporary     = 0,
	Temporary_KHR = Temporary,
}

Semaphore_Import_Flags :: distinct bit_set[Semaphore_Import_Flag; u32];
Semaphore_Import_Flag :: enum u32 {
	Temporary     = 0,
	Temporary_KHR = Temporary,
}

External_Semaphore_Handle_Type_Flags :: distinct bit_set[External_Semaphore_Handle_Type_Flag; u32];
External_Semaphore_Handle_Type_Flag :: enum u32 {
	Opaque_Fd            = 0,
	Opaque_Win32         = 1,
	Opaque_Win32_Kmt     = 2,
	D3D12_Fence          = 3,
	Sync_Fd              = 4,
	Opaque_Fd_KHR        = Opaque_Fd,
	Opaque_Win32_KHR     = Opaque_Win32,
	Opaque_Win32_Kmt_KHR = Opaque_Win32_Kmt,
	D3D12_Fence_KHR      = D3D12_Fence,
	Sync_Fd_KHR          = Sync_Fd,
}

External_Semaphore_Feature_Flags :: distinct bit_set[External_Semaphore_Feature_Flag; u32];
External_Semaphore_Feature_Flag :: enum u32 {
	Exportable     = 0,
	Importable     = 1,
	Exportable_KHR = Exportable,
	Importable_KHR = Importable,
}

Color_Space_KHR :: enum c.int {
	Srgb_Nonlinear              = 0,
	Display_P3_Nonlinear_EXT    = 1000104001,
	Extended_Srgb_Linear_EXT    = 1000104002,
	Dci_P3_Linear_EXT           = 1000104003,
	Dci_P3_Nonlinear_EXT        = 1000104004,
	Bt709_Linear_EXT            = 1000104005,
	Bt709_Nonlinear_EXT         = 1000104006,
	Bt2020_Linear_EXT           = 1000104007,
	Hdr10_St2084_EXT            = 1000104008,
	Dolbyvision_EXT             = 1000104009,
	Hdr10_Hlg_EXT               = 1000104010,
	Adobergb_Linear_EXT         = 1000104011,
	Adobergb_Nonlinear_EXT      = 1000104012,
	Pass_Through_EXT            = 1000104013,
	Extended_Srgb_Nonlinear_EXT = 1000104014,
	Colorspace_Srgb_Nonlinear   = Srgb_Nonlinear,
	Begin_Range                 = Srgb_Nonlinear,
	End_Range                   = Srgb_Nonlinear,
	Range_Size                  = (Srgb_Nonlinear-Srgb_Nonlinear+1),
}

Present_Mode_KHR :: enum c.int {
	Immediate                 = 0,
	Mailbox                   = 1,
	Fifo                      = 2,
	Fifo_Relaxed              = 3,
	Shared_Demand_Refresh     = 1000111000,
	Shared_Continuous_Refresh = 1000111001,
	Begin_Range               = Immediate,
	End_Range                 = Fifo_Relaxed,
	Range_Size                = (Fifo_Relaxed-Immediate+1),
}

Surface_Transform_Flags_KHR :: distinct bit_set[Surface_Transform_Flag_KHR; u32];
Surface_Transform_Flag_KHR :: enum u32 {
	Identity                     = 0,
	Rotate_90                    = 1,
	Rotate_180                   = 2,
	Rotate_270                   = 3,
	Horizontal_Mirror            = 4,
	Horizontal_Mirror_Rotate_90  = 5,
	Horizontal_Mirror_Rotate_180 = 6,
	Horizontal_Mirror_Rotate_270 = 7,
	Inherit                      = 8,
}

Composite_Alpha_Flags_KHR :: distinct bit_set[Composite_Alpha_Flag_KHR; u32];
Composite_Alpha_Flag_KHR :: enum u32 {
	Opaque          = 0,
	Pre_Multiplied  = 1,
	Post_Multiplied = 2,
	Inherit         = 3,
}

Swapchain_Create_Flags_KHR :: distinct bit_set[Swapchain_Create_Flag_KHR; u32];
Swapchain_Create_Flag_KHR :: enum u32 {
	Split_Instance_Bind_Regions = 0,
	Protected                   = 1,
}

Device_Group_Present_Mode_Flags_KHR :: distinct bit_set[Device_Group_Present_Mode_Flag_KHR; u32];
Device_Group_Present_Mode_Flag_KHR :: enum u32 {
	Local              = 0,
	Remote             = 1,
	Sum                = 2,
	Local_Multi_Device = 3,
}

Display_Plane_Alpha_Flags_KHR :: distinct bit_set[Display_Plane_Alpha_Flag_KHR; u32];
Display_Plane_Alpha_Flag_KHR :: enum u32 {
	Opaque                  = 0,
	Global                  = 1,
	Per_Pixel               = 2,
	Per_Pixel_Premultiplied = 3,
}

Driver_Id_KHR :: enum c.int {
	Amd_Proprietary           = 1,
	Amd_Open_Source           = 2,
	Mesa_Radv                 = 3,
	Nvidia_Proprietary        = 4,
	Intel_Proprietary_Windows = 5,
	Intel_Open_Source_Mesa    = 6,
	Imagination_Proprietary   = 7,
	Qualcomm_Proprietary      = 8,
	Arm_Proprietary           = 9,
	Begin_Range               = Amd_Proprietary,
	End_Range                 = Arm_Proprietary,
	Range_Size                = (Arm_Proprietary-Amd_Proprietary+1),
}

Debug_Report_Object_Type_EXT :: enum c.int {
	Unknown                        = 0,
	Instance                       = 1,
	Physical_Device                = 2,
	Device                         = 3,
	Queue                          = 4,
	Semaphore                      = 5,
	Command_Buffer                 = 6,
	Fence                          = 7,
	Device_Memory                  = 8,
	Buffer                         = 9,
	Image                          = 10,
	Event                          = 11,
	Query_Pool                     = 12,
	Buffer_View                    = 13,
	Image_View                     = 14,
	Shader_Module                  = 15,
	Pipeline_Cache                 = 16,
	Pipeline_Layout                = 17,
	Render_Pass                    = 18,
	Pipeline                       = 19,
	Descriptor_Set_Layout          = 20,
	Sampler                        = 21,
	Descriptor_Pool                = 22,
	Descriptor_Set                 = 23,
	Framebuffer                    = 24,
	Command_Pool                   = 25,
	Surface_KHR                    = 26,
	Swapchain_KHR                  = 27,
	Debug_Report_Callback_EXT      = 28,
	Display_KHR                    = 29,
	Display_Mode_KHR               = 30,
	Object_Table_NVX               = 31,
	Indirect_Commands_Layout_NVX   = 32,
	Validation_Cache_EXT           = 33,
	Sampler_Ycbcr_Conversion       = 1000156000,
	Descriptor_Update_Template     = 1000085000,
	Acceleration_Structure_NVX     = 1000165000,
	Debug_Report                   = Debug_Report_Callback_EXT,
	Validation_Cache               = Validation_Cache_EXT,
	Descriptor_Update_Template_KHR = Descriptor_Update_Template,
	Sampler_Ycbcr_Conversion_KHR   = Sampler_Ycbcr_Conversion,
	Begin_Range                    = Unknown,
	End_Range                      = Validation_Cache_EXT,
	Range_Size                     = (Validation_Cache_EXT-Unknown+1),
}

Debug_Report_Flags_EXT :: distinct bit_set[Debug_Report_Flag_EXT; u32];
Debug_Report_Flag_EXT :: enum u32 {
	Information         = 0,
	Warning             = 1,
	Performance_Warning = 2,
	Error               = 3,
	Debug               = 4,
}

Rasterization_Order_AMD :: enum c.int {
	Strict      = 0,
	Relaxed     = 1,
	Begin_Range = Strict,
	End_Range   = Relaxed,
	Range_Size  = (Relaxed-Strict+1),
}

Shader_Info_Type_AMD :: enum c.int {
	Statistics  = 0,
	Binary      = 1,
	Disassembly = 2,
	Begin_Range = Statistics,
	End_Range   = Disassembly,
	Range_Size  = (Disassembly-Statistics+1),
}

External_Memory_Handle_Type_Flags_NV :: distinct bit_set[External_Memory_Handle_Type_Flag_NV; u32];
External_Memory_Handle_Type_Flag_NV :: enum u32 {
	Opaque_Win32     = 0,
	Opaque_Win32_Kmt = 1,
	D3D11_Image      = 2,
	D3D11_Image_Kmt  = 3,
}

External_Memory_Feature_Flags_NV :: distinct bit_set[External_Memory_Feature_Flag_NV; u32];
External_Memory_Feature_Flag_NV :: enum u32 {
	Dedicated_Only = 0,
	Exportable     = 1,
	Importable     = 2,
}

Validation_Check_EXT :: enum c.int {
	All         = 0,
	Shaders     = 1,
	Begin_Range = All,
	End_Range   = Shaders,
	Range_Size  = (Shaders-All+1),
}

Conditional_Rendering_Flags_EXT :: distinct bit_set[Conditional_Rendering_Flag_EXT; u32];
Conditional_Rendering_Flag_EXT :: enum u32 {
	Inverted = 0,
}

Indirect_Commands_Token_Type_NVX :: enum c.int {
	Pipeline       = 0,
	Descriptor_Set = 1,
	Index_Buffer   = 2,
	Vertex_Buffer  = 3,
	Push_Constant  = 4,
	Draw_Indexed   = 5,
	Draw           = 6,
	Dispatch       = 7,
	Begin_Range    = Pipeline,
	End_Range      = Dispatch,
	Range_Size     = (Dispatch-Pipeline+1),
}

Object_Entry_Type_NVX :: enum c.int {
	Descriptor_Set = 0,
	Pipeline       = 1,
	Index_Buffer   = 2,
	Vertex_Buffer  = 3,
	Push_Constant  = 4,
	Begin_Range    = Descriptor_Set,
	End_Range      = Push_Constant,
	Range_Size     = (Push_Constant-Descriptor_Set+1),
}

Indirect_Commands_Layout_Usage_Flags_NVX :: distinct bit_set[Indirect_Commands_Layout_Usage_Flag_NVX; u32];
Indirect_Commands_Layout_Usage_Flag_NVX :: enum u32 {
	Unordered_Sequences = 0,
	Sparse_Sequences    = 1,
	Empty_Executions    = 2,
	Indexed_Sequences   = 3,
}

Object_Entry_Usage_Flags_NVX :: distinct bit_set[Object_Entry_Usage_Flag_NVX; u32];
Object_Entry_Usage_Flag_NVX :: enum u32 {
	Graphics = 0,
	Compute  = 1,
}

Surface_Counter_Flags_EXT :: distinct bit_set[Surface_Counter_Flag_EXT; u32];
Surface_Counter_Flag_EXT :: enum u32 {
	Vblank = 0,
}

Display_Power_State_EXT :: enum c.int {
	Off         = 0,
	Suspend     = 1,
	On          = 2,
	Begin_Range = Off,
	End_Range   = On,
	Range_Size  = (On-Off+1),
}

Device_Event_Type_EXT :: enum c.int {
	Display_Hotplug = 0,
	Begin_Range     = Display_Hotplug,
	End_Range       = Display_Hotplug,
	Range_Size      = (Display_Hotplug-Display_Hotplug+1),
}

Display_Event_Type_EXT :: enum c.int {
	First_Pixel_Out = 0,
	Begin_Range     = First_Pixel_Out,
	End_Range       = First_Pixel_Out,
	Range_Size      = (First_Pixel_Out-First_Pixel_Out+1),
}

Viewport_Coordinate_Swizzle_NV :: enum c.int {
	Positive_X  = 0,
	Negative_X  = 1,
	Positive_Y  = 2,
	Negative_Y  = 3,
	Positive_Z  = 4,
	Negative_Z  = 5,
	Positive_W  = 6,
	Negative_W  = 7,
	Begin_Range = Positive_X,
	End_Range   = Negative_W,
	Range_Size  = (Negative_W-Positive_X+1),
}

Discard_Rectangle_Mode_EXT :: enum c.int {
	Inclusive   = 0,
	Exclusive   = 1,
	Begin_Range = Inclusive,
	End_Range   = Exclusive,
	Range_Size  = (Exclusive-Inclusive+1),
}

Conservative_Rasterization_Mode_EXT :: enum c.int {
	Disabled      = 0,
	Overestimate  = 1,
	Underestimate = 2,
	Begin_Range   = Disabled,
	End_Range     = Underestimate,
	Range_Size    = (Underestimate-Disabled+1),
}

Debug_Utils_Message_Severity_Flags_EXT :: distinct bit_set[Debug_Utils_Message_Severity_Flag_EXT; u32];
Debug_Utils_Message_Severity_Flag_EXT :: enum u32 {
	Verbose = 0,
	Info    = 4,
	Warning = 8,
	Error   = 12,
}

Debug_Utils_Message_Type_Flags_EXT :: distinct bit_set[Debug_Utils_Message_Type_Flag_EXT; u32];
Debug_Utils_Message_Type_Flag_EXT :: enum u32 {
	General     = 0,
	Validation  = 1,
	Performance = 2,
}

Sampler_Reduction_Mode_EXT :: enum c.int {
	Weighted_Average = 0,
	Min              = 1,
	Max              = 2,
	Begin_Range      = Weighted_Average,
	End_Range        = Max,
	Range_Size       = (Max-Weighted_Average+1),
}

Blend_Overlap_EXT :: enum c.int {
	Uncorrelated = 0,
	Disjoint     = 1,
	Conjoint     = 2,
	Begin_Range  = Uncorrelated,
	End_Range    = Conjoint,
	Range_Size   = (Conjoint-Uncorrelated+1),
}

Coverage_Modulation_Mode_NV :: enum c.int {
	None        = 0,
	Rgb         = 1,
	Alpha       = 2,
	Rgba        = 3,
	Begin_Range = None,
	End_Range   = Rgba,
	Range_Size  = (Rgba-None+1),
}

Validation_Cache_Header_Version_EXT :: enum c.int {
	One         = 1,
	Begin_Range = One,
	End_Range   = One,
	Range_Size  = (One-One+1),
}

Descriptor_Binding_Flags_EXT :: distinct bit_set[Descriptor_Binding_Flag_EXT; u32];
Descriptor_Binding_Flag_EXT :: enum u32 {
	Update_After_Bind           = 0,
	Update_Unused_While_Pending = 1,
	Partially_Bound             = 2,
	Variable_Descriptor_Count   = 3,
}

Shading_Rate_Palette_Entry_NV :: enum c.int {
	No_Invocations               = 0,
	_16_Invocations_Per_Pixel    = 1,
	_8_Invocations_Per_Pixel     = 2,
	_4_Invocations_Per_Pixel     = 3,
	_2_Invocations_Per_Pixel     = 4,
	_1_Invocation_Per_Pixel      = 5,
	_1_Invocation_Per_2X1_Pixels = 6,
	_1_Invocation_Per_1X2_Pixels = 7,
	_1_Invocation_Per_2X2_Pixels = 8,
	_1_Invocation_Per_4X2_Pixels = 9,
	_1_Invocation_Per_2X4_Pixels = 10,
	_1_Invocation_Per_4X4_Pixels = 11,
	Begin_Range                  = No_Invocations,
	End_Range                    = _1_Invocation_Per_4X4_Pixels,
	Range_Size                   = (_1_Invocation_Per_4X4_Pixels-No_Invocations+1),
}

Coarse_Sample_Order_Type_NV :: enum c.int {
	Default      = 0,
	Custom       = 1,
	Pixel_Major  = 2,
	Sample_Major = 3,
	Begin_Range  = Default,
	End_Range    = Sample_Major,
	Range_Size   = (Sample_Major-Default+1),
}

Geometry_Type_NVX :: enum c.int {
	Triangles   = 0,
	Aabbs       = 1,
	Begin_Range = Triangles,
	End_Range   = Aabbs,
	Range_Size  = (Aabbs-Triangles+1),
}

Acceleration_Structure_Type_NVX :: enum c.int {
	Top_Level    = 0,
	Bottom_Level = 1,
	Begin_Range  = Top_Level,
	End_Range    = Bottom_Level,
	Range_Size   = (Bottom_Level-Top_Level+1),
}

Copy_Acceleration_Structure_Mode_NVX :: enum c.int {
	Clone       = 0,
	Compact     = 1,
	Begin_Range = Clone,
	End_Range   = Compact,
	Range_Size  = (Compact-Clone+1),
}

Geometry_Flags_NVX :: distinct bit_set[Geometry_Flag_NVX; u32];
Geometry_Flag_NVX :: enum u32 {
	Opaque                          = 0,
	No_Duplicate_Any_Hit_Invocation = 1,
}

Geometry_Instance_Flags_NVX :: distinct bit_set[Geometry_Instance_Flag_NVX; u32];
Geometry_Instance_Flag_NVX :: enum u32 {
	Triangle_Cull_Disable      = 0,
	Triangle_Cull_Flip_Winding = 1,
	Force_Opaque               = 2,
	Force_No_Opaque            = 3,
}

Build_Acceleration_Structure_Flags_NVX :: distinct bit_set[Build_Acceleration_Structure_Flag_NVX; u32];
Build_Acceleration_Structure_Flag_NVX :: enum u32 {
	Allow_Update      = 0,
	Allow_Compaction  = 1,
	Prefer_Fast_Trace = 2,
	Prefer_Fast_Build = 3,
	Low_Memory        = 4,
}

Queue_Global_Priority_EXT :: enum c.int {
	Low         = 128,
	Medium      = 256,
	High        = 512,
	Realtime    = 1024,
	Begin_Range = Low,
	End_Range   = Realtime,
	Range_Size  = (Realtime-Low+1),
}

Time_Domain_EXT :: enum c.int {
	Device                    = 0,
	Clock_Monotonic           = 1,
	Clock_Monotonic_Raw       = 2,
	Query_Performance_Counter = 3,
	Begin_Range               = Device,
	End_Range                 = Query_Performance_Counter,
	Range_Size                = (Query_Performance_Counter-Device+1),
}

Descriptor_Update_Template_Create_Flags                    :: distinct Flags;
Event_Create_Flags                                         :: distinct Flags;
Pipeline_Dynamic_State_Create_Flags                        :: distinct Flags;
Shader_Module_Create_Flags                                 :: distinct Flags;
Instance_Create_Flags                                      :: distinct Flags;
Render_Pass_Create_Flags                                   :: distinct Flags;
Sampler_Create_Flags                                       :: distinct Flags;
Pipeline_Rasterization_State_Create_Flags                  :: distinct Flags;
Validation_Cache_Create_Flags_EXT                          :: distinct Flags;
Pipeline_Tessellation_State_Create_Flags                   :: distinct Flags;
Descriptor_Pool_Reset_Flags                                :: distinct Flags;
Pipeline_Input_Assembly_State_Create_Flags                 :: distinct Flags;
Pipeline_Vertex_Input_State_Create_Flags                   :: distinct Flags;
Pipeline_Multisample_State_Create_Flags                    :: distinct Flags;
Pipeline_Rasterization_State_Stream_Create_Flags_EXT       :: distinct Flags;
Pipeline_Viewport_Swizzle_State_Create_Flags_NV            :: distinct Flags;
Buffer_View_Create_Flags                                   :: distinct Flags;
Device_Create_Flags                                        :: distinct Flags;
Display_Mode_Create_Flags_KHR                              :: distinct Flags;
Debug_Utils_Messenger_Callback_Data_Flags_EXT              :: distinct Flags;
Pipeline_Discard_Rectangle_State_Create_Flags_EXT          :: distinct Flags;
Image_View_Create_Flags                                    :: distinct Flags;
Pipeline_Layout_Create_Flags                               :: distinct Flags;
Pipeline_Shader_Stage_Create_Flags                         :: distinct Flags;
Pipeline_Color_Blend_State_Create_Flags                    :: distinct Flags;
Command_Pool_Trim_Flags                                    :: distinct Flags;
Display_Surface_Create_Flags_KHR                           :: distinct Flags;
Pipeline_Coverage_Modulation_State_Create_Flags_NV         :: distinct Flags;
Pipeline_Depth_Stencil_State_Create_Flags                  :: distinct Flags;
Pipeline_Coverage_To_Color_State_Create_Flags_NV           :: distinct Flags;
Pipeline_Cache_Create_Flags                                :: distinct Flags;
Debug_Utils_Messenger_Create_Flags_EXT                     :: distinct Flags;
Semaphore_Create_Flags                                     :: distinct Flags;
Pipeline_Rasterization_Conservative_State_Create_Flags_EXT :: distinct Flags;
Memory_Map_Flags                                           :: distinct Flags;
Pipeline_Viewport_State_Create_Flags                       :: distinct Flags;
Framebuffer_Create_Flags                                   :: distinct Flags;
Query_Pool_Create_Flags                                    :: distinct Flags;



Application_Info :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	application_name:    cstring,
	application_version: u32,
	engine_name:         cstring,
	engine_version:      u32,
	api_version:         u32,
}

Instance_Create_Info :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	flags:                   Instance_Create_Flags,
	application_info:        ^Application_Info,
	enabled_layer_count:     u32,
	enabled_layer_names:     cstring_array,
	enabled_extension_count: u32,
	enabled_extension_names: cstring_array,
}

Allocation_Callbacks :: struct {
	user_data:           rawptr,
	allocation:          Proc_Allocation_Function,
	reallocation:        Proc_Reallocation_Function,
	free:                Proc_Free_Function,
	internal_allocation: Proc_Internal_Allocation_Notification,
	internal_free:       Proc_Internal_Free_Notification,
}

Physical_Device_Features :: struct {
	robust_buffer_access:                         b32,
	full_draw_index_uint32:                       b32,
	image_cube_array:                             b32,
	independent_blend:                            b32,
	geometry_shader:                              b32,
	tessellation_shader:                          b32,
	sample_rate_shading:                          b32,
	dual_src_blend:                               b32,
	logic_op:                                     b32,
	multi_draw_indirect:                          b32,
	draw_indirect_first_instance:                 b32,
	depth_clamp:                                  b32,
	depth_bias_clamp:                             b32,
	fill_mode_non_solid:                          b32,
	depth_bounds:                                 b32,
	wide_lines:                                   b32,
	large_points:                                 b32,
	alpha_to_one:                                 b32,
	multi_viewport:                               b32,
	sampler_anisotropy:                           b32,
	texture_compression_etc2:                     b32,
	texture_compression_astc_ldr:                 b32,
	texture_compression_bc:                       b32,
	occlusion_query_precise:                      b32,
	pipeline_statistics_query:                    b32,
	vertex_pipeline_stores_and_atomics:           b32,
	fragment_stores_and_atomics:                  b32,
	shader_tessellation_and_geometry_point_size:  b32,
	shader_image_gather_extended:                 b32,
	shader_storage_image_extended_formats:        b32,
	shader_storage_image_multisample:             b32,
	shader_storage_image_read_without_format:     b32,
	shader_storage_image_write_without_format:    b32,
	shader_uniform_buffer_array_dynamic_indexing: b32,
	shader_sampled_image_array_dynamic_indexing:  b32,
	shader_storage_buffer_array_dynamic_indexing: b32,
	shader_storage_image_array_dynamic_indexing:  b32,
	shader_clip_distance:                         b32,
	shader_cull_distance:                         b32,
	shader_float64:                               b32,
	shader_int64:                                 b32,
	shader_int16:                                 b32,
	shader_resource_residency:                    b32,
	shader_resource_min_lod:                      b32,
	sparse_binding:                               b32,
	sparse_residency_buffer:                      b32,
	sparse_residency_image2d:                     b32,
	sparse_residency_image3d:                     b32,
	sparse_residency2_samples:                    b32,
	sparse_residency4_samples:                    b32,
	sparse_residency8_samples:                    b32,
	sparse_residency16_samples:                   b32,
	sparse_residency_aliased:                     b32,
	variable_multisample_rate:                    b32,
	inherited_queries:                            b32,
}

Format_Properties :: struct {
	linear_tiling_features:  Format_Feature_Flags,
	optimal_tiling_features: Format_Feature_Flags,
	buffer_features:         Format_Feature_Flags,
}

Extent3D :: struct {
	width:  u32,
	height: u32,
	depth:  u32,
}

Image_Format_Properties :: struct {
	max_extent:        Extent3D,
	max_mip_levels:    u32,
	max_array_layers:  u32,
	sample_counts:     Sample_Count_Flags,
	max_resource_size: Device_Size,
}

Physical_Device_Limits :: struct {
	max_image_dimension1d:                                 u32,
	max_image_dimension2d:                                 u32,
	max_image_dimension3d:                                 u32,
	max_image_dimension_cube:                              u32,
	max_image_array_layers:                                u32,
	max_texel_buffer_elements:                             u32,
	max_uniform_buffer_range:                              u32,
	max_storage_buffer_range:                              u32,
	max_push_constants_size:                               u32,
	max_memory_allocation_count:                           u32,
	max_sampler_allocation_count:                          u32,
	buffer_image_granularity:                              Device_Size,
	sparse_address_space_size:                             Device_Size,
	max_bound_descriptor_sets:                             u32,
	max_per_stage_descriptor_samplers:                     u32,
	max_per_stage_descriptor_uniform_buffers:              u32,
	max_per_stage_descriptor_storage_buffers:              u32,
	max_per_stage_descriptor_sampled_images:               u32,
	max_per_stage_descriptor_storage_images:               u32,
	max_per_stage_descriptor_input_attachments:            u32,
	max_per_stage_resources:                               u32,
	max_descriptor_set_samplers:                           u32,
	max_descriptor_set_uniform_buffers:                    u32,
	max_descriptor_set_uniform_buffers_dynamic:            u32,
	max_descriptor_set_storage_buffers:                    u32,
	max_descriptor_set_storage_buffers_dynamic:            u32,
	max_descriptor_set_sampled_images:                     u32,
	max_descriptor_set_storage_images:                     u32,
	max_descriptor_set_input_attachments:                  u32,
	max_vertex_input_attributes:                           u32,
	max_vertex_input_bindings:                             u32,
	max_vertex_input_attribute_offset:                     u32,
	max_vertex_input_binding_stride:                       u32,
	max_vertex_output_components:                          u32,
	max_tessellation_generation_level:                     u32,
	max_tessellation_patch_size:                           u32,
	max_tessellation_control_per_vertex_input_components:  u32,
	max_tessellation_control_per_vertex_output_components: u32,
	max_tessellation_control_per_patch_output_components:  u32,
	max_tessellation_control_total_output_components:      u32,
	max_tessellation_evaluation_input_components:          u32,
	max_tessellation_evaluation_output_components:         u32,
	max_geometry_shader_invocations:                       u32,
	max_geometry_input_components:                         u32,
	max_geometry_output_components:                        u32,
	max_geometry_output_vertices:                          u32,
	max_geometry_total_output_components:                  u32,
	max_fragment_input_components:                         u32,
	max_fragment_output_attachments:                       u32,
	max_fragment_dual_src_attachments:                     u32,
	max_fragment_combined_output_resources:                u32,
	max_compute_shared_memory_size:                        u32,
	max_compute_work_group_count:                          [3]u32,
	max_compute_work_group_invocations:                    u32,
	max_compute_work_group_size:                           [3]u32,
	sub_pixel_precision_bits:                              u32,
	sub_texel_precision_bits:                              u32,
	mipmap_precision_bits:                                 u32,
	max_draw_indexed_index_value:                          u32,
	max_draw_indirect_count:                               u32,
	max_sampler_lod_bias:                                  f32,
	max_sampler_anisotropy:                                f32,
	max_viewports:                                         u32,
	max_viewport_dimensions:                               [2]u32,
	viewport_bounds_range:                                 [2]f32,
	viewport_sub_pixel_bits:                               u32,
	min_memory_map_alignment:                              int,
	min_texel_buffer_offset_alignment:                     Device_Size,
	min_uniform_buffer_offset_alignment:                   Device_Size,
	min_storage_buffer_offset_alignment:                   Device_Size,
	min_texel_offset:                                      i32,
	max_texel_offset:                                      u32,
	min_texel_gather_offset:                               i32,
	max_texel_gather_offset:                               u32,
	min_interpolation_offset:                              f32,
	max_interpolation_offset:                              f32,
	sub_pixel_interpolation_offset_bits:                   u32,
	max_framebuffer_width:                                 u32,
	max_framebuffer_height:                                u32,
	max_framebuffer_layers:                                u32,
	framebuffer_color_sample_counts:                       Sample_Count_Flags,
	framebuffer_depth_sample_counts:                       Sample_Count_Flags,
	framebuffer_stencil_sample_counts:                     Sample_Count_Flags,
	framebuffer_no_attachments_sample_counts:              Sample_Count_Flags,
	max_color_attachments:                                 u32,
	sampled_image_color_sample_counts:                     Sample_Count_Flags,
	sampled_image_integer_sample_counts:                   Sample_Count_Flags,
	sampled_image_depth_sample_counts:                     Sample_Count_Flags,
	sampled_image_stencil_sample_counts:                   Sample_Count_Flags,
	storage_image_sample_counts:                           Sample_Count_Flags,
	max_sample_mask_words:                                 u32,
	timestamp_compute_and_graphics:                        b32,
	timestamp_period:                                      f32,
	max_clip_distances:                                    u32,
	max_cull_distances:                                    u32,
	max_combined_clip_and_cull_distances:                  u32,
	discrete_queue_priorities:                             u32,
	point_size_range:                                      [2]f32,
	line_width_range:                                      [2]f32,
	point_size_granularity:                                f32,
	line_width_granularity:                                f32,
	strict_lines:                                          b32,
	standard_sample_locations:                             b32,
	optimal_buffer_copy_offset_alignment:                  Device_Size,
	optimal_buffer_copy_row_pitch_alignment:               Device_Size,
	non_coherent_atom_size:                                Device_Size,
}

Physical_Device_Sparse_Properties :: struct {
	residency_standard_2d__block_shape:             b32,
	residency_standard_2d__multisample_block_shape: b32,
	residency_standard_3d__block_shape:             b32,
	residency_aligned_mip_size:                     b32,
	residency_non_resident_strict:                  b32,
}

Physical_Device_Properties :: struct {
	api_version:         u32,
	driver_version:      u32,
	vendor_id:           u32,
	device_id:           u32,
	device_type:         Physical_Device_Type,
	device_name:         [MAX_PHYSICAL_DEVICE_NAME_SIZE]byte,
	pipeline_cache_uuid: [UUID_SIZE]u8,
	limits:              Physical_Device_Limits,
	sparse_properties:   Physical_Device_Sparse_Properties,
}

Queue_Family_Properties :: struct {
	queue_flags:                    Queue_Flags,
	queue_count:                    u32,
	timestamp_valid_bits:           u32,
	min_image_transfer_granularity: Extent3D,
}

Memory_Type :: struct {
	property_flags: Memory_Property_Flags,
	heap_index:     u32,
}

Memory_Heap :: struct {
	size:  Device_Size,
	flags: Memory_Heap_Flags,
}

Physical_Device_Memory_Properties :: struct {
	memory_type_count: u32,
	memory_types:      [MAX_MEMORY_TYPES]Memory_Type,
	memory_heap_count: u32,
	memory_heaps:      [MAX_MEMORY_HEAPS]Memory_Heap,
}

Device_Queue_Create_Info :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	flags:              Device_Queue_Create_Flags,
	queue_family_index: u32,
	queue_count:        u32,
	queue_priorities:   ^f32,
}

Device_Create_Info :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	flags:                   Device_Create_Flags,
	queue_create_info_count: u32,
	queue_create_infos:      ^Device_Queue_Create_Info,
	enabled_layer_count:     u32,
	enabled_layer_names:     cstring_array,
	enabled_extension_count: u32,
	enabled_extension_names: cstring_array,
	enabled_features:        ^Physical_Device_Features,
}

Extension_Properties :: struct {
	extension_name: [MAX_EXTENSION_NAME_SIZE]byte,
	spec_version:   u32,
}

Layer_Properties :: struct {
	layer_name:             [MAX_EXTENSION_NAME_SIZE]byte,
	spec_version:           u32,
	implementation_version: u32,
	description:            [MAX_DESCRIPTION_SIZE]byte,
}

Submit_Info :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	wait_semaphore_count:   u32,
	wait_semaphores:        ^Semaphore,
	wait_dst_stage_mask:    ^Pipeline_Stage_Flags,
	command_buffer_count:   u32,
	command_buffers:        ^Command_Buffer,
	signal_semaphore_count: u32,
	signal_semaphores:      ^Semaphore,
}

Memory_Allocate_Info :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	allocation_size:   Device_Size,
	memory_type_index: u32,
}

Mapped_Memory_Range :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	memory: Device_Memory,
	offset: Device_Size,
	size:   Device_Size,
}

Memory_Requirements :: struct {
	size:             Device_Size,
	alignment:        Device_Size,
	memory_type_bits: u32,
}

Sparse_Image_Format_Properties :: struct {
	aspect_mask:       Image_Aspect_Flags,
	image_granularity: Extent3D,
	flags:             Sparse_Image_Format_Flags,
}

Sparse_Image_Memory_Requirements :: struct {
	format_properties:        Sparse_Image_Format_Properties,
	image_mip_tail_first_lod: u32,
	image_mip_tail_size:      Device_Size,
	image_mip_tail_offset:    Device_Size,
	image_mip_tail_stride:    Device_Size,
}

Sparse_Memory_Bind :: struct {
	resource_offset: Device_Size,
	size:            Device_Size,
	memory:          Device_Memory,
	memory_offset:   Device_Size,
	flags:           Sparse_Memory_Bind_Flags,
}

Sparse_Buffer_Memory_Bind_Info :: struct {
	buffer:     Buffer,
	bind_count: u32,
	binds:      ^Sparse_Memory_Bind,
}

Sparse_Image_Opaque_Memory_Bind_Info :: struct {
	image:      Image,
	bind_count: u32,
	binds:      ^Sparse_Memory_Bind,
}

Image_Subresource :: struct {
	aspect_mask: Image_Aspect_Flags,
	mip_level:   u32,
	array_layer: u32,
}

Offset3D :: struct {
	x: i32,
	y: i32,
	z: i32,
}

Sparse_Image_Memory_Bind :: struct {
	subresource:   Image_Subresource,
	offset:        Offset3D,
	extent:        Extent3D,
	memory:        Device_Memory,
	memory_offset: Device_Size,
	flags:         Sparse_Memory_Bind_Flags,
}

Sparse_Image_Memory_Bind_Info :: struct {
	image:      Image,
	bind_count: u32,
	binds:      ^Sparse_Image_Memory_Bind,
}

Bind_Sparse_Info :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	wait_semaphore_count:    u32,
	wait_semaphores:         ^Semaphore,
	buffer_bind_count:       u32,
	buffer_binds:            ^Sparse_Buffer_Memory_Bind_Info,
	image_opaque_bind_count: u32,
	image_opaque_binds:      ^Sparse_Image_Opaque_Memory_Bind_Info,
	image_bind_count:        u32,
	image_binds:             ^Sparse_Image_Memory_Bind_Info,
	signal_semaphore_count:  u32,
	signal_semaphores:       ^Semaphore,
}

Fence_Create_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	flags:  Fence_Create_Flags,
}

Semaphore_Create_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	flags:  Semaphore_Create_Flags,
}

Event_Create_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	flags:  Event_Create_Flags,
}

Query_Pool_Create_Info :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	flags:               Query_Pool_Create_Flags,
	query_type:          Query_Type,
	query_count:         u32,
	pipeline_statistics: Query_Pipeline_Statistic_Flags,
}

Buffer_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Buffer_Create_Flags,
	size:                     Device_Size,
	usage:                    Buffer_Usage_Flags,
	sharing_mode:             Sharing_Mode,
	queue_family_index_count: u32,
	queue_family_indices:     ^u32,
}

Buffer_View_Create_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	flags:  Buffer_View_Create_Flags,
	buffer: Buffer,
	format: Format,
	offset: Device_Size,
	range:  Device_Size,
}

Image_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Image_Create_Flags,
	image_type:               Image_Type,
	format:                   Format,
	extent:                   Extent3D,
	mip_levels:               u32,
	array_layers:             u32,
	samples:                  Sample_Count_Flags,
	tiling:                   Image_Tiling,
	usage:                    Image_Usage_Flags,
	sharing_mode:             Sharing_Mode,
	queue_family_index_count: u32,
	queue_family_indices:     ^u32,
	initial_layout:           Image_Layout,
}

Subresource_Layout :: struct {
	offset:      Device_Size,
	size:        Device_Size,
	row_pitch:   Device_Size,
	array_pitch: Device_Size,
	depth_pitch: Device_Size,
}

Component_Mapping :: struct {
	r: Component_Swizzle,
	g: Component_Swizzle,
	b: Component_Swizzle,
	a: Component_Swizzle,
}

Image_Subresource_Range :: struct {
	aspect_mask:      Image_Aspect_Flags,
	base_mip_level:   u32,
	level_count:      u32,
	base_array_layer: u32,
	layer_count:      u32,
}

Image_View_Create_Info :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	flags:             Image_View_Create_Flags,
	image:             Image,
	view_type:         Image_View_Type,
	format:            Format,
	components:        Component_Mapping,
	subresource_range: Image_Subresource_Range,
}

Shader_Module_Create_Info :: struct {
	s_type:    Structure_Type,
	next:      rawptr,
	flags:     Shader_Module_Create_Flags,
	code_size: int,
	code:      ^u32,
}

Pipeline_Cache_Create_Info :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	flags:             Pipeline_Cache_Create_Flags,
	initial_data_size: int,
	initial_data:      rawptr,
}

Specialization_Map_Entry :: struct {
	constant_id: u32,
	offset:      u32,
	size:        int,
}

Specialization_Info :: struct {
	map_entry_count: u32,
	map_entries:     ^Specialization_Map_Entry,
	data_size:       int,
	data:            rawptr,
}

Pipeline_Shader_Stage_Create_Info :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	flags:               Pipeline_Shader_Stage_Create_Flags,
	stage:               Shader_Stage_Flags,
	module:              Shader_Module,
	name:                cstring,
	specialization_info: ^Specialization_Info,
}

Vertex_Input_Binding_Description :: struct {
	binding:    u32,
	stride:     u32,
	input_rate: Vertex_Input_Rate,
}

Vertex_Input_Attribute_Description :: struct {
	location: u32,
	binding:  u32,
	format:   Format,
	offset:   u32,
}

Pipeline_Vertex_Input_State_Create_Info :: struct {
	s_type:                             Structure_Type,
	next:                               rawptr,
	flags:                              Pipeline_Vertex_Input_State_Create_Flags,
	vertex_binding_description_count:   u32,
	vertex_binding_descriptions:        ^Vertex_Input_Binding_Description,
	vertex_attribute_description_count: u32,
	vertex_attribute_descriptions:      ^Vertex_Input_Attribute_Description,
}

Pipeline_Input_Assembly_State_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Pipeline_Input_Assembly_State_Create_Flags,
	topology:                 Primitive_Topology,
	primitive_restart_enable: b32,
}

Pipeline_Tessellation_State_Create_Info :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	flags:                Pipeline_Tessellation_State_Create_Flags,
	patch_control_points: u32,
}

Viewport :: struct {
	x:         f32,
	y:         f32,
	width:     f32,
	height:    f32,
	min_depth: f32,
	max_depth: f32,
}

Offset2D :: struct {
	x: i32,
	y: i32,
}

Extent2D :: struct {
	width:  u32,
	height: u32,
}

Rect2D :: struct {
	offset: Offset2D,
	extent: Extent2D,
}

Pipeline_Viewport_State_Create_Info :: struct {
	s_type:         Structure_Type,
	next:           rawptr,
	flags:          Pipeline_Viewport_State_Create_Flags,
	viewport_count: u32,
	viewports:      ^Viewport,
	scissor_count:  u32,
	scissors:       ^Rect2D,
}

Pipeline_Rasterization_State_Create_Info :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	flags:                      Pipeline_Rasterization_State_Create_Flags,
	depth_clamp_enable:         b32,
	rasterizer_discard_enable:  b32,
	polygon_mode:               Polygon_Mode,
	cull_mode:                  Cull_Mode_Flags,
	front_face:                 Front_Face,
	depth_bias_enable:          b32,
	depth_bias_constant_factor: f32,
	depth_bias_clamp:           f32,
	depth_bias_slope_factor:    f32,
	line_width:                 f32,
}

Pipeline_Multisample_State_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Pipeline_Multisample_State_Create_Flags,
	rasterization_samples:    Sample_Count_Flags,
	sample_shading_enable:    b32,
	min_sample_shading:       f32,
	sample_mask:              ^Sample_Mask,
	alpha_to_coverage_enable: b32,
	alpha_to_one_enable:      b32,
}

Stencil_Op_State :: struct {
	fail_op:       Stencil_Op,
	pass_op:       Stencil_Op,
	depth_fail_op: Stencil_Op,
	compare_op:    Compare_Op,
	compare_mask:  u32,
	write_mask:    u32,
	reference:     u32,
}

Pipeline_Depth_Stencil_State_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Pipeline_Depth_Stencil_State_Create_Flags,
	depth_test_enable:        b32,
	depth_write_enable:       b32,
	depth_compare_op:         Compare_Op,
	depth_bounds_test_enable: b32,
	stencil_test_enable:      b32,
	front:                    Stencil_Op_State,
	back:                     Stencil_Op_State,
	min_depth_bounds:         f32,
	max_depth_bounds:         f32,
}

Pipeline_Color_Blend_Attachment_State :: struct {
	blend_enable:           b32,
	src_color_blend_factor: Blend_Factor,
	dst_color_blend_factor: Blend_Factor,
	color_blend_op:         Blend_Op,
	src_alpha_blend_factor: Blend_Factor,
	dst_alpha_blend_factor: Blend_Factor,
	alpha_blend_op:         Blend_Op,
	color_write_mask:       Color_Component_Flags,
}

Pipeline_Color_Blend_State_Create_Info :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Pipeline_Color_Blend_State_Create_Flags,
	logic_op_enable:  b32,
	logic_op:         Logic_Op,
	attachment_count: u32,
	attachments:      ^Pipeline_Color_Blend_Attachment_State,
	blend_constants:  [4]f32,
}

Pipeline_Dynamic_State_Create_Info :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	flags:               Pipeline_Dynamic_State_Create_Flags,
	dynamic_state_count: u32,
	dynamic_states:      ^Dynamic_State,
}

Graphics_Pipeline_Create_Info :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	flags:                Pipeline_Create_Flags,
	stage_count:          u32,
	stages:               ^Pipeline_Shader_Stage_Create_Info,
	vertex_input_state:   ^Pipeline_Vertex_Input_State_Create_Info,
	input_assembly_state: ^Pipeline_Input_Assembly_State_Create_Info,
	tessellation_state:   ^Pipeline_Tessellation_State_Create_Info,
	viewport_state:       ^Pipeline_Viewport_State_Create_Info,
	rasterization_state:  ^Pipeline_Rasterization_State_Create_Info,
	multisample_state:    ^Pipeline_Multisample_State_Create_Info,
	depth_stencil_state:  ^Pipeline_Depth_Stencil_State_Create_Info,
	color_blend_state:    ^Pipeline_Color_Blend_State_Create_Info,
	dynamic_state:        ^Pipeline_Dynamic_State_Create_Info,
	layout:               Pipeline_Layout,
	render_pass:          Render_Pass,
	subpass:              u32,
	base_pipeline_handle: Pipeline,
	base_pipeline_index:  i32,
}

Compute_Pipeline_Create_Info :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	flags:                Pipeline_Create_Flags,
	stage:                Pipeline_Shader_Stage_Create_Info,
	layout:               Pipeline_Layout,
	base_pipeline_handle: Pipeline,
	base_pipeline_index:  i32,
}

Push_Constant_Range :: struct {
	stage_flags: Shader_Stage_Flags,
	offset:      u32,
	size:        u32,
}

Pipeline_Layout_Create_Info :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	flags:                     Pipeline_Layout_Create_Flags,
	set_layout_count:          u32,
	set_layouts:               ^Descriptor_Set_Layout,
	push_constant_range_count: u32,
	push_constant_ranges:      ^Push_Constant_Range,
}

Sampler_Create_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Sampler_Create_Flags,
	mag_filter:               Filter,
	min_filter:               Filter,
	mipmap_mode:              Sampler_Mipmap_Mode,
	address_mode_u:           Sampler_Address_Mode,
	address_mode_v:           Sampler_Address_Mode,
	address_mode_w:           Sampler_Address_Mode,
	mip_lod_bias:             f32,
	anisotropy_enable:        b32,
	max_anisotropy:           f32,
	compare_enable:           b32,
	compare_op:               Compare_Op,
	min_lod:                  f32,
	max_lod:                  f32,
	border_color:             Border_Color,
	unnormalized_coordinates: b32,
}

Descriptor_Set_Layout_Binding :: struct {
	binding:            u32,
	descriptor_type:    Descriptor_Type,
	descriptor_count:   u32,
	stage_flags:        Shader_Stage_Flags,
	immutable_samplers: ^Sampler,
}

Descriptor_Set_Layout_Create_Info :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	flags:         Descriptor_Set_Layout_Create_Flags,
	binding_count: u32,
	bindings:      ^Descriptor_Set_Layout_Binding,
}

Descriptor_Pool_Size :: struct {
	type:             Descriptor_Type,
	descriptor_count: u32,
}

Descriptor_Pool_Create_Info :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	flags:           Descriptor_Pool_Create_Flags,
	max_sets:        u32,
	pool_size_count: u32,
	pool_sizes:      ^Descriptor_Pool_Size,
}

Descriptor_Set_Allocate_Info :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	descriptor_pool:      Descriptor_Pool,
	descriptor_set_count: u32,
	set_layouts:          ^Descriptor_Set_Layout,
}

Descriptor_Image_Info :: struct {
	sampler:      Sampler,
	image_view:   Image_View,
	image_layout: Image_Layout,
}

Descriptor_Buffer_Info :: struct {
	buffer: Buffer,
	offset: Device_Size,
	range:  Device_Size,
}

Write_Descriptor_Set :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	dst_set:           Descriptor_Set,
	dst_binding:       u32,
	dst_array_element: u32,
	descriptor_count:  u32,
	descriptor_type:   Descriptor_Type,
	image_info:        ^Descriptor_Image_Info,
	buffer_info:       ^Descriptor_Buffer_Info,
	texel_buffer_view: ^Buffer_View,
}

Copy_Descriptor_Set :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	src_set:           Descriptor_Set,
	src_binding:       u32,
	src_array_element: u32,
	dst_set:           Descriptor_Set,
	dst_binding:       u32,
	dst_array_element: u32,
	descriptor_count:  u32,
}

Framebuffer_Create_Info :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Framebuffer_Create_Flags,
	render_pass:      Render_Pass,
	attachment_count: u32,
	attachments:      ^Image_View,
	width:            u32,
	height:           u32,
	layers:           u32,
}

Attachment_Description :: struct {
	flags:            Attachment_Description_Flags,
	format:           Format,
	samples:          Sample_Count_Flags,
	load_op:          Attachment_Load_Op,
	store_op:         Attachment_Store_Op,
	stencil_load_op:  Attachment_Load_Op,
	stencil_store_op: Attachment_Store_Op,
	initial_layout:   Image_Layout,
	final_layout:     Image_Layout,
}

Attachment_Reference :: struct {
	attachment: u32,
	layout:     Image_Layout,
}

Subpass_Description :: struct {
	flags:                     Subpass_Description_Flags,
	pipeline_bind_point:       Pipeline_Bind_Point,
	input_attachment_count:    u32,
	input_attachments:         ^Attachment_Reference,
	color_attachment_count:    u32,
	color_attachments:         ^Attachment_Reference,
	resolve_attachments:       ^Attachment_Reference,
	depth_stencil_attachment:  ^Attachment_Reference,
	preserve_attachment_count: u32,
	preserve_attachments:      ^u32,
}

Subpass_Dependency :: struct {
	src_subpass:      u32,
	dst_subpass:      u32,
	src_stage_mask:   Pipeline_Stage_Flags,
	dst_stage_mask:   Pipeline_Stage_Flags,
	src_access_mask:  Access_Flags,
	dst_access_mask:  Access_Flags,
	dependency_flags: Dependency_Flags,
}

Render_Pass_Create_Info :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Render_Pass_Create_Flags,
	attachment_count: u32,
	attachments:      ^Attachment_Description,
	subpass_count:    u32,
	subpasses:        ^Subpass_Description,
	dependency_count: u32,
	dependencies:     ^Subpass_Dependency,
}

Command_Pool_Create_Info :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	flags:              Command_Pool_Create_Flags,
	queue_family_index: u32,
}

Command_Buffer_Allocate_Info :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	command_pool:         Command_Pool,
	level:                Command_Buffer_Level,
	command_buffer_count: u32,
}

Command_Buffer_Inheritance_Info :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	render_pass:            Render_Pass,
	subpass:                u32,
	framebuffer:            Framebuffer,
	occlusion_query_enable: b32,
	query_flags:            Query_Control_Flags,
	pipeline_statistics:    Query_Pipeline_Statistic_Flags,
}

Command_Buffer_Begin_Info :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Command_Buffer_Usage_Flags,
	inheritance_info: ^Command_Buffer_Inheritance_Info,
}

Buffer_Copy :: struct {
	src_offset: Device_Size,
	dst_offset: Device_Size,
	size:       Device_Size,
}

Image_Subresource_Layers :: struct {
	aspect_mask:      Image_Aspect_Flags,
	mip_level:        u32,
	base_array_layer: u32,
	layer_count:      u32,
}

Image_Copy :: struct {
	src_subresource: Image_Subresource_Layers,
	src_offset:      Offset3D,
	dst_subresource: Image_Subresource_Layers,
	dst_offset:      Offset3D,
	extent:          Extent3D,
}

Image_Blit :: struct {
	src_subresource: Image_Subresource_Layers,
	src_offsets:     [2]Offset3D,
	dst_subresource: Image_Subresource_Layers,
	dst_offsets:     [2]Offset3D,
}

Buffer_Image_Copy :: struct {
	buffer_offset:       Device_Size,
	buffer_row_length:   u32,
	buffer_image_height: u32,
	image_subresource:   Image_Subresource_Layers,
	image_offset:        Offset3D,
	image_extent:        Extent3D,
}

Clear_Color_Value :: struct #raw_union {
	float32: [4]f32,
	int32:   [4]i32,
	uint32:  [4]u32,
}

Clear_Depth_Stencil_Value :: struct {
	depth:   f32,
	stencil: u32,
}

Clear_Value :: struct #raw_union {
	color:         Clear_Color_Value,
	depth_stencil: Clear_Depth_Stencil_Value,
}

Clear_Attachment :: struct {
	aspect_mask:      Image_Aspect_Flags,
	color_attachment: u32,
	clear_value:      Clear_Value,
}

Clear_Rect :: struct {
	rect:             Rect2D,
	base_array_layer: u32,
	layer_count:      u32,
}

Image_Resolve :: struct {
	src_subresource: Image_Subresource_Layers,
	src_offset:      Offset3D,
	dst_subresource: Image_Subresource_Layers,
	dst_offset:      Offset3D,
	extent:          Extent3D,
}

Memory_Barrier :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	src_access_mask: Access_Flags,
	dst_access_mask: Access_Flags,
}

Buffer_Memory_Barrier :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	src_access_mask:        Access_Flags,
	dst_access_mask:        Access_Flags,
	src_queue_family_index: u32,
	dst_queue_family_index: u32,
	buffer:                 Buffer,
	offset:                 Device_Size,
	size:                   Device_Size,
}

Image_Memory_Barrier :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	src_access_mask:        Access_Flags,
	dst_access_mask:        Access_Flags,
	old_layout:             Image_Layout,
	new_layout:             Image_Layout,
	src_queue_family_index: u32,
	dst_queue_family_index: u32,
	image:                  Image,
	subresource_range:      Image_Subresource_Range,
}

Render_Pass_Begin_Info :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	render_pass:       Render_Pass,
	framebuffer:       Framebuffer,
	render_area:       Rect2D,
	clear_value_count: u32,
	clear_values:      ^Clear_Value,
}

Dispatch_Indirect_Command :: struct {
	x: u32,
	y: u32,
	z: u32,
}

Draw_Indexed_Indirect_Command :: struct {
	index_count:    u32,
	instance_count: u32,
	first_index:    u32,
	vertex_offset:  i32,
	first_instance: u32,
}

Draw_Indirect_Command :: struct {
	vertex_count:   u32,
	instance_count: u32,
	first_vertex:   u32,
	first_instance: u32,
}

Base_Out_Structure :: struct {
	s_type: Structure_Type,
	next:   ^Base_Out_Structure,
}

Base_In_Structure :: struct {
	s_type: Structure_Type,
	next:   ^Base_In_Structure,
}

Physical_Device_Subgroup_Properties :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	subgroup_size:                 u32,
	supported_stages:              Shader_Stage_Flags,
	supported_operations:          Subgroup_Feature_Flags,
	quad_operations_in_all_stages: b32,
}

Bind_Buffer_Memory_Info :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	buffer:        Buffer,
	memory:        Device_Memory,
	memory_offset: Device_Size,
}

Bind_Image_Memory_Info :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	image:         Image,
	memory:        Device_Memory,
	memory_offset: Device_Size,
}

Physical_Device16_Bit_Storage_Features :: struct {
	s_type:                                  Structure_Type,
	next:                                    rawptr,
	storage_buffer16_bit_access:             b32,
	uniform_and_storage_buffer16_bit_access: b32,
	storage_push_constant16:                 b32,
	storage_input_output16:                  b32,
}

Memory_Dedicated_Requirements :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	prefers_dedicated_allocation:  b32,
	requires_dedicated_allocation: b32,
}

Memory_Dedicated_Allocate_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	image:  Image,
	buffer: Buffer,
}

Memory_Allocate_Flags_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	flags:       Memory_Allocate_Flags,
	device_mask: u32,
}

Device_Group_Render_Pass_Begin_Info :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	device_mask:              u32,
	device_render_area_count: u32,
	device_render_areas:      ^Rect2D,
}

Device_Group_Command_Buffer_Begin_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	device_mask: u32,
}

Device_Group_Submit_Info :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	wait_semaphore_count:            u32,
	wait_semaphore_device_indices:   ^u32,
	command_buffer_count:            u32,
	command_buffer_device_masks:     ^u32,
	signal_semaphore_count:          u32,
	signal_semaphore_device_indices: ^u32,
}

Device_Group_Bind_Sparse_Info :: struct {
	s_type:                Structure_Type,
	next:                  rawptr,
	resource_device_index: u32,
	memory_device_index:   u32,
}

Bind_Buffer_Memory_Device_Group_Info :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	device_index_count: u32,
	device_indices:     ^u32,
}

Bind_Image_Memory_Device_Group_Info :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	device_index_count:               u32,
	device_indices:                   ^u32,
	split_instance_bind_region_count: u32,
	split_instance_bind_regions:      ^Rect2D,
}

Physical_Device_Group_Properties :: struct {
	s_type:                Structure_Type,
	next:                  rawptr,
	physical_device_count: u32,
	physical_devices:      [MAX_DEVICE_GROUP_SIZE]Physical_Device,
	subset_allocation:     b32,
}

Device_Group_Device_Create_Info :: struct {
	s_type:                Structure_Type,
	next:                  rawptr,
	physical_device_count: u32,
	physical_devices:      ^Physical_Device,
}

Buffer_Memory_Requirements_Info2 :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	buffer: Buffer,
}

Image_Memory_Requirements_Info2 :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	image:  Image,
}

Image_Sparse_Memory_Requirements_Info2 :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	image:  Image,
}

Memory_Requirements2 :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	memory_requirements: Memory_Requirements,
}

Memory_Requirements2_KHR :: Memory_Requirements2;

Sparse_Image_Memory_Requirements2 :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	memory_requirements: Sparse_Image_Memory_Requirements,
}

Physical_Device_Features2 :: struct {
	s_type:   Structure_Type,
	next:     rawptr,
	features: Physical_Device_Features,
}

Physical_Device_Properties2 :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	properties: Physical_Device_Properties,
}

Format_Properties2 :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	format_properties: Format_Properties,
}

Image_Format_Properties2 :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	image_format_properties: Image_Format_Properties,
}

Physical_Device_Image_Format_Info2 :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	format: Format,
	type:   Image_Type,
	tiling: Image_Tiling,
	usage:  Image_Usage_Flags,
	flags:  Image_Create_Flags,
}

Queue_Family_Properties2 :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	queue_family_properties: Queue_Family_Properties,
}

Physical_Device_Memory_Properties2 :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	memory_properties: Physical_Device_Memory_Properties,
}

Sparse_Image_Format_Properties2 :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	properties: Sparse_Image_Format_Properties,
}

Physical_Device_Sparse_Image_Format_Info2 :: struct {
	s_type:  Structure_Type,
	next:    rawptr,
	format:  Format,
	type:    Image_Type,
	samples: Sample_Count_Flags,
	usage:   Image_Usage_Flags,
	tiling:  Image_Tiling,
}

Physical_Device_Point_Clipping_Properties :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	point_clipping_behavior: Point_Clipping_Behavior,
}

Input_Attachment_Aspect_Reference :: struct {
	subpass:                u32,
	input_attachment_index: u32,
	aspect_mask:            Image_Aspect_Flags,
}

Render_Pass_Input_Attachment_Aspect_Create_Info :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	aspect_reference_count: u32,
	aspect_references:      ^Input_Attachment_Aspect_Reference,
}

Image_View_Usage_Create_Info :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	usage:  Image_Usage_Flags,
}

Pipeline_Tessellation_Domain_Origin_State_Create_Info :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	domain_origin: Tessellation_Domain_Origin,
}

Render_Pass_Multiview_Create_Info :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	subpass_count:          u32,
	view_masks:             ^u32,
	dependency_count:       u32,
	view_offsets:           ^i32,
	correlation_mask_count: u32,
	correlation_masks:      ^u32,
}

Physical_Device_Multiview_Features :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	multiview:                     b32,
	multiview_geometry_shader:     b32,
	multiview_tessellation_shader: b32,
}

Physical_Device_Multiview_Properties :: struct {
	s_type:                       Structure_Type,
	next:                         rawptr,
	max_multiview_view_count:     u32,
	max_multiview_instance_index: u32,
}

Physical_Device_Variable_Pointer_Features :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	variable_pointers_storage_buffer: b32,
	variable_pointers:                b32,
}

Physical_Device_Protected_Memory_Features :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	protected_memory: b32,
}

Physical_Device_Protected_Memory_Properties :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	protected_no_fault: b32,
}

Device_Queue_Info2 :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	flags:              Device_Queue_Create_Flags,
	queue_family_index: u32,
	queue_index:        u32,
}

Protected_Submit_Info :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	protected_submit: b32,
}

Sampler_Ycbcr_Conversion_Create_Info :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	format:                        Format,
	ycbcr_model:                   Sampler_Ycbcr_Model_Conversion,
	ycbcr_range:                   Sampler_Ycbcr_Range,
	components:                    Component_Mapping,
	x_chroma_offset:               Chroma_Location,
	y_chroma_offset:               Chroma_Location,
	chroma_filter:                 Filter,
	force_explicit_reconstruction: b32,
}

Sampler_Ycbcr_Conversion_Info :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	conversion: Sampler_Ycbcr_Conversion,
}

Bind_Image_Plane_Memory_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	plane_aspect: Image_Aspect_Flags,
}

Image_Plane_Memory_Requirements_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	plane_aspect: Image_Aspect_Flags,
}

Physical_Device_Sampler_Ycbcr_Conversion_Features :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	sampler_ycbcr_conversion: b32,
}

Sampler_Ycbcr_Conversion_Image_Format_Properties :: struct {
	s_type:                                  Structure_Type,
	next:                                    rawptr,
	combined_image_sampler_descriptor_count: u32,
}

Descriptor_Update_Template_Entry :: struct {
	dst_binding:       u32,
	dst_array_element: u32,
	descriptor_count:  u32,
	descriptor_type:   Descriptor_Type,
	offset:            int,
	stride:            int,
}

Descriptor_Update_Template_Create_Info :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	flags:                         Descriptor_Update_Template_Create_Flags,
	descriptor_update_entry_count: u32,
	descriptor_update_entries:     ^Descriptor_Update_Template_Entry,
	template_type:                 Descriptor_Update_Template_Type,
	descriptor_set_layout:         Descriptor_Set_Layout,
	pipeline_bind_point:           Pipeline_Bind_Point,
	pipeline_layout:               Pipeline_Layout,
	set:                           u32,
}

External_Memory_Properties :: struct {
	external_memory_features:          External_Memory_Feature_Flags,
	export_from_imported_handle_types: External_Memory_Handle_Type_Flags,
	compatible_handle_types:           External_Memory_Handle_Type_Flags,
}

Physical_Device_External_Image_Format_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	handle_type: External_Memory_Handle_Type_Flags,
}

External_Image_Format_Properties :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	external_memory_properties: External_Memory_Properties,
}

Physical_Device_External_Buffer_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	flags:       Buffer_Create_Flags,
	usage:       Buffer_Usage_Flags,
	handle_type: External_Memory_Handle_Type_Flags,
}

External_Buffer_Properties :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	external_memory_properties: External_Memory_Properties,
}

Physical_Device_Id_Properties :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	device_uuid:       [UUID_SIZE]u8,
	driver_uuid:       [UUID_SIZE]u8,
	device_luid:       [LUID_SIZE]u8,
	device_node_mask:  u32,
	device_luid_valid: b32,
}

External_Memory_Image_Create_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Memory_Handle_Type_Flags,
}

External_Memory_Buffer_Create_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Memory_Handle_Type_Flags,
}

Export_Memory_Allocate_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Memory_Handle_Type_Flags,
}

Physical_Device_External_Fence_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	handle_type: External_Fence_Handle_Type_Flags,
}

External_Fence_Properties :: struct {
	s_type:                            Structure_Type,
	next:                              rawptr,
	export_from_imported_handle_types: External_Fence_Handle_Type_Flags,
	compatible_handle_types:           External_Fence_Handle_Type_Flags,
	external_fence_features:           External_Fence_Feature_Flags,
}

Export_Fence_Create_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Fence_Handle_Type_Flags,
}

Export_Semaphore_Create_Info :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Semaphore_Handle_Type_Flags,
}

Physical_Device_External_Semaphore_Info :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	handle_type: External_Semaphore_Handle_Type_Flags,
}

External_Semaphore_Properties :: struct {
	s_type:                            Structure_Type,
	next:                              rawptr,
	export_from_imported_handle_types: External_Semaphore_Handle_Type_Flags,
	compatible_handle_types:           External_Semaphore_Handle_Type_Flags,
	external_semaphore_features:       External_Semaphore_Feature_Flags,
}

Physical_Device_Maintenance3_Properties :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	max_per_set_descriptors:    u32,
	max_memory_allocation_size: Device_Size,
}

Descriptor_Set_Layout_Support :: struct {
	s_type:    Structure_Type,
	next:      rawptr,
	supported: b32,
}

Physical_Device_Shader_Draw_Parameter_Features :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	shader_draw_parameters: b32,
}

Surface_Capabilities_KHR :: struct {
	min_image_count:           u32,
	max_image_count:           u32,
	current_extent:            Extent2D,
	min_image_extent:          Extent2D,
	max_image_extent:          Extent2D,
	max_image_array_layers:    u32,
	supported_transforms:      Surface_Transform_Flags_KHR,
	current_transform:         Surface_Transform_Flags_KHR,
	supported_composite_alpha: Composite_Alpha_Flags_KHR,
	supported_usage_flags:     Image_Usage_Flags,
}

Surface_Format_KHR :: struct {
	format:      Format,
	color_space: Color_Space_KHR,
}

Swapchain_Create_Info_KHR :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	flags:                    Swapchain_Create_Flags_KHR,
	surface:                  Surface_KHR,
	min_image_count:          u32,
	image_format:             Format,
	image_color_space:        Color_Space_KHR,
	image_extent:             Extent2D,
	image_array_layers:       u32,
	image_usage:              Image_Usage_Flags,
	image_sharing_mode:       Sharing_Mode,
	queue_family_index_count: u32,
	queue_family_indices:     ^u32,
	pre_transform:            Surface_Transform_Flags_KHR,
	composite_alpha:          Composite_Alpha_Flags_KHR,
	present_mode:             Present_Mode_KHR,
	clipped:                  b32,
	old_swapchain:            Swapchain_KHR,
}

Present_Info_KHR :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	wait_semaphore_count: u32,
	wait_semaphores:      ^Semaphore,
	swapchain_count:      u32,
	swapchains:           ^Swapchain_KHR,
	image_indices:        ^u32,
	results:              ^Result,
}

Image_Swapchain_Create_Info_KHR :: struct {
	s_type:    Structure_Type,
	next:      rawptr,
	swapchain: Swapchain_KHR,
}

Bind_Image_Memory_Swapchain_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	swapchain:   Swapchain_KHR,
	image_index: u32,
}

Acquire_Next_Image_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	swapchain:   Swapchain_KHR,
	timeout:     u64,
	semaphore:   Semaphore,
	fence:       Fence,
	device_mask: u32,
}

Device_Group_Present_Capabilities_KHR :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	present_mask: [MAX_DEVICE_GROUP_SIZE]u32,
	modes:        Device_Group_Present_Mode_Flags_KHR,
}

Device_Group_Present_Info_KHR :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	swapchain_count: u32,
	device_masks:    ^u32,
	mode:            Device_Group_Present_Mode_Flags_KHR,
}

Device_Group_Swapchain_Create_Info_KHR :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	modes:  Device_Group_Present_Mode_Flags_KHR,
}

Display_Properties_KHR :: struct {
	display:                Display_KHR,
	display_name:           cstring,
	physical_dimensions:    Extent2D,
	physical_resolution:    Extent2D,
	supported_transforms:   Surface_Transform_Flags_KHR,
	plane_reorder_possible: b32,
	persistent_content:     b32,
}

Display_Mode_Parameters_KHR :: struct {
	visible_region: Extent2D,
	refresh_rate:   u32,
}

Display_Mode_Properties_KHR :: struct {
	display_mode: Display_Mode_KHR,
	parameters:   Display_Mode_Parameters_KHR,
}

Display_Mode_Create_Info_KHR :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	flags:      Display_Mode_Create_Flags_KHR,
	parameters: Display_Mode_Parameters_KHR,
}

Display_Plane_Capabilities_KHR :: struct {
	supported_alpha:  Display_Plane_Alpha_Flags_KHR,
	min_src_position: Offset2D,
	max_src_position: Offset2D,
	min_src_extent:   Extent2D,
	max_src_extent:   Extent2D,
	min_dst_position: Offset2D,
	max_dst_position: Offset2D,
	min_dst_extent:   Extent2D,
	max_dst_extent:   Extent2D,
}

Display_Plane_Properties_KHR :: struct {
	current_display:     Display_KHR,
	current_stack_index: u32,
}

Display_Surface_Create_Info_KHR :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	flags:             Display_Surface_Create_Flags_KHR,
	display_mode:      Display_Mode_KHR,
	plane_index:       u32,
	plane_stack_index: u32,
	transform:         Surface_Transform_Flags_KHR,
	global_alpha:      f32,
	alpha_mode:        Display_Plane_Alpha_Flags_KHR,
	image_extent:      Extent2D,
}

Display_Present_Info_KHR :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	src_rect:   Rect2D,
	dst_rect:   Rect2D,
	persistent: b32,
}

Import_Memory_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	handle_type: External_Memory_Handle_Type_Flags,
	fd:          c.int,
}

Memory_Fd_Properties_KHR :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	memory_type_bits: u32,
}

Memory_Get_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	memory:      Device_Memory,
	handle_type: External_Memory_Handle_Type_Flags,
}

Import_Semaphore_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	semaphore:   Semaphore,
	flags:       Semaphore_Import_Flags,
	handle_type: External_Semaphore_Handle_Type_Flags,
	fd:          c.int,
}

Semaphore_Get_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	semaphore:   Semaphore,
	handle_type: External_Semaphore_Handle_Type_Flags,
}

Physical_Device_Push_Descriptor_Properties_KHR :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	max_push_descriptors: u32,
}

Rect_Layer_KHR :: struct {
	offset: Offset2D,
	extent: Extent2D,
	layer:  u32,
}

Present_Region_KHR :: struct {
	rectangle_count: u32,
	rectangles:      ^Rect_Layer_KHR,
}

Present_Regions_KHR :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	swapchain_count: u32,
	regions:         ^Present_Region_KHR,
}

Attachment_Description2_KHR :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Attachment_Description_Flags,
	format:           Format,
	samples:          Sample_Count_Flags,
	load_op:          Attachment_Load_Op,
	store_op:         Attachment_Store_Op,
	stencil_load_op:  Attachment_Load_Op,
	stencil_store_op: Attachment_Store_Op,
	initial_layout:   Image_Layout,
	final_layout:     Image_Layout,
}

Attachment_Reference2_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	attachment:  u32,
	layout:      Image_Layout,
	aspect_mask: Image_Aspect_Flags,
}

Subpass_Description2_KHR :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	flags:                     Subpass_Description_Flags,
	pipeline_bind_point:       Pipeline_Bind_Point,
	view_mask:                 u32,
	input_attachment_count:    u32,
	input_attachments:         ^Attachment_Reference2_KHR,
	color_attachment_count:    u32,
	color_attachments:         ^Attachment_Reference2_KHR,
	resolve_attachments:       ^Attachment_Reference2_KHR,
	depth_stencil_attachment:  ^Attachment_Reference2_KHR,
	preserve_attachment_count: u32,
	preserve_attachments:      ^u32,
}

Subpass_Dependency2_KHR :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	src_subpass:      u32,
	dst_subpass:      u32,
	src_stage_mask:   Pipeline_Stage_Flags,
	dst_stage_mask:   Pipeline_Stage_Flags,
	src_access_mask:  Access_Flags,
	dst_access_mask:  Access_Flags,
	dependency_flags: Dependency_Flags,
	view_offset:      i32,
}

Render_Pass_Create_Info2_KHR :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	flags:                      Render_Pass_Create_Flags,
	attachment_count:           u32,
	attachments:                ^Attachment_Description2_KHR,
	subpass_count:              u32,
	subpasses:                  ^Subpass_Description2_KHR,
	dependency_count:           u32,
	dependencies:               ^Subpass_Dependency2_KHR,
	correlated_view_mask_count: u32,
	correlated_view_masks:      ^u32,
}

Subpass_Begin_Info_KHR :: struct {
	s_type:   Structure_Type,
	next:     rawptr,
	contents: Subpass_Contents,
}

Subpass_End_Info_KHR :: struct {
	s_type: Structure_Type,
	next:   rawptr,
}

Shared_Present_Surface_Capabilities_KHR :: struct {
	s_type:                               Structure_Type,
	next:                                 rawptr,
	shared_present_supported_usage_flags: Image_Usage_Flags,
}

Import_Fence_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	fence:       Fence,
	flags:       Fence_Import_Flags,
	handle_type: External_Fence_Handle_Type_Flags,
	fd:          c.int,
}

Fence_Get_Fd_Info_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	fence:       Fence,
	handle_type: External_Fence_Handle_Type_Flags,
}

Physical_Device_Surface_Info2_KHR :: struct {
	s_type:  Structure_Type,
	next:    rawptr,
	surface: Surface_KHR,
}

Surface_Capabilities2_KHR :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	surface_capabilities: Surface_Capabilities_KHR,
}

Surface_Format2_KHR :: struct {
	s_type:         Structure_Type,
	next:           rawptr,
	surface_format: Surface_Format_KHR,
}

Display_Properties2_KHR :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	display_properties: Display_Properties_KHR,
}

Display_Plane_Properties2_KHR :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	display_plane_properties: Display_Plane_Properties_KHR,
}

Display_Mode_Properties2_KHR :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	display_mode_properties: Display_Mode_Properties_KHR,
}

Display_Plane_Info2_KHR :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	mode:        Display_Mode_KHR,
	plane_index: u32,
}

Display_Plane_Capabilities2_KHR :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	capabilities: Display_Plane_Capabilities_KHR,
}

Image_Format_List_Create_Info_KHR :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	view_format_count: u32,
	view_formats:      ^Format,
}

Physical_Device8_Bit_Storage_Features_KHR :: struct {
	s_type:                                 Structure_Type,
	next:                                   rawptr,
	storage_buffer8_bit_access:             b32,
	uniform_and_storage_buffer8_bit_access: b32,
	storage_push_constant8:                 b32,
}

Physical_Device_Shader_Atomic_Int64_Features_KHR :: struct {
	s_type:                      Structure_Type,
	next:                        rawptr,
	shader_buffer_int64_atomics: b32,
	shader_shared_int64_atomics: b32,
}

Conformance_Version_KHR :: struct {
	major:    u8,
	minor:    u8,
	subminor: u8,
	patch:    u8,
}

Physical_Device_Driver_Properties_KHR :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	driver_id:           Driver_Id_KHR,
	driver_name:         [MAX_DRIVER_NAME_SIZE_KHR]byte,
	driver_info:         [MAX_DRIVER_INFO_SIZE_KHR]byte,
	conformance_version: Conformance_Version_KHR,
}

Physical_Device_Vulkan_Memory_Model_Features_KHR :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	vulkan_memory_model:              b32,
	vulkan_memory_model_device_scope: b32,
}

Debug_Report_Callback_Create_Info_EXT :: struct {
	s_type:    Structure_Type,
	next:      rawptr,
	flags:     Debug_Report_Flags_EXT,
	callback:  Proc_Debug_Report_Callback_EXT,
	user_data: rawptr,
}

Pipeline_Rasterization_State_Rasterization_Order_AMD :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	rasterization_order: Rasterization_Order_AMD,
}

Debug_Marker_Object_Name_Info_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	object_type: Debug_Report_Object_Type_EXT,
	object:      u64,
	object_name: cstring,
}

Debug_Marker_Object_Tag_Info_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	object_type: Debug_Report_Object_Type_EXT,
	object:      u64,
	tag_name:    u64,
	tag_size:    int,
	tag:         rawptr,
}

Debug_Marker_Marker_Info_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	marker_name: cstring,
	color:       [4]f32,
}

Dedicated_Allocation_Image_Create_Info_NV :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	dedicated_allocation: b32,
}

Dedicated_Allocation_Buffer_Create_Info_NV :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	dedicated_allocation: b32,
}

Dedicated_Allocation_Memory_Allocate_Info_NV :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	image:  Image,
	buffer: Buffer,
}

Physical_Device_Transform_Feedback_Features_EXT :: struct {
	s_type:             Structure_Type,
	next:               rawptr,
	transform_feedback: b32,
	geometry_streams:   b32,
}

Physical_Device_Transform_Feedback_Properties_EXT :: struct {
	s_type:                                         Structure_Type,
	next:                                           rawptr,
	max_transform_feedback_streams:                 u32,
	max_transform_feedback_buffers:                 u32,
	max_transform_feedback_buffer_size:             Device_Size,
	max_transform_feedback_stream_data_size:        u32,
	max_transform_feedback_buffer_data_size:        u32,
	max_transform_feedback_buffer_data_stride:      u32,
	transform_feedback_queries:                     b32,
	transform_feedback_streams_lines_triangles:     b32,
	transform_feedback_rasterization_stream_select: b32,
	transform_feedback_draw:                        b32,
}

Pipeline_Rasterization_State_Stream_Create_Info_EXT :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	flags:                Pipeline_Rasterization_State_Stream_Create_Flags_EXT,
	rasterization_stream: u32,
}

Texture_Lod_Gather_Format_Properties_AMD :: struct {
	s_type:                               Structure_Type,
	next:                                 rawptr,
	supports_texture_gather_lod_bias_amd: b32,
}

Shader_Resource_Usage_AMD :: struct {
	num_used_vgprs:                u32,
	num_used_sgprs:                u32,
	lds_size_per_local_work_group: u32,
	lds_usage_size_in_bytes:       int,
	scratch_mem_usage_in_bytes:    int,
}

Shader_Statistics_Info_AMD :: struct {
	shader_stage_mask:       Shader_Stage_Flags,
	resource_usage:          Shader_Resource_Usage_AMD,
	num_physical_vgprs:      u32,
	num_physical_sgprs:      u32,
	num_available_vgprs:     u32,
	num_available_sgprs:     u32,
	compute_work_group_size: [3]u32,
}

Physical_Device_Corner_Sampled_Image_Features_NV :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	corner_sampled_image: b32,
}

External_Image_Format_Properties_NV :: struct {
	image_format_properties:           Image_Format_Properties,
	external_memory_features:          External_Memory_Feature_Flags_NV,
	export_from_imported_handle_types: External_Memory_Handle_Type_Flags_NV,
	compatible_handle_types:           External_Memory_Handle_Type_Flags_NV,
}

External_Memory_Image_Create_Info_NV :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Memory_Handle_Type_Flags_NV,
}

Export_Memory_Allocate_Info_NV :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_types: External_Memory_Handle_Type_Flags_NV,
}

Validation_Flags_EXT :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	disabled_validation_check_count: u32,
	disabled_validation_checks:      ^Validation_Check_EXT,
}

Image_View_Astc_Decode_Mode_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	decode_mode: Format,
}

Physical_Device_Astc_Decode_Features_EXT :: struct {
	s_type:                      Structure_Type,
	next:                        rawptr,
	decode_mode_shared_exponent: b32,
}

Conditional_Rendering_Begin_Info_EXT :: struct {
	s_type: Structure_Type,
	next:   rawptr,
	buffer: Buffer,
	offset: Device_Size,
	flags:  Conditional_Rendering_Flags_EXT,
}

Physical_Device_Conditional_Rendering_Features_EXT :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	conditional_rendering:           b32,
	inherited_conditional_rendering: b32,
}

Command_Buffer_Inheritance_Conditional_Rendering_Info_EXT :: struct {
	s_type:                       Structure_Type,
	next:                         rawptr,
	conditional_rendering_enable: b32,
}

Device_Generated_Commands_Features_NVX :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	compute_binding_point_support: b32,
}

Device_Generated_Commands_Limits_NVX :: struct {
	s_type:                                     Structure_Type,
	next:                                       rawptr,
	max_indirect_commands_layout_token_count:   u32,
	max_object_entry_counts:                    u32,
	min_sequence_count_buffer_offset_alignment: u32,
	min_sequence_index_buffer_offset_alignment: u32,
	min_commands_token_buffer_offset_alignment: u32,
}

Indirect_Commands_Token_NVX :: struct {
	token_type: Indirect_Commands_Token_Type_NVX,
	buffer:     Buffer,
	offset:     Device_Size,
}

Indirect_Commands_Layout_Token_NVX :: struct {
	token_type:    Indirect_Commands_Token_Type_NVX,
	binding_unit:  u32,
	dynamic_count: u32,
	divisor:       u32,
}

Indirect_Commands_Layout_Create_Info_NVX :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	pipeline_bind_point: Pipeline_Bind_Point,
	flags:               Indirect_Commands_Layout_Usage_Flags_NVX,
	token_count:         u32,
	tokens:              ^Indirect_Commands_Layout_Token_NVX,
}

Cmd_Process_Commands_Info_NVX :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	object_table:                  Object_Table_NVX,
	indirect_commands_layout:      Indirect_Commands_Layout_NVX,
	indirect_commands_token_count: u32,
	indirect_commands_tokens:      ^Indirect_Commands_Token_NVX,
	max_sequences_count:           u32,
	target_command_buffer:         Command_Buffer,
	sequences_count_buffer:        Buffer,
	sequences_count_offset:        Device_Size,
	sequences_index_buffer:        Buffer,
	sequences_index_offset:        Device_Size,
}

Cmd_Reserve_Space_For_Commands_Info_NVX :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	object_table:             Object_Table_NVX,
	indirect_commands_layout: Indirect_Commands_Layout_NVX,
	max_sequences_count:      u32,
}

Object_Table_Create_Info_NVX :: struct {
	s_type:                             Structure_Type,
	next:                               rawptr,
	object_count:                       u32,
	object_entry_types:                 ^Object_Entry_Type_NVX,
	object_entry_counts:                ^u32,
	object_entry_usage_flags:           ^Object_Entry_Usage_Flags_NVX,
	max_uniform_buffers_per_descriptor: u32,
	max_storage_buffers_per_descriptor: u32,
	max_storage_images_per_descriptor:  u32,
	max_sampled_images_per_descriptor:  u32,
	max_pipeline_layouts:               u32,
}

Object_Table_Entry_NVX :: struct {
	type:  Object_Entry_Type_NVX,
	flags: Object_Entry_Usage_Flags_NVX,
}

Object_Table_Pipeline_Entry_NVX :: struct {
	type:     Object_Entry_Type_NVX,
	flags:    Object_Entry_Usage_Flags_NVX,
	pipeline: Pipeline,
}

Object_Table_Descriptor_Set_Entry_NVX :: struct {
	type:            Object_Entry_Type_NVX,
	flags:           Object_Entry_Usage_Flags_NVX,
	pipeline_layout: Pipeline_Layout,
	descriptor_set:  Descriptor_Set,
}

Object_Table_Vertex_Buffer_Entry_NVX :: struct {
	type:   Object_Entry_Type_NVX,
	flags:  Object_Entry_Usage_Flags_NVX,
	buffer: Buffer,
}

Object_Table_Index_Buffer_Entry_NVX :: struct {
	type:       Object_Entry_Type_NVX,
	flags:      Object_Entry_Usage_Flags_NVX,
	buffer:     Buffer,
	index_type: Index_Type,
}

Object_Table_Push_Constant_Entry_NVX :: struct {
	type:            Object_Entry_Type_NVX,
	flags:           Object_Entry_Usage_Flags_NVX,
	pipeline_layout: Pipeline_Layout,
	stage_flags:     Shader_Stage_Flags,
}

Viewport_W_Scaling_NV :: struct {
	xcoeff: f32,
	ycoeff: f32,
}

Pipeline_Viewport_W_Scaling_State_Create_Info_NV :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	viewport_w_scaling_enable: b32,
	viewport_count:            u32,
	viewport_w_scalings:       ^Viewport_W_Scaling_NV,
}

Surface_Capabilities2_EXT :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	min_image_count:            u32,
	max_image_count:            u32,
	current_extent:             Extent2D,
	min_image_extent:           Extent2D,
	max_image_extent:           Extent2D,
	max_image_array_layers:     u32,
	supported_transforms:       Surface_Transform_Flags_KHR,
	current_transform:          Surface_Transform_Flags_KHR,
	supported_composite_alpha:  Composite_Alpha_Flags_KHR,
	supported_usage_flags:      Image_Usage_Flags,
	supported_surface_counters: Surface_Counter_Flags_EXT,
}

Display_Power_Info_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	power_state: Display_Power_State_EXT,
}

Device_Event_Info_EXT :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	device_event: Device_Event_Type_EXT,
}

Display_Event_Info_EXT :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	display_event: Display_Event_Type_EXT,
}

Swapchain_Counter_Create_Info_EXT :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	surface_counters: Surface_Counter_Flags_EXT,
}

Refresh_Cycle_Duration_GOOGLE :: struct {
	refresh_duration: u64,
}

Past_Presentation_Timing_GOOGLE :: struct {
	present_id:            u32,
	desired_present_time:  u64,
	actual_present_time:   u64,
	earliest_present_time: u64,
	present_margin:        u64,
}

Present_Time_GOOGLE :: struct {
	present_id:           u32,
	desired_present_time: u64,
}

Present_Times_Info_GOOGLE :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	swapchain_count: u32,
	times:           ^Present_Time_GOOGLE,
}

Physical_Device_Multiview_Per_View_Attributes_Properties_NVX :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	per_view_position_all_components: b32,
}

Viewport_Swizzle_NV :: struct {
	x: Viewport_Coordinate_Swizzle_NV,
	y: Viewport_Coordinate_Swizzle_NV,
	z: Viewport_Coordinate_Swizzle_NV,
	w: Viewport_Coordinate_Swizzle_NV,
}

Pipeline_Viewport_Swizzle_State_Create_Info_NV :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	flags:             Pipeline_Viewport_Swizzle_State_Create_Flags_NV,
	viewport_count:    u32,
	viewport_swizzles: ^Viewport_Swizzle_NV,
}

Physical_Device_Discard_Rectangle_Properties_EXT :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	max_discard_rectangles: u32,
}

Pipeline_Discard_Rectangle_State_Create_Info_EXT :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	flags:                   Pipeline_Discard_Rectangle_State_Create_Flags_EXT,
	discard_rectangle_mode:  Discard_Rectangle_Mode_EXT,
	discard_rectangle_count: u32,
	discard_rectangles:      ^Rect2D,
}

Physical_Device_Conservative_Rasterization_Properties_EXT :: struct {
	s_type:                                          Structure_Type,
	next:                                            rawptr,
	primitive_overestimation_size:                   f32,
	max_extra_primitive_overestimation_size:         f32,
	extra_primitive_overestimation_size_granularity: f32,
	primitive_underestimation:                       b32,
	conservative_point_and_line_rasterization:       b32,
	degenerate_triangles_rasterized:                 b32,
	degenerate_lines_rasterized:                     b32,
	fully_covered_fragment_shader_input_variable:    b32,
	conservative_rasterization_post_depth_coverage:  b32,
}

Pipeline_Rasterization_Conservative_State_Create_Info_EXT :: struct {
	s_type:                              Structure_Type,
	next:                                rawptr,
	flags:                               Pipeline_Rasterization_Conservative_State_Create_Flags_EXT,
	conservative_rasterization_mode:     Conservative_Rasterization_Mode_EXT,
	extra_primitive_overestimation_size: f32,
}

Xy_Color_EXT :: struct {
	x: f32,
	y: f32,
}

Hdr_Metadata_EXT :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	display_primary_red:           Xy_Color_EXT,
	display_primary_green:         Xy_Color_EXT,
	display_primary_blue:          Xy_Color_EXT,
	white_point:                   Xy_Color_EXT,
	max_luminance:                 f32,
	min_luminance:                 f32,
	max_content_light_level:       f32,
	max_frame_average_light_level: f32,
}

Debug_Utils_Object_Name_Info_EXT :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	object_type:   Object_Type,
	object_handle: u64,
	object_name:   cstring,
}

Debug_Utils_Object_Tag_Info_EXT :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	object_type:   Object_Type,
	object_handle: u64,
	tag_name:      u64,
	tag_size:      int,
	tag:           rawptr,
}

Debug_Utils_Label_EXT :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	label_name: cstring,
	color:      [4]f32,
}

Debug_Utils_Messenger_Callback_Data_EXT :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	flags:               Debug_Utils_Messenger_Callback_Data_Flags_EXT,
	message_id_name:     cstring,
	message_id_number:   i32,
	message:             cstring,
	queue_label_count:   u32,
	queue_labels:        ^Debug_Utils_Label_EXT,
	cmd_buf_label_count: u32,
	cmd_buf_labels:      ^Debug_Utils_Label_EXT,
	object_count:        u32,
	objects:             ^Debug_Utils_Object_Name_Info_EXT,
}

Debug_Utils_Messenger_Create_Info_EXT :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	flags:            Debug_Utils_Messenger_Create_Flags_EXT,
	message_severity: Debug_Utils_Message_Severity_Flags_EXT,
	message_type:     Debug_Utils_Message_Type_Flags_EXT,
	user_callback:    Proc_Debug_Utils_Messenger_Callback_EXT,
	user_data:        rawptr,
}

Sampler_Reduction_Mode_Create_Info_EXT :: struct {
	s_type:         Structure_Type,
	next:           rawptr,
	reduction_mode: Sampler_Reduction_Mode_EXT,
}

Physical_Device_Sampler_Filter_Minmax_Properties_EXT :: struct {
	s_type:                                 Structure_Type,
	next:                                   rawptr,
	filter_minmax_single_component_formats: b32,
	filter_minmax_image_component_mapping:  b32,
}

Physical_Device_Inline_Uniform_Block_Features_EXT :: struct {
	s_type:                                                    Structure_Type,
	next:                                                      rawptr,
	inline_uniform_block:                                      b32,
	descriptor_binding_inline_uniform_block_update_after_bind: b32,
}

Physical_Device_Inline_Uniform_Block_Properties_EXT :: struct {
	s_type:                                                           Structure_Type,
	next:                                                             rawptr,
	max_inline_uniform_block_size:                                    u32,
	max_per_stage_descriptor_inline_uniform_blocks:                   u32,
	max_per_stage_descriptor_update_after_bind_inline_uniform_blocks: u32,
	max_descriptor_set_inline_uniform_blocks:                         u32,
	max_descriptor_set_update_after_bind_inline_uniform_blocks:       u32,
}

Write_Descriptor_Set_Inline_Uniform_Block_EXT :: struct {
	s_type:    Structure_Type,
	next:      rawptr,
	data_size: u32,
	data:      rawptr,
}

Descriptor_Pool_Inline_Uniform_Block_Create_Info_EXT :: struct {
	s_type:                            Structure_Type,
	next:                              rawptr,
	max_inline_uniform_block_bindings: u32,
}

Sample_Location_EXT :: struct {
	x: f32,
	y: f32,
}

Sample_Locations_Info_EXT :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	sample_locations_per_pixel: Sample_Count_Flags,
	sample_location_grid_size:  Extent2D,
	sample_locations_count:     u32,
	sample_locations:           ^Sample_Location_EXT,
}

Attachment_Sample_Locations_EXT :: struct {
	attachment_index:      u32,
	sample_locations_info: Sample_Locations_Info_EXT,
}

Subpass_Sample_Locations_EXT :: struct {
	subpass_index:         u32,
	sample_locations_info: Sample_Locations_Info_EXT,
}

Render_Pass_Sample_Locations_Begin_Info_EXT :: struct {
	s_type:                                    Structure_Type,
	next:                                      rawptr,
	attachment_initial_sample_locations_count: u32,
	attachment_initial_sample_locations:       ^Attachment_Sample_Locations_EXT,
	post_subpass_sample_locations_count:       u32,
	post_subpass_sample_locations:             ^Subpass_Sample_Locations_EXT,
}

Pipeline_Sample_Locations_State_Create_Info_EXT :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	sample_locations_enable: b32,
	sample_locations_info:   Sample_Locations_Info_EXT,
}

Physical_Device_Sample_Locations_Properties_EXT :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	sample_location_sample_counts:    Sample_Count_Flags,
	max_sample_location_grid_size:    Extent2D,
	sample_location_coordinate_range: [2]f32,
	sample_location_sub_pixel_bits:   u32,
	variable_sample_locations:        b32,
}

Multisample_Properties_EXT :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	max_sample_location_grid_size: Extent2D,
}

Physical_Device_Blend_Operation_Advanced_Features_EXT :: struct {
	s_type:                             Structure_Type,
	next:                               rawptr,
	advanced_blend_coherent_operations: b32,
}

Physical_Device_Blend_Operation_Advanced_Properties_EXT :: struct {
	s_type:                                     Structure_Type,
	next:                                       rawptr,
	advanced_blend_max_color_attachments:       u32,
	advanced_blend_independent_blend:           b32,
	advanced_blend_non_premultiplied_src_color: b32,
	advanced_blend_non_premultiplied_dst_color: b32,
	advanced_blend_correlated_overlap:          b32,
	advanced_blend_all_operations:              b32,
}

Pipeline_Color_Blend_Advanced_State_Create_Info_EXT :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	src_premultiplied: b32,
	dst_premultiplied: b32,
	blend_overlap:     Blend_Overlap_EXT,
}

Pipeline_Coverage_To_Color_State_Create_Info_NV :: struct {
	s_type:                     Structure_Type,
	next:                       rawptr,
	flags:                      Pipeline_Coverage_To_Color_State_Create_Flags_NV,
	coverage_to_color_enable:   b32,
	coverage_to_color_location: u32,
}

Pipeline_Coverage_Modulation_State_Create_Info_NV :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	flags:                            Pipeline_Coverage_Modulation_State_Create_Flags_NV,
	coverage_modulation_mode:         Coverage_Modulation_Mode_NV,
	coverage_modulation_table_enable: b32,
	coverage_modulation_table_count:  u32,
	coverage_modulation_table:        ^f32,
}

Drm_Format_Modifier_Properties_EXT :: struct {
	drm_format_modifier:                 u64,
	drm_format_modifier_plane_count:     u32,
	drm_format_modifier_tiling_features: Format_Feature_Flags,
}

Drm_Format_Modifier_Properties_List_EXT :: struct {
	s_type:                         Structure_Type,
	next:                           rawptr,
	drm_format_modifier_count:      u32,
	drm_format_modifier_properties: ^Drm_Format_Modifier_Properties_EXT,
}

Physical_Device_Image_Drm_Format_Modifier_Info_EXT :: struct {
	s_type:                   Structure_Type,
	next:                     rawptr,
	drm_format_modifier:      u64,
	sharing_mode:             Sharing_Mode,
	queue_family_index_count: u32,
	queue_family_indices:     ^u32,
}

Image_Drm_Format_Modifier_List_Create_Info_EXT :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	drm_format_modifier_count: u32,
	drm_format_modifiers:      ^u64,
}

Image_Drm_Format_Modifier_Explicit_Create_Info_EXT :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	drm_format_modifier:             u64,
	drm_format_modifier_plane_count: u32,
	plane_layouts:                   ^Subresource_Layout,
}

Image_Drm_Format_Modifier_Properties_EXT :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	drm_format_modifier: u64,
}

Validation_Cache_Create_Info_EXT :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	flags:             Validation_Cache_Create_Flags_EXT,
	initial_data_size: int,
	initial_data:      rawptr,
}

Shader_Module_Validation_Cache_Create_Info_EXT :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	validation_cache: Validation_Cache_EXT,
}

Descriptor_Set_Layout_Binding_Flags_Create_Info_EXT :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	binding_count: u32,
	binding_flags: ^Descriptor_Binding_Flags_EXT,
}

Physical_Device_Descriptor_Indexing_Features_EXT :: struct {
	s_type:                                                    Structure_Type,
	next:                                                      rawptr,
	shader_input_attachment_array_dynamic_indexing:            b32,
	shader_uniform_texel_buffer_array_dynamic_indexing:        b32,
	shader_storage_texel_buffer_array_dynamic_indexing:        b32,
	shader_uniform_buffer_array_non_uniform_indexing:          b32,
	shader_sampled_image_array_non_uniform_indexing:           b32,
	shader_storage_buffer_array_non_uniform_indexing:          b32,
	shader_storage_image_array_non_uniform_indexing:           b32,
	shader_input_attachment_array_non_uniform_indexing:        b32,
	shader_uniform_texel_buffer_array_non_uniform_indexing:    b32,
	shader_storage_texel_buffer_array_non_uniform_indexing:    b32,
	descriptor_binding_uniform_buffer_update_after_bind:       b32,
	descriptor_binding_sampled_image_update_after_bind:        b32,
	descriptor_binding_storage_image_update_after_bind:        b32,
	descriptor_binding_storage_buffer_update_after_bind:       b32,
	descriptor_binding_uniform_texel_buffer_update_after_bind: b32,
	descriptor_binding_storage_texel_buffer_update_after_bind: b32,
	descriptor_binding_update_unused_while_pending:            b32,
	descriptor_binding_partially_bound:                        b32,
	descriptor_binding_variable_descriptor_count:              b32,
	runtime_descriptor_array:                                  b32,
}

Physical_Device_Descriptor_Indexing_Properties_EXT :: struct {
	s_type:                                                       Structure_Type,
	next:                                                         rawptr,
	max_update_after_bind_descriptors_in_all_pools:               u32,
	shader_uniform_buffer_array_non_uniform_indexing_native:      b32,
	shader_sampled_image_array_non_uniform_indexing_native:       b32,
	shader_storage_buffer_array_non_uniform_indexing_native:      b32,
	shader_storage_image_array_non_uniform_indexing_native:       b32,
	shader_input_attachment_array_non_uniform_indexing_native:    b32,
	robust_buffer_access_update_after_bind:                       b32,
	quad_divergent_implicit_lod:                                  b32,
	max_per_stage_descriptor_update_after_bind_samplers:          u32,
	max_per_stage_descriptor_update_after_bind_uniform_buffers:   u32,
	max_per_stage_descriptor_update_after_bind_storage_buffers:   u32,
	max_per_stage_descriptor_update_after_bind_sampled_images:    u32,
	max_per_stage_descriptor_update_after_bind_storage_images:    u32,
	max_per_stage_descriptor_update_after_bind_input_attachments: u32,
	max_per_stage_update_after_bind_resources:                    u32,
	max_descriptor_set_update_after_bind_samplers:                u32,
	max_descriptor_set_update_after_bind_uniform_buffers:         u32,
	max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32,
	max_descriptor_set_update_after_bind_storage_buffers:         u32,
	max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32,
	max_descriptor_set_update_after_bind_sampled_images:          u32,
	max_descriptor_set_update_after_bind_storage_images:          u32,
	max_descriptor_set_update_after_bind_input_attachments:       u32,
}

Descriptor_Set_Variable_Descriptor_Count_Allocate_Info_EXT :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	descriptor_set_count: u32,
	descriptor_counts:    ^u32,
}

Descriptor_Set_Variable_Descriptor_Count_Layout_Support_EXT :: struct {
	s_type:                        Structure_Type,
	next:                          rawptr,
	max_variable_descriptor_count: u32,
}

Shading_Rate_Palette_NV :: struct {
	shading_rate_palette_entry_count: u32,
	shading_rate_palette_entries:     ^Shading_Rate_Palette_Entry_NV,
}

Pipeline_Viewport_Shading_Rate_Image_State_Create_Info_NV :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	shading_rate_image_enable: b32,
	viewport_count:            u32,
	shading_rate_palettes:     ^Shading_Rate_Palette_NV,
}

Physical_Device_Shading_Rate_Image_Features_NV :: struct {
	s_type:                           Structure_Type,
	next:                             rawptr,
	shading_rate_image:               b32,
	shading_rate_coarse_sample_order: b32,
}

Physical_Device_Shading_Rate_Image_Properties_NV :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	shading_rate_texel_size:         Extent2D,
	shading_rate_palette_size:       u32,
	shading_rate_max_coarse_samples: u32,
}

Coarse_Sample_Location_NV :: struct {
	pixel_x: u32,
	pixel_y: u32,
	sample:  u32,
}

Coarse_Sample_Order_Custom_NV :: struct {
	shading_rate:          Shading_Rate_Palette_Entry_NV,
	sample_count:          u32,
	sample_location_count: u32,
	sample_locations:      ^Coarse_Sample_Location_NV,
}

Pipeline_Viewport_Coarse_Sample_Order_State_Create_Info_NV :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	sample_order_type:         Coarse_Sample_Order_Type_NV,
	custom_sample_order_count: u32,
	custom_sample_orders:      ^Coarse_Sample_Order_Custom_NV,
}

Raytracing_Pipeline_Create_Info_NVX :: struct {
	s_type:               Structure_Type,
	next:                 rawptr,
	flags:                Pipeline_Create_Flags,
	stage_count:          u32,
	stages:               ^Pipeline_Shader_Stage_Create_Info,
	group_numbers:        ^u32,
	max_recursion_depth:  u32,
	layout:               Pipeline_Layout,
	base_pipeline_handle: Pipeline,
	base_pipeline_index:  i32,
}

Geometry_Triangles_NVX :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	vertex_data:      Buffer,
	vertex_offset:    Device_Size,
	vertex_count:     u32,
	vertex_stride:    Device_Size,
	vertex_format:    Format,
	index_data:       Buffer,
	index_offset:     Device_Size,
	index_count:      u32,
	index_type:       Index_Type,
	transform_data:   Buffer,
	transform_offset: Device_Size,
}

Geometry_Aabbnvx :: struct {
	s_type:     Structure_Type,
	next:       rawptr,
	aabb_data:  Buffer,
	num_aab_bs: u32,
	stride:     u32,
	offset:     Device_Size,
}

Geometry_Data_NVX :: struct {
	triangles: Geometry_Triangles_NVX,
	aabbs:     Geometry_Aabbnvx,
}

Geometry_NVX :: struct {
	s_type:        Structure_Type,
	next:          rawptr,
	geometry_type: Geometry_Type_NVX,
	geometry:      Geometry_Data_NVX,
	flags:         Geometry_Flags_NVX,
}

Acceleration_Structure_Create_Info_NVX :: struct {
	s_type:         Structure_Type,
	next:           rawptr,
	type:           Acceleration_Structure_Type_NVX,
	flags:          Build_Acceleration_Structure_Flags_NVX,
	compacted_size: Device_Size,
	instance_count: u32,
	geometry_count: u32,
	geometries:     ^Geometry_NVX,
}

Bind_Acceleration_Structure_Memory_Info_NVX :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	acceleration_structure: Acceleration_Structure_NVX,
	memory:                 Device_Memory,
	memory_offset:          Device_Size,
	device_index_count:     u32,
	device_indices:         ^u32,
}

Descriptor_Acceleration_Structure_Info_NVX :: struct {
	s_type:                       Structure_Type,
	next:                         rawptr,
	acceleration_structure_count: u32,
	acceleration_structures:      ^Acceleration_Structure_NVX,
}

Acceleration_Structure_Memory_Requirements_Info_NVX :: struct {
	s_type:                 Structure_Type,
	next:                   rawptr,
	acceleration_structure: Acceleration_Structure_NVX,
}

Physical_Device_Raytracing_Properties_NVX :: struct {
	s_type:              Structure_Type,
	next:                rawptr,
	shader_header_size:  u32,
	max_recursion_depth: u32,
	max_geometry_count:  u32,
}

Physical_Device_Representative_Fragment_Test_Features_NV :: struct {
	s_type:                       Structure_Type,
	next:                         rawptr,
	representative_fragment_test: b32,
}

Pipeline_Representative_Fragment_Test_State_Create_Info_NV :: struct {
	s_type:                              Structure_Type,
	next:                                rawptr,
	representative_fragment_test_enable: b32,
}

Device_Queue_Global_Priority_Create_Info_EXT :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	global_priority: Queue_Global_Priority_EXT,
}

Import_Memory_Host_Pointer_Info_EXT :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	handle_type:  External_Memory_Handle_Type_Flags,
	host_pointer: rawptr,
}

Memory_Host_Pointer_Properties_EXT :: struct {
	s_type:           Structure_Type,
	next:             rawptr,
	memory_type_bits: u32,
}

Physical_Device_External_Memory_Host_Properties_EXT :: struct {
	s_type:                              Structure_Type,
	next:                                rawptr,
	min_imported_host_pointer_alignment: Device_Size,
}

Calibrated_Timestamp_Info_EXT :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	time_domain: Time_Domain_EXT,
}

Physical_Device_Shader_Core_Properties_AMD :: struct {
	s_type:                         Structure_Type,
	next:                           rawptr,
	shader_engine_count:            u32,
	shader_arrays_per_engine_count: u32,
	compute_units_per_shader_array: u32,
	simd_per_compute_unit:          u32,
	wavefronts_per_simd:            u32,
	wavefront_size:                 u32,
	sgprs_per_simd:                 u32,
	min_sgpr_allocation:            u32,
	max_sgpr_allocation:            u32,
	sgpr_allocation_granularity:    u32,
	vgprs_per_simd:                 u32,
	min_vgpr_allocation:            u32,
	max_vgpr_allocation:            u32,
	vgpr_allocation_granularity:    u32,
}

Physical_Device_Vertex_Attribute_Divisor_Properties_EXT :: struct {
	s_type:                    Structure_Type,
	next:                      rawptr,
	max_vertex_attrib_divisor: u32,
}

Vertex_Input_Binding_Divisor_Description_EXT :: struct {
	binding: u32,
	divisor: u32,
}

Pipeline_Vertex_Input_Divisor_State_Create_Info_EXT :: struct {
	s_type:                       Structure_Type,
	next:                         rawptr,
	vertex_binding_divisor_count: u32,
	vertex_binding_divisors:      ^Vertex_Input_Binding_Divisor_Description_EXT,
}

Physical_Device_Vertex_Attribute_Divisor_Features_EXT :: struct {
	s_type:                                      Structure_Type,
	next:                                        rawptr,
	vertex_attribute_instance_rate_divisor:      b32,
	vertex_attribute_instance_rate_zero_divisor: b32,
}

Physical_Device_Compute_Shader_Derivatives_Features_NV :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	compute_derivative_group_quads:  b32,
	compute_derivative_group_linear: b32,
}

Physical_Device_Mesh_Shader_Features_NV :: struct {
	s_type:      Structure_Type,
	next:        rawptr,
	task_shader: b32,
	mesh_shader: b32,
}

Physical_Device_Mesh_Shader_Properties_NV :: struct {
	s_type:                                Structure_Type,
	next:                                  rawptr,
	max_draw_mesh_tasks_count:             u32,
	max_task_work_group_invocations:       u32,
	max_task_work_group_size:              [3]u32,
	max_task_total_memory_size:            u32,
	max_task_output_count:                 u32,
	max_mesh_work_group_invocations:       u32,
	max_mesh_work_group_size:              [3]u32,
	max_mesh_total_memory_size:            u32,
	max_mesh_output_vertices:              u32,
	max_mesh_output_primitives:            u32,
	max_mesh_multiview_view_count:         u32,
	mesh_output_per_vertex_granularity:    u32,
	mesh_output_per_primitive_granularity: u32,
}

Draw_Mesh_Tasks_Indirect_Command_NV :: struct {
	task_count: u32,
	first_task: u32,
}

Physical_Device_Fragment_Shader_Barycentric_Features_NV :: struct {
	s_type:                      Structure_Type,
	next:                        rawptr,
	fragment_shader_barycentric: b32,
}

Physical_Device_Shader_Image_Footprint_Features_NV :: struct {
	s_type:          Structure_Type,
	next:            rawptr,
	image_footprint: b32,
}

Pipeline_Viewport_Exclusive_Scissor_State_Create_Info_NV :: struct {
	s_type:                  Structure_Type,
	next:                    rawptr,
	exclusive_scissor_count: u32,
	exclusive_scissors:      ^Rect2D,
}

Physical_Device_Exclusive_Scissor_Features_NV :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	exclusive_scissor: b32,
}

Queue_Family_Checkpoint_Properties_NV :: struct {
	s_type:                          Structure_Type,
	next:                            rawptr,
	checkpoint_execution_stage_mask: Pipeline_Stage_Flags,
}

Checkpoint_Data_NV :: struct {
	s_type:            Structure_Type,
	next:              rawptr,
	stage:             Pipeline_Stage_Flags,
	checkpoint_marker: rawptr,
}

Physical_Device_Pci_Bus_Info_Properties_EXT :: struct {
	s_type:       Structure_Type,
	next:         rawptr,
	pci_domain:   u16,
	pci_bus:      u8,
	pci_device:   u8,
	pci_function: u8,
}




Proc_Allocation_Function                                        :: #type proc"c"(user_data: rawptr, size: int, alignment: int, allocation_scope: System_Allocation_Scope) -> rawptr;
Proc_Reallocation_Function                                      :: #type proc"c"(user_data: rawptr, original: rawptr, size: int, alignment: int, allocation_scope: System_Allocation_Scope) -> rawptr;
Proc_Free_Function                                              :: #type proc"c"(user_data: rawptr, memory: rawptr);
Proc_Internal_Allocation_Notification                           :: #type proc"c"(user_data: rawptr, size: int, allocation_type: Internal_Allocation_Type, allocation_scope: System_Allocation_Scope);
Proc_Internal_Free_Notification                                 :: #type proc"c"(user_data: rawptr, size: int, allocation_type: Internal_Allocation_Type, allocation_scope: System_Allocation_Scope);
Proc_Void_Function                                              :: #type proc"c"();
Proc_Create_Instance                                            :: #type proc"c"(create_info: ^Instance_Create_Info, allocator: ^Allocation_Callbacks, instance: ^Instance) -> Result;
Proc_Destroy_Instance                                           :: #type proc"c"(instance: Instance, allocator: ^Allocation_Callbacks);
Proc_Enumerate_Physical_Devices                                 :: #type proc"c"(instance: Instance, physical_device_count: ^u32, physical_devices: ^Physical_Device) -> Result;
Proc_Get_Physical_Device_Features                               :: #type proc"c"(physical_device: Physical_Device, features: ^Physical_Device_Features);
Proc_Get_Physical_Device_Format_Properties                      :: #type proc"c"(physical_device: Physical_Device, format: Format, format_properties: ^Format_Properties);
Proc_Get_Physical_Device_Image_Format_Properties                :: #type proc"c"(physical_device: Physical_Device, format: Format, type: Image_Type, tiling: Image_Tiling, usage: Image_Usage_Flags, flags: Image_Create_Flags, image_format_properties: ^Image_Format_Properties) -> Result;
Proc_Get_Physical_Device_Properties                             :: #type proc"c"(physical_device: Physical_Device, properties: ^Physical_Device_Properties);
Proc_Get_Physical_Device_Queue_Family_Properties                :: #type proc"c"(physical_device: Physical_Device, queue_family_property_count: ^u32, queue_family_properties: ^Queue_Family_Properties);
Proc_Get_Physical_Device_Memory_Properties                      :: #type proc"c"(physical_device: Physical_Device, memory_properties: ^Physical_Device_Memory_Properties);
Proc_Get_Instance_Proc_Addr                                     :: #type proc"c"(instance: Instance, name: cstring) -> Proc_Void_Function;
Proc_Get_Device_Proc_Addr                                       :: #type proc"c"(device: Device, name: cstring) -> Proc_Void_Function;
Proc_Create_Device                                              :: #type proc"c"(physical_device: Physical_Device, create_info: ^Device_Create_Info, allocator: ^Allocation_Callbacks, device: ^Device) -> Result;
Proc_Destroy_Device                                             :: #type proc"c"(device: Device, allocator: ^Allocation_Callbacks);
Proc_Enumerate_Instance_Extension_Properties                    :: #type proc"c"(layer_name: cstring, property_count: ^u32, properties: ^Extension_Properties) -> Result;
Proc_Enumerate_Device_Extension_Properties                      :: #type proc"c"(physical_device: Physical_Device, layer_name: cstring, property_count: ^u32, properties: ^Extension_Properties) -> Result;
Proc_Enumerate_Instance_Layer_Properties                        :: #type proc"c"(property_count: ^u32, properties: ^Layer_Properties) -> Result;
Proc_Enumerate_Device_Layer_Properties                          :: #type proc"c"(physical_device: Physical_Device, property_count: ^u32, properties: ^Layer_Properties) -> Result;
Proc_Get_Device_Queue                                           :: #type proc"c"(device: Device, queue_family_index: u32, queue_index: u32, queue: ^Queue);
Proc_Queue_Submit                                               :: #type proc"c"(queue: Queue, submit_count: u32, submits: ^Submit_Info, fence: Fence) -> Result;
Proc_Queue_Wait_Idle                                            :: #type proc"c"(queue: Queue) -> Result;
Proc_Device_Wait_Idle                                           :: #type proc"c"(device: Device) -> Result;
Proc_Allocate_Memory                                            :: #type proc"c"(device: Device, allocate_info: ^Memory_Allocate_Info, allocator: ^Allocation_Callbacks, memory: ^Device_Memory) -> Result;
Proc_Free_Memory                                                :: #type proc"c"(device: Device, memory: Device_Memory, allocator: ^Allocation_Callbacks);
Proc_Map_Memory                                                 :: #type proc"c"(device: Device, memory: Device_Memory, offset: Device_Size, size: Device_Size, flags: Memory_Map_Flags, data: ^rawptr) -> Result;
Proc_Unmap_Memory                                               :: #type proc"c"(device: Device, memory: Device_Memory);
Proc_Flush_Mapped_Memory_Ranges                                 :: #type proc"c"(device: Device, memory_range_count: u32, memory_ranges: ^Mapped_Memory_Range) -> Result;
Proc_Invalidate_Mapped_Memory_Ranges                            :: #type proc"c"(device: Device, memory_range_count: u32, memory_ranges: ^Mapped_Memory_Range) -> Result;
Proc_Get_Device_Memory_Commitment                               :: #type proc"c"(device: Device, memory: Device_Memory, committed_memory_in_bytes: ^Device_Size);
Proc_Bind_Buffer_Memory                                         :: #type proc"c"(device: Device, buffer: Buffer, memory: Device_Memory, memory_offset: Device_Size) -> Result;
Proc_Bind_Image_Memory                                          :: #type proc"c"(device: Device, image: Image, memory: Device_Memory, memory_offset: Device_Size) -> Result;
Proc_Get_Buffer_Memory_Requirements                             :: #type proc"c"(device: Device, buffer: Buffer, memory_requirements: ^Memory_Requirements);
Proc_Get_Image_Memory_Requirements                              :: #type proc"c"(device: Device, image: Image, memory_requirements: ^Memory_Requirements);
Proc_Get_Image_Sparse_Memory_Requirements                       :: #type proc"c"(device: Device, image: Image, sparse_memory_requirement_count: ^u32, sparse_memory_requirements: ^Sparse_Image_Memory_Requirements);
Proc_Get_Physical_Device_Sparse_Image_Format_Properties         :: #type proc"c"(physical_device: Physical_Device, format: Format, type: Image_Type, samples: Sample_Count_Flags, usage: Image_Usage_Flags, tiling: Image_Tiling, property_count: ^u32, properties: ^Sparse_Image_Format_Properties);
Proc_Queue_Bind_Sparse                                          :: #type proc"c"(queue: Queue, bind_info_count: u32, bind_info: ^Bind_Sparse_Info, fence: Fence) -> Result;
Proc_Create_Fence                                               :: #type proc"c"(device: Device, create_info: ^Fence_Create_Info, allocator: ^Allocation_Callbacks, fence: ^Fence) -> Result;
Proc_Destroy_Fence                                              :: #type proc"c"(device: Device, fence: Fence, allocator: ^Allocation_Callbacks);
Proc_Reset_Fences                                               :: #type proc"c"(device: Device, fence_count: u32, fences: ^Fence) -> Result;
Proc_Get_Fence_Status                                           :: #type proc"c"(device: Device, fence: Fence) -> Result;
Proc_Wait_For_Fences                                            :: #type proc"c"(device: Device, fence_count: u32, fences: ^Fence, wait_all: b32, timeout: u64) -> Result;
Proc_Create_Semaphore                                           :: #type proc"c"(device: Device, create_info: ^Semaphore_Create_Info, allocator: ^Allocation_Callbacks, semaphore: ^Semaphore) -> Result;
Proc_Destroy_Semaphore                                          :: #type proc"c"(device: Device, semaphore: Semaphore, allocator: ^Allocation_Callbacks);
Proc_Create_Event                                               :: #type proc"c"(device: Device, create_info: ^Event_Create_Info, allocator: ^Allocation_Callbacks, event: ^Event) -> Result;
Proc_Destroy_Event                                              :: #type proc"c"(device: Device, event: Event, allocator: ^Allocation_Callbacks);
Proc_Get_Event_Status                                           :: #type proc"c"(device: Device, event: Event) -> Result;
Proc_Set_Event                                                  :: #type proc"c"(device: Device, event: Event) -> Result;
Proc_Reset_Event                                                :: #type proc"c"(device: Device, event: Event) -> Result;
Proc_Create_Query_Pool                                          :: #type proc"c"(device: Device, create_info: ^Query_Pool_Create_Info, allocator: ^Allocation_Callbacks, query_pool: ^Query_Pool) -> Result;
Proc_Destroy_Query_Pool                                         :: #type proc"c"(device: Device, query_pool: Query_Pool, allocator: ^Allocation_Callbacks);
Proc_Get_Query_Pool_Results                                     :: #type proc"c"(device: Device, query_pool: Query_Pool, first_query: u32, query_count: u32, data_size: int, data: rawptr, stride: Device_Size, flags: Query_Result_Flags) -> Result;
Proc_Create_Buffer                                              :: #type proc"c"(device: Device, create_info: ^Buffer_Create_Info, allocator: ^Allocation_Callbacks, buffer: ^Buffer) -> Result;
Proc_Destroy_Buffer                                             :: #type proc"c"(device: Device, buffer: Buffer, allocator: ^Allocation_Callbacks);
Proc_Create_Buffer_View                                         :: #type proc"c"(device: Device, create_info: ^Buffer_View_Create_Info, allocator: ^Allocation_Callbacks, view: ^Buffer_View) -> Result;
Proc_Destroy_Buffer_View                                        :: #type proc"c"(device: Device, buffer_view: Buffer_View, allocator: ^Allocation_Callbacks);
Proc_Create_Image                                               :: #type proc"c"(device: Device, create_info: ^Image_Create_Info, allocator: ^Allocation_Callbacks, image: ^Image) -> Result;
Proc_Destroy_Image                                              :: #type proc"c"(device: Device, image: Image, allocator: ^Allocation_Callbacks);
Proc_Get_Image_Subresource_Layout                               :: #type proc"c"(device: Device, image: Image, subresource: ^Image_Subresource, layout: ^Subresource_Layout);
Proc_Create_Image_View                                          :: #type proc"c"(device: Device, create_info: ^Image_View_Create_Info, allocator: ^Allocation_Callbacks, view: ^Image_View) -> Result;
Proc_Destroy_Image_View                                         :: #type proc"c"(device: Device, image_view: Image_View, allocator: ^Allocation_Callbacks);
Proc_Create_Shader_Module                                       :: #type proc"c"(device: Device, create_info: ^Shader_Module_Create_Info, allocator: ^Allocation_Callbacks, shader_module: ^Shader_Module) -> Result;
Proc_Destroy_Shader_Module                                      :: #type proc"c"(device: Device, shader_module: Shader_Module, allocator: ^Allocation_Callbacks);
Proc_Create_Pipeline_Cache                                      :: #type proc"c"(device: Device, create_info: ^Pipeline_Cache_Create_Info, allocator: ^Allocation_Callbacks, pipeline_cache: ^Pipeline_Cache) -> Result;
Proc_Destroy_Pipeline_Cache                                     :: #type proc"c"(device: Device, pipeline_cache: Pipeline_Cache, allocator: ^Allocation_Callbacks);
Proc_Get_Pipeline_Cache_Data                                    :: #type proc"c"(device: Device, pipeline_cache: Pipeline_Cache, data_size: ^int, data: rawptr) -> Result;
Proc_Merge_Pipeline_Caches                                      :: #type proc"c"(device: Device, dst_cache: Pipeline_Cache, src_cache_count: u32, src_caches: ^Pipeline_Cache) -> Result;
Proc_Create_Graphics_Pipelines                                  :: #type proc"c"(device: Device, pipeline_cache: Pipeline_Cache, create_info_count: u32, create_infos: ^Graphics_Pipeline_Create_Info, allocator: ^Allocation_Callbacks, pipelines: ^Pipeline) -> Result;
Proc_Create_Compute_Pipelines                                   :: #type proc"c"(device: Device, pipeline_cache: Pipeline_Cache, create_info_count: u32, create_infos: ^Compute_Pipeline_Create_Info, allocator: ^Allocation_Callbacks, pipelines: ^Pipeline) -> Result;
Proc_Destroy_Pipeline                                           :: #type proc"c"(device: Device, pipeline: Pipeline, allocator: ^Allocation_Callbacks);
Proc_Create_Pipeline_Layout                                     :: #type proc"c"(device: Device, create_info: ^Pipeline_Layout_Create_Info, allocator: ^Allocation_Callbacks, pipeline_layout: ^Pipeline_Layout) -> Result;
Proc_Destroy_Pipeline_Layout                                    :: #type proc"c"(device: Device, pipeline_layout: Pipeline_Layout, allocator: ^Allocation_Callbacks);
Proc_Create_Sampler                                             :: #type proc"c"(device: Device, create_info: ^Sampler_Create_Info, allocator: ^Allocation_Callbacks, sampler: ^Sampler) -> Result;
Proc_Destroy_Sampler                                            :: #type proc"c"(device: Device, sampler: Sampler, allocator: ^Allocation_Callbacks);
Proc_Create_Descriptor_Set_Layout                               :: #type proc"c"(device: Device, create_info: ^Descriptor_Set_Layout_Create_Info, allocator: ^Allocation_Callbacks, set_layout: ^Descriptor_Set_Layout) -> Result;
Proc_Destroy_Descriptor_Set_Layout                              :: #type proc"c"(device: Device, descriptor_set_layout: Descriptor_Set_Layout, allocator: ^Allocation_Callbacks);
Proc_Create_Descriptor_Pool                                     :: #type proc"c"(device: Device, create_info: ^Descriptor_Pool_Create_Info, allocator: ^Allocation_Callbacks, descriptor_pool: ^Descriptor_Pool) -> Result;
Proc_Destroy_Descriptor_Pool                                    :: #type proc"c"(device: Device, descriptor_pool: Descriptor_Pool, allocator: ^Allocation_Callbacks);
Proc_Reset_Descriptor_Pool                                      :: #type proc"c"(device: Device, descriptor_pool: Descriptor_Pool, flags: Descriptor_Pool_Reset_Flags) -> Result;
Proc_Allocate_Descriptor_Sets                                   :: #type proc"c"(device: Device, allocate_info: ^Descriptor_Set_Allocate_Info, descriptor_sets: ^Descriptor_Set) -> Result;
Proc_Free_Descriptor_Sets                                       :: #type proc"c"(device: Device, descriptor_pool: Descriptor_Pool, descriptor_set_count: u32, descriptor_sets: ^Descriptor_Set) -> Result;
Proc_Update_Descriptor_Sets                                     :: #type proc"c"(device: Device, descriptor_write_count: u32, descriptor_writes: ^Write_Descriptor_Set, descriptor_copy_count: u32, descriptor_copies: ^Copy_Descriptor_Set);
Proc_Create_Framebuffer                                         :: #type proc"c"(device: Device, create_info: ^Framebuffer_Create_Info, allocator: ^Allocation_Callbacks, framebuffer: ^Framebuffer) -> Result;
Proc_Destroy_Framebuffer                                        :: #type proc"c"(device: Device, framebuffer: Framebuffer, allocator: ^Allocation_Callbacks);
Proc_Create_Render_Pass                                         :: #type proc"c"(device: Device, create_info: ^Render_Pass_Create_Info, allocator: ^Allocation_Callbacks, render_pass: ^Render_Pass) -> Result;
Proc_Destroy_Render_Pass                                        :: #type proc"c"(device: Device, render_pass: Render_Pass, allocator: ^Allocation_Callbacks);
Proc_Get_Render_Area_Granularity                                :: #type proc"c"(device: Device, render_pass: Render_Pass, granularity: ^Extent2D);
Proc_Create_Command_Pool                                        :: #type proc"c"(device: Device, create_info: ^Command_Pool_Create_Info, allocator: ^Allocation_Callbacks, command_pool: ^Command_Pool) -> Result;
Proc_Destroy_Command_Pool                                       :: #type proc"c"(device: Device, command_pool: Command_Pool, allocator: ^Allocation_Callbacks);
Proc_Reset_Command_Pool                                         :: #type proc"c"(device: Device, command_pool: Command_Pool, flags: Command_Pool_Reset_Flags) -> Result;
Proc_Allocate_Command_Buffers                                   :: #type proc"c"(device: Device, allocate_info: ^Command_Buffer_Allocate_Info, command_buffers: ^Command_Buffer) -> Result;
Proc_Free_Command_Buffers                                       :: #type proc"c"(device: Device, command_pool: Command_Pool, command_buffer_count: u32, command_buffers: ^Command_Buffer);
Proc_Begin_Command_Buffer                                       :: #type proc"c"(command_buffer: Command_Buffer, begin_info: ^Command_Buffer_Begin_Info) -> Result;
Proc_End_Command_Buffer                                         :: #type proc"c"(command_buffer: Command_Buffer) -> Result;
Proc_Reset_Command_Buffer                                       :: #type proc"c"(command_buffer: Command_Buffer, flags: Command_Buffer_Reset_Flags) -> Result;
Proc_Cmd_Bind_Pipeline                                          :: #type proc"c"(command_buffer: Command_Buffer, pipeline_bind_point: Pipeline_Bind_Point, pipeline: Pipeline);
Proc_Cmd_Set_Viewport                                           :: #type proc"c"(command_buffer: Command_Buffer, first_viewport: u32, viewport_count: u32, viewports: ^Viewport);
Proc_Cmd_Set_Scissor                                            :: #type proc"c"(command_buffer: Command_Buffer, first_scissor: u32, scissor_count: u32, scissors: ^Rect2D);
Proc_Cmd_Set_Line_Width                                         :: #type proc"c"(command_buffer: Command_Buffer, line_width: f32);
Proc_Cmd_Set_Depth_Bias                                         :: #type proc"c"(command_buffer: Command_Buffer, depth_bias_constant_factor: f32, depth_bias_clamp: f32, depth_bias_slope_factor: f32);
Proc_Cmd_Set_Blend_Constants                                    :: #type proc"c"(command_buffer: Command_Buffer);
Proc_Cmd_Set_Depth_Bounds                                       :: #type proc"c"(command_buffer: Command_Buffer, min_depth_bounds: f32, max_depth_bounds: f32);
Proc_Cmd_Set_Stencil_Compare_Mask                               :: #type proc"c"(command_buffer: Command_Buffer, face_mask: Stencil_Face_Flags, compare_mask: u32);
Proc_Cmd_Set_Stencil_Write_Mask                                 :: #type proc"c"(command_buffer: Command_Buffer, face_mask: Stencil_Face_Flags, write_mask: u32);
Proc_Cmd_Set_Stencil_Reference                                  :: #type proc"c"(command_buffer: Command_Buffer, face_mask: Stencil_Face_Flags, reference: u32);
Proc_Cmd_Bind_Descriptor_Sets                                   :: #type proc"c"(command_buffer: Command_Buffer, pipeline_bind_point: Pipeline_Bind_Point, layout: Pipeline_Layout, first_set: u32, descriptor_set_count: u32, descriptor_sets: ^Descriptor_Set, dynamic_offset_count: u32, dynamic_offsets: ^u32);
Proc_Cmd_Bind_Index_Buffer                                      :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, index_type: Index_Type);
Proc_Cmd_Bind_Vertex_Buffers                                    :: #type proc"c"(command_buffer: Command_Buffer, first_binding: u32, binding_count: u32, buffers: ^Buffer, offsets: ^Device_Size);
Proc_Cmd_Draw                                                   :: #type proc"c"(command_buffer: Command_Buffer, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32);
Proc_Cmd_Draw_Indexed                                           :: #type proc"c"(command_buffer: Command_Buffer, index_count: u32, instance_count: u32, first_index: u32, vertex_offset: i32, first_instance: u32);
Proc_Cmd_Draw_Indirect                                          :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, draw_count: u32, stride: u32);
Proc_Cmd_Draw_Indexed_Indirect                                  :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, draw_count: u32, stride: u32);
Proc_Cmd_Dispatch                                               :: #type proc"c"(command_buffer: Command_Buffer, group_count_x: u32, group_count_y: u32, group_count_z: u32);
Proc_Cmd_Dispatch_Indirect                                      :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size);
Proc_Cmd_Copy_Buffer                                            :: #type proc"c"(command_buffer: Command_Buffer, src_buffer: Buffer, dst_buffer: Buffer, region_count: u32, regions: ^Buffer_Copy);
Proc_Cmd_Copy_Image                                             :: #type proc"c"(command_buffer: Command_Buffer, src_image: Image, src_image_layout: Image_Layout, dst_image: Image, dst_image_layout: Image_Layout, region_count: u32, regions: ^Image_Copy);
Proc_Cmd_Blit_Image                                             :: #type proc"c"(command_buffer: Command_Buffer, src_image: Image, src_image_layout: Image_Layout, dst_image: Image, dst_image_layout: Image_Layout, region_count: u32, regions: ^Image_Blit, filter: Filter);
Proc_Cmd_Copy_Buffer_To_Image                                   :: #type proc"c"(command_buffer: Command_Buffer, src_buffer: Buffer, dst_image: Image, dst_image_layout: Image_Layout, region_count: u32, regions: ^Buffer_Image_Copy);
Proc_Cmd_Copy_Image_To_Buffer                                   :: #type proc"c"(command_buffer: Command_Buffer, src_image: Image, src_image_layout: Image_Layout, dst_buffer: Buffer, region_count: u32, regions: ^Buffer_Image_Copy);
Proc_Cmd_Update_Buffer                                          :: #type proc"c"(command_buffer: Command_Buffer, dst_buffer: Buffer, dst_offset: Device_Size, data_size: Device_Size, data: rawptr);
Proc_Cmd_Fill_Buffer                                            :: #type proc"c"(command_buffer: Command_Buffer, dst_buffer: Buffer, dst_offset: Device_Size, size: Device_Size, data: u32);
Proc_Cmd_Clear_Color_Image                                      :: #type proc"c"(command_buffer: Command_Buffer, image: Image, image_layout: Image_Layout, color: ^Clear_Color_Value, range_count: u32, ranges: ^Image_Subresource_Range);
Proc_Cmd_Clear_Depth_Stencil_Image                              :: #type proc"c"(command_buffer: Command_Buffer, image: Image, image_layout: Image_Layout, depth_stencil: ^Clear_Depth_Stencil_Value, range_count: u32, ranges: ^Image_Subresource_Range);
Proc_Cmd_Clear_Attachments                                      :: #type proc"c"(command_buffer: Command_Buffer, attachment_count: u32, attachments: ^Clear_Attachment, rect_count: u32, rects: ^Clear_Rect);
Proc_Cmd_Resolve_Image                                          :: #type proc"c"(command_buffer: Command_Buffer, src_image: Image, src_image_layout: Image_Layout, dst_image: Image, dst_image_layout: Image_Layout, region_count: u32, regions: ^Image_Resolve);
Proc_Cmd_Set_Event                                              :: #type proc"c"(command_buffer: Command_Buffer, event: Event, stage_mask: Pipeline_Stage_Flags);
Proc_Cmd_Reset_Event                                            :: #type proc"c"(command_buffer: Command_Buffer, event: Event, stage_mask: Pipeline_Stage_Flags);
Proc_Cmd_Wait_Events                                            :: #type proc"c"(command_buffer: Command_Buffer, event_count: u32, events: ^Event, src_stage_mask: Pipeline_Stage_Flags, dst_stage_mask: Pipeline_Stage_Flags, memory_barrier_count: u32, memory_barriers: ^Memory_Barrier, buffer_memory_barrier_count: u32, buffer_memory_barriers: ^Buffer_Memory_Barrier, image_memory_barrier_count: u32, image_memory_barriers: ^Image_Memory_Barrier);
Proc_Cmd_Pipeline_Barrier                                       :: #type proc"c"(command_buffer: Command_Buffer, src_stage_mask: Pipeline_Stage_Flags, dst_stage_mask: Pipeline_Stage_Flags, dependency_flags: Dependency_Flags, memory_barrier_count: u32, memory_barriers: ^Memory_Barrier, buffer_memory_barrier_count: u32, buffer_memory_barriers: ^Buffer_Memory_Barrier, image_memory_barrier_count: u32, image_memory_barriers: ^Image_Memory_Barrier);
Proc_Cmd_Begin_Query                                            :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, query: u32, flags: Query_Control_Flags);
Proc_Cmd_End_Query                                              :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, query: u32);
Proc_Cmd_Reset_Query_Pool                                       :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, first_query: u32, query_count: u32);
Proc_Cmd_Write_Timestamp                                        :: #type proc"c"(command_buffer: Command_Buffer, pipeline_stage: Pipeline_Stage_Flags, query_pool: Query_Pool, query: u32);
Proc_Cmd_Copy_Query_Pool_Results                                :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, first_query: u32, query_count: u32, dst_buffer: Buffer, dst_offset: Device_Size, stride: Device_Size, flags: Query_Result_Flags);
Proc_Cmd_Push_Constants                                         :: #type proc"c"(command_buffer: Command_Buffer, layout: Pipeline_Layout, stage_flags: Shader_Stage_Flags, offset: u32, size: u32, values: rawptr);
Proc_Cmd_Begin_Render_Pass                                      :: #type proc"c"(command_buffer: Command_Buffer, render_pass_begin: ^Render_Pass_Begin_Info, contents: Subpass_Contents);
Proc_Cmd_Next_Subpass                                           :: #type proc"c"(command_buffer: Command_Buffer, contents: Subpass_Contents);
Proc_Cmd_End_Render_Pass                                        :: #type proc"c"(command_buffer: Command_Buffer);
Proc_Cmd_Execute_Commands                                       :: #type proc"c"(command_buffer: Command_Buffer, command_buffer_count: u32, command_buffers: ^Command_Buffer);
Proc_Enumerate_Instance_Version                                 :: #type proc"c"(api_version: ^u32) -> Result;
Proc_Bind_Buffer_Memory2                                        :: #type proc"c"(device: Device, bind_info_count: u32, bind_infos: ^Bind_Buffer_Memory_Info) -> Result;
Proc_Bind_Image_Memory2                                         :: #type proc"c"(device: Device, bind_info_count: u32, bind_infos: ^Bind_Image_Memory_Info) -> Result;
Proc_Get_Device_Group_Peer_Memory_Features                      :: #type proc"c"(device: Device, heap_index: u32, local_device_index: u32, remote_device_index: u32, peer_memory_features: ^Peer_Memory_Feature_Flags);
Proc_Cmd_Set_Device_Mask                                        :: #type proc"c"(command_buffer: Command_Buffer, device_mask: u32);
Proc_Cmd_Dispatch_Base                                          :: #type proc"c"(command_buffer: Command_Buffer, base_group_x: u32, base_group_y: u32, base_group_z: u32, group_count_x: u32, group_count_y: u32, group_count_z: u32);
Proc_Enumerate_Physical_Device_Groups                           :: #type proc"c"(instance: Instance, physical_device_group_count: ^u32, physical_device_group_properties: ^Physical_Device_Group_Properties) -> Result;
Proc_Get_Image_Memory_Requirements2                             :: #type proc"c"(device: Device, info: ^Image_Memory_Requirements_Info2, memory_requirements: ^Memory_Requirements2);
Proc_Get_Buffer_Memory_Requirements2                            :: #type proc"c"(device: Device, info: ^Buffer_Memory_Requirements_Info2, memory_requirements: ^Memory_Requirements2);
Proc_Get_Image_Sparse_Memory_Requirements2                      :: #type proc"c"(device: Device, info: ^Image_Sparse_Memory_Requirements_Info2, sparse_memory_requirement_count: ^u32, sparse_memory_requirements: ^Sparse_Image_Memory_Requirements2);
Proc_Get_Physical_Device_Features2                              :: #type proc"c"(physical_device: Physical_Device, features: ^Physical_Device_Features2);
Proc_Get_Physical_Device_Properties2                            :: #type proc"c"(physical_device: Physical_Device, properties: ^Physical_Device_Properties2);
Proc_Get_Physical_Device_Format_Properties2                     :: #type proc"c"(physical_device: Physical_Device, format: Format, format_properties: ^Format_Properties2);
Proc_Get_Physical_Device_Image_Format_Properties2               :: #type proc"c"(physical_device: Physical_Device, image_format_info: ^Physical_Device_Image_Format_Info2, image_format_properties: ^Image_Format_Properties2) -> Result;
Proc_Get_Physical_Device_Queue_Family_Properties2               :: #type proc"c"(physical_device: Physical_Device, queue_family_property_count: ^u32, queue_family_properties: ^Queue_Family_Properties2);
Proc_Get_Physical_Device_Memory_Properties2                     :: #type proc"c"(physical_device: Physical_Device, memory_properties: ^Physical_Device_Memory_Properties2);
Proc_Get_Physical_Device_Sparse_Image_Format_Properties2        :: #type proc"c"(physical_device: Physical_Device, format_info: ^Physical_Device_Sparse_Image_Format_Info2, property_count: ^u32, properties: ^Sparse_Image_Format_Properties2);
Proc_Trim_Command_Pool                                          :: #type proc"c"(device: Device, command_pool: Command_Pool, flags: Command_Pool_Trim_Flags);
Proc_Get_Device_Queue2                                          :: #type proc"c"(device: Device, queue_info: ^Device_Queue_Info2, queue: ^Queue);
Proc_Create_Sampler_Ycbcr_Conversion                            :: #type proc"c"(device: Device, create_info: ^Sampler_Ycbcr_Conversion_Create_Info, allocator: ^Allocation_Callbacks, ycbcr_conversion: ^Sampler_Ycbcr_Conversion) -> Result;
Proc_Destroy_Sampler_Ycbcr_Conversion                           :: #type proc"c"(device: Device, ycbcr_conversion: Sampler_Ycbcr_Conversion, allocator: ^Allocation_Callbacks);
Proc_Create_Descriptor_Update_Template                          :: #type proc"c"(device: Device, create_info: ^Descriptor_Update_Template_Create_Info, allocator: ^Allocation_Callbacks, descriptor_update_template: ^Descriptor_Update_Template) -> Result;
Proc_Destroy_Descriptor_Update_Template                         :: #type proc"c"(device: Device, descriptor_update_template: Descriptor_Update_Template, allocator: ^Allocation_Callbacks);
Proc_Update_Descriptor_Set_With_Template                        :: #type proc"c"(device: Device, descriptor_set: Descriptor_Set, descriptor_update_template: Descriptor_Update_Template, data: rawptr);
Proc_Get_Physical_Device_External_Buffer_Properties             :: #type proc"c"(physical_device: Physical_Device, external_buffer_info: ^Physical_Device_External_Buffer_Info, external_buffer_properties: ^External_Buffer_Properties);
Proc_Get_Physical_Device_External_Fence_Properties              :: #type proc"c"(physical_device: Physical_Device, external_fence_info: ^Physical_Device_External_Fence_Info, external_fence_properties: ^External_Fence_Properties);
Proc_Get_Physical_Device_External_Semaphore_Properties          :: #type proc"c"(physical_device: Physical_Device, external_semaphore_info: ^Physical_Device_External_Semaphore_Info, external_semaphore_properties: ^External_Semaphore_Properties);
Proc_Get_Descriptor_Set_Layout_Support                          :: #type proc"c"(device: Device, create_info: ^Descriptor_Set_Layout_Create_Info, support: ^Descriptor_Set_Layout_Support);
Proc_Destroy_Surface_KHR                                        :: #type proc"c"(instance: Instance, surface: Surface_KHR, allocator: ^Allocation_Callbacks);
Proc_Get_Physical_Device_Surface_Support_KHR                    :: #type proc"c"(physical_device: Physical_Device, queue_family_index: u32, surface: Surface_KHR, supported: ^b32) -> Result;
Proc_Get_Physical_Device_Surface_Capabilities_KHR               :: #type proc"c"(physical_device: Physical_Device, surface: Surface_KHR, surface_capabilities: ^Surface_Capabilities_KHR) -> Result;
Proc_Get_Physical_Device_Surface_Formats_KHR                    :: #type proc"c"(physical_device: Physical_Device, surface: Surface_KHR, surface_format_count: ^u32, surface_formats: ^Surface_Format_KHR) -> Result;
Proc_Get_Physical_Device_Surface_Present_Modes_KHR              :: #type proc"c"(physical_device: Physical_Device, surface: Surface_KHR, present_mode_count: ^u32, present_modes: ^Present_Mode_KHR) -> Result;
Proc_Create_Swapchain_KHR                                       :: #type proc"c"(device: Device, create_info: ^Swapchain_Create_Info_KHR, allocator: ^Allocation_Callbacks, swapchain: ^Swapchain_KHR) -> Result;
Proc_Destroy_Swapchain_KHR                                      :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, allocator: ^Allocation_Callbacks);
Proc_Get_Swapchain_Images_KHR                                   :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, swapchain_image_count: ^u32, swapchain_images: ^Image) -> Result;
Proc_Acquire_Next_Image_KHR                                     :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, timeout: u64, semaphore: Semaphore, fence: Fence, image_index: ^u32) -> Result;
Proc_Queue_Present_KHR                                          :: #type proc"c"(queue: Queue, present_info: ^Present_Info_KHR) -> Result;
Proc_Get_Device_Group_Present_Capabilities_KHR                  :: #type proc"c"(device: Device, device_group_present_capabilities: ^Device_Group_Present_Capabilities_KHR) -> Result;
Proc_Get_Device_Group_Surface_Present_Modes_KHR                 :: #type proc"c"(device: Device, surface: Surface_KHR, modes: ^Device_Group_Present_Mode_Flags_KHR) -> Result;
Proc_Get_Physical_Device_Present_Rectangles_KHR                 :: #type proc"c"(physical_device: Physical_Device, surface: Surface_KHR, rect_count: ^u32, rects: ^Rect2D) -> Result;
Proc_Acquire_Next_Image2_KHR                                    :: #type proc"c"(device: Device, acquire_info: ^Acquire_Next_Image_Info_KHR, image_index: ^u32) -> Result;
Proc_Get_Physical_Device_Display_Properties_KHR                 :: #type proc"c"(physical_device: Physical_Device, property_count: ^u32, properties: ^Display_Properties_KHR) -> Result;
Proc_Get_Physical_Device_Display_Plane_Properties_KHR           :: #type proc"c"(physical_device: Physical_Device, property_count: ^u32, properties: ^Display_Plane_Properties_KHR) -> Result;
Proc_Get_Display_Plane_Supported_Displays_KHR                   :: #type proc"c"(physical_device: Physical_Device, plane_index: u32, display_count: ^u32, displays: ^Display_KHR) -> Result;
Proc_Get_Display_Mode_Properties_KHR                            :: #type proc"c"(physical_device: Physical_Device, display: Display_KHR, property_count: ^u32, properties: ^Display_Mode_Properties_KHR) -> Result;
Proc_Create_Display_Mode_KHR                                    :: #type proc"c"(physical_device: Physical_Device, display: Display_KHR, create_info: ^Display_Mode_Create_Info_KHR, allocator: ^Allocation_Callbacks, mode: ^Display_Mode_KHR) -> Result;
Proc_Get_Display_Plane_Capabilities_KHR                         :: #type proc"c"(physical_device: Physical_Device, mode: Display_Mode_KHR, plane_index: u32, capabilities: ^Display_Plane_Capabilities_KHR) -> Result;
Proc_Create_Display_Plane_Surface_KHR                           :: #type proc"c"(instance: Instance, create_info: ^Display_Surface_Create_Info_KHR, allocator: ^Allocation_Callbacks, surface: ^Surface_KHR) -> Result;
Proc_Create_Shared_Swapchains_KHR                               :: #type proc"c"(device: Device, swapchain_count: u32, create_infos: ^Swapchain_Create_Info_KHR, allocator: ^Allocation_Callbacks, swapchains: ^Swapchain_KHR) -> Result;
Proc_Get_Physical_Device_Features2_KHR                          :: #type proc"c"(physical_device: Physical_Device, features: ^Physical_Device_Features2);
Proc_Get_Physical_Device_Properties2_KHR                        :: #type proc"c"(physical_device: Physical_Device, properties: ^Physical_Device_Properties2);
Proc_Get_Physical_Device_Format_Properties2_KHR                 :: #type proc"c"(physical_device: Physical_Device, format: Format, format_properties: ^Format_Properties2);
Proc_Get_Physical_Device_Image_Format_Properties2_KHR           :: #type proc"c"(physical_device: Physical_Device, image_format_info: ^Physical_Device_Image_Format_Info2, image_format_properties: ^Image_Format_Properties2) -> Result;
Proc_Get_Physical_Device_Queue_Family_Properties2_KHR           :: #type proc"c"(physical_device: Physical_Device, queue_family_property_count: ^u32, queue_family_properties: ^Queue_Family_Properties2);
Proc_Get_Physical_Device_Memory_Properties2_KHR                 :: #type proc"c"(physical_device: Physical_Device, memory_properties: ^Physical_Device_Memory_Properties2);
Proc_Get_Physical_Device_Sparse_Image_Format_Properties2_KHR    :: #type proc"c"(physical_device: Physical_Device, format_info: ^Physical_Device_Sparse_Image_Format_Info2, property_count: ^u32, properties: ^Sparse_Image_Format_Properties2);
Proc_Get_Device_Group_Peer_Memory_Features_KHR                  :: #type proc"c"(device: Device, heap_index: u32, local_device_index: u32, remote_device_index: u32, peer_memory_features: ^Peer_Memory_Feature_Flags);
Proc_Cmd_Set_Device_Mask_KHR                                    :: #type proc"c"(command_buffer: Command_Buffer, device_mask: u32);
Proc_Cmd_Dispatch_Base_KHR                                      :: #type proc"c"(command_buffer: Command_Buffer, base_group_x: u32, base_group_y: u32, base_group_z: u32, group_count_x: u32, group_count_y: u32, group_count_z: u32);
Proc_Trim_Command_Pool_KHR                                      :: #type proc"c"(device: Device, command_pool: Command_Pool, flags: Command_Pool_Trim_Flags);
Proc_Enumerate_Physical_Device_Groups_KHR                       :: #type proc"c"(instance: Instance, physical_device_group_count: ^u32, physical_device_group_properties: ^Physical_Device_Group_Properties) -> Result;
Proc_Get_Physical_Device_External_Buffer_Properties_KHR         :: #type proc"c"(physical_device: Physical_Device, external_buffer_info: ^Physical_Device_External_Buffer_Info, external_buffer_properties: ^External_Buffer_Properties);
Proc_Get_Memory_Fd_KHR                                          :: #type proc"c"(device: Device, get_fd_info: ^Memory_Get_Fd_Info_KHR, fd: ^c.int) -> Result;
Proc_Get_Memory_Fd_Properties_KHR                               :: #type proc"c"(device: Device, handle_type: External_Memory_Handle_Type_Flags, fd: c.int, memory_fd_properties: ^Memory_Fd_Properties_KHR) -> Result;
Proc_Get_Physical_Device_External_Semaphore_Properties_KHR      :: #type proc"c"(physical_device: Physical_Device, external_semaphore_info: ^Physical_Device_External_Semaphore_Info, external_semaphore_properties: ^External_Semaphore_Properties);
Proc_Import_Semaphore_Fd_KHR                                    :: #type proc"c"(device: Device, import_semaphore_fd_info: ^Import_Semaphore_Fd_Info_KHR) -> Result;
Proc_Get_Semaphore_Fd_KHR                                       :: #type proc"c"(device: Device, get_fd_info: ^Semaphore_Get_Fd_Info_KHR, fd: ^c.int) -> Result;
Proc_Cmd_Push_Descriptor_Set_KHR                                :: #type proc"c"(command_buffer: Command_Buffer, pipeline_bind_point: Pipeline_Bind_Point, layout: Pipeline_Layout, set: u32, descriptor_write_count: u32, descriptor_writes: ^Write_Descriptor_Set);
Proc_Cmd_Push_Descriptor_Set_With_Template_KHR                  :: #type proc"c"(command_buffer: Command_Buffer, descriptor_update_template: Descriptor_Update_Template, layout: Pipeline_Layout, set: u32, data: rawptr);
Proc_Create_Descriptor_Update_Template_KHR                      :: #type proc"c"(device: Device, create_info: ^Descriptor_Update_Template_Create_Info, allocator: ^Allocation_Callbacks, descriptor_update_template: ^Descriptor_Update_Template) -> Result;
Proc_Destroy_Descriptor_Update_Template_KHR                     :: #type proc"c"(device: Device, descriptor_update_template: Descriptor_Update_Template, allocator: ^Allocation_Callbacks);
Proc_Update_Descriptor_Set_With_Template_KHR                    :: #type proc"c"(device: Device, descriptor_set: Descriptor_Set, descriptor_update_template: Descriptor_Update_Template, data: rawptr);
Proc_Create_Render_Pass2_KHR                                    :: #type proc"c"(device: Device, create_info: ^Render_Pass_Create_Info2_KHR, allocator: ^Allocation_Callbacks, render_pass: ^Render_Pass) -> Result;
Proc_Cmd_Begin_Render_Pass2_KHR                                 :: #type proc"c"(command_buffer: Command_Buffer, render_pass_begin: ^Render_Pass_Begin_Info, subpass_begin_info: ^Subpass_Begin_Info_KHR);
Proc_Cmd_Next_Subpass2_KHR                                      :: #type proc"c"(command_buffer: Command_Buffer, subpass_begin_info: ^Subpass_Begin_Info_KHR, subpass_end_info: ^Subpass_End_Info_KHR);
Proc_Cmd_End_Render_Pass2_KHR                                   :: #type proc"c"(command_buffer: Command_Buffer, subpass_end_info: ^Subpass_End_Info_KHR);
Proc_Get_Swapchain_Status_KHR                                   :: #type proc"c"(device: Device, swapchain: Swapchain_KHR) -> Result;
Proc_Get_Physical_Device_External_Fence_Properties_KHR          :: #type proc"c"(physical_device: Physical_Device, external_fence_info: ^Physical_Device_External_Fence_Info, external_fence_properties: ^External_Fence_Properties);
Proc_Import_Fence_Fd_KHR                                        :: #type proc"c"(device: Device, import_fence_fd_info: ^Import_Fence_Fd_Info_KHR) -> Result;
Proc_Get_Fence_Fd_KHR                                           :: #type proc"c"(device: Device, get_fd_info: ^Fence_Get_Fd_Info_KHR, fd: ^c.int) -> Result;
Proc_Get_Physical_Device_Surface_Capabilities2_KHR              :: #type proc"c"(physical_device: Physical_Device, surface_info: ^Physical_Device_Surface_Info2_KHR, surface_capabilities: ^Surface_Capabilities2_KHR) -> Result;
Proc_Get_Physical_Device_Surface_Formats2_KHR                   :: #type proc"c"(physical_device: Physical_Device, surface_info: ^Physical_Device_Surface_Info2_KHR, surface_format_count: ^u32, surface_formats: ^Surface_Format2_KHR) -> Result;
Proc_Get_Physical_Device_Display_Properties2_KHR                :: #type proc"c"(physical_device: Physical_Device, property_count: ^u32, properties: ^Display_Properties2_KHR) -> Result;
Proc_Get_Physical_Device_Display_Plane_Properties2_KHR          :: #type proc"c"(physical_device: Physical_Device, property_count: ^u32, properties: ^Display_Plane_Properties2_KHR) -> Result;
Proc_Get_Display_Mode_Properties2_KHR                           :: #type proc"c"(physical_device: Physical_Device, display: Display_KHR, property_count: ^u32, properties: ^Display_Mode_Properties2_KHR) -> Result;
Proc_Get_Display_Plane_Capabilities2_KHR                        :: #type proc"c"(physical_device: Physical_Device, display_plane_info: ^Display_Plane_Info2_KHR, capabilities: ^Display_Plane_Capabilities2_KHR) -> Result;
Proc_Get_Image_Memory_Requirements2_KHR                         :: #type proc"c"(device: Device, info: ^Image_Memory_Requirements_Info2, memory_requirements: ^Memory_Requirements2);
Proc_Get_Buffer_Memory_Requirements2_KHR                        :: #type proc"c"(device: Device, info: ^Buffer_Memory_Requirements_Info2, memory_requirements: ^Memory_Requirements2);
Proc_Get_Image_Sparse_Memory_Requirements2_KHR                  :: #type proc"c"(device: Device, info: ^Image_Sparse_Memory_Requirements_Info2, sparse_memory_requirement_count: ^u32, sparse_memory_requirements: ^Sparse_Image_Memory_Requirements2);
Proc_Create_Sampler_Ycbcr_Conversion_KHR                        :: #type proc"c"(device: Device, create_info: ^Sampler_Ycbcr_Conversion_Create_Info, allocator: ^Allocation_Callbacks, ycbcr_conversion: ^Sampler_Ycbcr_Conversion) -> Result;
Proc_Destroy_Sampler_Ycbcr_Conversion_KHR                       :: #type proc"c"(device: Device, ycbcr_conversion: Sampler_Ycbcr_Conversion, allocator: ^Allocation_Callbacks);
Proc_Bind_Buffer_Memory2_KHR                                    :: #type proc"c"(device: Device, bind_info_count: u32, bind_infos: ^Bind_Buffer_Memory_Info) -> Result;
Proc_Bind_Image_Memory2_KHR                                     :: #type proc"c"(device: Device, bind_info_count: u32, bind_infos: ^Bind_Image_Memory_Info) -> Result;
Proc_Get_Descriptor_Set_Layout_Support_KHR                      :: #type proc"c"(device: Device, create_info: ^Descriptor_Set_Layout_Create_Info, support: ^Descriptor_Set_Layout_Support);
Proc_Cmd_Draw_Indirect_Count_KHR                                :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, count_buffer: Buffer, count_buffer_offset: Device_Size, max_draw_count: u32, stride: u32);
Proc_Cmd_Draw_Indexed_Indirect_Count_KHR                        :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, count_buffer: Buffer, count_buffer_offset: Device_Size, max_draw_count: u32, stride: u32);
Proc_Debug_Report_Callback_EXT                                  :: #type proc"c"(flags: Debug_Report_Flags_EXT, object_type: Debug_Report_Object_Type_EXT, object: u64, location: int, message_code: i32, layer_prefix: cstring, message: cstring, user_data: rawptr) -> b32;
Proc_Create_Debug_Report_Callback_EXT                           :: #type proc"c"(instance: Instance, create_info: ^Debug_Report_Callback_Create_Info_EXT, allocator: ^Allocation_Callbacks, callback: ^Debug_Report_Callback_EXT) -> Result;
Proc_Destroy_Debug_Report_Callback_EXT                          :: #type proc"c"(instance: Instance, callback: Debug_Report_Callback_EXT, allocator: ^Allocation_Callbacks);
Proc_Debug_Report_Message_EXT                                   :: #type proc"c"(instance: Instance, flags: Debug_Report_Flags_EXT, object_type: Debug_Report_Object_Type_EXT, object: u64, location: int, message_code: i32, layer_prefix: cstring, message: cstring);
Proc_Debug_Marker_Set_Object_Tag_EXT                            :: #type proc"c"(device: Device, tag_info: ^Debug_Marker_Object_Tag_Info_EXT) -> Result;
Proc_Debug_Marker_Set_Object_Name_EXT                           :: #type proc"c"(device: Device, name_info: ^Debug_Marker_Object_Name_Info_EXT) -> Result;
Proc_Cmd_Debug_Marker_Begin_EXT                                 :: #type proc"c"(command_buffer: Command_Buffer, marker_info: ^Debug_Marker_Marker_Info_EXT);
Proc_Cmd_Debug_Marker_End_EXT                                   :: #type proc"c"(command_buffer: Command_Buffer);
Proc_Cmd_Debug_Marker_Insert_EXT                                :: #type proc"c"(command_buffer: Command_Buffer, marker_info: ^Debug_Marker_Marker_Info_EXT);
Proc_Cmd_Bind_Transform_Feedback_Buffers_EXT                    :: #type proc"c"(command_buffer: Command_Buffer, first_binding: u32, binding_count: u32, buffers: ^Buffer, offsets: ^Device_Size, sizes: ^Device_Size);
Proc_Cmd_Begin_Transform_Feedback_EXT                           :: #type proc"c"(command_buffer: Command_Buffer, first_counter_buffer: u32, counter_buffer_count: u32, counter_buffers: ^Buffer, counter_buffer_offsets: ^Device_Size);
Proc_Cmd_End_Transform_Feedback_EXT                             :: #type proc"c"(command_buffer: Command_Buffer, first_counter_buffer: u32, counter_buffer_count: u32, counter_buffers: ^Buffer, counter_buffer_offsets: ^Device_Size);
Proc_Cmd_Begin_Query_Indexed_EXT                                :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, query: u32, flags: Query_Control_Flags, index: u32);
Proc_Cmd_End_Query_Indexed_EXT                                  :: #type proc"c"(command_buffer: Command_Buffer, query_pool: Query_Pool, query: u32, index: u32);
Proc_Cmd_Draw_Indirect_Byte_Count_EXT                           :: #type proc"c"(command_buffer: Command_Buffer, instance_count: u32, first_instance: u32, counter_buffer: Buffer, counter_buffer_offset: Device_Size, counter_offset: u32, vertex_stride: u32);
Proc_Cmd_Draw_Indirect_Count_AMD                                :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, count_buffer: Buffer, count_buffer_offset: Device_Size, max_draw_count: u32, stride: u32);
Proc_Cmd_Draw_Indexed_Indirect_Count_AMD                        :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, count_buffer: Buffer, count_buffer_offset: Device_Size, max_draw_count: u32, stride: u32);
Proc_Get_Shader_Info_AMD                                        :: #type proc"c"(device: Device, pipeline: Pipeline, shader_stage: Shader_Stage_Flags, info_type: Shader_Info_Type_AMD, info_size: ^int, info: rawptr) -> Result;
Proc_Get_Physical_Device_External_Image_Format_Properties_NV    :: #type proc"c"(physical_device: Physical_Device, format: Format, type: Image_Type, tiling: Image_Tiling, usage: Image_Usage_Flags, flags: Image_Create_Flags, external_handle_type: External_Memory_Handle_Type_Flags_NV, external_image_format_properties: ^External_Image_Format_Properties_NV) -> Result;
Proc_Cmd_Begin_Conditional_Rendering_EXT                        :: #type proc"c"(command_buffer: Command_Buffer, conditional_rendering_begin: ^Conditional_Rendering_Begin_Info_EXT);
Proc_Cmd_End_Conditional_Rendering_EXT                          :: #type proc"c"(command_buffer: Command_Buffer);
Proc_Cmd_Process_Commands_NVX                                   :: #type proc"c"(command_buffer: Command_Buffer, process_commands_info: ^Cmd_Process_Commands_Info_NVX);
Proc_Cmd_Reserve_Space_For_Commands_NVX                         :: #type proc"c"(command_buffer: Command_Buffer, reserve_space_info: ^Cmd_Reserve_Space_For_Commands_Info_NVX);
Proc_Create_Indirect_Commands_Layout_NVX                        :: #type proc"c"(device: Device, create_info: ^Indirect_Commands_Layout_Create_Info_NVX, allocator: ^Allocation_Callbacks, indirect_commands_layout: ^Indirect_Commands_Layout_NVX) -> Result;
Proc_Destroy_Indirect_Commands_Layout_NVX                       :: #type proc"c"(device: Device, indirect_commands_layout: Indirect_Commands_Layout_NVX, allocator: ^Allocation_Callbacks);
Proc_Create_Object_Table_NVX                                    :: #type proc"c"(device: Device, create_info: ^Object_Table_Create_Info_NVX, allocator: ^Allocation_Callbacks, object_table: ^Object_Table_NVX) -> Result;
Proc_Destroy_Object_Table_NVX                                   :: #type proc"c"(device: Device, object_table: Object_Table_NVX, allocator: ^Allocation_Callbacks);
Proc_Register_Objects_NVX                                       :: #type proc"c"(device: Device, object_table: Object_Table_NVX, object_count: u32, object_table_entries: ^^Object_Table_Entry_NVX, object_indices: ^u32) -> Result;
Proc_Unregister_Objects_NVX                                     :: #type proc"c"(device: Device, object_table: Object_Table_NVX, object_count: u32, object_entry_types: ^Object_Entry_Type_NVX, object_indices: ^u32) -> Result;
Proc_Get_Physical_Device_Generated_Commands_Properties_NVX      :: #type proc"c"(physical_device: Physical_Device, features: ^Device_Generated_Commands_Features_NVX, limits: ^Device_Generated_Commands_Limits_NVX);
Proc_Cmd_Set_Viewport_W_Scaling_NV                              :: #type proc"c"(command_buffer: Command_Buffer, first_viewport: u32, viewport_count: u32, viewport_w_scalings: ^Viewport_W_Scaling_NV);
Proc_Release_Display_EXT                                        :: #type proc"c"(physical_device: Physical_Device, display: Display_KHR) -> Result;
Proc_Get_Physical_Device_Surface_Capabilities2_EXT              :: #type proc"c"(physical_device: Physical_Device, surface: Surface_KHR, surface_capabilities: ^Surface_Capabilities2_EXT) -> Result;
Proc_Display_Power_Control_EXT                                  :: #type proc"c"(device: Device, display: Display_KHR, display_power_info: ^Display_Power_Info_EXT) -> Result;
Proc_Register_Device_Event_EXT                                  :: #type proc"c"(device: Device, device_event_info: ^Device_Event_Info_EXT, allocator: ^Allocation_Callbacks, fence: ^Fence) -> Result;
Proc_Register_Display_Event_EXT                                 :: #type proc"c"(device: Device, display: Display_KHR, display_event_info: ^Display_Event_Info_EXT, allocator: ^Allocation_Callbacks, fence: ^Fence) -> Result;
Proc_Get_Swapchain_Counter_EXT                                  :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, counter: Surface_Counter_Flags_EXT, counter_value: ^u64) -> Result;
Proc_Get_Refresh_Cycle_Duration_GOOGLE                          :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, display_timing_properties: ^Refresh_Cycle_Duration_GOOGLE) -> Result;
Proc_Get_Past_Presentation_Timing_GOOGLE                        :: #type proc"c"(device: Device, swapchain: Swapchain_KHR, presentation_timing_count: ^u32, presentation_timings: ^Past_Presentation_Timing_GOOGLE) -> Result;
Proc_Cmd_Set_Discard_Rectangle_EXT                              :: #type proc"c"(command_buffer: Command_Buffer, first_discard_rectangle: u32, discard_rectangle_count: u32, discard_rectangles: ^Rect2D);
Proc_Set_Hdr_Metadata_EXT                                       :: #type proc"c"(device: Device, swapchain_count: u32, swapchains: ^Swapchain_KHR, metadata: ^Hdr_Metadata_EXT);
Proc_Debug_Utils_Messenger_Callback_EXT                         :: #type proc"c"(message_severity: Debug_Utils_Message_Severity_Flags_EXT, message_types: Debug_Utils_Message_Type_Flags_EXT, callback_data: ^Debug_Utils_Messenger_Callback_Data_EXT, user_data: rawptr) -> b32;
Proc_Set_Debug_Utils_Object_Name_EXT                            :: #type proc"c"(device: Device, name_info: ^Debug_Utils_Object_Name_Info_EXT) -> Result;
Proc_Set_Debug_Utils_Object_Tag_EXT                             :: #type proc"c"(device: Device, tag_info: ^Debug_Utils_Object_Tag_Info_EXT) -> Result;
Proc_Queue_Begin_Debug_Utils_Label_EXT                          :: #type proc"c"(queue: Queue, label_info: ^Debug_Utils_Label_EXT);
Proc_Queue_End_Debug_Utils_Label_EXT                            :: #type proc"c"(queue: Queue);
Proc_Queue_Insert_Debug_Utils_Label_EXT                         :: #type proc"c"(queue: Queue, label_info: ^Debug_Utils_Label_EXT);
Proc_Cmd_Begin_Debug_Utils_Label_EXT                            :: #type proc"c"(command_buffer: Command_Buffer, label_info: ^Debug_Utils_Label_EXT);
Proc_Cmd_End_Debug_Utils_Label_EXT                              :: #type proc"c"(command_buffer: Command_Buffer);
Proc_Cmd_Insert_Debug_Utils_Label_EXT                           :: #type proc"c"(command_buffer: Command_Buffer, label_info: ^Debug_Utils_Label_EXT);
Proc_Create_Debug_Utils_Messenger_EXT                           :: #type proc"c"(instance: Instance, create_info: ^Debug_Utils_Messenger_Create_Info_EXT, allocator: ^Allocation_Callbacks, messenger: ^Debug_Utils_Messenger_EXT) -> Result;
Proc_Destroy_Debug_Utils_Messenger_EXT                          :: #type proc"c"(instance: Instance, messenger: Debug_Utils_Messenger_EXT, allocator: ^Allocation_Callbacks);
Proc_Submit_Debug_Utils_Message_EXT                             :: #type proc"c"(instance: Instance, message_severity: Debug_Utils_Message_Severity_Flags_EXT, message_types: Debug_Utils_Message_Type_Flags_EXT, callback_data: ^Debug_Utils_Messenger_Callback_Data_EXT);
Proc_Cmd_Set_Sample_Locations_EXT                               :: #type proc"c"(command_buffer: Command_Buffer, sample_locations_info: ^Sample_Locations_Info_EXT);
Proc_Get_Physical_Device_Multisample_Properties_EXT             :: #type proc"c"(physical_device: Physical_Device, samples: Sample_Count_Flags, multisample_properties: ^Multisample_Properties_EXT);
Proc_Get_Image_Drm_Format_Modifier_Properties_EXT               :: #type proc"c"(device: Device, image: Image, properties: ^Image_Drm_Format_Modifier_Properties_EXT) -> Result;
Proc_Create_Validation_Cache_EXT                                :: #type proc"c"(device: Device, create_info: ^Validation_Cache_Create_Info_EXT, allocator: ^Allocation_Callbacks, validation_cache: ^Validation_Cache_EXT) -> Result;
Proc_Destroy_Validation_Cache_EXT                               :: #type proc"c"(device: Device, validation_cache: Validation_Cache_EXT, allocator: ^Allocation_Callbacks);
Proc_Merge_Validation_Caches_EXT                                :: #type proc"c"(device: Device, dst_cache: Validation_Cache_EXT, src_cache_count: u32, src_caches: ^Validation_Cache_EXT) -> Result;
Proc_Get_Validation_Cache_Data_EXT                              :: #type proc"c"(device: Device, validation_cache: Validation_Cache_EXT, data_size: ^int, data: rawptr) -> Result;
Proc_Cmd_Bind_Shading_Rate_Image_NV                             :: #type proc"c"(command_buffer: Command_Buffer, image_view: Image_View, image_layout: Image_Layout);
Proc_Cmd_Set_Viewport_Shading_Rate_Palette_NV                   :: #type proc"c"(command_buffer: Command_Buffer, first_viewport: u32, viewport_count: u32, shading_rate_palettes: ^Shading_Rate_Palette_NV);
Proc_Cmd_Set_Coarse_Sample_Order_NV                             :: #type proc"c"(command_buffer: Command_Buffer, sample_order_type: Coarse_Sample_Order_Type_NV, custom_sample_order_count: u32, custom_sample_orders: ^Coarse_Sample_Order_Custom_NV);
Proc_Create_Acceleration_Structure_NVX                          :: #type proc"c"(device: Device, create_info: ^Acceleration_Structure_Create_Info_NVX, allocator: ^Allocation_Callbacks, acceleration_structure: ^Acceleration_Structure_NVX) -> Result;
Proc_Destroy_Acceleration_Structure_NVX                         :: #type proc"c"(device: Device, acceleration_structure: Acceleration_Structure_NVX, allocator: ^Allocation_Callbacks);
Proc_Get_Acceleration_Structure_Memory_Requirements_NVX         :: #type proc"c"(device: Device, info: ^Acceleration_Structure_Memory_Requirements_Info_NVX, memory_requirements: ^Memory_Requirements2_KHR);
Proc_Get_Acceleration_Structure_Scratch_Memory_Requirements_NVX :: #type proc"c"(device: Device, info: ^Acceleration_Structure_Memory_Requirements_Info_NVX, memory_requirements: ^Memory_Requirements2_KHR);
Proc_Bind_Acceleration_Structure_Memory_NVX                     :: #type proc"c"(device: Device, bind_info_count: u32, bind_infos: ^Bind_Acceleration_Structure_Memory_Info_NVX) -> Result;
Proc_Cmd_Build_Acceleration_Structure_NVX                       :: #type proc"c"(command_buffer: Command_Buffer, type: Acceleration_Structure_Type_NVX, instance_count: u32, instance_data: Buffer, instance_offset: Device_Size, geometry_count: u32, geometries: ^Geometry_NVX, flags: Build_Acceleration_Structure_Flags_NVX, update: b32, dst: Acceleration_Structure_NVX, src: Acceleration_Structure_NVX, scratch: Buffer, scratch_offset: Device_Size);
Proc_Cmd_Copy_Acceleration_Structure_NVX                        :: #type proc"c"(command_buffer: Command_Buffer, dst: Acceleration_Structure_NVX, src: Acceleration_Structure_NVX, mode: Copy_Acceleration_Structure_Mode_NVX);
Proc_Cmd_Trace_Rays_NVX                                         :: #type proc"c"(command_buffer: Command_Buffer, raygen_shader_binding_table_buffer: Buffer, raygen_shader_binding_offset: Device_Size, miss_shader_binding_table_buffer: Buffer, miss_shader_binding_offset: Device_Size, miss_shader_binding_stride: Device_Size, hit_shader_binding_table_buffer: Buffer, hit_shader_binding_offset: Device_Size, hit_shader_binding_stride: Device_Size, width: u32, height: u32);
Proc_Create_Raytracing_Pipelines_NVX                            :: #type proc"c"(device: Device, pipeline_cache: Pipeline_Cache, create_info_count: u32, create_infos: ^Raytracing_Pipeline_Create_Info_NVX, allocator: ^Allocation_Callbacks, pipelines: ^Pipeline) -> Result;
Proc_Get_Raytracing_Shader_Handles_NVX                          :: #type proc"c"(device: Device, pipeline: Pipeline, first_group: u32, group_count: u32, data_size: int, data: rawptr) -> Result;
Proc_Get_Acceleration_Structure_Handle_NVX                      :: #type proc"c"(device: Device, acceleration_structure: Acceleration_Structure_NVX, data_size: int, data: rawptr) -> Result;
Proc_Cmd_Write_Acceleration_Structure_Properties_NVX            :: #type proc"c"(command_buffer: Command_Buffer, acceleration_structure: Acceleration_Structure_NVX, query_type: Query_Type, query_pool: Query_Pool, query: u32);
Proc_Compile_Deferred_NVX                                       :: #type proc"c"(device: Device, pipeline: Pipeline, shader: u32) -> Result;
Proc_Get_Memory_Host_Pointer_Properties_EXT                     :: #type proc"c"(device: Device, handle_type: External_Memory_Handle_Type_Flags, host_pointer: rawptr, memory_host_pointer_properties: ^Memory_Host_Pointer_Properties_EXT) -> Result;
Proc_Cmd_Write_Buffer_Marker_AMD                                :: #type proc"c"(command_buffer: Command_Buffer, pipeline_stage: Pipeline_Stage_Flags, dst_buffer: Buffer, dst_offset: Device_Size, marker: u32);
Proc_Get_Physical_Device_Calibrateable_Time_Domains_EXT         :: #type proc"c"(physical_device: Physical_Device, time_domain_count: ^u32, time_domains: ^Time_Domain_EXT) -> Result;
Proc_Get_Calibrated_Timestamps_EXT                              :: #type proc"c"(device: Device, timestamp_count: u32, timestamp_infos: ^Calibrated_Timestamp_Info_EXT, timestamps: ^u64, max_deviation: ^u64) -> Result;
Proc_Cmd_Draw_Mesh_Tasks_NV                                     :: #type proc"c"(command_buffer: Command_Buffer, task_count: u32, first_task: u32);
Proc_Cmd_Draw_Mesh_Tasks_Indirect_NV                            :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, draw_count: u32, stride: u32);
Proc_Cmd_Draw_Mesh_Tasks_Indirect_Count_NV                      :: #type proc"c"(command_buffer: Command_Buffer, buffer: Buffer, offset: Device_Size, count_buffer: Buffer, count_buffer_offset: Device_Size, max_draw_count: u32, stride: u32);
Proc_Cmd_Set_Exclusive_Scissor_NV                               :: #type proc"c"(command_buffer: Command_Buffer, first_exclusive_scissor: u32, exclusive_scissor_count: u32, exclusive_scissors: ^Rect2D);
Proc_Cmd_Set_Checkpoint_NV                                      :: #type proc"c"(command_buffer: Command_Buffer, checkpoint_marker: rawptr);
Proc_Get_Queue_Checkpoint_Data_NV                               :: #type proc"c"(queue: Queue, checkpoint_data_count: ^u32, checkpoint_data: ^Checkpoint_Data_NV);


// Instance Procedures
destroy_instance:                     Proc_Destroy_Instance;
enumerate_physical_devices:           Proc_Enumerate_Physical_Devices;
get_instance_proc_addr:               Proc_Get_Instance_Proc_Addr;
enumerate_physical_device_groups:     Proc_Enumerate_Physical_Device_Groups;
destroy_surface_khr:                  Proc_Destroy_Surface_KHR;
create_display_plane_surface_khr:     Proc_Create_Display_Plane_Surface_KHR;
enumerate_physical_device_groups_khr: Proc_Enumerate_Physical_Device_Groups_KHR;
create_debug_report_callback_ext:     Proc_Create_Debug_Report_Callback_EXT;
destroy_debug_report_callback_ext:    Proc_Destroy_Debug_Report_Callback_EXT;
debug_report_message_ext:             Proc_Debug_Report_Message_EXT;
create_debug_utils_messenger_ext:     Proc_Create_Debug_Utils_Messenger_EXT;
destroy_debug_utils_messenger_ext:    Proc_Destroy_Debug_Utils_Messenger_EXT;
submit_debug_utils_message_ext:       Proc_Submit_Debug_Utils_Message_EXT;

// Device Procedures
get_device_proc_addr:                                       Proc_Get_Device_Proc_Addr;
destroy_device:                                             Proc_Destroy_Device;
get_device_queue:                                           Proc_Get_Device_Queue;
queue_submit:                                               Proc_Queue_Submit;
queue_wait_idle:                                            Proc_Queue_Wait_Idle;
device_wait_idle:                                           Proc_Device_Wait_Idle;
allocate_memory:                                            Proc_Allocate_Memory;
free_memory:                                                Proc_Free_Memory;
map_memory:                                                 Proc_Map_Memory;
unmap_memory:                                               Proc_Unmap_Memory;
flush_mapped_memory_ranges:                                 Proc_Flush_Mapped_Memory_Ranges;
invalidate_mapped_memory_ranges:                            Proc_Invalidate_Mapped_Memory_Ranges;
get_device_memory_commitment:                               Proc_Get_Device_Memory_Commitment;
bind_buffer_memory:                                         Proc_Bind_Buffer_Memory;
bind_image_memory:                                          Proc_Bind_Image_Memory;
get_buffer_memory_requirements:                             Proc_Get_Buffer_Memory_Requirements;
get_image_memory_requirements:                              Proc_Get_Image_Memory_Requirements;
get_image_sparse_memory_requirements:                       Proc_Get_Image_Sparse_Memory_Requirements;
queue_bind_sparse:                                          Proc_Queue_Bind_Sparse;
create_fence:                                               Proc_Create_Fence;
destroy_fence:                                              Proc_Destroy_Fence;
reset_fences:                                               Proc_Reset_Fences;
get_fence_status:                                           Proc_Get_Fence_Status;
wait_for_fences:                                            Proc_Wait_For_Fences;
create_semaphore:                                           Proc_Create_Semaphore;
destroy_semaphore:                                          Proc_Destroy_Semaphore;
create_event:                                               Proc_Create_Event;
destroy_event:                                              Proc_Destroy_Event;
get_event_status:                                           Proc_Get_Event_Status;
set_event:                                                  Proc_Set_Event;
reset_event:                                                Proc_Reset_Event;
create_query_pool:                                          Proc_Create_Query_Pool;
destroy_query_pool:                                         Proc_Destroy_Query_Pool;
get_query_pool_results:                                     Proc_Get_Query_Pool_Results;
create_buffer:                                              Proc_Create_Buffer;
destroy_buffer:                                             Proc_Destroy_Buffer;
create_buffer_view:                                         Proc_Create_Buffer_View;
destroy_buffer_view:                                        Proc_Destroy_Buffer_View;
create_image:                                               Proc_Create_Image;
destroy_image:                                              Proc_Destroy_Image;
get_image_subresource_layout:                               Proc_Get_Image_Subresource_Layout;
create_image_view:                                          Proc_Create_Image_View;
destroy_image_view:                                         Proc_Destroy_Image_View;
create_shader_module:                                       Proc_Create_Shader_Module;
destroy_shader_module:                                      Proc_Destroy_Shader_Module;
create_pipeline_cache:                                      Proc_Create_Pipeline_Cache;
destroy_pipeline_cache:                                     Proc_Destroy_Pipeline_Cache;
get_pipeline_cache_data:                                    Proc_Get_Pipeline_Cache_Data;
merge_pipeline_caches:                                      Proc_Merge_Pipeline_Caches;
create_graphics_pipelines:                                  Proc_Create_Graphics_Pipelines;
create_compute_pipelines:                                   Proc_Create_Compute_Pipelines;
destroy_pipeline:                                           Proc_Destroy_Pipeline;
create_pipeline_layout:                                     Proc_Create_Pipeline_Layout;
destroy_pipeline_layout:                                    Proc_Destroy_Pipeline_Layout;
create_sampler:                                             Proc_Create_Sampler;
destroy_sampler:                                            Proc_Destroy_Sampler;
create_descriptor_set_layout:                               Proc_Create_Descriptor_Set_Layout;
destroy_descriptor_set_layout:                              Proc_Destroy_Descriptor_Set_Layout;
create_descriptor_pool:                                     Proc_Create_Descriptor_Pool;
destroy_descriptor_pool:                                    Proc_Destroy_Descriptor_Pool;
reset_descriptor_pool:                                      Proc_Reset_Descriptor_Pool;
allocate_descriptor_sets:                                   Proc_Allocate_Descriptor_Sets;
free_descriptor_sets:                                       Proc_Free_Descriptor_Sets;
update_descriptor_sets:                                     Proc_Update_Descriptor_Sets;
create_framebuffer:                                         Proc_Create_Framebuffer;
destroy_framebuffer:                                        Proc_Destroy_Framebuffer;
create_render_pass:                                         Proc_Create_Render_Pass;
destroy_render_pass:                                        Proc_Destroy_Render_Pass;
get_render_area_granularity:                                Proc_Get_Render_Area_Granularity;
create_command_pool:                                        Proc_Create_Command_Pool;
destroy_command_pool:                                       Proc_Destroy_Command_Pool;
reset_command_pool:                                         Proc_Reset_Command_Pool;
allocate_command_buffers:                                   Proc_Allocate_Command_Buffers;
free_command_buffers:                                       Proc_Free_Command_Buffers;
bind_buffer_memory2:                                        Proc_Bind_Buffer_Memory2;
bind_image_memory2:                                         Proc_Bind_Image_Memory2;
get_device_group_peer_memory_features:                      Proc_Get_Device_Group_Peer_Memory_Features;
get_image_memory_requirements2:                             Proc_Get_Image_Memory_Requirements2;
get_buffer_memory_requirements2:                            Proc_Get_Buffer_Memory_Requirements2;
get_image_sparse_memory_requirements2:                      Proc_Get_Image_Sparse_Memory_Requirements2;
trim_command_pool:                                          Proc_Trim_Command_Pool;
get_device_queue2:                                          Proc_Get_Device_Queue2;
create_sampler_ycbcr_conversion:                            Proc_Create_Sampler_Ycbcr_Conversion;
destroy_sampler_ycbcr_conversion:                           Proc_Destroy_Sampler_Ycbcr_Conversion;
create_descriptor_update_template:                          Proc_Create_Descriptor_Update_Template;
destroy_descriptor_update_template:                         Proc_Destroy_Descriptor_Update_Template;
update_descriptor_set_with_template:                        Proc_Update_Descriptor_Set_With_Template;
get_descriptor_set_layout_support:                          Proc_Get_Descriptor_Set_Layout_Support;
create_swapchain_khr:                                       Proc_Create_Swapchain_KHR;
destroy_swapchain_khr:                                      Proc_Destroy_Swapchain_KHR;
get_swapchain_images_khr:                                   Proc_Get_Swapchain_Images_KHR;
acquire_next_image_khr:                                     Proc_Acquire_Next_Image_KHR;
queue_present_khr:                                          Proc_Queue_Present_KHR;
get_device_group_present_capabilities_khr:                  Proc_Get_Device_Group_Present_Capabilities_KHR;
get_device_group_surface_present_modes_khr:                 Proc_Get_Device_Group_Surface_Present_Modes_KHR;
acquire_next_image2_khr:                                    Proc_Acquire_Next_Image2_KHR;
create_shared_swapchains_khr:                               Proc_Create_Shared_Swapchains_KHR;
get_device_group_peer_memory_features_khr:                  Proc_Get_Device_Group_Peer_Memory_Features_KHR;
trim_command_pool_khr:                                      Proc_Trim_Command_Pool_KHR;
get_memory_fd_khr:                                          Proc_Get_Memory_Fd_KHR;
get_memory_fd_properties_khr:                               Proc_Get_Memory_Fd_Properties_KHR;
import_semaphore_fd_khr:                                    Proc_Import_Semaphore_Fd_KHR;
get_semaphore_fd_khr:                                       Proc_Get_Semaphore_Fd_KHR;
create_descriptor_update_template_khr:                      Proc_Create_Descriptor_Update_Template_KHR;
destroy_descriptor_update_template_khr:                     Proc_Destroy_Descriptor_Update_Template_KHR;
update_descriptor_set_with_template_khr:                    Proc_Update_Descriptor_Set_With_Template_KHR;
create_render_pass2_khr:                                    Proc_Create_Render_Pass2_KHR;
get_swapchain_status_khr:                                   Proc_Get_Swapchain_Status_KHR;
import_fence_fd_khr:                                        Proc_Import_Fence_Fd_KHR;
get_fence_fd_khr:                                           Proc_Get_Fence_Fd_KHR;
get_image_memory_requirements2_khr:                         Proc_Get_Image_Memory_Requirements2_KHR;
get_buffer_memory_requirements2_khr:                        Proc_Get_Buffer_Memory_Requirements2_KHR;
get_image_sparse_memory_requirements2_khr:                  Proc_Get_Image_Sparse_Memory_Requirements2_KHR;
create_sampler_ycbcr_conversion_khr:                        Proc_Create_Sampler_Ycbcr_Conversion_KHR;
destroy_sampler_ycbcr_conversion_khr:                       Proc_Destroy_Sampler_Ycbcr_Conversion_KHR;
bind_buffer_memory2_khr:                                    Proc_Bind_Buffer_Memory2_KHR;
bind_image_memory2_khr:                                     Proc_Bind_Image_Memory2_KHR;
get_descriptor_set_layout_support_khr:                      Proc_Get_Descriptor_Set_Layout_Support_KHR;
debug_marker_set_object_tag_ext:                            Proc_Debug_Marker_Set_Object_Tag_EXT;
debug_marker_set_object_name_ext:                           Proc_Debug_Marker_Set_Object_Name_EXT;
get_shader_info_amd:                                        Proc_Get_Shader_Info_AMD;
create_indirect_commands_layout_nvx:                        Proc_Create_Indirect_Commands_Layout_NVX;
destroy_indirect_commands_layout_nvx:                       Proc_Destroy_Indirect_Commands_Layout_NVX;
create_object_table_nvx:                                    Proc_Create_Object_Table_NVX;
destroy_object_table_nvx:                                   Proc_Destroy_Object_Table_NVX;
register_objects_nvx:                                       Proc_Register_Objects_NVX;
unregister_objects_nvx:                                     Proc_Unregister_Objects_NVX;
display_power_control_ext:                                  Proc_Display_Power_Control_EXT;
register_device_event_ext:                                  Proc_Register_Device_Event_EXT;
register_display_event_ext:                                 Proc_Register_Display_Event_EXT;
get_swapchain_counter_ext:                                  Proc_Get_Swapchain_Counter_EXT;
get_refresh_cycle_duration_google:                          Proc_Get_Refresh_Cycle_Duration_GOOGLE;
get_past_presentation_timing_google:                        Proc_Get_Past_Presentation_Timing_GOOGLE;
set_hdr_metadata_ext:                                       Proc_Set_Hdr_Metadata_EXT;
set_debug_utils_object_name_ext:                            Proc_Set_Debug_Utils_Object_Name_EXT;
set_debug_utils_object_tag_ext:                             Proc_Set_Debug_Utils_Object_Tag_EXT;
queue_begin_debug_utils_label_ext:                          Proc_Queue_Begin_Debug_Utils_Label_EXT;
queue_end_debug_utils_label_ext:                            Proc_Queue_End_Debug_Utils_Label_EXT;
queue_insert_debug_utils_label_ext:                         Proc_Queue_Insert_Debug_Utils_Label_EXT;
get_image_drm_format_modifier_properties_ext:               Proc_Get_Image_Drm_Format_Modifier_Properties_EXT;
create_validation_cache_ext:                                Proc_Create_Validation_Cache_EXT;
destroy_validation_cache_ext:                               Proc_Destroy_Validation_Cache_EXT;
merge_validation_caches_ext:                                Proc_Merge_Validation_Caches_EXT;
get_validation_cache_data_ext:                              Proc_Get_Validation_Cache_Data_EXT;
create_acceleration_structure_nvx:                          Proc_Create_Acceleration_Structure_NVX;
destroy_acceleration_structure_nvx:                         Proc_Destroy_Acceleration_Structure_NVX;
get_acceleration_structure_memory_requirements_nvx:         Proc_Get_Acceleration_Structure_Memory_Requirements_NVX;
get_acceleration_structure_scratch_memory_requirements_nvx: Proc_Get_Acceleration_Structure_Scratch_Memory_Requirements_NVX;
bind_acceleration_structure_memory_nvx:                     Proc_Bind_Acceleration_Structure_Memory_NVX;
create_raytracing_pipelines_nvx:                            Proc_Create_Raytracing_Pipelines_NVX;
get_raytracing_shader_handles_nvx:                          Proc_Get_Raytracing_Shader_Handles_NVX;
get_acceleration_structure_handle_nvx:                      Proc_Get_Acceleration_Structure_Handle_NVX;
compile_deferred_nvx:                                       Proc_Compile_Deferred_NVX;
get_memory_host_pointer_properties_ext:                     Proc_Get_Memory_Host_Pointer_Properties_EXT;
get_calibrated_timestamps_ext:                              Proc_Get_Calibrated_Timestamps_EXT;
get_queue_checkpoint_data_nv:                               Proc_Get_Queue_Checkpoint_Data_NV;

// Loader Procedures
create_instance:                                         Proc_Create_Instance;
get_physical_device_features:                            Proc_Get_Physical_Device_Features;
get_physical_device_format_properties:                   Proc_Get_Physical_Device_Format_Properties;
get_physical_device_image_format_properties:             Proc_Get_Physical_Device_Image_Format_Properties;
get_physical_device_properties:                          Proc_Get_Physical_Device_Properties;
get_physical_device_queue_family_properties:             Proc_Get_Physical_Device_Queue_Family_Properties;
get_physical_device_memory_properties:                   Proc_Get_Physical_Device_Memory_Properties;
create_device:                                           Proc_Create_Device;
enumerate_instance_extension_properties:                 Proc_Enumerate_Instance_Extension_Properties;
enumerate_device_extension_properties:                   Proc_Enumerate_Device_Extension_Properties;
enumerate_instance_layer_properties:                     Proc_Enumerate_Instance_Layer_Properties;
enumerate_device_layer_properties:                       Proc_Enumerate_Device_Layer_Properties;
get_physical_device_sparse_image_format_properties:      Proc_Get_Physical_Device_Sparse_Image_Format_Properties;
begin_command_buffer:                                    Proc_Begin_Command_Buffer;
end_command_buffer:                                      Proc_End_Command_Buffer;
reset_command_buffer:                                    Proc_Reset_Command_Buffer;
cmd_bind_pipeline:                                       Proc_Cmd_Bind_Pipeline;
cmd_set_viewport:                                        Proc_Cmd_Set_Viewport;
cmd_set_scissor:                                         Proc_Cmd_Set_Scissor;
cmd_set_line_width:                                      Proc_Cmd_Set_Line_Width;
cmd_set_depth_bias:                                      Proc_Cmd_Set_Depth_Bias;
cmd_set_blend_constants:                                 Proc_Cmd_Set_Blend_Constants;
cmd_set_depth_bounds:                                    Proc_Cmd_Set_Depth_Bounds;
cmd_set_stencil_compare_mask:                            Proc_Cmd_Set_Stencil_Compare_Mask;
cmd_set_stencil_write_mask:                              Proc_Cmd_Set_Stencil_Write_Mask;
cmd_set_stencil_reference:                               Proc_Cmd_Set_Stencil_Reference;
cmd_bind_descriptor_sets:                                Proc_Cmd_Bind_Descriptor_Sets;
cmd_bind_index_buffer:                                   Proc_Cmd_Bind_Index_Buffer;
cmd_bind_vertex_buffers:                                 Proc_Cmd_Bind_Vertex_Buffers;
cmd_draw:                                                Proc_Cmd_Draw;
cmd_draw_indexed:                                        Proc_Cmd_Draw_Indexed;
cmd_draw_indirect:                                       Proc_Cmd_Draw_Indirect;
cmd_draw_indexed_indirect:                               Proc_Cmd_Draw_Indexed_Indirect;
cmd_dispatch:                                            Proc_Cmd_Dispatch;
cmd_dispatch_indirect:                                   Proc_Cmd_Dispatch_Indirect;
cmd_copy_buffer:                                         Proc_Cmd_Copy_Buffer;
cmd_copy_image:                                          Proc_Cmd_Copy_Image;
cmd_blit_image:                                          Proc_Cmd_Blit_Image;
cmd_copy_buffer_to_image:                                Proc_Cmd_Copy_Buffer_To_Image;
cmd_copy_image_to_buffer:                                Proc_Cmd_Copy_Image_To_Buffer;
cmd_update_buffer:                                       Proc_Cmd_Update_Buffer;
cmd_fill_buffer:                                         Proc_Cmd_Fill_Buffer;
cmd_clear_color_image:                                   Proc_Cmd_Clear_Color_Image;
cmd_clear_depth_stencil_image:                           Proc_Cmd_Clear_Depth_Stencil_Image;
cmd_clear_attachments:                                   Proc_Cmd_Clear_Attachments;
cmd_resolve_image:                                       Proc_Cmd_Resolve_Image;
cmd_set_event:                                           Proc_Cmd_Set_Event;
cmd_reset_event:                                         Proc_Cmd_Reset_Event;
cmd_wait_events:                                         Proc_Cmd_Wait_Events;
cmd_pipeline_barrier:                                    Proc_Cmd_Pipeline_Barrier;
cmd_begin_query:                                         Proc_Cmd_Begin_Query;
cmd_end_query:                                           Proc_Cmd_End_Query;
cmd_reset_query_pool:                                    Proc_Cmd_Reset_Query_Pool;
cmd_write_timestamp:                                     Proc_Cmd_Write_Timestamp;
cmd_copy_query_pool_results:                             Proc_Cmd_Copy_Query_Pool_Results;
cmd_push_constants:                                      Proc_Cmd_Push_Constants;
cmd_begin_render_pass:                                   Proc_Cmd_Begin_Render_Pass;
cmd_next_subpass:                                        Proc_Cmd_Next_Subpass;
cmd_end_render_pass:                                     Proc_Cmd_End_Render_Pass;
cmd_execute_commands:                                    Proc_Cmd_Execute_Commands;
enumerate_instance_version:                              Proc_Enumerate_Instance_Version;
cmd_set_device_mask:                                     Proc_Cmd_Set_Device_Mask;
cmd_dispatch_base:                                       Proc_Cmd_Dispatch_Base;
get_physical_device_features2:                           Proc_Get_Physical_Device_Features2;
get_physical_device_properties2:                         Proc_Get_Physical_Device_Properties2;
get_physical_device_format_properties2:                  Proc_Get_Physical_Device_Format_Properties2;
get_physical_device_image_format_properties2:            Proc_Get_Physical_Device_Image_Format_Properties2;
get_physical_device_queue_family_properties2:            Proc_Get_Physical_Device_Queue_Family_Properties2;
get_physical_device_memory_properties2:                  Proc_Get_Physical_Device_Memory_Properties2;
get_physical_device_sparse_image_format_properties2:     Proc_Get_Physical_Device_Sparse_Image_Format_Properties2;
get_physical_device_external_buffer_properties:          Proc_Get_Physical_Device_External_Buffer_Properties;
get_physical_device_external_fence_properties:           Proc_Get_Physical_Device_External_Fence_Properties;
get_physical_device_external_semaphore_properties:       Proc_Get_Physical_Device_External_Semaphore_Properties;
get_physical_device_surface_support_khr:                 Proc_Get_Physical_Device_Surface_Support_KHR;
get_physical_device_surface_capabilities_khr:            Proc_Get_Physical_Device_Surface_Capabilities_KHR;
get_physical_device_surface_formats_khr:                 Proc_Get_Physical_Device_Surface_Formats_KHR;
get_physical_device_surface_present_modes_khr:           Proc_Get_Physical_Device_Surface_Present_Modes_KHR;
get_physical_device_present_rectangles_khr:              Proc_Get_Physical_Device_Present_Rectangles_KHR;
get_physical_device_display_properties_khr:              Proc_Get_Physical_Device_Display_Properties_KHR;
get_physical_device_display_plane_properties_khr:        Proc_Get_Physical_Device_Display_Plane_Properties_KHR;
get_display_plane_supported_displays_khr:                Proc_Get_Display_Plane_Supported_Displays_KHR;
get_display_mode_properties_khr:                         Proc_Get_Display_Mode_Properties_KHR;
create_display_mode_khr:                                 Proc_Create_Display_Mode_KHR;
get_display_plane_capabilities_khr:                      Proc_Get_Display_Plane_Capabilities_KHR;
get_physical_device_features2_khr:                       Proc_Get_Physical_Device_Features2_KHR;
get_physical_device_properties2_khr:                     Proc_Get_Physical_Device_Properties2_KHR;
get_physical_device_format_properties2_khr:              Proc_Get_Physical_Device_Format_Properties2_KHR;
get_physical_device_image_format_properties2_khr:        Proc_Get_Physical_Device_Image_Format_Properties2_KHR;
get_physical_device_queue_family_properties2_khr:        Proc_Get_Physical_Device_Queue_Family_Properties2_KHR;
get_physical_device_memory_properties2_khr:              Proc_Get_Physical_Device_Memory_Properties2_KHR;
get_physical_device_sparse_image_format_properties2_khr: Proc_Get_Physical_Device_Sparse_Image_Format_Properties2_KHR;
cmd_set_device_mask_khr:                                 Proc_Cmd_Set_Device_Mask_KHR;
cmd_dispatch_base_khr:                                   Proc_Cmd_Dispatch_Base_KHR;
get_physical_device_external_buffer_properties_khr:      Proc_Get_Physical_Device_External_Buffer_Properties_KHR;
get_physical_device_external_semaphore_properties_khr:   Proc_Get_Physical_Device_External_Semaphore_Properties_KHR;
cmd_push_descriptor_set_khr:                             Proc_Cmd_Push_Descriptor_Set_KHR;
cmd_push_descriptor_set_with_template_khr:               Proc_Cmd_Push_Descriptor_Set_With_Template_KHR;
cmd_begin_render_pass2_khr:                              Proc_Cmd_Begin_Render_Pass2_KHR;
cmd_next_subpass2_khr:                                   Proc_Cmd_Next_Subpass2_KHR;
cmd_end_render_pass2_khr:                                Proc_Cmd_End_Render_Pass2_KHR;
get_physical_device_external_fence_properties_khr:       Proc_Get_Physical_Device_External_Fence_Properties_KHR;
get_physical_device_surface_capabilities2_khr:           Proc_Get_Physical_Device_Surface_Capabilities2_KHR;
get_physical_device_surface_formats2_khr:                Proc_Get_Physical_Device_Surface_Formats2_KHR;
get_physical_device_display_properties2_khr:             Proc_Get_Physical_Device_Display_Properties2_KHR;
get_physical_device_display_plane_properties2_khr:       Proc_Get_Physical_Device_Display_Plane_Properties2_KHR;
get_display_mode_properties2_khr:                        Proc_Get_Display_Mode_Properties2_KHR;
get_display_plane_capabilities2_khr:                     Proc_Get_Display_Plane_Capabilities2_KHR;
cmd_draw_indirect_count_khr:                             Proc_Cmd_Draw_Indirect_Count_KHR;
cmd_draw_indexed_indirect_count_khr:                     Proc_Cmd_Draw_Indexed_Indirect_Count_KHR;
debug_report_callback_ext:                               Proc_Debug_Report_Callback_EXT;
cmd_debug_marker_begin_ext:                              Proc_Cmd_Debug_Marker_Begin_EXT;
cmd_debug_marker_end_ext:                                Proc_Cmd_Debug_Marker_End_EXT;
cmd_debug_marker_insert_ext:                             Proc_Cmd_Debug_Marker_Insert_EXT;
cmd_bind_transform_feedback_buffers_ext:                 Proc_Cmd_Bind_Transform_Feedback_Buffers_EXT;
cmd_begin_transform_feedback_ext:                        Proc_Cmd_Begin_Transform_Feedback_EXT;
cmd_end_transform_feedback_ext:                          Proc_Cmd_End_Transform_Feedback_EXT;
cmd_begin_query_indexed_ext:                             Proc_Cmd_Begin_Query_Indexed_EXT;
cmd_end_query_indexed_ext:                               Proc_Cmd_End_Query_Indexed_EXT;
cmd_draw_indirect_byte_count_ext:                        Proc_Cmd_Draw_Indirect_Byte_Count_EXT;
cmd_draw_indirect_count_amd:                             Proc_Cmd_Draw_Indirect_Count_AMD;
cmd_draw_indexed_indirect_count_amd:                     Proc_Cmd_Draw_Indexed_Indirect_Count_AMD;
get_physical_device_external_image_format_properties_nv: Proc_Get_Physical_Device_External_Image_Format_Properties_NV;
cmd_begin_conditional_rendering_ext:                     Proc_Cmd_Begin_Conditional_Rendering_EXT;
cmd_end_conditional_rendering_ext:                       Proc_Cmd_End_Conditional_Rendering_EXT;
cmd_process_commands_nvx:                                Proc_Cmd_Process_Commands_NVX;
cmd_reserve_space_for_commands_nvx:                      Proc_Cmd_Reserve_Space_For_Commands_NVX;
get_physical_device_generated_commands_properties_nvx:   Proc_Get_Physical_Device_Generated_Commands_Properties_NVX;
cmd_set_viewport_w_scaling_nv:                           Proc_Cmd_Set_Viewport_W_Scaling_NV;
release_display_ext:                                     Proc_Release_Display_EXT;
get_physical_device_surface_capabilities2_ext:           Proc_Get_Physical_Device_Surface_Capabilities2_EXT;
cmd_set_discard_rectangle_ext:                           Proc_Cmd_Set_Discard_Rectangle_EXT;
debug_utils_messenger_callback_ext:                      Proc_Debug_Utils_Messenger_Callback_EXT;
cmd_begin_debug_utils_label_ext:                         Proc_Cmd_Begin_Debug_Utils_Label_EXT;
cmd_end_debug_utils_label_ext:                           Proc_Cmd_End_Debug_Utils_Label_EXT;
cmd_insert_debug_utils_label_ext:                        Proc_Cmd_Insert_Debug_Utils_Label_EXT;
cmd_set_sample_locations_ext:                            Proc_Cmd_Set_Sample_Locations_EXT;
get_physical_device_multisample_properties_ext:          Proc_Get_Physical_Device_Multisample_Properties_EXT;
cmd_bind_shading_rate_image_nv:                          Proc_Cmd_Bind_Shading_Rate_Image_NV;
cmd_set_viewport_shading_rate_palette_nv:                Proc_Cmd_Set_Viewport_Shading_Rate_Palette_NV;
cmd_set_coarse_sample_order_nv:                          Proc_Cmd_Set_Coarse_Sample_Order_NV;
cmd_build_acceleration_structure_nvx:                    Proc_Cmd_Build_Acceleration_Structure_NVX;
cmd_copy_acceleration_structure_nvx:                     Proc_Cmd_Copy_Acceleration_Structure_NVX;
cmd_trace_rays_nvx:                                      Proc_Cmd_Trace_Rays_NVX;
cmd_write_acceleration_structure_properties_nvx:         Proc_Cmd_Write_Acceleration_Structure_Properties_NVX;
cmd_write_buffer_marker_amd:                             Proc_Cmd_Write_Buffer_Marker_AMD;
get_physical_device_calibrateable_time_domains_ext:      Proc_Get_Physical_Device_Calibrateable_Time_Domains_EXT;
cmd_draw_mesh_tasks_nv:                                  Proc_Cmd_Draw_Mesh_Tasks_NV;
cmd_draw_mesh_tasks_indirect_nv:                         Proc_Cmd_Draw_Mesh_Tasks_Indirect_NV;
cmd_draw_mesh_tasks_indirect_count_nv:                   Proc_Cmd_Draw_Mesh_Tasks_Indirect_Count_NV;
cmd_set_exclusive_scissor_nv:                            Proc_Cmd_Set_Exclusive_Scissor_NV;
cmd_set_checkpoint_nv:                                   Proc_Cmd_Set_Checkpoint_NV;


load_instance_proc_addresses :: proc(instance: Instance, set_proc_address: Set_Proc_Address_Type) {
	set_proc_address(&get_instance_proc_addr, nil, "vkGetInstanceProcAddr");
	assert(get_instance_proc_addr != nil);

	// Instance Procedures
	destroy_instance                     = auto_cast get_instance_proc_addr(instance, "vkDestroyInstance");
	enumerate_physical_devices           = auto_cast get_instance_proc_addr(instance, "vkEnumeratePhysicalDevices");
	enumerate_physical_device_groups     = auto_cast get_instance_proc_addr(instance, "vkEnumeratePhysicalDeviceGroups");
	destroy_surface_khr                  = auto_cast get_instance_proc_addr(instance, "vkDestroySurfaceKHR");
	create_display_plane_surface_khr     = auto_cast get_instance_proc_addr(instance, "vkCreateDisplayPlaneSurfaceKHR");
	enumerate_physical_device_groups_khr = auto_cast get_instance_proc_addr(instance, "vkEnumeratePhysicalDeviceGroupsKHR");
	create_debug_report_callback_ext     = auto_cast get_instance_proc_addr(instance, "vkCreateDebugReportCallbackEXT");
	destroy_debug_report_callback_ext    = auto_cast get_instance_proc_addr(instance, "vkDestroyDebugReportCallbackEXT");
	debug_report_message_ext             = auto_cast get_instance_proc_addr(instance, "vkDebugReportMessageEXT");
	create_debug_utils_messenger_ext     = auto_cast get_instance_proc_addr(instance, "vkCreateDebugUtilsMessengerEXT");
	destroy_debug_utils_messenger_ext    = auto_cast get_instance_proc_addr(instance, "vkDestroyDebugUtilsMessengerEXT");
	submit_debug_utils_message_ext       = auto_cast get_instance_proc_addr(instance, "vkSubmitDebugUtilsMessageEXT");
}

load_device_proc_addresses :: proc(instance: Instance, set_proc_address: Set_Proc_Address_Type) {
	// Device Procedures
	get_device_proc_addr                                       = auto_cast get_instance_proc_addr(instance, "vkGetDeviceProcAddr");
	destroy_device                                             = auto_cast get_instance_proc_addr(instance, "vkDestroyDevice");
	get_device_queue                                           = auto_cast get_instance_proc_addr(instance, "vkGetDeviceQueue");
	queue_submit                                               = auto_cast get_instance_proc_addr(instance, "vkQueueSubmit");
	queue_wait_idle                                            = auto_cast get_instance_proc_addr(instance, "vkQueueWaitIdle");
	device_wait_idle                                           = auto_cast get_instance_proc_addr(instance, "vkDeviceWaitIdle");
	allocate_memory                                            = auto_cast get_instance_proc_addr(instance, "vkAllocateMemory");
	free_memory                                                = auto_cast get_instance_proc_addr(instance, "vkFreeMemory");
	map_memory                                                 = auto_cast get_instance_proc_addr(instance, "vkMapMemory");
	unmap_memory                                               = auto_cast get_instance_proc_addr(instance, "vkUnmapMemory");
	flush_mapped_memory_ranges                                 = auto_cast get_instance_proc_addr(instance, "vkFlushMappedMemoryRanges");
	invalidate_mapped_memory_ranges                            = auto_cast get_instance_proc_addr(instance, "vkInvalidateMappedMemoryRanges");
	get_device_memory_commitment                               = auto_cast get_instance_proc_addr(instance, "vkGetDeviceMemoryCommitment");
	bind_buffer_memory                                         = auto_cast get_instance_proc_addr(instance, "vkBindBufferMemory");
	bind_image_memory                                          = auto_cast get_instance_proc_addr(instance, "vkBindImageMemory");
	get_buffer_memory_requirements                             = auto_cast get_instance_proc_addr(instance, "vkGetBufferMemoryRequirements");
	get_image_memory_requirements                              = auto_cast get_instance_proc_addr(instance, "vkGetImageMemoryRequirements");
	get_image_sparse_memory_requirements                       = auto_cast get_instance_proc_addr(instance, "vkGetImageSparseMemoryRequirements");
	queue_bind_sparse                                          = auto_cast get_instance_proc_addr(instance, "vkQueueBindSparse");
	create_fence                                               = auto_cast get_instance_proc_addr(instance, "vkCreateFence");
	destroy_fence                                              = auto_cast get_instance_proc_addr(instance, "vkDestroyFence");
	reset_fences                                               = auto_cast get_instance_proc_addr(instance, "vkResetFences");
	get_fence_status                                           = auto_cast get_instance_proc_addr(instance, "vkGetFenceStatus");
	wait_for_fences                                            = auto_cast get_instance_proc_addr(instance, "vkWaitForFences");
	create_semaphore                                           = auto_cast get_instance_proc_addr(instance, "vkCreateSemaphore");
	destroy_semaphore                                          = auto_cast get_instance_proc_addr(instance, "vkDestroySemaphore");
	create_event                                               = auto_cast get_instance_proc_addr(instance, "vkCreateEvent");
	destroy_event                                              = auto_cast get_instance_proc_addr(instance, "vkDestroyEvent");
	get_event_status                                           = auto_cast get_instance_proc_addr(instance, "vkGetEventStatus");
	set_event                                                  = auto_cast get_instance_proc_addr(instance, "vkSetEvent");
	reset_event                                                = auto_cast get_instance_proc_addr(instance, "vkResetEvent");
	create_query_pool                                          = auto_cast get_instance_proc_addr(instance, "vkCreateQueryPool");
	destroy_query_pool                                         = auto_cast get_instance_proc_addr(instance, "vkDestroyQueryPool");
	get_query_pool_results                                     = auto_cast get_instance_proc_addr(instance, "vkGetQueryPoolResults");
	create_buffer                                              = auto_cast get_instance_proc_addr(instance, "vkCreateBuffer");
	destroy_buffer                                             = auto_cast get_instance_proc_addr(instance, "vkDestroyBuffer");
	create_buffer_view                                         = auto_cast get_instance_proc_addr(instance, "vkCreateBufferView");
	destroy_buffer_view                                        = auto_cast get_instance_proc_addr(instance, "vkDestroyBufferView");
	create_image                                               = auto_cast get_instance_proc_addr(instance, "vkCreateImage");
	destroy_image                                              = auto_cast get_instance_proc_addr(instance, "vkDestroyImage");
	get_image_subresource_layout                               = auto_cast get_instance_proc_addr(instance, "vkGetImageSubresourceLayout");
	create_image_view                                          = auto_cast get_instance_proc_addr(instance, "vkCreateImageView");
	destroy_image_view                                         = auto_cast get_instance_proc_addr(instance, "vkDestroyImageView");
	create_shader_module                                       = auto_cast get_instance_proc_addr(instance, "vkCreateShaderModule");
	destroy_shader_module                                      = auto_cast get_instance_proc_addr(instance, "vkDestroyShaderModule");
	create_pipeline_cache                                      = auto_cast get_instance_proc_addr(instance, "vkCreatePipelineCache");
	destroy_pipeline_cache                                     = auto_cast get_instance_proc_addr(instance, "vkDestroyPipelineCache");
	get_pipeline_cache_data                                    = auto_cast get_instance_proc_addr(instance, "vkGetPipelineCacheData");
	merge_pipeline_caches                                      = auto_cast get_instance_proc_addr(instance, "vkMergePipelineCaches");
	create_graphics_pipelines                                  = auto_cast get_instance_proc_addr(instance, "vkCreateGraphicsPipelines");
	create_compute_pipelines                                   = auto_cast get_instance_proc_addr(instance, "vkCreateComputePipelines");
	destroy_pipeline                                           = auto_cast get_instance_proc_addr(instance, "vkDestroyPipeline");
	create_pipeline_layout                                     = auto_cast get_instance_proc_addr(instance, "vkCreatePipelineLayout");
	destroy_pipeline_layout                                    = auto_cast get_instance_proc_addr(instance, "vkDestroyPipelineLayout");
	create_sampler                                             = auto_cast get_instance_proc_addr(instance, "vkCreateSampler");
	destroy_sampler                                            = auto_cast get_instance_proc_addr(instance, "vkDestroySampler");
	create_descriptor_set_layout                               = auto_cast get_instance_proc_addr(instance, "vkCreateDescriptorSetLayout");
	destroy_descriptor_set_layout                              = auto_cast get_instance_proc_addr(instance, "vkDestroyDescriptorSetLayout");
	create_descriptor_pool                                     = auto_cast get_instance_proc_addr(instance, "vkCreateDescriptorPool");
	destroy_descriptor_pool                                    = auto_cast get_instance_proc_addr(instance, "vkDestroyDescriptorPool");
	reset_descriptor_pool                                      = auto_cast get_instance_proc_addr(instance, "vkResetDescriptorPool");
	allocate_descriptor_sets                                   = auto_cast get_instance_proc_addr(instance, "vkAllocateDescriptorSets");
	free_descriptor_sets                                       = auto_cast get_instance_proc_addr(instance, "vkFreeDescriptorSets");
	update_descriptor_sets                                     = auto_cast get_instance_proc_addr(instance, "vkUpdateDescriptorSets");
	create_framebuffer                                         = auto_cast get_instance_proc_addr(instance, "vkCreateFramebuffer");
	destroy_framebuffer                                        = auto_cast get_instance_proc_addr(instance, "vkDestroyFramebuffer");
	create_render_pass                                         = auto_cast get_instance_proc_addr(instance, "vkCreateRenderPass");
	destroy_render_pass                                        = auto_cast get_instance_proc_addr(instance, "vkDestroyRenderPass");
	get_render_area_granularity                                = auto_cast get_instance_proc_addr(instance, "vkGetRenderAreaGranularity");
	create_command_pool                                        = auto_cast get_instance_proc_addr(instance, "vkCreateCommandPool");
	destroy_command_pool                                       = auto_cast get_instance_proc_addr(instance, "vkDestroyCommandPool");
	reset_command_pool                                         = auto_cast get_instance_proc_addr(instance, "vkResetCommandPool");
	allocate_command_buffers                                   = auto_cast get_instance_proc_addr(instance, "vkAllocateCommandBuffers");
	free_command_buffers                                       = auto_cast get_instance_proc_addr(instance, "vkFreeCommandBuffers");
	bind_buffer_memory2                                        = auto_cast get_instance_proc_addr(instance, "vkBindBufferMemory2");
	bind_image_memory2                                         = auto_cast get_instance_proc_addr(instance, "vkBindImageMemory2");
	get_device_group_peer_memory_features                      = auto_cast get_instance_proc_addr(instance, "vkGetDeviceGroupPeerMemoryFeatures");
	get_image_memory_requirements2                             = auto_cast get_instance_proc_addr(instance, "vkGetImageMemoryRequirements2");
	get_buffer_memory_requirements2                            = auto_cast get_instance_proc_addr(instance, "vkGetBufferMemoryRequirements2");
	get_image_sparse_memory_requirements2                      = auto_cast get_instance_proc_addr(instance, "vkGetImageSparseMemoryRequirements2");
	trim_command_pool                                          = auto_cast get_instance_proc_addr(instance, "vkTrimCommandPool");
	get_device_queue2                                          = auto_cast get_instance_proc_addr(instance, "vkGetDeviceQueue2");
	create_sampler_ycbcr_conversion                            = auto_cast get_instance_proc_addr(instance, "vkCreateSamplerYcbcrConversion");
	destroy_sampler_ycbcr_conversion                           = auto_cast get_instance_proc_addr(instance, "vkDestroySamplerYcbcrConversion");
	create_descriptor_update_template                          = auto_cast get_instance_proc_addr(instance, "vkCreateDescriptorUpdateTemplate");
	destroy_descriptor_update_template                         = auto_cast get_instance_proc_addr(instance, "vkDestroyDescriptorUpdateTemplate");
	update_descriptor_set_with_template                        = auto_cast get_instance_proc_addr(instance, "vkUpdateDescriptorSetWithTemplate");
	get_descriptor_set_layout_support                          = auto_cast get_instance_proc_addr(instance, "vkGetDescriptorSetLayoutSupport");
	create_swapchain_khr                                       = auto_cast get_instance_proc_addr(instance, "vkCreateSwapchainKHR");
	destroy_swapchain_khr                                      = auto_cast get_instance_proc_addr(instance, "vkDestroySwapchainKHR");
	get_swapchain_images_khr                                   = auto_cast get_instance_proc_addr(instance, "vkGetSwapchainImagesKHR");
	acquire_next_image_khr                                     = auto_cast get_instance_proc_addr(instance, "vkAcquireNextImageKHR");
	queue_present_khr                                          = auto_cast get_instance_proc_addr(instance, "vkQueuePresentKHR");
	get_device_group_present_capabilities_khr                  = auto_cast get_instance_proc_addr(instance, "vkGetDeviceGroupPresentCapabilitiesKHR");
	get_device_group_surface_present_modes_khr                 = auto_cast get_instance_proc_addr(instance, "vkGetDeviceGroupSurfacePresentModesKHR");
	acquire_next_image2_khr                                    = auto_cast get_instance_proc_addr(instance, "vkAcquireNextImage2KHR");
	create_shared_swapchains_khr                               = auto_cast get_instance_proc_addr(instance, "vkCreateSharedSwapchainsKHR");
	get_device_group_peer_memory_features_khr                  = auto_cast get_instance_proc_addr(instance, "vkGetDeviceGroupPeerMemoryFeaturesKHR");
	trim_command_pool_khr                                      = auto_cast get_instance_proc_addr(instance, "vkTrimCommandPoolKHR");
	get_memory_fd_khr                                          = auto_cast get_instance_proc_addr(instance, "vkGetMemoryFdKHR");
	get_memory_fd_properties_khr                               = auto_cast get_instance_proc_addr(instance, "vkGetMemoryFdPropertiesKHR");
	import_semaphore_fd_khr                                    = auto_cast get_instance_proc_addr(instance, "vkImportSemaphoreFdKHR");
	get_semaphore_fd_khr                                       = auto_cast get_instance_proc_addr(instance, "vkGetSemaphoreFdKHR");
	create_descriptor_update_template_khr                      = auto_cast get_instance_proc_addr(instance, "vkCreateDescriptorUpdateTemplateKHR");
	destroy_descriptor_update_template_khr                     = auto_cast get_instance_proc_addr(instance, "vkDestroyDescriptorUpdateTemplateKHR");
	update_descriptor_set_with_template_khr                    = auto_cast get_instance_proc_addr(instance, "vkUpdateDescriptorSetWithTemplateKHR");
	create_render_pass2_khr                                    = auto_cast get_instance_proc_addr(instance, "vkCreateRenderPass2KHR");
	get_swapchain_status_khr                                   = auto_cast get_instance_proc_addr(instance, "vkGetSwapchainStatusKHR");
	import_fence_fd_khr                                        = auto_cast get_instance_proc_addr(instance, "vkImportFenceFdKHR");
	get_fence_fd_khr                                           = auto_cast get_instance_proc_addr(instance, "vkGetFenceFdKHR");
	get_image_memory_requirements2_khr                         = auto_cast get_instance_proc_addr(instance, "vkGetImageMemoryRequirements2KHR");
	get_buffer_memory_requirements2_khr                        = auto_cast get_instance_proc_addr(instance, "vkGetBufferMemoryRequirements2KHR");
	get_image_sparse_memory_requirements2_khr                  = auto_cast get_instance_proc_addr(instance, "vkGetImageSparseMemoryRequirements2KHR");
	create_sampler_ycbcr_conversion_khr                        = auto_cast get_instance_proc_addr(instance, "vkCreateSamplerYcbcrConversionKHR");
	destroy_sampler_ycbcr_conversion_khr                       = auto_cast get_instance_proc_addr(instance, "vkDestroySamplerYcbcrConversionKHR");
	bind_buffer_memory2_khr                                    = auto_cast get_instance_proc_addr(instance, "vkBindBufferMemory2KHR");
	bind_image_memory2_khr                                     = auto_cast get_instance_proc_addr(instance, "vkBindImageMemory2KHR");
	get_descriptor_set_layout_support_khr                      = auto_cast get_instance_proc_addr(instance, "vkGetDescriptorSetLayoutSupportKHR");
	debug_marker_set_object_tag_ext                            = auto_cast get_instance_proc_addr(instance, "vkDebugMarkerSetObjectTagEXT");
	debug_marker_set_object_name_ext                           = auto_cast get_instance_proc_addr(instance, "vkDebugMarkerSetObjectNameEXT");
	get_shader_info_amd                                        = auto_cast get_instance_proc_addr(instance, "vkGetShaderInfoAMD");
	create_indirect_commands_layout_nvx                        = auto_cast get_instance_proc_addr(instance, "vkCreateIndirectCommandsLayoutNVX");
	destroy_indirect_commands_layout_nvx                       = auto_cast get_instance_proc_addr(instance, "vkDestroyIndirectCommandsLayoutNVX");
	create_object_table_nvx                                    = auto_cast get_instance_proc_addr(instance, "vkCreateObjectTableNVX");
	destroy_object_table_nvx                                   = auto_cast get_instance_proc_addr(instance, "vkDestroyObjectTableNVX");
	register_objects_nvx                                       = auto_cast get_instance_proc_addr(instance, "vkRegisterObjectsNVX");
	unregister_objects_nvx                                     = auto_cast get_instance_proc_addr(instance, "vkUnregisterObjectsNVX");
	display_power_control_ext                                  = auto_cast get_instance_proc_addr(instance, "vkDisplayPowerControlEXT");
	register_device_event_ext                                  = auto_cast get_instance_proc_addr(instance, "vkRegisterDeviceEventEXT");
	register_display_event_ext                                 = auto_cast get_instance_proc_addr(instance, "vkRegisterDisplayEventEXT");
	get_swapchain_counter_ext                                  = auto_cast get_instance_proc_addr(instance, "vkGetSwapchainCounterEXT");
	get_refresh_cycle_duration_google                          = auto_cast get_instance_proc_addr(instance, "vkGetRefreshCycleDurationGOOGLE");
	get_past_presentation_timing_google                        = auto_cast get_instance_proc_addr(instance, "vkGetPastPresentationTimingGOOGLE");
	set_hdr_metadata_ext                                       = auto_cast get_instance_proc_addr(instance, "vkSetHdrMetadataEXT");
	set_debug_utils_object_name_ext                            = auto_cast get_instance_proc_addr(instance, "vkSetDebugUtilsObjectNameEXT");
	set_debug_utils_object_tag_ext                             = auto_cast get_instance_proc_addr(instance, "vkSetDebugUtilsObjectTagEXT");
	queue_begin_debug_utils_label_ext                          = auto_cast get_instance_proc_addr(instance, "vkQueueBeginDebugUtilsLabelEXT");
	queue_end_debug_utils_label_ext                            = auto_cast get_instance_proc_addr(instance, "vkQueueEndDebugUtilsLabelEXT");
	queue_insert_debug_utils_label_ext                         = auto_cast get_instance_proc_addr(instance, "vkQueueInsertDebugUtilsLabelEXT");
	get_image_drm_format_modifier_properties_ext               = auto_cast get_instance_proc_addr(instance, "vkGetImageDrmFormatModifierPropertiesEXT");
	create_validation_cache_ext                                = auto_cast get_instance_proc_addr(instance, "vkCreateValidationCacheEXT");
	destroy_validation_cache_ext                               = auto_cast get_instance_proc_addr(instance, "vkDestroyValidationCacheEXT");
	merge_validation_caches_ext                                = auto_cast get_instance_proc_addr(instance, "vkMergeValidationCachesEXT");
	get_validation_cache_data_ext                              = auto_cast get_instance_proc_addr(instance, "vkGetValidationCacheDataEXT");
	create_acceleration_structure_nvx                          = auto_cast get_instance_proc_addr(instance, "vkCreateAccelerationStructureNVX");
	destroy_acceleration_structure_nvx                         = auto_cast get_instance_proc_addr(instance, "vkDestroyAccelerationStructureNVX");
	get_acceleration_structure_memory_requirements_nvx         = auto_cast get_instance_proc_addr(instance, "vkGetAccelerationStructureMemoryRequirementsNVX");
	get_acceleration_structure_scratch_memory_requirements_nvx = auto_cast get_instance_proc_addr(instance, "vkGetAccelerationStructureScratchMemoryRequirementsNVX");
	bind_acceleration_structure_memory_nvx                     = auto_cast get_instance_proc_addr(instance, "vkBindAccelerationStructureMemoryNVX");
	create_raytracing_pipelines_nvx                            = auto_cast get_instance_proc_addr(instance, "vkCreateRaytracingPipelinesNVX");
	get_raytracing_shader_handles_nvx                          = auto_cast get_instance_proc_addr(instance, "vkGetRaytracingShaderHandlesNVX");
	get_acceleration_structure_handle_nvx                      = auto_cast get_instance_proc_addr(instance, "vkGetAccelerationStructureHandleNVX");
	compile_deferred_nvx                                       = auto_cast get_instance_proc_addr(instance, "vkCompileDeferredNVX");
	get_memory_host_pointer_properties_ext                     = auto_cast get_instance_proc_addr(instance, "vkGetMemoryHostPointerPropertiesEXT");
	get_calibrated_timestamps_ext                              = auto_cast get_instance_proc_addr(instance, "vkGetCalibratedTimestampsEXT");
	get_queue_checkpoint_data_nv                               = auto_cast get_instance_proc_addr(instance, "vkGetQueueCheckpointDataNV");
}

load_loader_proc_addresses :: proc(set_proc_address: Set_Proc_Address_Type) {
	// Loader Procedures
	set_proc_address(&create_instance,                                         nil, "vkCreateInstance");
	set_proc_address(&get_physical_device_features,                            nil, "vkGetPhysicalDeviceFeatures");
	set_proc_address(&get_physical_device_format_properties,                   nil, "vkGetPhysicalDeviceFormatProperties");
	set_proc_address(&get_physical_device_image_format_properties,             nil, "vkGetPhysicalDeviceImageFormatProperties");
	set_proc_address(&get_physical_device_properties,                          nil, "vkGetPhysicalDeviceProperties");
	set_proc_address(&get_physical_device_queue_family_properties,             nil, "vkGetPhysicalDeviceQueueFamilyProperties");
	set_proc_address(&get_physical_device_memory_properties,                   nil, "vkGetPhysicalDeviceMemoryProperties");
	set_proc_address(&create_device,                                           nil, "vkCreateDevice");
	set_proc_address(&enumerate_instance_extension_properties,                 nil, "vkEnumerateInstanceExtensionProperties");
	set_proc_address(&enumerate_device_extension_properties,                   nil, "vkEnumerateDeviceExtensionProperties");
	set_proc_address(&enumerate_instance_layer_properties,                     nil, "vkEnumerateInstanceLayerProperties");
	set_proc_address(&enumerate_device_layer_properties,                       nil, "vkEnumerateDeviceLayerProperties");
	set_proc_address(&get_physical_device_sparse_image_format_properties,      nil, "vkGetPhysicalDeviceSparseImageFormatProperties");
	set_proc_address(&begin_command_buffer,                                    nil, "vkBeginCommandBuffer");
	set_proc_address(&end_command_buffer,                                      nil, "vkEndCommandBuffer");
	set_proc_address(&reset_command_buffer,                                    nil, "vkResetCommandBuffer");
	set_proc_address(&cmd_bind_pipeline,                                       nil, "vkCmdBindPipeline");
	set_proc_address(&cmd_set_viewport,                                        nil, "vkCmdSetViewport");
	set_proc_address(&cmd_set_scissor,                                         nil, "vkCmdSetScissor");
	set_proc_address(&cmd_set_line_width,                                      nil, "vkCmdSetLineWidth");
	set_proc_address(&cmd_set_depth_bias,                                      nil, "vkCmdSetDepthBias");
	set_proc_address(&cmd_set_blend_constants,                                 nil, "vkCmdSetBlendConstants");
	set_proc_address(&cmd_set_depth_bounds,                                    nil, "vkCmdSetDepthBounds");
	set_proc_address(&cmd_set_stencil_compare_mask,                            nil, "vkCmdSetStencilCompareMask");
	set_proc_address(&cmd_set_stencil_write_mask,                              nil, "vkCmdSetStencilWriteMask");
	set_proc_address(&cmd_set_stencil_reference,                               nil, "vkCmdSetStencilReference");
	set_proc_address(&cmd_bind_descriptor_sets,                                nil, "vkCmdBindDescriptorSets");
	set_proc_address(&cmd_bind_index_buffer,                                   nil, "vkCmdBindIndexBuffer");
	set_proc_address(&cmd_bind_vertex_buffers,                                 nil, "vkCmdBindVertexBuffers");
	set_proc_address(&cmd_draw,                                                nil, "vkCmdDraw");
	set_proc_address(&cmd_draw_indexed,                                        nil, "vkCmdDrawIndexed");
	set_proc_address(&cmd_draw_indirect,                                       nil, "vkCmdDrawIndirect");
	set_proc_address(&cmd_draw_indexed_indirect,                               nil, "vkCmdDrawIndexedIndirect");
	set_proc_address(&cmd_dispatch,                                            nil, "vkCmdDispatch");
	set_proc_address(&cmd_dispatch_indirect,                                   nil, "vkCmdDispatchIndirect");
	set_proc_address(&cmd_copy_buffer,                                         nil, "vkCmdCopyBuffer");
	set_proc_address(&cmd_copy_image,                                          nil, "vkCmdCopyImage");
	set_proc_address(&cmd_blit_image,                                          nil, "vkCmdBlitImage");
	set_proc_address(&cmd_copy_buffer_to_image,                                nil, "vkCmdCopyBufferToImage");
	set_proc_address(&cmd_copy_image_to_buffer,                                nil, "vkCmdCopyImageToBuffer");
	set_proc_address(&cmd_update_buffer,                                       nil, "vkCmdUpdateBuffer");
	set_proc_address(&cmd_fill_buffer,                                         nil, "vkCmdFillBuffer");
	set_proc_address(&cmd_clear_color_image,                                   nil, "vkCmdClearColorImage");
	set_proc_address(&cmd_clear_depth_stencil_image,                           nil, "vkCmdClearDepthStencilImage");
	set_proc_address(&cmd_clear_attachments,                                   nil, "vkCmdClearAttachments");
	set_proc_address(&cmd_resolve_image,                                       nil, "vkCmdResolveImage");
	set_proc_address(&cmd_set_event,                                           nil, "vkCmdSetEvent");
	set_proc_address(&cmd_reset_event,                                         nil, "vkCmdResetEvent");
	set_proc_address(&cmd_wait_events,                                         nil, "vkCmdWaitEvents");
	set_proc_address(&cmd_pipeline_barrier,                                    nil, "vkCmdPipelineBarrier");
	set_proc_address(&cmd_begin_query,                                         nil, "vkCmdBeginQuery");
	set_proc_address(&cmd_end_query,                                           nil, "vkCmdEndQuery");
	set_proc_address(&cmd_reset_query_pool,                                    nil, "vkCmdResetQueryPool");
	set_proc_address(&cmd_write_timestamp,                                     nil, "vkCmdWriteTimestamp");
	set_proc_address(&cmd_copy_query_pool_results,                             nil, "vkCmdCopyQueryPoolResults");
	set_proc_address(&cmd_push_constants,                                      nil, "vkCmdPushConstants");
	set_proc_address(&cmd_begin_render_pass,                                   nil, "vkCmdBeginRenderPass");
	set_proc_address(&cmd_next_subpass,                                        nil, "vkCmdNextSubpass");
	set_proc_address(&cmd_end_render_pass,                                     nil, "vkCmdEndRenderPass");
	set_proc_address(&cmd_execute_commands,                                    nil, "vkCmdExecuteCommands");
	set_proc_address(&enumerate_instance_version,                              nil, "vkEnumerateInstanceVersion");
	set_proc_address(&cmd_set_device_mask,                                     nil, "vkCmdSetDeviceMask");
	set_proc_address(&cmd_dispatch_base,                                       nil, "vkCmdDispatchBase");
	set_proc_address(&get_physical_device_features2,                           nil, "vkGetPhysicalDeviceFeatures2");
	set_proc_address(&get_physical_device_properties2,                         nil, "vkGetPhysicalDeviceProperties2");
	set_proc_address(&get_physical_device_format_properties2,                  nil, "vkGetPhysicalDeviceFormatProperties2");
	set_proc_address(&get_physical_device_image_format_properties2,            nil, "vkGetPhysicalDeviceImageFormatProperties2");
	set_proc_address(&get_physical_device_queue_family_properties2,            nil, "vkGetPhysicalDeviceQueueFamilyProperties2");
	set_proc_address(&get_physical_device_memory_properties2,                  nil, "vkGetPhysicalDeviceMemoryProperties2");
	set_proc_address(&get_physical_device_sparse_image_format_properties2,     nil, "vkGetPhysicalDeviceSparseImageFormatProperties2");
	set_proc_address(&get_physical_device_external_buffer_properties,          nil, "vkGetPhysicalDeviceExternalBufferProperties");
	set_proc_address(&get_physical_device_external_fence_properties,           nil, "vkGetPhysicalDeviceExternalFenceProperties");
	set_proc_address(&get_physical_device_external_semaphore_properties,       nil, "vkGetPhysicalDeviceExternalSemaphoreProperties");
	set_proc_address(&get_physical_device_surface_support_khr,                 nil, "vkGetPhysicalDeviceSurfaceSupportKHR");
	set_proc_address(&get_physical_device_surface_capabilities_khr,            nil, "vkGetPhysicalDeviceSurfaceCapabilitiesKHR");
	set_proc_address(&get_physical_device_surface_formats_khr,                 nil, "vkGetPhysicalDeviceSurfaceFormatsKHR");
	set_proc_address(&get_physical_device_surface_present_modes_khr,           nil, "vkGetPhysicalDeviceSurfacePresentModesKHR");
	set_proc_address(&get_physical_device_present_rectangles_khr,              nil, "vkGetPhysicalDevicePresentRectanglesKHR");
	set_proc_address(&get_physical_device_display_properties_khr,              nil, "vkGetPhysicalDeviceDisplayPropertiesKHR");
	set_proc_address(&get_physical_device_display_plane_properties_khr,        nil, "vkGetPhysicalDeviceDisplayPlanePropertiesKHR");
	set_proc_address(&get_display_plane_supported_displays_khr,                nil, "vkGetDisplayPlaneSupportedDisplaysKHR");
	set_proc_address(&get_display_mode_properties_khr,                         nil, "vkGetDisplayModePropertiesKHR");
	set_proc_address(&create_display_mode_khr,                                 nil, "vkCreateDisplayModeKHR");
	set_proc_address(&get_display_plane_capabilities_khr,                      nil, "vkGetDisplayPlaneCapabilitiesKHR");
	set_proc_address(&get_physical_device_features2_khr,                       nil, "vkGetPhysicalDeviceFeatures2KHR");
	set_proc_address(&get_physical_device_properties2_khr,                     nil, "vkGetPhysicalDeviceProperties2KHR");
	set_proc_address(&get_physical_device_format_properties2_khr,              nil, "vkGetPhysicalDeviceFormatProperties2KHR");
	set_proc_address(&get_physical_device_image_format_properties2_khr,        nil, "vkGetPhysicalDeviceImageFormatProperties2KHR");
	set_proc_address(&get_physical_device_queue_family_properties2_khr,        nil, "vkGetPhysicalDeviceQueueFamilyProperties2KHR");
	set_proc_address(&get_physical_device_memory_properties2_khr,              nil, "vkGetPhysicalDeviceMemoryProperties2KHR");
	set_proc_address(&get_physical_device_sparse_image_format_properties2_khr, nil, "vkGetPhysicalDeviceSparseImageFormatProperties2KHR");
	set_proc_address(&cmd_set_device_mask_khr,                                 nil, "vkCmdSetDeviceMaskKHR");
	set_proc_address(&cmd_dispatch_base_khr,                                   nil, "vkCmdDispatchBaseKHR");
	set_proc_address(&get_physical_device_external_buffer_properties_khr,      nil, "vkGetPhysicalDeviceExternalBufferPropertiesKHR");
	set_proc_address(&get_physical_device_external_semaphore_properties_khr,   nil, "vkGetPhysicalDeviceExternalSemaphorePropertiesKHR");
	set_proc_address(&cmd_push_descriptor_set_khr,                             nil, "vkCmdPushDescriptorSetKHR");
	set_proc_address(&cmd_push_descriptor_set_with_template_khr,               nil, "vkCmdPushDescriptorSetWithTemplateKHR");
	set_proc_address(&cmd_begin_render_pass2_khr,                              nil, "vkCmdBeginRenderPass2KHR");
	set_proc_address(&cmd_next_subpass2_khr,                                   nil, "vkCmdNextSubpass2KHR");
	set_proc_address(&cmd_end_render_pass2_khr,                                nil, "vkCmdEndRenderPass2KHR");
	set_proc_address(&get_physical_device_external_fence_properties_khr,       nil, "vkGetPhysicalDeviceExternalFencePropertiesKHR");
	set_proc_address(&get_physical_device_surface_capabilities2_khr,           nil, "vkGetPhysicalDeviceSurfaceCapabilities2KHR");
	set_proc_address(&get_physical_device_surface_formats2_khr,                nil, "vkGetPhysicalDeviceSurfaceFormats2KHR");
	set_proc_address(&get_physical_device_display_properties2_khr,             nil, "vkGetPhysicalDeviceDisplayProperties2KHR");
	set_proc_address(&get_physical_device_display_plane_properties2_khr,       nil, "vkGetPhysicalDeviceDisplayPlaneProperties2KHR");
	set_proc_address(&get_display_mode_properties2_khr,                        nil, "vkGetDisplayModeProperties2KHR");
	set_proc_address(&get_display_plane_capabilities2_khr,                     nil, "vkGetDisplayPlaneCapabilities2KHR");
	set_proc_address(&cmd_draw_indirect_count_khr,                             nil, "vkCmdDrawIndirectCountKHR");
	set_proc_address(&cmd_draw_indexed_indirect_count_khr,                     nil, "vkCmdDrawIndexedIndirectCountKHR");
	set_proc_address(&debug_report_callback_ext,                               nil, "vkDebugReportCallbackEXT");
	set_proc_address(&cmd_debug_marker_begin_ext,                              nil, "vkCmdDebugMarkerBeginEXT");
	set_proc_address(&cmd_debug_marker_end_ext,                                nil, "vkCmdDebugMarkerEndEXT");
	set_proc_address(&cmd_debug_marker_insert_ext,                             nil, "vkCmdDebugMarkerInsertEXT");
	set_proc_address(&cmd_bind_transform_feedback_buffers_ext,                 nil, "vkCmdBindTransformFeedbackBuffersEXT");
	set_proc_address(&cmd_begin_transform_feedback_ext,                        nil, "vkCmdBeginTransformFeedbackEXT");
	set_proc_address(&cmd_end_transform_feedback_ext,                          nil, "vkCmdEndTransformFeedbackEXT");
	set_proc_address(&cmd_begin_query_indexed_ext,                             nil, "vkCmdBeginQueryIndexedEXT");
	set_proc_address(&cmd_end_query_indexed_ext,                               nil, "vkCmdEndQueryIndexedEXT");
	set_proc_address(&cmd_draw_indirect_byte_count_ext,                        nil, "vkCmdDrawIndirectByteCountEXT");
	set_proc_address(&cmd_draw_indirect_count_amd,                             nil, "vkCmdDrawIndirectCountAMD");
	set_proc_address(&cmd_draw_indexed_indirect_count_amd,                     nil, "vkCmdDrawIndexedIndirectCountAMD");
	set_proc_address(&get_physical_device_external_image_format_properties_nv, nil, "vkGetPhysicalDeviceExternalImageFormatPropertiesNV");
	set_proc_address(&cmd_begin_conditional_rendering_ext,                     nil, "vkCmdBeginConditionalRenderingEXT");
	set_proc_address(&cmd_end_conditional_rendering_ext,                       nil, "vkCmdEndConditionalRenderingEXT");
	set_proc_address(&cmd_process_commands_nvx,                                nil, "vkCmdProcessCommandsNVX");
	set_proc_address(&cmd_reserve_space_for_commands_nvx,                      nil, "vkCmdReserveSpaceForCommandsNVX");
	set_proc_address(&get_physical_device_generated_commands_properties_nvx,   nil, "vkGetPhysicalDeviceGeneratedCommandsPropertiesNVX");
	set_proc_address(&cmd_set_viewport_w_scaling_nv,                           nil, "vkCmdSetViewportWScalingNV");
	set_proc_address(&release_display_ext,                                     nil, "vkReleaseDisplayEXT");
	set_proc_address(&get_physical_device_surface_capabilities2_ext,           nil, "vkGetPhysicalDeviceSurfaceCapabilities2EXT");
	set_proc_address(&cmd_set_discard_rectangle_ext,                           nil, "vkCmdSetDiscardRectangleEXT");
	set_proc_address(&debug_utils_messenger_callback_ext,                      nil, "vkDebugUtilsMessengerCallbackEXT");
	set_proc_address(&cmd_begin_debug_utils_label_ext,                         nil, "vkCmdBeginDebugUtilsLabelEXT");
	set_proc_address(&cmd_end_debug_utils_label_ext,                           nil, "vkCmdEndDebugUtilsLabelEXT");
	set_proc_address(&cmd_insert_debug_utils_label_ext,                        nil, "vkCmdInsertDebugUtilsLabelEXT");
	set_proc_address(&cmd_set_sample_locations_ext,                            nil, "vkCmdSetSampleLocationsEXT");
	set_proc_address(&get_physical_device_multisample_properties_ext,          nil, "vkGetPhysicalDeviceMultisamplePropertiesEXT");
	set_proc_address(&cmd_bind_shading_rate_image_nv,                          nil, "vkCmdBindShadingRateImageNV");
	set_proc_address(&cmd_set_viewport_shading_rate_palette_nv,                nil, "vkCmdSetViewportShadingRatePaletteNV");
	set_proc_address(&cmd_set_coarse_sample_order_nv,                          nil, "vkCmdSetCoarseSampleOrderNV");
	set_proc_address(&cmd_build_acceleration_structure_nvx,                    nil, "vkCmdBuildAccelerationStructureNVX");
	set_proc_address(&cmd_copy_acceleration_structure_nvx,                     nil, "vkCmdCopyAccelerationStructureNVX");
	set_proc_address(&cmd_trace_rays_nvx,                                      nil, "vkCmdTraceRaysNVX");
	set_proc_address(&cmd_write_acceleration_structure_properties_nvx,         nil, "vkCmdWriteAccelerationStructurePropertiesNVX");
	set_proc_address(&cmd_write_buffer_marker_amd,                             nil, "vkCmdWriteBufferMarkerAMD");
	set_proc_address(&get_physical_device_calibrateable_time_domains_ext,      nil, "vkGetPhysicalDeviceCalibrateableTimeDomainsEXT");
	set_proc_address(&cmd_draw_mesh_tasks_nv,                                  nil, "vkCmdDrawMeshTasksNV");
	set_proc_address(&cmd_draw_mesh_tasks_indirect_nv,                         nil, "vkCmdDrawMeshTasksIndirectNV");
	set_proc_address(&cmd_draw_mesh_tasks_indirect_count_nv,                   nil, "vkCmdDrawMeshTasksIndirectCountNV");
	set_proc_address(&cmd_set_exclusive_scissor_nv,                            nil, "vkCmdSetExclusiveScissorNV");
	set_proc_address(&cmd_set_checkpoint_nv,                                   nil, "vkCmdSetCheckpointNV");
}

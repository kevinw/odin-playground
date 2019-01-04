set VULKAN_SDK=C:\VulkanSDK\1.1.92.1

set glslc=%VULKAN_SDK%\Bin\glslangValidator.exe -V

%glslc% vulkan_test\shaders\shader.vert -o vulkan_test\shaders\shader.vert.spv
%glslc% vulkan_test\shaders\shader.frag -o vulkan_test\shaders\shader.frag.spv

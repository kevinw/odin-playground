@set VULKAN_SDK=C:\VulkanSDK\1.1.92.1

@set glslc=%VULKAN_SDK%\Bin\glslangValidator.exe -V

@pushd %~dp0

%glslc% shaders\shader.vert -o shaders\shader.vert.spv
%glslc% shaders\shader.frag -o shaders\shader.frag.spv

@popd

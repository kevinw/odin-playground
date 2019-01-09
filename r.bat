@setlocal

@call vulkan_buffers\compile_shaders.bat
@..\odin\odin run main.odin -vet -debug -opt=0

package main

import "core:fmt"
import "shared:odin-glfw"
import "shared:odin-gl"

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) {
        return;
    }

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}

Vert :: struct {
    x, y: f32,
    r, g, b: f32,
}

// load_shaders :: proc(vertex_shader_filename, fragment_shader_filename: string) -> (program: u32, success: bool)

// get_uniforms_from_program :: proc(program: u32) -> (uniforms: map[string]Uniform_Info)

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "foo";

vertices := []Vert {
    Vert { -0.6, -0.4, 1.0, 0.0, 0.0 },
    Vert {  0.6, -0.4, 0.0, 1.0, 0.0 },
    Vert {   0.,  0.6, 0.0, 0.0, 1.0 }
};

glfw_get_proc_addr :: proc(p: rawptr, name: cstring) {
    (cast(^rawptr)p)^ = glfw.get_proc_address(string(name));
}

run_app :: proc() -> int {
    // fmt.println("Hello");

    window := glfw.init_helper(RES_X, RES_Y, WINDOW_TITLE);
    if window == nil {
        fmt.println("could not create glfw window");
        glfw.terminate();
        return -1;
    }

    glfw.set_key_callback(window, key_callback);

    gl.load_up_to(4, 5, glfw_get_proc_addr);

    for !glfw.window_should_close(window) {
        glfw.poll_events();
        glfw.swap_buffers(window);
    }

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices, gl.STATIC_DRAW);
    
    glfw.terminate();

    return 0;
}

main :: proc() {
    ret_code := run_app(); // TODO: exit with error code   
}

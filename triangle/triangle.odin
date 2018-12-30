package triangle

import "../glutil"

import "shared:odin-glfw"
import "shared:odin-gl"

import "core:mem"
import "core:fmt"
import "core:math";
import "core:strings"

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "glfw triangle";
GL_VERSION_MAJOR :: 4;
GL_VERSION_MINOR :: 3;

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}

run :: proc() -> int {
    window := glfw.init_helper(RES_X, RES_Y, WINDOW_TITLE, GL_VERSION_MAJOR, GL_VERSION_MINOR);

    gl.load_up_to(4, 5, glfw.set_proc_address);

    glutil.log_all_errors();

    fmt.println("Renderer: ", cstring(gl.GetString(gl.RENDERER)));
    fmt.println("OpenGL version supported ", cstring(gl.GetString(gl.VERSION)));

    gl.Enable(gl.DEBUG_OUTPUT);
    gl.DebugMessageControl(gl.DONT_CARE, gl.DONT_CARE, gl.DONT_CARE, 0, nil, gl.TRUE);
    gl.DebugMessageCallback(glutil.on_debug_message, nil);

    defer glfw.terminate();
    if window == nil {
        fmt.println("could not create glfw window");
        return -1;
    }

    glfw.set_key_callback(window, key_callback);
    
    program, ok := gl.load_shaders_file("triangle/shaders/vert.glsl", "triangle/shaders/frag.glsl");
    if !ok {
        fmt.println("error: cannot load shaders");
        return -1;
    }

    //uniforms := gl.get_uniforms_from_program(program);
    //defer gl.destroy_uniforms(uniforms);

    vertex_array_id : u32 = ---;
    gl.GenVertexArrays(1, &vertex_array_id);
    gl.BindVertexArray(vertex_array_id);

    vertex_buffer_data := [9]f32 {
        -1.0, -1.0, 0.0,
        1.0, -1.0, 0.0,
        0.0,  1.0, 0.0,
    };

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertex_buffer_data), &vertex_buffer_data, gl.STATIC_DRAW);

    for !glfw.window_should_close(window) {
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

        gl.UseProgram(program);
        gl.EnableVertexAttribArray(0);
        gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
        gl.VertexAttribPointer(
            0, // attribute 0
            3, // size
            gl.FLOAT, // type
            gl.FALSE, // normalized?
            0, // stride
            nil // array buffer offset
        );

        gl.DrawArrays(gl.TRIANGLES, 0, 3);
        gl.DisableVertexAttribArray(0);

        glfw.swap_buffers(window);
        glfw.poll_events();
    }

    glfw.destroy_window(window);

    return 0;
}


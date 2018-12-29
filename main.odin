package main

import "core:fmt"
import "shared:odin-glfw"
import "shared:odin-gl"

import "core:math"; // using import "linmath"

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) {
        return;
    }

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}

Vert :: struct #packed {
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
    defer glfw.terminate();
    if window == nil {
        fmt.println("could not create glfw window");
        return -1;
    }

    glfw.set_key_callback(window, key_callback);

    gl.load_up_to(4, 5, glfw_get_proc_addr);

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices, gl.STATIC_DRAW);

    program, ok := gl.load_shaders_file("shaders/vert.glsl", "shaders/frag.glsl");
    if !ok {
        fmt.println("error: cannot load shaders");
        return -1;
    }

    uniforms := gl.get_uniforms_from_program(program);
    defer gl.destroy_uniforms(uniforms);

    /* for key, value in uniforms {
        fmt.println(key, value);
    } */

    mvp_location := uniforms["MVP"].location;
    vpos_location := gl.get_attribute_location(program, "vPos");
    vcol_location := gl.get_attribute_location(program, "vCol");

    {
        gl.EnableVertexAttribArray(cast(u32)vpos_location);
        ptr : i32 = 0;
        gl.VertexAttribPointer(cast(u32)vpos_location, 2, gl.FLOAT, gl.FALSE, size_of(f32) * 5, &ptr);
    }

    {
        gl.EnableVertexAttribArray(cast(u32)vcol_location);
        ptr : i32 = size_of(f32) * 2;
        gl.VertexAttribPointer(cast(u32)vcol_location, 3, gl.FLOAT, gl.FALSE, size_of(f32) * 5, &ptr);
    }

    for !glfw.window_should_close(window) {
        using math;

        width, height := glfw.get_framebuffer_size(window);
        ratio : f32 = cast(f32)width / cast(f32)height;

        gl.Viewport(0, 0, cast(i32)width, cast(i32)height);

        m := mul(identity(Mat4), mat4_rotate(Vec3 { 0, 0, 1 }, cast(f32)glfw.get_time()));
        p := ortho3d(-ratio, ratio, -1., 1., 1., -1.);
        mvp := mul(p, m);

        gl.UseProgram(program);
        gl.UniformMatrix4fv(mvp_location, 1, gl.FALSE, &mvp[0][0]);
        gl.DrawArrays(gl.TRIANGLES, 0, 3);

        glfw.swap_buffers(window);
        glfw.poll_events();
    }
    
    return 0;
}

main :: proc() {
    ret_code := run_app(); // TODO: exit with error code   
}

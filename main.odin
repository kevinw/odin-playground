package main

import "core:mem"
import "core:fmt"
import "core:strings"
import "shared:odin-glfw"
import "shared:odin-gl"

import "core:math";

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

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
GL_VERSION_MAJOR :: 4;
GL_VERSION_MINOR :: 3;

vertices := []Vert {
    Vert { -0.6, -0.4, 1.0, 0.0, 0.0 },
    Vert {  0.6, -0.4, 0.0, 1.0, 0.0 },
    Vert {   0.,  0.6, 0.0, 0.0, 1.0 }
};

glfw_get_proc_addr :: proc(p: rawptr, name: cstring) {
    (cast(^rawptr)p)^ = glfw.get_proc_address(string(name));
}

// debug_proc_t :: #type proc "c" (source: u32, type_: u32, id: u32, severity: u32, length: i32, message: ^u8, userParam: rawptr);

debug_message_cb :: proc "c" (source : u32, type : u32, id: u32, severity: u32, length: i32, c_message: ^u8, userParam: rawptr) {
    message_len := str_len(c_message);
    message := strings.string_from_ptr(c_message, message_len);

    fmt.println(message);
    
    //msg := cast(string)message;
    //fmt.printf("GL CALLBACK: %v type = %v, severity = %v, message = %v\n",
            //(type == gl.DEBUG_TYPE_ERROR ? "** GL ERROR **" : ""),
            //type, severity, msg);
}

str_len :: proc(bytes: ^u8) -> int { // TODO: Put this in a library (or find the equiv in core?).
    count := 0;
    for {
        char := mem.ptr_offset(bytes, count)^;
        if char == 0 do break;
        count += 1;
    }

    return count;
}

run_app :: proc() -> int {
    // fmt.println("Hello");
    window := glfw.init_helper(RES_X, RES_Y, WINDOW_TITLE, GL_VERSION_MAJOR, GL_VERSION_MINOR);

    gl.load_up_to(4, 5, glfw_get_proc_addr);

    gl.Enable(gl.DEBUG_OUTPUT);
    gl.DebugMessageCallback(debug_message_cb, nil);

    defer glfw.terminate();
    if window == nil {
        fmt.println("could not create glfw window");
        return -1;
    }

    glfw.set_key_callback(window, key_callback);

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW);

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

        m := mul(mat4_rotate(Vec3 { 0, 0, 1 }, cast(f32)glfw.get_time()), identity(Mat4));
        p := ortho3d(-ratio, ratio, -1., 1., 1., -1.);
        mvp := mul(p, m);

        gl.ClearColor(1, 0, 1, 1);
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

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

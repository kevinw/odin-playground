package main

import "core:mem"
import "core:fmt"
import "core:math";
import "core:strings"

import "shared:odin-glfw"
import bind "shared:odin-glfw/bindings"
import "shared:odin-gl"

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "foo";
GL_VERSION_MAJOR :: 4;
GL_VERSION_MINOR :: 3;

Vert :: struct #packed {
    x, y: f32,
    r, g, b: f32,
}

vertices := []Vert {
    Vert { -0.6, -0.4, 1.0, 0.0, 0.0 },
    Vert {  0.6, -0.4, 0.0, 1.0, 0.0 },
    Vert {   0.,  0.6, 0.0, 0.0, 1.0 }
};

gl_log_type_to_string :: proc(type:u32) -> string {
    switch (type) {
        case gl.DEBUG_TYPE_ERROR: return "Error";
        case gl.DEBUG_TYPE_DEPRECATED_BEHAVIOR: return "Deprecated behavior";
        case gl.DEBUG_TYPE_UNDEFINED_BEHAVIOR: return "Undefined behavior";
        case gl.DEBUG_TYPE_PORTABILITY: return "Portability issue";
        case gl.DEBUG_TYPE_PERFORMANCE: return "Performance issue";
        case gl.DEBUG_TYPE_MARKER: return "Stream annotation";
        case gl.DEBUG_TYPE_OTHER_ARB: return "Other";
        case:
              assert(false);
              return "";
    }
}

gl_log_source_to_string :: proc(source:u32) -> string {
    switch (source) {
        case gl.DEBUG_SOURCE_API: return "API";
        case gl.DEBUG_SOURCE_WINDOW_SYSTEM: return "Window system";
        case gl.DEBUG_SOURCE_SHADER_COMPILER: return "Shader compiler";
        case gl.DEBUG_SOURCE_THIRD_PARTY: return "Third party";
        case gl.DEBUG_SOURCE_APPLICATION: return "Application";
        case gl.DEBUG_SOURCE_OTHER: return "Other";
        case:
            assert(false);
            return "";
    }
}

gl_log_severity_to_string :: proc(severity:u32) -> string
{
    switch (severity) {
        case gl.DEBUG_SEVERITY_HIGH: return "High";
        case gl.DEBUG_SEVERITY_MEDIUM: return "Medium";
        case gl.DEBUG_SEVERITY_LOW: return "Low";
        case gl.DEBUG_SEVERITY_NOTIFICATION: return "Info";
        case:
            assert(false);
            return("");
    }
}

debug_message_cb :: proc "c" (source : u32, type : u32, id: u32, severity: u32, length: i32, message: ^u8, userParam: rawptr) {
    fmt.printf("(%s) [%s] %s\n", gl_log_severity_to_string(severity), gl_log_source_to_string(source), cstring(message));
}

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }
}

log_all_errors :: proc() {
    for {
        error := gl.GetError();
        if error == gl.NO_ERROR do break;

        switch (error) {
            case gl.INVALID_ENUM: fmt.println("Error: GL_INVALID_ENUM");
            case gl.INVALID_VALUE: fmt.println("Error: GL_INVALID_VALUE");
            case gl.INVALID_OPERATION: fmt.println("Error: GL_INVALID_OPERATION");
            case gl.INVALID_FRAMEBUFFER_OPERATION: fmt.println("Error: GL_INVALID_FRAMEBUFFER_OPERATION");
            case gl.OUT_OF_MEMORY: fmt.println("Error: GL_OUT_OF_MEMORY");
            case gl.STACK_UNDERFLOW: fmt.println("Error: GL_STACK_UNDERFLOW");
            case gl.STACK_OVERFLOW: fmt.println("Error: GL_STACK_OVERFLOW");
            case:
                assert(false);
        }
    }
}


init_helper :: proc(resx := 1280, resy := 720, title := "Window title", version_major := 3, version_minor := 3, samples := 0, vsync := false) -> glfw.Window_Handle {
    //
    error_callback :: proc"c"(error: i32, desc: cstring) {
        fmt.printf("Error code %d: %s\n", error, desc);
    }

    bind.SetErrorCallback(error_callback);

    //
    if bind.Init() == bind.FALSE do return nil;

    //
    if samples > 0 do bind.WindowHint(bind.SAMPLES, i32(samples));
    //bind.WindowHint(bind.DECORATED, 1);
    bind.WindowHint(bind.CONTEXT_VERSION_MAJOR, i32(version_major));
    bind.WindowHint(bind.CONTEXT_VERSION_MINOR, i32(version_minor));
    bind.WindowHint(bind.OPENGL_PROFILE, bind.OPENGL_CORE_PROFILE);

    //
    window := glfw.create_window(int(resx), int(resy), title, nil, nil);
    if window == nil do return nil;

    //
    bind.MakeContextCurrent(window);
    bind.SwapInterval(i32(vsync));

    return window;
}

run_app :: proc() -> int {
    // fmt.println("Hello");
    window := init_helper(RES_X, RES_Y, WINDOW_TITLE, GL_VERSION_MAJOR, GL_VERSION_MINOR);

    gl.load_up_to(4, 5, glfw.set_proc_address);

    log_all_errors();

    // get version info
    fmt.println("Renderer: ", cstring(gl.GetString(gl.RENDERER)));
    fmt.println("OpenGL version supported ", cstring(gl.GetString(gl.VERSION)));

    gl.Enable(gl.DEBUG_OUTPUT);
    gl.DebugMessageControl(gl.DONT_CARE, gl.DONT_CARE, gl.DONT_CARE, 0, nil, gl.TRUE);
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

    // missing from the glfw demo
    vao:u32 = ---;
    gl.GenVertexArrays(1, &vao);
    gl.BindVertexArray(vao);

    {
        gl.EnableVertexAttribArray(cast(u32)vpos_location);
        ptr : ^u32 = nil;
        gl.VertexAttribPointer(cast(u32)vpos_location, 2, gl.FLOAT, gl.FALSE, size_of(f32) * 5, ptr);
    }

    {
        gl.EnableVertexAttribArray(cast(u32)vcol_location);
        ptr : u32 = size_of(f32) * 2;
        gl.VertexAttribPointer(cast(u32)vcol_location, 3, gl.FLOAT, gl.FALSE, size_of(f32) * 5, &ptr);
    }

    for !glfw.window_should_close(window) {
        using math;

        width, height := glfw.get_framebuffer_size(window);
        ratio : f32 = cast(f32)width / cast(f32)height;

        gl.Viewport(0, 0, cast(i32)width, cast(i32)height);
        gl.Clear(gl.COLOR_BUFFER_BIT);

        m := mul(mat4_rotate(Vec3 { 0, 0, 1 }, cast(f32)glfw.get_time()), identity(Mat4));
        p := ortho3d(-ratio, ratio, -1., 1., 1., -1.);
        mvp := mul(p, m);

        gl.UseProgram(program);
        gl.UniformMatrix4fv(mvp_location, 1, gl.FALSE, &mvp[0][0]);
        gl.DrawArrays(gl.TRIANGLES, 0, 3);

        glfw.swap_buffers(window);
        glfw.poll_events();
    }

    glfw.destroy_window(window);

    return 0;
}

main :: proc() {
    ret_code := run_app(); // TODO: exit with error code   
}


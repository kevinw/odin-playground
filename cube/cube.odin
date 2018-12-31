package cube

import "../glutil"

import "shared:odin-glfw"
import "shared:odin-gl"

import "core:fmt"
import "core:math";

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "cube";
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
    
    program, ok := gl.load_shaders_file("cube/shaders/vert.glsl", "cube/shaders/frag.glsl");
    if !ok {
        fmt.println("error: cannot load shaders");
        return -1;
    }

    //uniforms := gl.get_uniforms_from_program(program);
    //defer gl.destroy_uniforms(uniforms);

    vertex_array_id : u32 = ---;
    gl.GenVertexArrays(1, &vertex_array_id);
    gl.BindVertexArray(vertex_array_id);

    // Our vertices. Three consecutive floats give a 3D vertex; Three consecutive vertices give a triangle.
    // A cube has 6 faces with 2 triangles each, so this makes 6*2=12 triangles, and 12*3 vertices
    vertex_buffer_data := []f32 {
        -1.0,-1.0,-1.0, // triangle 1 : begin
        -1.0,-1.0, 1.0,
        -1.0, 1.0, 1.0, // triangle 1 : end
        1.0, 1.0,-1.0, // triangle 2 : begin
        -1.0,-1.0,-1.0,
        -1.0, 1.0,-1.0, // triangle 2 : end
        1.0,-1.0, 1.0,
        -1.0,-1.0,-1.0,
        1.0,-1.0,-1.0,
        1.0, 1.0,-1.0,
        1.0,-1.0,-1.0,
        -1.0,-1.0,-1.0,
        -1.0,-1.0,-1.0,
        -1.0, 1.0, 1.0,
        -1.0, 1.0,-1.0,
        1.0,-1.0, 1.0,
        -1.0,-1.0, 1.0,
        -1.0,-1.0,-1.0,
        -1.0, 1.0, 1.0,
        -1.0,-1.0, 1.0,
        1.0,-1.0, 1.0,
        1.0, 1.0, 1.0,
        1.0,-1.0,-1.0,
        1.0, 1.0,-1.0,
        1.0,-1.0,-1.0,
        1.0, 1.0, 1.0,
        1.0,-1.0, 1.0,
        1.0, 1.0, 1.0,
        1.0, 1.0,-1.0,
        -1.0, 1.0,-1.0,
        1.0, 1.0, 1.0,
        -1.0, 1.0,-1.0,
        -1.0, 1.0, 1.0,
        1.0, 1.0, 1.0,
        -1.0, 1.0, 1.0,
        1.0,-1.0, 1.0
    };

    color_buffer_data := []f32 {
        0.583,  0.771,  0.014,
        0.609,  0.115,  0.436,
        0.327,  0.483,  0.844,
        0.822,  0.569,  0.201,
        0.435,  0.602,  0.223,
        0.310,  0.747,  0.185,
        0.597,  0.770,  0.761,
        0.559,  0.436,  0.730,
        0.359,  0.583,  0.152,
        0.483,  0.596,  0.789,
        0.559,  0.861,  0.639,
        0.195,  0.548,  0.859,
        0.014,  0.184,  0.576,
        0.771,  0.328,  0.970,
        0.406,  0.615,  0.116,
        0.676,  0.977,  0.133,
        0.971,  0.572,  0.833,
        0.140,  0.616,  0.489,
        0.997,  0.513,  0.064,
        0.945,  0.719,  0.592,
        0.543,  0.021,  0.978,
        0.279,  0.317,  0.505,
        0.167,  0.620,  0.077,
        0.347,  0.857,  0.137,
        0.055,  0.953,  0.042,
        0.714,  0.505,  0.345,
        0.783,  0.290,  0.734,
        0.722,  0.645,  0.174,
        0.302,  0.455,  0.848,
        0.225,  0.587,  0.040,
        0.517,  0.713,  0.338,
        0.053,  0.959,  0.120,
        0.393,  0.621,  0.362,
        0.673,  0.211,  0.457,
        0.820,  0.883,  0.371,
        0.982,  0.099,  0.879
    };

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, len(vertex_buffer_data) * size_of(f32), &vertex_buffer_data[0], gl.STATIC_DRAW);

    color_buffer: u32 = ---;
    gl.GenBuffers(1, &color_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, color_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, len(color_buffer_data) * size_of(f32), &color_buffer_data[0], gl.STATIC_DRAW);

    projection := math.perspective(45, cast(f32)RES_X / cast(f32)RES_Y, 0.1, 100);
    view := math.look_at(
        math.Vec3{4, 3, 3}, // eye
        math.Vec3{0, 0, 0}, // center (target to look at)
        math.Vec3{0, 1, 0}, // up
    );
    model := math.identity(math.Mat4);
    mvp := math.mul(math.mul(projection, view), model);

    mvp_id := gl.get_uniform_location(program, "MVP");


    for !glfw.window_should_close(window) {
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

        gl.UseProgram(program);
        gl.UniformMatrix4fv(mvp_id, 1, gl.FALSE, &mvp[0][0]);

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

        gl.EnableVertexAttribArray(1);
        gl.BindBuffer(gl.ARRAY_BUFFER, color_buffer);
        gl.VertexAttribPointer(
            1,
            3, // size
            gl.FLOAT, // type
            gl.FALSE, // normalized
            0, // stride
            nil, // array buffer offset
        );



        gl.DrawArrays(gl.TRIANGLES, 0, 12 * 3);
        gl.DisableVertexAttribArray(0);
        gl.DisableVertexAttribArray(1);

        glfw.swap_buffers(window);
        glfw.poll_events();
    }

    glfw.destroy_window(window);

    return 0;
}


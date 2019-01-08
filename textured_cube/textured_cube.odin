package cube

import "../glutil"

import "shared:odin-glfw"
import "shared:odin-gl"
import "shared:odin-stb/stbi"

import "core:fmt"
import "core:math";

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "textured_cube";
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
    
    program, ok := gl.load_shaders_file("textured_cube/shaders/vert.glsl", "textured_cube/shaders/frag.glsl");
    if !ok {
        fmt.println("error: cannot load shaders");
        return -1;
    }

    // load image
    image_width, image_height, image_channels_in_file : i32;
    image_path := cstring("textured_cube/assets/cube_texture_debug.png");
    image_data := stbi.load(cast(^u8)image_path, &image_width, &image_height, &image_channels_in_file, 0);
    if image_data == nil {
        fmt.println("could not load image", image_path);
        return -1;
    }
    defer stbi.image_free(image_data);

    texture_id : u32;
    gl.GenTextures(1, &texture_id);
    gl.BindTexture(gl.TEXTURE_2D, texture_id);
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA, image_width, image_height, 0, gl.RGB, gl.UNSIGNED_BYTE, image_data);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);


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

    uv_buffer_data := []f32 {
        0.000059, 1.0-0.000004,
        0.000103, 1.0-0.336048,
        0.335973, 1.0-0.335903,
        1.000023, 1.0-0.000013,
        0.667979, 1.0-0.335851,
        0.999958, 1.0-0.336064,
        0.667979, 1.0-0.335851,
        0.336024, 1.0-0.671877,
        0.667969, 1.0-0.671889,
        1.000023, 1.0-0.000013,
        0.668104, 1.0-0.000013,
        0.667979, 1.0-0.335851,
        0.000059, 1.0-0.000004,
        0.335973, 1.0-0.335903,
        0.336098, 1.0-0.000071,
        0.667979, 1.0-0.335851,
        0.335973, 1.0-0.335903,
        0.336024, 1.0-0.671877,
        1.000004, 1.0-0.671847,
        0.999958, 1.0-0.336064,
        0.667979, 1.0-0.335851,
        0.668104, 1.0-0.000013,
        0.335973, 1.0-0.335903,
        0.667979, 1.0-0.335851,
        0.335973, 1.0-0.335903,
        0.668104, 1.0-0.000013,
        0.336098, 1.0-0.000071,
        0.000103, 1.0-0.336048,
        0.000004, 1.0-0.671870,
        0.336024, 1.0-0.671877,
        0.000103, 1.0-0.336048,
        0.336024, 1.0-0.671877,
        0.335973, 1.0-0.335903,
        0.667969, 1.0-0.671889,
        1.000004, 1.0-0.671847,
        0.667979, 1.0-0.335851
    };

    vertex_buffer : u32 = ---;
    gl.GenBuffers(1, &vertex_buffer);
    defer gl.DeleteBuffers(1, &vertex_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, len(vertex_buffer_data) * size_of(f32), &vertex_buffer_data[0], gl.STATIC_DRAW);

    uv_buffer: u32 = ---;
    gl.GenBuffers(1, &uv_buffer);
    defer gl.DeleteBuffers(1, &uv_buffer);
    gl.BindBuffer(gl.ARRAY_BUFFER, uv_buffer);
    gl.BufferData(gl.ARRAY_BUFFER, len(uv_buffer_data) * size_of(f32), &uv_buffer_data[0], gl.STATIC_DRAW);

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
        gl.BindBuffer(gl.ARRAY_BUFFER, uv_buffer);
        gl.VertexAttribPointer(
            1, // attribute 2
            2, // size
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


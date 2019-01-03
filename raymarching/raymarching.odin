package raymarching

import "../glutil"
import "../camera"
import "../path"
import "../gui"

import "shared:odin-glfw"
import "shared:odin-gl"
import "shared:odin-imgui"

import "core:fmt"
import "core:math";
import "core:os"

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "raymarching";
GL_VERSION_MAJOR :: 4;
GL_VERSION_MINOR :: 5;

flycam := camera.FlyControls {};

Shader :: struct {
    id: u32,
    last_vertex_time: os.File_Time,
    last_fragment_time: os.File_Time,
    vertex_filename: string,
    fragment_filename: string,
}

Shader_init :: proc(
    program: ^Shader,
    vertex_filename: string,
    fragment_filename: string,
) -> bool {
    program.vertex_filename = vertex_filename;
    program.fragment_filename = fragment_filename;
    return Shader_update_if_changed(program);
}

Shader_update_if_changed :: proc(
    using program: ^Shader,
) -> bool {
    shaders_updated := false;
    id, last_vertex_time, last_fragment_time, shaders_updated = 
        gl.update_shader_if_changed(
            vertex_filename, fragment_filename, id, last_vertex_time, last_fragment_time);

    return shaders_updated;
}

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }

    if key == i32(glfw.KEY_SPACE) do flycam.enabled = !flycam.enabled;
}

run :: proc() -> int {
    camera.FlyControls_init(&flycam);

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
    glfw.set_input_mode(window, glfw.CURSOR, auto_cast glfw.CURSOR_DISABLED);

    // init gui
    gui_state : gui.State;
    gui.init(&gui_state, window);
    defer gui.deinit(&gui_state);

    vertex_name := fmt.tprint(path.dir_name(#file), "/shaders/vert.glsl");
    fragment_name := fmt.tprint(path.dir_name(#file), "/shaders/frag.glsl");

    program : Shader;
    success := Shader_init(&program, vertex_name, fragment_name);
    if !success {
        fmt.println("error: cannot load raymarching shaders");
        return -1;
    }

    cube_program : Shader;
    success2 := Shader_init(&cube_program, "cube/shaders/vert.glsl", "cube/shaders/frag.glsl");
    if !success2 {
        fmt.println("error: cannot load cube shaders");
        return -1;
    }

    // set clip space Z range to [0, 1], not [-1, +1]
    // thanks https://nlguillemot.wordpress.com/2016/12/07/reversed-z-in-opengl/
    //gl.ClipControl(gl.LOWER_LEFT, gl.ZERO_TO_ONE); 

    // Array object. needed to draw elements
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

    //projection := math.perspective(45, cast(f32)RES_X / cast(f32)RES_Y, 0.1, 100);
    //model := math.identity(math.Mat4);

    last_time := glfw.get_time();

    view := math.Mat4 {};

    gl.Enable(gl.CULL_FACE);

    cam := camera.Camera {};
    {
        window_width, window_height := glfw.get_window_size(window);
        aspect := cast(f32)(cast(f32)window_height / cast(f32)window_width);
        camera.init(&cam, aspect);
        cam.position = math.Vec3 { 0, 0.2, -3.6 };
    }

    SHADER_UPDATE_INTERVAL :: 0.3;
    next_shader_update := last_time + SHADER_UPDATE_INTERVAL;

    //gl.DepthMask(gl.TRUE);
    //gl.DepthFunc(gl.LESS);
    gl.Enable(gl.DEPTH_TEST);

    frustum_corners : [8]math.Vec3 = ---;

    frame_count := 0;

    for !glfw.window_should_close(window) {
        frame_count += 1;

        window_width, window_height := glfw.get_window_size(window);

        current_time := glfw.get_time();
        delta_time := cast(f32)(current_time - last_time);

        camera.FlyControls_update(window, &cam, &flycam, delta_time);
        camera.view_matrix(&cam, &view);

        camera.frustum_corners(&cam, frustum_corners);
        //fmt.println(frustum_corners);

        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
        /*

        mvp := math.mul(math.mul(projection, view), model);

        { // RAYMARCH

            aspect := cast(f32)(cast(f32)window_height / cast(f32)window_width);
            time_id := gl.get_uniform_location(program.id, "time");
            projectionMatrixId := gl.get_uniform_location(program.id, "projectionMatrix");
            worldSpaceCameraPosId := gl.get_uniform_location(program.id, "worldSpaceCameraPos");
            projectionParamsId := gl.get_uniform_location(program.id, "projectionParams");
            gl.UseProgram(program.id);
            gl.Uniform1f(gl.get_uniform_location(program.id, "aspect"), aspect);
            gl.Uniform1f(time_id, cast(f32)glfw.get_time());
            gl.UniformMatrix4fv(projectionMatrixId, 1, gl.FALSE, &projection[0][0]);
            gl.Uniform3fv(worldSpaceCameraPosId, 1, &cam.position[0]);
            gl.Uniform3fv(gl.get_uniform_location(program.id, "cam_forward"), 1, &cam.forward[0]);
            gl.Uniform3fv(gl.get_uniform_location(program.id, "cam_up"), 1, &cam.up[0]);
            gl.Uniform3fv(gl.get_uniform_location(program.id, "cam_right"), 1, &cam.right[0]);
            projectionParams := math.Vec4 { -1.0, cam.near, cam.far, cast(f32)(1.0 / cam.far) };
            gl.Uniform4fv(projectionParamsId, 1, &projectionParams[0]);
            gl.DrawArrays(gl.TRIANGLES, 0, 3);
        }

        { // CUBE
            gl.UseProgram(cube_program.id);
            gl.UniformMatrix4fv(gl.get_uniform_location(cube_program.id, "MVP"), 1, gl.FALSE, &mvp[0][0]); // TODO: don't do get_uniform_location every frame

            gl.EnableVertexAttribArray(0);
            gl.BindBuffer(gl.ARRAY_BUFFER, vertex_buffer);
            gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, 0, nil);

            gl.EnableVertexAttribArray(1);
            gl.BindBuffer(gl.ARRAY_BUFFER, color_buffer);
            gl.VertexAttribPointer(1, 3, gl.FLOAT, gl.FALSE, 0, nil);

            gl.DrawArrays(gl.TRIANGLES, 0, 12 * 3);
            gl.DisableVertexAttribArray(0);
            gl.DisableVertexAttribArray(1);
        }
        */


        // GUI
        {
            frame_state : gui.Frame_State;
            {
                frame_state.deltatime = delta_time;
                frame_state.window_width = window_width;
                frame_state.window_height = window_height;
                frame_state.window_focus = 0 != glfw.get_window_attrib(window, glfw.FOCUSED);

                xpos, ypos := glfw.get_cursor_pos(window);
                frame_state.mouse_x = int(xpos);
                frame_state.mouse_y = int(ypos);
                frame_state.mouse_wheel = 0; // TODO
                frame_state.left_mouse = 0 != glfw.get_mouse_button(window, glfw.MOUSE_BUTTON_LEFT);
                frame_state.right_mouse = 0 != glfw.get_mouse_button(window, glfw.MOUSE_BUTTON_RIGHT);
            }
            gui.begin_new_frame(window, &frame_state);
        }

        imgui.show_demo_window();


        gui.render_proc(&gui_state, true);
        glfw.swap_buffers(window);
        glfw.poll_events();
        glfw.calculate_frame_timings(window);

        if current_time > next_shader_update {
            Shader_update_if_changed(&program);
            Shader_update_if_changed(&cube_program);
            next_shader_update = current_time + SHADER_UPDATE_INTERVAL;
        }

        last_time = current_time;
    }

    glfw.destroy_window(window);

    return 0;
}


package input

import "../glutil"
import "../controls"

import "shared:odin-glfw"
import "shared:odin-gl"
import "shared:odin-stb/stbi"

import "core:fmt"
import "core:math";
import "core:mem"
import "core:os"
import "core:strings"

RES_X := 1280;
RES_Y := 720;
WINDOW_TITLE := "raymarching";
GL_VERSION_MAJOR :: 4;
GL_VERSION_MINOR :: 3;

flycam := controls.new_flycam();

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if action != i32(glfw.PRESS) do return;

    if key == i32(glfw.KEY_ESCAPE) || key == i32(glfw.KEY_Q) {
        glfw.set_window_should_close(window, true);
    }

    if key == i32(glfw.KEY_SPACE) do flycam.enabled = !flycam.enabled;
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
    glfw.set_input_mode(window, glfw.CURSOR, auto_cast glfw.CURSOR_DISABLED);

    vertex_name :: "raymarching/shaders/vert.glsl";
    fragment_name :: "raymarching/shaders/frag.glsl";

    last_vertex_time := os.File_Time(0);
    last_fragment_time := os.File_Time(0);
    shaders_updated := false;
    program :u32 = 0;

    program, last_vertex_time, last_fragment_time, shaders_updated = gl.update_shader_if_changed(vertex_name, fragment_name, 0, os.File_Time(0), os.File_Time(0));
    if !shaders_updated {
        fmt.println("error: cannot load shaders");
        return -1;
    }

    // Array object. needed to draw elements
    vertex_array_id : u32 = ---;
    gl.GenVertexArrays(1, &vertex_array_id);
    gl.BindVertexArray(vertex_array_id);

    projection := math.perspective(45, cast(f32)RES_X / cast(f32)RES_Y, 0.1, 100);
    model := math.identity(math.Mat4);

    mvp_id := gl.get_uniform_location(program, "MVP");
    aspect_id := gl.get_uniform_location(program, "aspect");
    time_id := gl.get_uniform_location(program, "time");

    last_time := glfw.get_time();

    view := math.Mat4 {};

    gl.Enable(gl.CULL_FACE);

    for !glfw.window_should_close(window) {

        window_width, window_height := glfw.get_window_size(window);
        aspect := cast(f32)(cast(f32)window_height / cast(f32)window_width);

        current_time := glfw.get_time();
        delta_time := cast(f32)(current_time - last_time);

        controls.update_flycam(window, &flycam, delta_time);
        controls.flycam_view_matrix(&flycam, &view);

        mvp := math.mul(math.mul(projection, view), model);

        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

        gl.UseProgram(program);
        gl.UniformMatrix4fv(mvp_id, 1, gl.FALSE, &mvp[0][0]);
        gl.Uniform1f(aspect_id, aspect);
        gl.Uniform1f(time_id, cast(f32)glfw.get_time());

        gl.DrawArrays(gl.TRIANGLES, 0, 3);

        glfw.swap_buffers(window);
        glfw.poll_events();
        glfw.calculate_frame_timings(window);

        updated := false;
        program, last_vertex_time, last_fragment_time, updated = gl.update_shader_if_changed(vertex_name, fragment_name, program, last_vertex_time, last_fragment_time);

        last_time = current_time;
    }

    glfw.destroy_window(window);

    return 0;
}


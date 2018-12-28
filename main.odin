package main

import "core:fmt"
import "shared:odin-glfw"
import "shared:odin-gl"

key_callback :: proc "c" (window: glfw.Window_Handle, key: i32, scancode: i32, action: i32, mods: i32) {
    if key == i32(glfw.KEY_ESCAPE) && action == i32(glfw.PRESS) {
        glfw.set_window_should_close(window, true);
    }
}

main :: proc() {
    fmt.println("Hello");
    window := glfw.init_helper();
    if window == nil {
        fmt.println("could not create glfw window");
        return;
    }

    glfw.set_key_callback(window, key_callback);

    gl.load_up_to(4, 5, 
        //proc(p: rawptr, name: string) do (cast(^rawptr)p)^ = glfw.get_proc_address(&name[0]); );
        proc(p: rawptr, name: cstring) {
            (cast(^rawptr)p)^ = glfw.get_proc_address(string(name));
        }
    );

    for !glfw.window_should_close(window) {
        glfw.poll_events();
        glfw.swap_buffers(window);
    }
    
    glfw.terminate();
}

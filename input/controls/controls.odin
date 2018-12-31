package controls;

using import "core:math"
import glfw "shared:odin-glfw"

_TAU_OVER_FOUR := cast(f32)(math.TAU / 4.0);

FlyCam :: struct {
    position: Vec3,
    horizontal_angle: f32,
    vertical_angle: f32,

    direction: Vec3,
    right: Vec3,
    up: Vec3,

    enabled: bool,
}

new_flycam :: proc() -> FlyCam {
    return FlyCam {
        position = math.Vec3{ 0, 0, 5 },
        horizontal_angle = 3.1,
        vertical_angle = 0,
        enabled = true,
    };
}

flycam_view_matrix :: proc(using flycam: ^FlyCam, mat: ^math.Mat4) {
    mat^ = look_at(
        position,
        position + direction,
        up
    );
}

update_flycam :: proc(window: glfw.Window_Handle, using flycam: ^FlyCam, delta_time: f32) {
    // if not focused, don't fly around
    if 0 == glfw.get_window_attrib(window, glfw.FOCUSED) do return;

    if !enabled do return;

    window_w, window_h := glfw.get_window_size(window);
    center_x := cast(f64)window_w / cast(f64)2;
    center_y := cast(f64)window_h / cast(f64)2;

    initial_fov:f32 = 45;

    speed:f32 = 3;
    mouse_speed:f32 = 1.0;

    xpos, ypos := glfw.get_cursor_pos(window);

    glfw.set_cursor_pos(window, auto_cast center_x, auto_cast center_y);

    horizontal_angle += mouse_speed * delta_time * cast(f32)(center_x - xpos);
    vertical_angle += mouse_speed * delta_time * cast(f32)(center_y - ypos);

    direction = Vec3 {
        cos(vertical_angle) * sin(horizontal_angle),
        sin(vertical_angle),
        cos(vertical_angle) * cos(horizontal_angle)
    };

    right = Vec3{
        sin(horizontal_angle - _TAU_OVER_FOUR),
        0,
        cos(horizontal_angle - _TAU_OVER_FOUR)
    };

    up = cross(right, direction);

    up_pressed := glfw.get_key(window, glfw.KEY_UP) || glfw.get_key(window, glfw.KEY_W);
    down_pressed := glfw.get_key(window, glfw.KEY_DOWN) || glfw.get_key(window, glfw.KEY_S);
    left_pressed := glfw.get_key(window, glfw.KEY_LEFT) || glfw.get_key(window, glfw.KEY_A);
    right_pressed := glfw.get_key(window, glfw.KEY_RIGHT) || glfw.get_key(window, glfw.KEY_D);

    raise_pressed := glfw.get_key(window, glfw.KEY_E);
    crouch_pressed := glfw.get_key(window, glfw.KEY_C);

    if up_pressed do position += direction * delta_time * speed;
    if down_pressed do position -= direction * delta_time * speed;

    if right_pressed do position += right * delta_time * speed;
    if left_pressed do position -= right * delta_time * speed;

    if raise_pressed do position += up * delta_time * speed;
    if crouch_pressed do position -= up * delta_time * speed;
}

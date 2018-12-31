package camera;

using import "core:math"
import "shared:odin-glfw"

_TAU_OVER_FOUR :: cast(f32)(math.TAU / 4.0);

Camera :: struct {
    position: Vec3,
    forward: Vec3,
    right: Vec3,
    up: Vec3,

    aspect: f32,
    fov: f32,
    near: f32,
    far: f32,
}

Camera_init :: proc(
    camera: ^Camera,
    aspect: f32,
    fov: f32 = 45.0,
    near: f32 = 0.1,
    far: f32 = 100.0
) {
    camera.aspect = aspect;
    camera.fov = fov;
    camera.near = near;
    camera.far = far;
}

view_matrix :: inline proc(using camera: ^Camera, mat: ^Mat4) {
    mat^ = look_at(position, position + forward, up);
}

projection_matrix :: inline proc(using camera: ^Camera, mat: ^Mat4) {
    mat^ = perspective(fov, aspect, near, far);
}

FlyControls :: struct {
    horizontal_angle: f32,
    vertical_angle: f32,
    enabled: bool,
}

FlyControls_init :: proc(using fly_controls: ^FlyControls) {
    horizontal_angle = 0;
    vertical_angle = 0;
    enabled = true;
}

FlyControls_update :: proc(
    window: glfw.Window_Handle,
    using camera: ^Camera,
    using fly_controls: ^FlyControls,
    delta_time: f32
) {
    // if not focused, don't fly around
    if 0 == glfw.get_window_attrib(window, glfw.FOCUSED) do return;

    if !enabled do return;

    window_w, window_h := glfw.get_window_size(window);
    center_x := cast(f64)window_w / cast(f64)2;
    center_y := cast(f64)window_h / cast(f64)2;

    speed:f32 = 3;
    mouse_speed:f32 = 1.0;

    xpos, ypos := glfw.get_cursor_pos(window);

    glfw.set_cursor_pos(window, auto_cast center_x, auto_cast center_y);

    horizontal_angle += mouse_speed * delta_time * cast(f32)(center_x - xpos);
    vertical_angle += mouse_speed * delta_time * cast(f32)(center_y - ypos);

    forward = Vec3 {
        cos(vertical_angle) * sin(horizontal_angle),
        sin(vertical_angle),
        cos(vertical_angle) * cos(horizontal_angle)
    };

    right = Vec3{
        sin(horizontal_angle - _TAU_OVER_FOUR),
        0,
        cos(horizontal_angle - _TAU_OVER_FOUR)
    };

    up = cross(right, forward);

    up_pressed := glfw.get_key(window, glfw.KEY_UP) || glfw.get_key(window, glfw.KEY_W);
    down_pressed := glfw.get_key(window, glfw.KEY_DOWN) || glfw.get_key(window, glfw.KEY_S);
    left_pressed := glfw.get_key(window, glfw.KEY_LEFT) || glfw.get_key(window, glfw.KEY_A);
    right_pressed := glfw.get_key(window, glfw.KEY_RIGHT) || glfw.get_key(window, glfw.KEY_D);

    raise_pressed := glfw.get_key(window, glfw.KEY_E);
    crouch_pressed := glfw.get_key(window, glfw.KEY_C);

    if up_pressed do position += forward * delta_time * speed;
    if down_pressed do position -= forward * delta_time * speed;

    if right_pressed do position += right * delta_time * speed;
    if left_pressed do position -= right * delta_time * speed;

    if raise_pressed do position += up * delta_time * speed;
    if crouch_pressed do position -= up * delta_time * speed;
}


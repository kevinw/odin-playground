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

init :: proc(
    camera: ^Camera,
    aspect: f32,
    fov: f32 = 45.0,
    near: f32 = 0.1,
    far: f32 = 10.0
) {
    camera.aspect = aspect;
    camera.fov = fov;
    camera.near = near;
    camera.far = far;
}

import "core:fmt"

frustum_planes_old :: proc (cam: ^Camera, planes: [8]Vec3) {
    using math;

    view : Mat4 = ---;
    view_matrix(cam, &view);

    proj : Mat4 = ---;
    projection_matrix(cam, &proj);

    fmt.println("view", view);
    fmt.println("proj", proj);

    inv := inverse(mul(view, proj));

    ndc_planes : [8]Vec4 = {
        // near face
        Vec4 {1, 1, -1, 1},
        Vec4 {-1, 1, -1, 1},
        Vec4 {1, -1, -1, 1},
        Vec4 {-1, -1, -1, 1},

        // far face
        Vec4 {1, 1, 1, 1},
        Vec4 {-1, 1, 1 , 1},
        Vec4 {1, -1, 1 , 1},
        Vec4 {-1, -1,1, 1},
    };

    for i := 0; i < 8; i += 1 {
        ff : Vec4 = mul(inv, ndc_planes[i]);
        planes[i].x = ff.x / ff.w;
    }
}

transform_vector :: proc(cam: ^Camera, vec: Vec3) {
}

frustum_corners :: proc(cam: ^Camera, planes: [8]Vec3) {
    fov_radians := to_radians(cam.fov);

    near_center := cam.position - cam.forward * cam.near;
    far_center := cam.position - cam.forward * cam.far;

    near_height := 2. * math.tan(fov_radians / 2.) * cam.near;
    far_height := 2. * math.tan(fov_radians / 2.) * cam.far;

    near_width := near_height * cam.aspect;
    far_width := far_height * cam.aspect;

    far_top_left := far_center + cam.up * (far_height*0.5) - cam.right * (far_width*0.5);
    far_top_right := far_center + cam.up * (far_height*0.5) + cam.right * (far_width*0.5);
    far_bottom_left := far_center - cam.up * (far_height*0.5) - cam.right * (far_width*0.5);
    far_bottom_right := far_center - cam.up * (far_height*0.5) + cam.right * (far_width*0.5);

    near_top_left := near_center + cam.position.y * (near_height*0.5) - cam.position.x * (near_width*0.5);
    near_top_right := near_center + cam.position.y * (near_height*0.5) + cam.position.x * (near_width*0.5);
    near_bottom_left := near_center - cam.position.y * (near_height*0.5) - cam.position.x * (near_width*0.5);
    near_bottom_right := near_center - cam.position.y * (near_height*0.5) + cam.position.x * (near_width*0.5);

    // TODO: just pass a Z value (like near or far) and use that instead to calculate 4 corners
    planes[0] = near_bottom_left;
    planes[1] = near_bottom_right;
    planes[2] = near_top_left;
    planes[3] = near_top_right;

    planes[4] = far_bottom_left;
    planes[5] = far_bottom_right;
    planes[6] = far_top_left;
    planes[7] = far_top_right;
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


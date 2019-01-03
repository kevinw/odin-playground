# Odin notes

Some thoughts jotted down while learning Odin...

## bueno

* `defer` is such a natural way to handle deallocation, I can't believe C has gone this long without it
* community has been helpful, for things like compiler bug fixes and libraries like [odin-path](https://github.com/bpunsky/bp/tree/master/path) and more

## no bueno

* compile-time (plus link) still feels slow for a tiny example
* I'm missing default arguments. As an example...
* error messages
    * It'd be nice if the compiler provided more context: `gui.odin(230:47) Cannot assign value 'io.display_framebuffer_scale' of type 'Vec2' to 'Vec2' in argument`

```
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
    using camera: ^Camera,
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
```

This would be a lot simpler if I could just put 45, 0.1, and 100 in the struct definition.

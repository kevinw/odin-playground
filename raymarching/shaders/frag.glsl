#version 330 core

// thanks http://www.michaelwalczyk.com/blog/2017/5/25/ray-marching for a starting point
// thanks iq's raymarching pages https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

in vec2 vUV;
out vec4 color;

uniform float aspect = 1.0;
uniform float time;
uniform mat4 projectionMatrix;
uniform vec3 worldSpaceCameraPos;
uniform vec4 projectionParams;

// TODO: these aren't right, they are vaguely off. use frustum corners like in 
// https://gist.github.com/kevinw/80593a34b7211d99d251d266e957fe87
uniform vec3 cam_forward; 
uniform vec3 cam_up;
uniform vec3 cam_right;

float sdSphere(in vec3 p, in vec3 c, float r) {
    return length(p - c) - r;
}

float sdBox(vec3 p, vec3 b) {
  vec3 d = abs(p) - b;
  return length(max(d,0.0))
         + min(max(d.x,max(d.y,d.z)),0.0); // remove this line for an only partially signed sdf 
}

float opSmoothUnion( float d1, float d2, float k ) {
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

float map(in vec3 p) {
    vec3 k = p + time;
    float box_0 = sdBox(p, vec3(0.5, 0.5, 1.5));

    float displacement = sin(5.0 * k.x) * sin(3.0 * k.y) * sin(4.0 * p.z) * 0.25;
    float sphere_0 = sdSphere(p, vec3(0.0), 1.0) + displacement;

    return opSmoothUnion(sphere_0, box_0, 0.3);
}

vec3 calculate_normal(in vec3 p) {
    const vec3 small_step = vec3(0.001, 0.0, 0.0);

    float gradient_x = map(p + small_step.xyy) - map(p - small_step.xyy);
    float gradient_y = map(p + small_step.yxy) - map(p - small_step.yxy);
    float gradient_z = map(p + small_step.yyx) - map(p - small_step.yyx);

    vec3 normal = vec3(gradient_x, gradient_y, gradient_z);

    return normalize(normal);
}

vec3 raymarch(in vec3 ro, in vec3 rd, out vec3 current_position) {
    float total_distance_traveled = 0.0;
    const int NUMBER_OF_STEPS = 64;
    const float MINIMUM_HIT_DISTANCE = 0.001;
    const float MAXIMUM_TRACE_DISTANCE = 1000.0;

    current_position = vec3(0, 0, 0);

    for (int i = 0; i < NUMBER_OF_STEPS; ++i) {
        vec3 current_position = ro + total_distance_traveled * rd;

        float distance_to_closest = map(current_position);

        if (distance_to_closest < MINIMUM_HIT_DISTANCE) {
            vec3 normal = calculate_normal(current_position);
            vec3 light_position = vec3(2.0, -5.0, 3.0);
            vec3 direction_to_light = normalize(current_position - light_position);

            float diffuse_intensity = max(0.0, dot(normal, direction_to_light));
            return vec3(1.0, 0.0, 0.5) * diffuse_intensity;
        }

        if (total_distance_traveled > MAXIMUM_TRACE_DISTANCE) {
            discard;
            break;
        }

        total_distance_traveled += distance_to_closest;
    }

    return vec3(0.0);
}

float  GetCameraFocalLength() { return abs(projectionMatrix[1][1]); }
float  GetCameraNearClip()    { return projectionParams.y; }
float  GetCameraFarClip()     { return projectionParams.z; }
float  GetCameraMaxDistance() { return GetCameraFarClip() - GetCameraNearClip(); }

vec3 getCameraDirection(vec2 uv) {
    float  focalLen    = GetCameraFocalLength();
    return normalize((cam_right * uv.x) + (cam_up * uv.y) + (cam_forward * focalLen));
}

void main()
{
    vec2 varyingUV = vUV;
    varyingUV.s /= aspect;

    vec2 uv = varyingUV.st * 2.0 - 1.0;

    vec3 ro = worldSpaceCameraPos;
    vec3 rd = getCameraDirection(uv);

    float depth = 0;

    vec3 hit_position;
    vec3 shaded_color = raymarch(ro, rd, hit_position);

    vec4 hit_position_screen = projectionMatrix * vec4(hit_position, 1.0);
    gl_FragDepth = 0.5 * (hit_position_screen.z / hit_position_screen.w) + 0.5;

    color = vec4(shaded_color, 1.0);
}

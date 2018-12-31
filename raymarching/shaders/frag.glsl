#version 330 core

// thanks http://www.michaelwalczyk.com/blog/2017/5/25/ray-marching for a starting point

in vec2 vUV;
out vec4 color;

uniform float aspect = 1.0;
uniform float time;

uniform mat4 MVP;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 worldSpaceCameraPos;
uniform vec4 projectionParams;

float sdSphere(in vec3 p, in vec3 c, float r)
{
    return length(p - c) - r;
}

float map(in vec3 p)
{
    vec3 k = p + time;
    float displacement = sin(5.0 * k.x) * sin(3.0 * k.y) * sin(4.0 * p.z) * 0.25;
    float sphere_0 = sdSphere(p, vec3(0.0), 1.0);

    return sphere_0 + displacement;
}

vec3 calculate_normal(in vec3 p) {
    const vec3 small_step = vec3(0.001, 0.0, 0.0);

    float gradient_x = map(p + small_step.xyy) - map(p - small_step.xyy);
    float gradient_y = map(p + small_step.yxy) - map(p - small_step.yxy);
    float gradient_z = map(p + small_step.yyx) - map(p - small_step.yyx);

    vec3 normal = vec3(gradient_x, gradient_y, gradient_z);

    return normalize(normal);
}

vec3 raymarch(in vec3 ro, in vec3 rd) {
    float total_distance_traveled = 0.0;
    const int NUMBER_OF_STEPS = 64;
    const float MINIMUM_HIT_DISTANCE = 0.001;
    const float MAXIMUM_TRACE_DISTANCE = 1000.0;

    for (int i = 0; i < NUMBER_OF_STEPS; ++i) {
        vec3 current_position = ro + total_distance_traveled * rd;

        float distance_to_closest = map(current_position);

        if (distance_to_closest < MINIMUM_HIT_DISTANCE) {
            vec3 normal = calculate_normal(current_position);
            vec3 light_position = vec3(2.0, -5.0, 3.0);
            vec3 direction_to_light = normalize(current_position - light_position);

            float diffuse_intensity = max(0.0, dot(normal, direction_to_light));
            return vec3(1.0, 0.0, 0.0) * diffuse_intensity;
        }

        if (total_distance_traveled > MAXIMUM_TRACE_DISTANCE)
            break;

        total_distance_traveled += distance_to_closest;
    }

    return vec3(0.0);
}

vec3 GetCameraPosition()    { return worldSpaceCameraPos; }
vec3 GetCameraForward()     { return -viewMatrix[2].xyz; }
vec3 GetCameraUp()          { return viewMatrix[1].xyz; }
vec3 GetCameraRight()       { return viewMatrix[0].xyz; }
float  GetCameraFocalLength() { return abs(projectionMatrix[1][1]); }
float  GetCameraNearClip()    { return projectionParams.y; }
float  GetCameraFarClip()     { return projectionParams.z; }
float  GetCameraMaxDistance() { return GetCameraFarClip() - GetCameraNearClip(); }

vec3 getCameraDirection(vec2 uv) {
    vec3 camDir      = GetCameraForward();
    vec3 camUp       = GetCameraUp();
    vec3 camSide     = GetCameraRight();
    float  focalLen    = GetCameraFocalLength();

    return normalize((camSide * uv.x) + (camUp * uv.y) + (camDir * focalLen));
}


void main()
{
    vec2 varyingUV = vUV;
    varyingUV.s /= aspect;

    vec2 uv = varyingUV.st * 2.0 - 1.0;

    //vec3 camera_position = vec3(0.0, 0.0, -2.0);
    //vec3 ro = camera_position;
    //vec3 rd = vec3(uv, 1.0);
    //

    vec3 ro = GetCameraPosition();
    vec3 rd = getCameraDirection(uv);


    vec3 shaded_color = raymarch(ro, rd);

    color = vec4(shaded_color, 1.0);
}

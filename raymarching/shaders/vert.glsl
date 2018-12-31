#version 330 core

out vec2 vUV;


void main() {
    // this a trick to use gl_VertexID to draw a fullscreen covering triangle
    float x = -1.0 + float((gl_VertexID & 1) << 2);
    float y = -1.0 + float((gl_VertexID & 2) << 1);
    vUV.x = (x + 1.0) * 0.5;
    vUV.y = (y + 1.0) * 0.5;
    gl_Position = vec4(x, y, 0, 1);
}

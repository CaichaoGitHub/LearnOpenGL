#version 330 core
in vec3 aPosition;
in vec3 aVelocity;
in float aDistance;

void main() {
    gl_Position =  vec4 (aPosition, 1.0);
}

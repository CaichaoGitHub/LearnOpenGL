#version 330 core
out vec4 FragColor;
uniform int uUseOpacity;
in float vOpacity;
void main()
{
    if (uUseOpacity == 1) {
        FragColor = vec4 (.85, .85, .85, clamp (vOpacity, .0, 1.));
    } else {
        FragColor = vec4 (.85, .85, .85, 1.);
    }
}
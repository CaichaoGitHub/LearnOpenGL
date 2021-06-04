#version 330 core
in vec3 aPosition;
in vec3 aVelocity;
in float aDistance;

uniform mat4 uPersp;
uniform vec3 uEye;
uniform vec3 uAim;
uniform vec3 uUp;
uniform vec3 uTranslate;
uniform vec3 uAngles;

out float vOpacity;

mat4 rot (vec3 angles)
{
vec3 rad = radians (angles);
vec3 c = cos (rad);
vec3 s = sin (rad);

mat4 matX = mat4 (vec4 (1.0, 0.0, 0.0, 0.0),
                  vec4 (0.0, c.x, s.x, 0.0),
                  vec4 (0.0,-s.x, c.x, 0.0),
                  vec4 (0.0, 0.0, 0.0, 1.0));

mat4 matY = mat4 (vec4 (c.y, 0.0,-s.y, 0.0),
                  vec4 (0.0, 1.0, 0.0, 0.0),
                  vec4 (s.y, 0.0, c.y, 0.0),
                  vec4 (0.0, 0.0, 0.0, 1.0));

mat4 matZ = mat4 (vec4 (c.z,  s.z, 0.0, 0.0),
                  vec4 (-s.z, c.z, 0.0, 0.0),
                  vec4 ( 0.0, 0.0, 1.0, 0.0),
                  vec4 ( 0.0, 0.0, 0.0, 1.0));

return matZ * matY * matX;
}

mat4 trans (vec3 t)
{
mat4 mat = mat4 (vec4 (1.0, 0.0, 0.0, 0.0),
                 vec4 (0.0, 1.0, 0.0, 0.0),
                 vec4 (0.0, 0.0, 1.0, 0.0),
                 vec4 (t.x, t.y, t.z, 1.0));
return mat;
}

mat4 lookAt (vec3 eye, vec3 aim, vec3 up)
{
vec3 f = normalize (aim - eye);
vec3 s = normalize (cross (f, up));
vec3 u = cross (s, f);
mat4 view = mat4 (vec4 (s.x, u.x, -f.x, 0.0),
                  vec4 (s.y, u.y, -f.y, 0.0),
                  vec4 (s.z, u.z, -f.z, 0.0),
                  vec4 (0.0, 0.0, 0.0, 1.0));
return view;
}

void main()
{
    //mat4 view = lookAt (uEye, uAim, uUp);
    //mat4 model = trans (uTranslate) * rot (uAngles);
    //gl_Position = uPersp * view * model * vec4 (aPosition, 1.0);
    gl_Position =  vec4 (aPosition, 1.0);
    gl_PointSize = 0.5;
    vOpacity = length (aVelocity);
}
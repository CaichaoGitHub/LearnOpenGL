#version 330 core
in vec3 aPosition;
in vec3 aVelocity;
in float aDistance;

out vec3 vPosition;
out vec3 vVelocity;
out float vDistance;

uniform mat4 uPersp;
uniform vec3 uEye;
uniform vec3 uAim;
uniform vec3 uUp;
uniform vec3 uTranslate;
uniform vec3 uAngles;

uniform vec3 uBlackHolePosition;
uniform float uTimeStep;
uniform float uBlackHoleMass;
uniform vec3 uLimits;

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

void main() {
    vec3 blackHolePos = vec4 (rot (uAngles) * vec4 (uBlackHolePosition, 1.)).xyz;
    vec3 p = blackHolePos - aPosition;
    float g = 0.0000000000667384;
    float particleMass = 1000.0;
    float k = g * particleMass * uBlackHoleMass;
    float dist = length (p);
    float d = dist * dist;

    vDistance = dist;
    vec3 v = blackHolePos - aPosition;
    vec3 f = k * normalize (v) / d;

    vec3 a = particleMass * f;
    vec3 newVelocity = a + aVelocity;
    vec3 tmp = .475 * (aVelocity + newVelocity);
    vPosition = aPosition + tmp * uTimeStep;
    vVelocity = tmp;
    if (vPosition.x <= -uLimits.x ||
        vPosition.x >= uLimits.x ||
        vPosition.y <= -uLimits.y ||
        vPosition.y >= uLimits.y ||
        vPosition.z <= -uLimits.z ||
        vPosition.z >= uLimits.z) {
        vVelocity = 0.1 * tmp;
        if (vPosition.x <= -uLimits.x ) {
            vPosition.x = uLimits.x;
        } else if (vPosition.x >= uLimits.x) {
            vPosition.x = -uLimits.x;
        }
        if (vPosition.y <= -uLimits.y) {
            vPosition.y = uLimits.y;
        } else if (vPosition.y >= uLimits.y) {
            vPosition.y = -uLimits.y;
        }
        if (vPosition.z <= -uLimits.z) {
            vPosition.z = uLimits.z;
        } else if (vPosition.z >= uLimits.z) {
            vPosition.z = -uLimits.z;
        }
    }
    gl_Position = vec4 (0.0, 0.0, 0.0, 0.0);
}
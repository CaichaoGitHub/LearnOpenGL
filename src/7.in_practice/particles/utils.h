//
// Created by caichao on 2021/6/3.
//

#ifndef LEARNOPENGL_SRC_7_IN_PRACTICE_PARTICLES_UTILS_H
#define LEARNOPENGL_SRC_7_IN_PRACTICE_PARTICLES_UTILS_H

#include <iostream>
#include <list>
#include <sstream>
#include <iterator>
#include <cassert>
#include <cmath>

#include <glad/glad.h>
#include <GLFW/glfw3.h>
//#include <GL/glew.h>

#define GLSL(src) "#version 330\n" #src

void frustum (float a,
              float b,
              float c,
              float d,
              float e,
              float g,
              float* out);
void perspective (float a,
                  float b,
                  float c,
                  float d,
                  float* out);
void ortho (float left,
            float right,
            float bottom,
            float top,
            float nearVal,
            float farVal,
            float* out);
void checkGLError (const char* func);
void dumpGLInfo ();
GLuint createTexture (const char* filename);
GLuint loadShader (const char *src, GLenum type);
GLuint createShaderProgram (const char* vertexShaderSrc,
                            const char* fragmentShaderSrc,
                            bool link);
void linkShaderProgram (GLuint progId);
GLuint createVBO (GLsizeiptr size, const GLvoid* data, GLenum usage);
void updateVBO (GLuint vbo, GLsizeiptr size, const GLvoid* data, GLenum usage);

#endif //LEARNOPENGL_SRC_7_IN_PRACTICE_PARTICLES_UTILS_H

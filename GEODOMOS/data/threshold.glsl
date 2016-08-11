
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;

// The inverse of the texture dimensions along X and Y
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float low;  
uniform float high;     


void main() {  
  vec4 col = texture2D(texture, vertTexCoord.st);
  float l = step(low, col.x);
  float h = step(-high, -col.x);
  gl_FragColor = vec4(vec3(l*h), 1.0);
}
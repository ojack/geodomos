
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

uniform float sides;  
uniform float offset;     

uniform vec2 resolution;

void main() {  
  vec2 p = gl_FragCoord.xy/resolution - 0.5; // vector from center to texture coordinate
  // convert to polar coordinates 
  float r = length(p); //radius
  float a = atan(p.x, p.y); // angle
  float tau = 2. * 3.1416 ;  //pi
  a = mod(a, tau/sides) + (a/(tau/sides))*offset;
  a = abs(a - tau/sides/2.);
  p = r * vec2(cos(a), sin(a));
  vec4 color = texture2D(texture, p + 0.5);
 // gl_FragColor = texture2D(texture, gl_FragCoord.xy);
   gl_FragColor = color;
}
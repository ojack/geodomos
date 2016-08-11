// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265358979323846
#define TWO_PI 6.28318530718

uniform float u_time;
uniform float s0;
uniform float s1;
uniform float s2;
uniform float s3;
uniform float s4;
uniform float s5;
uniform float s6;
uniform float s7;
uniform float beat;

uniform vec2 mouse;
uniform vec2 renderRes;

uniform sampler2D texture2;

float r(float n)
{
  return fract(abs(sin(n*55.753)*367.34));   
}
float r(vec2 n)
{
    return r(dot(n,vec2(2.46,-1.21)));
}
float cycle(float n)
{
  return cos(fract(n)*2.0*3.141592653)*2.0+0.5;
}
void main( void )
{
    float a = (radians(60.0)) + 3.0;

    float zoom = 200.0+400.0*s0;
    float speed = 0.0;

    vec2 c = (gl_FragCoord.xy+vec2(u_time*zoom*speed,0.0));
    c = c*vec2(sin(a),1.0);
   c = ((c+vec2(c.y,0.0)*cos(a))/zoom)+vec2(floor((c.x-c.y*cos(a))/zoom),0.0);
    float n = cycle(r(floor(c*4.0))*0.2+r(floor(c*2.0))*0.3+r(floor(c))*0.5+u_time*0.125);

   vec4 col = vec4(n*2.0,pow(n,2.0),0.0,1.0);
   // gl_FragColor = mix(col, texture2D(texture2, gl_FragCoord.xy/renderRes+col.xy*(0.02+0.06)), 0.5);
   gl_FragColor = col*texture2D(texture2, gl_FragCoord.xy/renderRes+col.xy*(0.02));
}


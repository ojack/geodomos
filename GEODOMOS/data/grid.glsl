
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER
#define PI 3.14159265358979323846

//uniform sampler2D texture;
uniform sampler2D texture2;
uniform sampler2D bodyTexture;

// The inverse of the texture dimensions along X and Y
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float sides;  
uniform float offset;     
uniform float u_time;
uniform vec2 resolution;
uniform vec2 renderRes;
uniform vec3 c1;
uniform vec3 c2;

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 movingTiles(vec2 _st, float _zoom, float _speed){
    _st *= _zoom;
    float time = u_time*_speed*0.0004;
    if( fract(time)>0.5 ){
        if (fract( _st.y * 0.5) > 0.5){
            _st.x += fract(time)*4.0;
            // _st.y = 1.0 - _st.y;
        } else {
            _st.x -= fract(time)*4.0;
        } 

    } else {
        if (fract( _st.x * 0.5) > 0.5){
            _st.y += fract(time)*4.0;
          //  _st.x = 1.0 - _st.x;
        } else {
            _st.y -= fract(time)*4.0;
        } 
    }
      if(step(1., mod(_st.x,2.0)) == 1.0) _st.x = 1.0 - _st.x;
     //  if(step(1., mod(_st.y,2.0)) == 1.0) _st.y = 1.0 - _st.y;
   // _st = rotate2D(_st,PI*0.025*_st.x);  
    return fract(_st);
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
     // Here is where the offset is happening
   // _st.x += step(1., mod(_st.y,2.0)) * 0.5;
    if(step(1., mod(_st.x,2.0)) == 1.0) _st.x = 1.0 - _st.x;
    if(step(1., mod(_st.y,2.0)) == 1.0) _st.y = 1.0 - _st.y;
    return fract(_st);
}

void main() {
  vec2 st = gl_FragCoord.xy/renderRes;

     // Use a matrix to rotate the space 45 degrees
    //st = rotate2D(st,PI*0.25);  

    // Divide the space in 4
   // st = tile(st,time);
   st = movingTiles(st, 4.0, 0.5);
  // st = clamp(st, 0.3, 1.0);
   vec4 col1 = vec4(c1, 1.0)*texture2D(texture2, st);
   vec4 col2 = texture2D(texture2, gl_FragCoord.xy/renderRes)*vec4(c2, 1.0);
   //gl_FragColor = mix(col2, col1, 0.5);
   gl_FragColor = vec4(abs(col2.xyz-col1.xyz), 1.0);
 //  gl_FragColor = texture2D(texture2, st);
// gl_FragColor = texture2D(texture2, gl_FragCoord.xy/renderRes);
 //gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0); 
}
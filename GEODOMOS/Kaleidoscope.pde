class Kaleidoscope extends KinectEffect { 
  PShader kal;
  PShader grid;
  
  Kaleidoscope() {  
     kal = loadShader("trianglepattern2.glsl");
  /*   kal.set("sides", 3.0);
    kal.set("offset", 0.0);*/
   
    kal.set("resolution", float(SOURCE_WIDTH), float(SOURCE_HEIGHT));  
    kal.set("renderRes", float(displayWidth), float(displayHeight));
  } 
  
  void init(){
  }
  
  void update(){
  getThreshold();
     float t = float(millis());
  //println(t);   
   kal.set("u_time", t*0.001);
   kal.set("s0", t_scale);
   kal.set("texture2", output);
   //threshold.set("low", 0.1);
  //  threshold.set("high", 1.0);
    render.beginDraw();
   render.shader(kal);
  // render.fill(255);
  render.rect(0, 0, width, height);
  //render.ellipse(width/2, height/2, 100, 100);
 //  render.image(blur2, 0, 0, render.width, render.height);
  //  render.ellipse(20, 20, 100, 100);
  //render.image(blur2, 0, 0);
   render.endDraw();
  }
}

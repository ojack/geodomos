class Grid extends KinectEffect { 
  PShader kal;
  PShader grid;
  PGraphics body;
  
  Grid() {  
     kal = loadShader("grid.glsl");
  /*   kal.set("sides", 3.0);
    kal.set("offset", 0.0);*/
   
    kal.set("resolution", float(SOURCE_WIDTH), float(SOURCE_HEIGHT));  
    kal.set("renderRes", float(displayWidth), float(displayHeight));
    
    body = createGraphics(SOURCE_WIDTH/2, SOURCE_HEIGHT, P3D);
  } 
  
  void init(){
  }
  
  void update(){
    getThreshold();
    body.beginDraw();
    body.background(0);
    ArrayList<Contour> c = getContours();
    body.fill(255);
    int contourIndex = 0;
    for (Contour contour : c) {
      if (contour.area() > minArea) {
        if(contourIndex==0){
          Rectangle2D r = contour.getBoundingBox();
          contour.setPolygonApproximationFactor(contourApprox);
        PShape s = contourToShape(contour.getPolygonApproximation(), r);
        body.shape(s, body.width/2, body.height/2, body.width, body.height);
        }
        contourIndex++;
      }
    }
    body.endDraw();
    
     float t = float(millis());
  //println(t);   
   kal.set("u_time", t);
   kal.set("texture2", blur2);
   kal.set("bodyTexture", body);
   int r = (c1 >> 16) & 0xFF;
      int g = (c1 >> 8) & 0xFF;
      int b = c1 & 0xFF;
      kal.set("c1", (float)r/255.9, (float)g/255.0, (float)b/255.0);
       r = (c2 >> 16) & 0xFF;
      g = (c2 >> 8) & 0xFF;
      b = c2 & 0xFF;
        kal.set("c2", (float)r/255.9, (float)g/255.0, (float)b/255.0);
   //threshold.set("low", 0.1);
  //  threshold.set("high", 1.0);
    render.beginDraw();
  render.shader(kal);
 
   render.fill(255);
  render.rect(0, 0, width, height);
 //  render.image(body, 0, 0);
  //render.ellipse(width/2, height/2, 100, 100);
 //  render.image(blur2, 0, 0, render.width, render.height);
  //  render.ellipse(20, 20, 100, 100);
  //render.image(blur2, 0, 0);
   render.endDraw();
  }
}

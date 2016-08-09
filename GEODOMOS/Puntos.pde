class Puntos extends KinectEffect{ 
  Puntos () {  
    println("puntos");
  } 
  
  void update() {
   
   // println("DRAWING PUNTOS");
    loadOpenCV();
    ArrayList<Contour> c = getContours();
    
     render.beginDraw();
    
     render.image(thresh, 0, 0);
     fill(0, 0, 0, blending);
     rect(0, 0, width, height);
   
    // scale(0.5, 0.5);
    
      for (Contour contour : c) {
         pushMatrix();
          scale(displayWidth/kinect.width, displayHeight/kinect.height);
        
         contour.setPolygonApproximationFactor(contourApprox);
        
        Contour approx = contour.getPolygonApproximation();
          Contour hull = contour.getConvexHull();
      //  scale(displayWidth/kinect.width, displayHeight/kinect.height);
         for(int i = 0; i < 5; i++){
           fill(0, 255, 255, 25);
            stroke(0, 255, 255);
           approx.draw();
            fill(255, 0, 255, 40);
            stroke(255, 0, 255);
            hull.draw();
            scale(0.95);
         }
          popMatrix();
      }
     render.endDraw();
    
    
 // image(kinect.getDepthImage(), 0, 0);
 
 // drawContours();
// opticalFlow();
  }
} 

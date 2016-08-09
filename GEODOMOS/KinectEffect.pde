class KinectEffect {
  KinectEffect(){
    println(" kinect effect");
  }
  
  void update(){
    println("HEY");
  }
  
  void loadOpenCV(){
    src = kinect.getDepthImage();
    opencv.loadImage(src);
    opencv.inRange(lowThresh, highThresh);
  }
  
  ArrayList<Contour> getContours(){
    opencv.dilate();
    opencv.dilate();
    opencv.erode();
    opencv.blur(2);
    thresh = opencv.getOutput();
    return opencv.findContours();
  }
  
  void opticalFlow(){
     opencv.dilate();
    opencv.dilate();
    opencv.erode();
    opencv.blur(2);
    opencv.calculateOpticalFlow();
     thresh = opencv.getOutput();
    stroke(255,0,0);
    image(thresh, 0, 0);
    opencv.drawOpticalFlow();
  }
  
  void drawContours(){
    
  noFill();
  strokeWeight(3);
  for (Contour contour : contours) {
    stroke(0, 255, 255);
    if(contour.area() > minArea){
    //  contour.draw();
      
      stroke(255, 0, 0);
        contour.setPolygonApproximationFactor(contourApprox);
        
        Contour approx = contour.getPolygonApproximation();
        int numPoints = approx.numPoints();
        
       int picked = (int)(numPoints/5);
       
       println(numPoints);
       println(picked);
       ArrayList<PVector> pts = approx.getPoints();
      beginShape();
        for (PVector point : pts) {
        vertex(point.x, point.y);
      }
       endShape();
       if(picked > 0) {
         fill(255);
         noStroke();
       for(int i = 0; i < numPoints; i+=picked){
         PVector point = pts.get(i);
         ellipse(point.x, point.y, 10, 10);
        }
       }
   //   println(contour.getPolygonApproximationFactor());
    
       noFill();
        stroke(0, 255, 0);
      beginShape();
      for (PVector point : contour.getConvexHull().getPoints()) {
        vertex(point.x, point.y);
      }
     endShape();
    }
  }
}

  void drawDebug(){
  }
}

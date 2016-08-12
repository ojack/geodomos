class KinectEffect {
 
  
  KinectEffect() {
    println(" kinect effect");
  }
  
  void init(){
  }
  
  void update() {
    println("HEY");
  }

void getThreshold(){
  threshold.set("low", lowThresh/255.0);
    threshold.set("high", highThresh/255.0);
    src.beginDraw();
    src.shader(threshold);
    src.image(kinect.getDepthImage(), 0, 0, src.width, src.height);
    src.endDraw();
    
     // Applying the blur shader along the vertical direction   
  blur.set("horizontalPass", 0);
  blur1.beginDraw();            
  blur1.shader(blur);  
  blur1.image(src, 0, 0);
  blur1.endDraw();
  
  // Applying the blur shader along the horizontal direction      
  blur.set("horizontalPass", 1);
  blur2.beginDraw();            
  blur2.shader(blur);  
  blur2.image(blur1, 0, 0);
  blur2.endDraw();    
  
  threshold.set("low", 0.1);
    threshold.set("high", 1.0);
  output.beginDraw();
  output.shader(threshold);  
  output.image(blur2, 0, 0);
  output.endDraw(); 
}

 

  ArrayList<Contour> getContours() {
  /*  opencv.dilate();
     opencv.dilate();
     opencv.erode();
     opencv.blur(2);*/
   // thresh = opencv.getOutput();
    opencv.loadImage(blur2);
    return opencv.findContours(false, true);
  }



PShape contourToShape(Contour c, Rectangle2D r) {
  
    ArrayList<PVector> approxPts = c.getPoints();
   
    //PVector offset = new PVector((int)(r.getWidth()/2), (int)(r.getHeight()/2));
      float cx = (float)r.getCenterX();
       float cy = (float)r.getCenterY();
    PShape shp = createShape();
      
     shp.beginShape();
    
      for (PVector p : approxPts) {
         shp.vertex(p.x-cx, p.y-cy);
      }

      shp.endShape(CLOSE);
    
    return shp;
  }
  
PShape contourToShape(Contour c, float tightness, int spacing, boolean equalSpacing, Rectangle2D r) {
    List<Vec2D> vertices = new ArrayList<Vec2D>();
  //  List <Vec2D> splineVert = new List<Vec2D>();
     float cx = (float)r.getCenterX();
     float cy = (float)r.getCenterY();
    ArrayList<PVector> approxPts = c.getPoints();
    PShape shp = createShape();
    if (approxPts.size()> 2) {   
      for (PVector point : approxPts) {
        vertices.add(new Vec2D(point.x, point.y));
      }
      Spline2D s=new Spline2D(vertices);
      s.setTightness(tightness);
      shp.beginShape();
      if(equalSpacing){
        for(Iterator j=s.getDecimatedVertices(spacing, true).iterator(); j.hasNext();) {
             // for(Iterator j=s.computeVertices(10).iterator(); j.hasNext();) {
                Vec2D p=(Vec2D)j.next();
                shp.vertex(p.x-cx, p.y-cy);
         }
       }else{
         for(Iterator j=s.computeVertices(spacing).iterator(); j.hasNext();) {
                Vec2D p=(Vec2D)j.next();
                shp.vertex(p.x-cx, p.y-cy);
         }
       }
      shp.endShape();
    } 
    return shp;
  }

  void opticalFlow() {
    opencv.dilate();
    opencv.dilate();
    opencv.erode();
    opencv.blur(2);
    opencv.calculateOpticalFlow();
    stroke(255, 0, 0);
  //  image(thresh, 0, 0);
    opencv.drawOpticalFlow();
  }



  void drawDebug() {
  }
}


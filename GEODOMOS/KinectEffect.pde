class KinectEffect {
  KinectEffect() {
    println(" kinect effect");
  }

  void update() {
    println("HEY");
  }

  void loadOpenCV() {
    src = kinect.getDepthImage();
    opencv.loadImage(src);
    opencv.inRange(lowThresh, highThresh);
  }

  ArrayList<Contour> getContours() {
    /* opencv.dilate();
     opencv.dilate();
     opencv.erode();
     opencv.blur(2);*/
    thresh = opencv.getOutput();
    return opencv.findContours(false, true);
  }

/* List<Vec2D> contourToSpline(Contour c, float tightness, int spacing) {
    List<Vec2D> vertices = new ArrayList<Vec2D>();
  //  List <Vec2D> splineVert = new List<Vec2D>();
    ArrayList<PVector> approxPts = c.getPoints();
     Rectangle2D r = c.getBoundingBox();
    PVector offset = new PVector((int)(r.getWidth()/2), (int)(r.getHeight()/2));
    if (approxPts.size()> 2) {   
      for (PVector point : approxPts) {
        vertices.add(new Vec2D(point.x-offset.x, point.y-offset.y));
      }
      Spline2D s=new Spline2D(vertices);
      s.setTightness(tightness);
      return s.getDecimatedVertices(spacing, true);
    } else {
      return vertices;
    }
  }*/

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

      shp.endShape();
    
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
    thresh = opencv.getOutput();
    stroke(255, 0, 0);
    image(thresh, 0, 0);
    opencv.drawOpticalFlow();
  }



  void drawDebug() {
  }
}


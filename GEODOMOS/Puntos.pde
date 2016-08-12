class Puntos extends KinectEffect { 
  Puntos () {  
    println("puntos");

  } 
  void init(){
     render.beginDraw();
     render.resetShader();
   render.fill(0, 0, 0, 255);
    render.rect(0, 0, width, height);
  
     render.endDraw();
     numReps = 30;
  }
  void update() {
    shapeMode(CENTER);
    // println("DRAWING PUNTOS");
    //loadOpenCV();
    getThreshold();
    ArrayList<Contour> c = getContours();

    render.beginDraw();
    
  //  render.pushMatrix();
     render.blendMode(BLEND);
    render.fill(0, 0, 0, blending);
    render.rect(0, 0, width, height);
    /*  if (drawDebug) {
     render.image(thresh, 0, 0);
     }*/
       render.blendMode(EXCLUSION);
     render.noFill();
    render.stroke(0, 255, 255);
  
     // render.scale(displayWidth/kinect.width, displayHeight/kinect.height);
    for (Contour contour : c) {
      if (contour.area() > minArea) {
        
        contour.setPolygonApproximationFactor(contourApprox);
      //  List<Vec2D> s = contourToSpline(contour.getPolygonApproximation(), splineTightness, splinePoints);
        PShape s;
         Rectangle2D r = contour.getBoundingBox();
        if(useSpline) {
           s = contourToShape(contour.getPolygonApproximation(), splineTightness, splinePoints, spacingMode, r);
        } else {
           s = contourToShape(contour.getPolygonApproximation(), r);
        }
      
       float cx = (float)r.getCenterX();
       float cy = (float)r.getCenterY();
        s.disableStyle();
         render.pushMatrix();
       render.translate(width/2, height/2);
          render.scale(width/SOURCE_WIDTH, height/SOURCE_HEIGHT);
           
         //render.translate(width/2, height/2);
          render.fill(0, 255, 255, 20);
        render.stroke(0, 255, 255);
        for(int k = 0; k < numReps; k++){
          render.shape(s, cx-SOURCE_WIDTH/2, cy- SOURCE_HEIGHT/2-k*k);
       //  render.shape(s, cx-SOURCE_WIDTH/2, cy - SOURCE_HEIGHT/2);
          render.scale(0.8, 0.95);
        }
         render.popMatrix();
       /* for(int k = 0; k < numReps; k++){
          render.beginShape();
          for(Iterator j=s.iterator(); j.hasNext();) {
             // for(Iterator j=s.computeVertices(10).iterator(); j.hasNext();) {
                Vec2D p=(Vec2D)j.next();
               // render.ellipse(p.x, p.y, 5, 5);
               render.vertex(p.x, p.y);
              
           }
           render.endShape();
           render.scale(0.95);
           render.translate(width*0.05, height*0.05);
          }*/
          
      }
    } //  render.popMatrix();
    render.endDraw();
  }
} 

/*
  render.pushMatrix();
        render.scale(displayWidth/kinect.width, displayHeight/kinect.height);
 // Contour hull = contour.getConvexHull();
        ArrayList<PVector> approxPts = approx.getPoints();
       // ArrayList<PVector> hullPts = hull.getPoints();
        //  scale(displayWidth/kinect.width, displayHeight/kinect.height);
        Vec2D[] vertices = new Vec2D[approxPts.size()];
       
        for (int i = 0; i < 1; i++) {
          // render.fill(0, 255, 255, 25);
          render.stroke(0, 255, 255);
          render.beginShape();
          for (int j = 0; j < approxPts.size(); j++) {
            PVector pt = approxPts.get(j);
            vertices[j]= new Vec2D(pt.x, pt.y);
           //  vertices[j] = (Vec2D)pt;
            render.vertex(pt.x, pt.y);
          }
          render.endShape();
         //  
          render.stroke(255, 0, 255);
        //  render.beginShape();
         if(approxPts.size()> 2){
           Spline2D s=new Spline2D(vertices);
           s.setTightness(splineTightness);
           
           
            for(Iterator j=s.getDecimatedVertices(splinePoints,true).iterator(); j.hasNext();) {
           // for(Iterator j=s.computeVertices(10).iterator(); j.hasNext();) {
              Vec2D p=(Vec2D)j.next();
              render.ellipse(p.x, p.y, 5, 5);
            }
         }
         // render.endShape();
         
          render.scale(0.95);
         }
         render.popMatrix();
        }
        
      }
     render.endDraw();
     */

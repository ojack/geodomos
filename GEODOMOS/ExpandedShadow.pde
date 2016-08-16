class ExpandedShadow extends KinectEffect { 
  ExpandedShadow () {  
    println("puntos");

  } 
  void init(int index){
     render.beginDraw();
     render.resetShader();
   render.fill(0, 0, 0, 255);
    render.rect(0, 0, width, height);
    switch(index){
      case 0:
        numReps = 30;
        c1 = color(228, 0, 12);
        c2 = color(0, 182, 8);
        shadowScale = 2.26;
         contourApprox = 10;
        useSpline = false;
        break;
      case 1:
        numReps = 10;
        c1 = color(228, 0, 12);
        c2 = color(0, 182, 8);
        shadowScale = 2.26;
        contourApprox = 1;
        useSpline = true;
        break;
      case 2:
        numReps = 37;
        c1 = color(228, 0, 12);
        c2 = color(0, 182, 8);
        shadowScale = 2.26;
        contourApprox = 1;
        useSpline = false;
        break;
      default:
         numReps = 4;
        c1 = color(228, 0, 12);
        c2 = color(0, 182, 8);
        shadowScale = 2.26;
        contourApprox = 24;
        useSpline = false;
        break;
    }
     render.endDraw();
     
     
    
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
     render.noStroke();
    render.fill(0, 0, 0, blending);
    render.rect(0, 0, width, height);
    /*  if (drawDebug) {
     render.image(thresh, 0, 0);
     }*/
       render.blendMode(EXCLUSION);
     render.noFill();
    render.stroke(0, 255, 255);
    int contourIndex = 0;
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
       float w = (float)r.getWidth();
        float h = (float)r.getHeight();
        s.disableStyle();
      
        render.pushMatrix();
       // render.fill(c1);
     if(contourIndex %2==0){
         render.fill( (c1 >> 16) & 0xFF,  (c1 >> 8) & 0xFF,  c1 & 0xFF, 5);
      } else {
         render.fill( (c2 >> 16) & 0xFF,  (c2 >> 8) & 0xFF,  c2 & 0xFF, 5);
       }
       contourIndex++;
        render.noStroke();
     //   render.stroke(0, 255, 255);
       render.translate(width/2, height/2);
          render.scale(width/SOURCE_WIDTH, height/SOURCE_HEIGHT);
          float stepAmt = shadowScale/(numReps-numReps*beatInfluence*beatAmt/100);
          float scale = shadowScale;
           for(int k = 0; k < numReps; k++){
             render.shape(s, cx-SOURCE_WIDTH/2, cy- SOURCE_HEIGHT/2, w*scale, h*scale);
            scale -=stepAmt;
           }
             render.popMatrix();
      }
    }
    render.endDraw();
  }
} 



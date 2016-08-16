class Lines extends KinectEffect { 
  Lines () {  
    println("puntos");

  } 
  void init(int index){
     render.beginDraw();
     render.resetShader();
     render.noStroke();
   render.fill(0, 0, 0, 255);
    render.rect(0, 0, width, height);
    switch(index){
      case 0:
        numReps = 50;
        lineScaleMode = true;
        c1 = color(234, 51, 0);
         c2 = color(254, 185, 21);
        shadowScale = 3.6;
        useSpline = false;
         sWeight = 4.0;
         strokeOpacity = 255.0;
        contourApprox = 0;
        useSpline = false;
        lineAnimXScale = 0.0;
        lineAnimYScale = 0.0;
        break;
      case 1:
        numReps = 11;
        lineScaleMode = false;
         c1 = color(6, 255, 20);
         c2 = color(255, 116, 5);
         sWeight = 20.0;
         strokeOpacity = 149.0;
        shadowScale = 1.4;
        contourApprox = 1;
        useSpline = false;
        lineAnimXScale = 1.0;
        lineAnimYScale = 0.0;
        break;
      case 2:
        numReps = 27;
        lineScaleMode = true;
        c1 = color(167, 254, 12);
         c2 = color(167, 254, 12);
        contourApprox = 8;
         sWeight = 6.0;
         strokeOpacity = 149.0;
        shadowScale = 3.0;
        useSpline = false;
        beatInfluence = 0.5;
        lineAnimXScale = 0.6;
        lineAnimYScale = 0.6;
        break;
      default:
        numReps = 4;
        c1 = color(255, 255, 255);
        shadowScale = 4.0;
        useSpline = false;
      //  break;
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
    //   render.blendMode(EXCLUSION);
     render.noFill();
  
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
     //  if(contourIndex %2==0){
      //   render.strokeWeight(strokeWeight);
     
         render.stroke( (c1 >> 16) & 0xFF,  (c1 >> 8) & 0xFF,  c1 & 0xFF, strokeOpacity);
       //  render.strokeWeight(strokeWeight);
      /* } else {
         render.fill( (c2 >> 16) & 0xFF,  (c2 >> 8) & 0xFF,  c2 & 0xFF, 10);
       }
       contourIndex++;*/
      //  render.noStroke();
     //   render.stroke(0, 255, 255);
       render.translate(width/2, height/2);
          render.scale(width/SOURCE_WIDTH, height/SOURCE_HEIGHT);
          render.fill( (c2 >> 16) & 0xFF,  (c2 >> 8) & 0xFF,  c2 & 0xFF, 80);
            render.shape(s, cx-SOURCE_WIDTH/2, cy- SOURCE_HEIGHT/2, w, h);
            render.noFill();
       //   float stepAmt = shadowScale/numReps+beatAmt*beatInfluence*0.001;
       float stepAmt = shadowScale/numReps;
          float scale = shadowScale;
          render.strokeWeight(sWeight);
           for(int k = 0; k < numReps; k++){
             float xOffset, yOffset = 0; 
             if(scale < 1)  {
               render.stroke( (c2 >> 16) & 0xFF,  (c2 >> 8) & 0xFF,  c2 & 0xFF, strokeOpacity);
             } 
               xOffset = sin(millis()*0.0003)*200*(scale-1)*lineAnimXScale+sin(scale*2*PI)*(rotationAnimation+beatAmt*beatInfluence);
              // xOffset = sin(millis()*0.0003)*200*(scale-1)*lineAnimXScale+sin(k*0.2+millis()*0.001)*(rotationAnimation+beatAmt*beatInfluence);
               yOffset = cos(millis()*0.0001)*300*(scale-1)*lineAnimYScale;
               if(contourIndex%2==0) xOffset = -xOffset;
          
           //  render.shape(s, cx-SOURCE_WIDTH/2-xOffset, cy- SOURCE_HEIGHT/2-yOffset, w*scale, h*scale);
           if(lineScaleMode){
             render.shape(s, cx-SOURCE_WIDTH/2-xOffset, cy- SOURCE_HEIGHT/2-yOffset, w*scale, h*scale);
           } else {
              render.shape(s, cx-SOURCE_WIDTH/2-xOffset, cy- SOURCE_HEIGHT/2-yOffset, w, h);
           }
            scale -=stepAmt;
           }
             render.popMatrix();
      contourIndex++;
    }
     
    }
    render.endDraw();
  }
} 



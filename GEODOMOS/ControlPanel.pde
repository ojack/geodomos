ControlFrame addControlFrame(String theName, int theWidth, int theHeight, CheckBox checkbox, PGraphics debug) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight, checkbox, debug);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;
  CheckBox checkbox;
  int abc = 100;
  
  public void setup() {
    size(w, h);
   frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("low thresh").plugTo(parent,"lowThresh").setRange(0, 255).setPosition(10,10).setValue(133);
    cp5.addSlider("high thresh").plugTo(parent,"highThresh").setRange(0, 255).setPosition(10,30).setValue(255);
     cp5.addSlider("min area").plugTo(parent,"minArea").setRange(0, 100000).setPosition(10,50).setValue(2000);
      cp5.addSlider("contour approx: ").plugTo(parent,"contourApprox").setRange(0, 50).setPosition(10,70).setValue(10);
      cp5.addSlider("blending ").plugTo(parent,"blending").setRange(0, 255).setPosition(10,90).setValue(255);
      cp5.addSlider("spline tightness").plugTo(parent,"splineTightness").setRange(-1.0, 1.0).setPosition(10,110).setValue(0.25);
       cp5.addSlider("spline points").plugTo(parent,"splinePoints").setRange(2, 300).setPosition(10,130).setValue(10);
         cp5.addSlider("num repetitions").plugTo(parent,"numReps").setRange(1, 50).setPosition(10,150).setValue(5);
     cp5.addSlider("triangle scale").plugTo(parent,"t_scale").setRange(0.0, 1.0).setPosition(10,250).setValue(0.5);
      cp5.addSlider("shadow scale").plugTo(parent,"shadowScale").setRange(0.0, 8.0).setPosition(10,350).setValue(3.0);
      cp5.addSlider("line anim x scale").plugTo(parent,"lineAnimXScale").setRange(0.0, 8.0).setPosition(10,370).setValue(1.0);
      cp5.addSlider("line anim y scale").plugTo(parent,"lineAnimYScale").setRange(0.0, 8.0).setPosition(10,390).setValue(1.0);
       cp5.addSlider("rotation animation").plugTo(parent,"rotationAnimation").setRange(0.0, 200.0).setPosition(10,450).setValue(0.0);
       cp5.addSlider("stroke weight").plugTo(parent,"sWeight").setRange(0.0, 200.0).setPosition(10,410).setValue(1.0);
       cp5.addSlider("stroke opacity").plugTo(parent,"strokeOpacity").setRange(0.0, 255.0).setPosition(10,430).setValue(255.0);
      cp5.addSlider("beat influence").plugTo(parent,"beatInfluence").setRange(0.0, 1.0).setPosition(10,270).setValue(1.0);
      int y_pos = 500;
      cp5.addSlider("rot X Speed").plugTo(parent,"rotXSpeed").setRange(0,0.10).setPosition(10,y_pos).setValue(0.01);
    y_pos+=20;
    cp5.addSlider("rot Y Speed").plugTo(parent,"rotYSpeed").setRange(0,0.10).setPosition(10,y_pos).setValue(0.01);
    y_pos+=20;
      cp5.addToggle("draw debug").plugTo(parent, "drawDebug").setValue(true).setPosition(300,10);
       cp5.addToggle("equal spacing").plugTo(parent, "spacingMode").setValue(true).setPosition(370,10);
        cp5.addToggle("use splines").plugTo(parent, "useSpline").setValue(false).setPosition(440,10);
         cp5.addToggle("line scale mode").plugTo(parent, "lineScaleMode").setValue(false).setPosition(250,350);
         cp5.addColorWheel("c1" , 250 , 10 , 200 ).plugTo(parent, "c1").setRGB(color(128,0,255)).setPosition(600,10);
          cp5.addColorWheel("c2" , 250 , 10 , 200 ).plugTo(parent, "c2").setRGB(color(128,0,255)).setPosition(600,300);
   }

  public void draw() {
      background(abc);
      //image(output, 10, 200);
    /*  int r = (c1 >> 16) & 0xFF;
      int g = (c1 >> 8) & 0xFF;
      int b = c1 & 0xFF;
      String c1text = "c1: r: " + r + "g: " + g + "b: " + b;
        text(c1text, 300, 600);*/
        drawColorInfo(c1, 600, 270);
         drawColorInfo(c2, 600, 600);
         
         ellipse(20, 20, beatAmt, beatAmt);
      //image(kinect.getDepthImage(), 0, 0);
   // if(drawDebug) image(src, 0, 0);
  }
  
  private ControlFrame() {
  }

  void drawColorInfo(color c, int x, int y){
     int r = (c >> 16) & 0xFF;
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      String c1text = "c1: r: " + r + " g: " + g + " b: " + b;
        text(c1text, x, y);
  }
  public ControlFrame(Object theParent, int theWidth, int theHeight, CheckBox this_checkbox, PGraphics _debug) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
    debug = _debug;
    checkbox = this_checkbox;
  }

  void keyPressed(){
  println("CONTROL KEY" + key);
  updateEffect = true;
  effectKey = key;
  effectKeyCode = keyCode;
//  parent.myTest();
  /* if (keyCode == RIGHT) {
     effectIndex += 1;
     if(effectIndex >= ke.length)effectIndex = 0;
     ke[effectIndex].init(0);
   } else if(keyCode==LEFT){
     effectIndex--;
      if(effectIndex < 0) effectIndex = ke.length - 1;
      ke[effectIndex].init(0);
   } else if(key =='1'){
     println("KEY");
     ke[effectIndex].init(1);
   } else if(key =='2'){
     ke[effectIndex].init(2);
   } else if(key =='0'){
     ke[effectIndex].init(0);
   }*/
  
}
  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}

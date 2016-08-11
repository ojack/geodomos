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
    cp5.addSlider("low thresh").plugTo(parent,"lowThresh").setRange(0, 255).setPosition(10,10).setValue(146);
    cp5.addSlider("high thresh").plugTo(parent,"highThresh").setRange(0, 255).setPosition(10,30).setValue(255);
     cp5.addSlider("min area").plugTo(parent,"minArea").setRange(0, 100000).setPosition(10,50).setValue(2000);
      cp5.addSlider("contour approx: ").plugTo(parent,"contourApprox").setRange(0, 50).setPosition(10,70).setValue(10);
      cp5.addSlider("blending ").plugTo(parent,"blending").setRange(0, 255).setPosition(10,90).setValue(255);
      cp5.addSlider("spline tightness").plugTo(parent,"splineTightness").setRange(-1.0, 1.0).setPosition(10,110).setValue(0.25);
       cp5.addSlider("spline points").plugTo(parent,"splinePoints").setRange(2, 300).setPosition(10,130).setValue(10);
         cp5.addSlider("num repetitions").plugTo(parent,"numReps").setRange(1, 10).setPosition(10,150).setValue(5);
            cp5.addSlider("triangle scale").plugTo(parent,"t_scale").setRange(0.0, 1.0).setPosition(10,250).setValue(0.5);
      cp5.addToggle("draw debug").plugTo(parent, "drawDebug").setValue(true).setPosition(300,10);
       cp5.addToggle("equal spacing").plugTo(parent, "spacingMode").setValue(true).setPosition(370,10);
        cp5.addToggle("use splines").plugTo(parent, "useSpline").setValue(false).setPosition(440,10);
   }

  public void draw() {
      background(abc);
      //image(debug, 10, 200);
      //image(kinect.getDepthImage(), 0, 0);
   // if(drawDebug) image(src, 0, 0);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight, CheckBox this_checkbox, PGraphics _debug) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
    debug = _debug;
    checkbox = this_checkbox;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}

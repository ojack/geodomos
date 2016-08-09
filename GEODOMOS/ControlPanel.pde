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
      cp5.addSlider("contour approx: ").plugTo(parent,"contourApprox").setRange(0, 100).setPosition(10,70).setValue(10);
      cp5.addSlider("blending ").plugTo(parent,"blending").setRange(0, 255).setPosition(10,90).setValue(255);
   }

  public void draw() {
      background(abc);
      //image(debug, 10, 200);
      //image(kinect.getDepthImage(), 0, 0);
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

import javax.swing.JFrame;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

import gab.opencv.*;

int SOURCE_WIDTH = 640;
int SOURCE_HEIGHT = 480;

private ControlP5 cp5;
ControlFrame cf;
CheckBox checkbox;

Kinect kinect;
KinectEffect [] ke; 

Puntos puntos;

OpenCV opencv;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;


PImage thresh, src;
PGraphics render, debug;

int lowThresh, highThresh, minArea, maxArea, contourApprox, blending;

void setup() 
{
  size(displayWidth, displayHeight, P3D); 
   background(0);
   initKinect();
   ke = new KinectEffect[2];
 
   ke[0] = (KinectEffect)new Puntos();

 
   /* draw output to render PGraphics, and draw any debugging information to debug */
   render = createGraphics(displayWidth, displayHeight);
   //debug = createGraphics(kinect.width, kinect.height);
   debug = createGraphics(800, 600);
   /* setup gui */
   cp5 = new ControlP5(this);
   cf = addControlFrame("Kinect control", 1000, 800, checkbox, debug);
}

void draw(){
  frame.setTitle("" + frameRate);
  
 ke[0].update();
// puntos.update();
 //puntos.update();
  image(render, 0, 0);
 
 
}

void initKinect(){
  kinect = new Kinect(this);
  kinect.initDepth();

  
  opencv = new OpenCV(this, SOURCE_WIDTH, SOURCE_HEIGHT);
  thresh = new PImage(SOURCE_WIDTH, SOURCE_HEIGHT);
  src = new PImage(SOURCE_WIDTH, SOURCE_HEIGHT);
}

void loadOpenCV(){
  
}

void getContours(){
 
  
}


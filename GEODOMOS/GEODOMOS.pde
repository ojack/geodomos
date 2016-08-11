import processing.opengl.*;
import javax.swing.JFrame;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import java.util.*;
 import java.awt.geom.*;
import toxi.geom.*;
import gab.opencv.*;

int SOURCE_WIDTH = 640/2;
int SOURCE_HEIGHT = 480/2;

private ControlP5 cp5;
ControlFrame cf;
CheckBox checkbox;

Kinect kinect;
KinectEffect [] ke; 

Puntos puntos;

OpenCV opencv;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;

PGraphics render, debug;

int lowThresh, highThresh, minArea, maxArea, contourApprox, blending, splinePoints, numReps;
float splineTightness, t_scale;
boolean drawDebug, spacingMode, useSpline;

PShader blur, threshold;
PGraphics src, blur1, blur2, output;
  
 int numFrames = 0;
void setup() 
{
  size(displayWidth, displayHeight, OPENGL); 
   background(0);
   initKinect();
   ke = new KinectEffect[2];
 
   ke[0] = (KinectEffect)new Puntos();
   ke[1] = (KinectEffect)new Triangles();
 
   /* draw output to render PGraphics, and draw any debugging information to debug */
   render = createGraphics(displayWidth, displayHeight, OPENGL);
   //debug = createGraphics(kinect.width, kinect.height);
   debug = createGraphics(800, 600);
   /* setup gui */
   cp5 = new ControlP5(this);
   cf = addControlFrame("Kinect control", 1000, 800, checkbox, debug);
   
 //  frameRate(25);
}

void draw(){
  numFrames++;
  frame.setTitle("" + frameRate);
  
 ke[1].update();
// puntos.update();
 //puntos.update();
  image(render, 0, 0);
 
 
}

void initKinect(){
  kinect = new Kinect(this);
  kinect.initDepth();

  
  opencv = new OpenCV(this, SOURCE_WIDTH, SOURCE_HEIGHT);
  blur = loadShader("sepBlur.glsl");
    threshold = loadShader("threshold.glsl");
    println("kaleido");
     blur.set("blurSize", 9);
    blur.set("sigma", 5.0);
    src = createGraphics(SOURCE_WIDTH, SOURCE_HEIGHT, P2D);
     blur1 = createGraphics(SOURCE_WIDTH, SOURCE_HEIGHT, P2D);
     blur1.noSmooth();
     blur2 = createGraphics(SOURCE_WIDTH, SOURCE_HEIGHT, P2D);
     blur2.noSmooth();
     output = createGraphics(SOURCE_WIDTH, SOURCE_HEIGHT, P2D);
     output.noSmooth();
}

void loadOpenCV(){
  
}

void getContours(){
 
  
}


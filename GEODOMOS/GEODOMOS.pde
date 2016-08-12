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
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
BeatDetect beat;

float beatAmt = 0;

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

int effectIndex = 4;

int lowThresh, highThresh, minArea, maxArea, contourApprox, blending, splinePoints, numReps;
float splineTightness, t_scale, beatInfluence, shadowScale, lineOffsetX, lineOffsetY, lineAnimXScale, lineAnimYScale, rotationAnimation, sWeight,  strokeOpacity, rotXSpeed,rotYSpeed;
boolean drawDebug, spacingMode, useSpline, lineScaleMode;
color c1, c2;

boolean updateEffect = false;
char effectKey = ' ';
int effectKeyCode = ' ';

PShader blur, threshold;
PGraphics src, blur1, blur2, output;
  
 int numFrames = 0;
void setup() 
{
  size(displayWidth, displayHeight, OPENGL); 
   background(0);
   initKinect();
  

  
 
   /* draw output to render PGraphics, and draw any debugging information to debug */
   render = createGraphics(displayWidth, displayHeight, OPENGL);
   //debug = createGraphics(kinect.width, kinect.height);
   debug = createGraphics(800, 600);
   /* setup gui */
   cp5 = new ControlP5(this);
   cf = addControlFrame("Kinect control", 1000, 800, checkbox, debug);
   
    minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  beat = new BeatDetect();
  //beat.setSensitivity(300);  
 //  frameRate(25);
  ke = new KinectEffect[5];
  ke[0] = (KinectEffect)new ExpandedShadow();
   ke[1] = (KinectEffect)new Triangles();
   ke[2] = (KinectEffect)new Grid();
   ke[3] = (KinectEffect)new Lines();
    ke[4] = (KinectEffect)new IcosahedronEffect();
    ke[effectIndex].init(0);
}

void draw(){
  if(updateEffect){
    updateEffectIndex();
    updateEffect = false;
  }
  beat.detect(in.mix);
  numFrames++;
  frame.setTitle("" + frameRate);
  
 ke[effectIndex].update();
// puntos.update();
 //puntos.update();
  image(render, 0, 0);
  
 if ( beat.isOnset() ) beatAmt = 100;
 /*boolean newBeat = false;
  if ( beat.isKick() ) {
    newBeat = true;
    beatAmt = 100;
     fill(255, 0, 0);
  } else if ( beat.isSnare() ) {
  //  newBeat = true;
   // beatAmt = 100;
     fill(255, 255, 0);
  } else if(beat.isHat()){
  //  newBeat = true;
  //  beatAmt = 100;
     fill(0, 0, 255);
  }*/
 
  beatAmt *= 0.95;
  if ( beatAmt < 0 ) beatAmt = 0;
 // ellipse(20, 20, beatAmt, beatAmt);
}

public void myTest(){
  println("MY TEST");
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

void updateEffectIndex(){
  println("key"+ key);
  if (effectKeyCode == RIGHT) {
     effectIndex += 1;
     if(effectIndex >= ke.length)effectIndex = 0;
     ke[effectIndex].init(0);
   } else if(effectKeyCode==LEFT){
     effectIndex--;
      if(effectIndex < 0) effectIndex = ke.length - 1;
      ke[effectIndex].init(0);
   } else if(effectKey =='1'){
     println("KEY");
     ke[effectIndex].init(1);
   } else if(effectKey =='2'){
     ke[effectIndex].init(2);
   } else if(effectKey =='0'){
     ke[effectIndex].init(0);
   }
}
void keyPressed(){
 // println(key);
  effectKey = key;
  effectKeyCode = keyCode;
   updateEffectIndex();
  
}


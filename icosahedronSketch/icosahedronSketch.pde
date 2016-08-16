import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import peasy.*;
import controlP5.*;
import java.util.List;
import java.awt.Frame;

PeasyCam cam;

Minim minim;
AudioInput in;
AudioPlayer jingle;
BeatDetect beat;
float beatAmt = 0;

private ControlP5 cp5;
ControlFrame cf;
CheckBox checkbox;
PGraphics render, debug;

String path = "C:/Users/alvaro/Dropbox/processing/geodomos/icosahedronSketch/data/";
String presets_path = path + "presets.json";
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/92464*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */


// Icosahedron ico;
int radius = 200;
int radius_step = 20;
KinectEffect [] ke;

float rotXSpeed,rotYSpeed; 

DirectoryReader reader = new DirectoryReader();
int current_effect_index=0;
void setup() {
	size( 800,600, P3D );
	println("setup");
	// println("reader: "+reader);
	String[] filenames = reader.listFileNames(path);
	JSONObject json = new JSONObject();
	try{

		json = loadJSONObject(presets_path);
	}catch (Exception e) {
		println("e: "+e);	
		println("File does NOT exist");
	}

	if(json!=null){

		println(json);
	}else{
		println("File does NOT exist");
		
	}
	if(filenames!=null){
		println(filenames);

	}

	cam = new PeasyCam(this, 500);
	// ico = new Icosahedron();
	noStroke();
	fill( 255,0,0 );
	ke = new KinectEffect[1];

	ke[current_effect_index] = (KinectEffect)new IcosahedronEffect();
	minim = new Minim(this);

	// use the getLineIn method of the Minim object to get an AudioInput
	in = minim.getLineIn();
	beat = new BeatDetect();

	render = createGraphics(displayWidth, displayHeight, OPENGL);
	// debug = createGraphics(kinect.width, kinect.height);
	debug = createGraphics(800, 600);
	// cp5 = new ControlP5(this);
	cf = addControlFrame("Kinect control", 500, 800, checkbox, debug);
}
boolean flag = false;
void draw() {
	if (!flag) {
		frame.setLocation(520, 0);
		// cf.setLocation(0, 0);
		flag = true;
	}
	beat.detect(in.mix);

	if ( beat.isOnset() ) beatAmt = 100;

	// fill( 0,0,0 );
	// text("icosahedron division: "+int( ICOSUBDIVISION ),20,40);
	// text("vertices: "+int( ico.vertexList.size() ),20,60);
	// text("fps: "+int(frameRate),20,80);
	// text("press up & down to change division",20,100);
	// text("press q & a to change radius",20,120);
	beatAmt *= 0.95;
	if ( beatAmt < 0 ) beatAmt = 0;
	ellipse(20, 20, beatAmt, beatAmt);

	ke[0].update(beatAmt);
}

void keyPressed() {
	((IcosahedronEffect)ke[0]).keyPressed();
}
void reds() {
	((IcosahedronEffect)ke[0]).colors_red();
}
void colors_original() {
	((IcosahedronEffect)ke[0]).colors_original();
	
}
void colors_blues() {
	((IcosahedronEffect)ke[0]).colors_blues();
	
}
void whole() {
	((IcosahedronEffect)ke[0]).setPolyhedron(0);
}
void pyramid() {
	((IcosahedronEffect)ke[0]).setPolyhedron(1);
}
void pyramidRest() {
	((IcosahedronEffect)ke[0]).setPolyhedron(2);
}
void stripe() {
	((IcosahedronEffect)ke[0]).setPolyhedron(3);
}
void subdivisions(int ev) {
	// println("ev: "+ev);
	((IcosahedronEffect)ke[0]).set_subdivisions(ev);
}
void subdivisions3(int ev) {
	// println("ev:3 "+ev);
	int subdivs = (int)ev;
	((IcosahedronEffect)ke[0]).set_subdivisions(subdivs);
	// ((IcosahedronEffect)ke[0]).ICOSUBDIVISION = subdivs;
	// ((IcosahedronEffect)ke[0]).init(subdivs);

}
void save_presets() {
	// println("a: "+a);
	// println("hhhhhh");
	JSONObject j  = ke[0].get_settings();
	println("j: "+j);
	j.setInt("current_effect_index",current_effect_index);
	j.setString("name","nammmannamamnaae");
	saveJSONObject(j, presets_path);

	
}
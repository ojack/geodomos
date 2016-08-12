ControlFrame addControlFrame(String theName, int theWidth, int theHeight, CheckBox checkbox, PGraphics debug) {
	Frame f = new Frame(theName);
	ControlFrame p = new ControlFrame(this, theWidth, theHeight, checkbox, debug);
	f.add(p);
	p.init();
	f.setTitle(theName);
	f.setSize(p.w, p.h);
	f.setLocation(0, 0);
	f.setResizable(false);
	f.setVisible(true);
	return p;
}

public class ControlFrame extends PApplet {

	int w, h;
	CheckBox checkbox;
	int abc = 100;
	int y_pos = 0;

	public void setup() {
		size(w, h);
		frameRate(25);
		cp5 = new ControlP5(this);
		cp5.addSlider("rot X Speed").plugTo(parent,"rotXSpeed").setRange(0,0.25).setPosition(10,y_pos).setValue(0.0);
		y_pos+=20;
		cp5.addSlider("rot Y Speed").plugTo(parent,"rotYSpeed").setRange(0,0.25).setPosition(10,y_pos).setValue(0.0);
		y_pos+=20;
		y_pos+=20;
		cp5.addButton("original clrs (W)").plugTo(parent,"colors_original").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("red (Z)").plugTo(parent,"reds").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("blues (X)").plugTo(parent,"colors_blues").setPosition(10,y_pos);
		y_pos+=20;
		y_pos+=20;
		cp5.addButton("whole").plugTo(parent,"whole").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("pyramid").plugTo(parent,"pyramid").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("bottom").plugTo(parent,"pyramidRest").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("stripe").plugTo(parent,"stripe").setPosition(10,y_pos);
		y_pos+=20;
		y_pos+=20;
		cp5.addSlider("subdivisions").plugTo(parent,"subdivisions").setNumberOfTickMarks(4).setRange(0,3).setPosition(10,y_pos).setValue(0);
		y_pos+=20;
		cp5.addNumberbox("subdivisions2").plugTo(parent,"subdivisions").setRange(0,3).setPosition(10,y_pos).setValue(0);
		y_pos+=20;
		cp5.addButtonBar("subdivisions3").addItems(split("0 1 2 3"," ")).plugTo(parent,"subdivisions3").setPosition(10,y_pos);
		y_pos+=20;
	}
	void reds() {
		println("reds");
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
		/*
		*/
	}


	public ControlP5 control() {
		return cp5;
	}


	ControlP5 cp5;

	Object parent;


}

Textfield preset_name_display;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight, JSONObject j, PGraphics debug) {
	Frame f = new Frame(theName);
	ControlFrame p = new ControlFrame(this, theWidth, theHeight, j, debug);
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
	JSONObject presets_json;
	int abc = 100;
	int y_pos = 0;

	public void setup() {
		size(w, h);
		frameRate(25);
		cp5 = new ControlP5(this);
		set_presets();
		y_pos=0;
		y_pos+=20;
		cp5.addLabel("ROTATIONS SPEED").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addSlider("rot X Speed").plugTo(parent,"rotXSpeed").setRange(0,0.25).setPosition(10,y_pos).setValue(0.0);
		y_pos+=20;
		cp5.addSlider("rot Y Speed").plugTo(parent,"rotYSpeed").setRange(0,0.25).setPosition(10,y_pos).setValue(0.0);
		y_pos+=20;
		y_pos+=20;
		cp5.addLabel("COLORS SCHEME").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("original clrs (W)").plugTo(parent,"colors_original").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("red (Z)").plugTo(parent,"reds").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addButton("blues (X)").plugTo(parent,"colors_blues").setPosition(10,y_pos);
		y_pos+=20;
		y_pos+=20;
		cp5.addLabel("PARTS OF ICOSAHEDRON DISPLAYED").setPosition(10,y_pos);
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
		cp5.addLabel("ICOSUBDIVISION").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("Following controllers sometimes fail: not important: should be controlled by kinect.").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("Subdivisions are also controlled by UP and DOWN arrows.").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("Next three controlleres: just testing which ones worked fine, but none seems to do so.").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("Insist: they should be controlled by kinect").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("Meaning that the ICOSUBDIVISION field/parameter of the IcosahedronEffect,").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("should be controlled by kinect.").setPosition(10,y_pos);
		y_pos+=20;
		cp5.addLabel("The thing is don't know exactly how.").setPosition(10,y_pos);
		y_pos+=20;
		/*
		cp5.addSlider("subdivisions").plugTo(parent,"subdivisions").setNumberOfTickMarks(4).setRange(0,3).setPosition(10,y_pos).setValue(0);
		y_pos+=20;
		cp5.addNumberbox("subdivisions2").plugTo(parent,"subdivisions").setRange(0,3).setPosition(10,y_pos).setValue(0);
		y_pos+=20;
		y_pos+=20;
		*/
		cp5.addButtonBar("subdivisions3").addItems(split("0 1 2 3"," ")).plugTo(parent,"subdivisions3").setPosition(10,y_pos);
	}
	Object[] keys_strings;
	void set_presets() {
		y_pos=0;
		int x_pos = 300;
		y_pos+=20;
		cp5.addLabel("PRESETS").setPosition(x_pos,y_pos);
		y_pos+=20;
		cp5.addButton("save current").plugTo(parent,"save_presets").setPosition(x_pos,y_pos);
		y_pos+=20;
		preset_name_display = cp5.addTextfield("preset name").plugTo(parent,"save_presets").setPosition(x_pos,y_pos);
		set_preset_name_to_random_word();
		y_pos+=20;
		y_pos+=20;
		cp5.addButton("delete all presets").setSize(100,18).plugTo(parent,"delete_all_presets").setPosition(x_pos,y_pos);
		y_pos+=20;
		cp5.addButton("random name").plugTo(parent,"set_preset_name_to_random_word").setPosition(x_pos,y_pos);
		y_pos+=20;
		cp5.addLabel("SAVED PRESETS").setPosition(300,y_pos);
		y_pos+=20;
		cp5.addLabel("Currently:").setPosition(300,y_pos);
		y_pos+=20;
		cp5.addLabel("Each time you save a random name for the preset is generated.").setPosition(300,y_pos);
		y_pos+=20;
		cp5.addLabel("effectIndex is also set randomly:").setPosition(300,y_pos);
		y_pos+=20;
		Set keys = presets_json.keys();
		keys_strings = keys.toArray();
		y_presets = y_pos;
		show_presets_for_effectIndex();
	}
		int y_presets;
	void show_presets_for_effectIndex() {
		y_pos = y_presets;
		Iterator keys2 = presets_json.keyIterator();
		int count=0;
		while (keys2.hasNext()) {
			String item = (String)keys2.next();
			JSONObject datum = presets_json.getJSONObject(item);
			if(datum.getInt("effect_index")==effectIndex){

				this.add_preset_button(item,count);
			}
			count++;
		}

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

	public ControlFrame(Object theParent, int theWidth, int theHeight, JSONObject presets_json_, PGraphics _debug) {
		parent = theParent;
		w = theWidth;
		h = theHeight;
		debug = _debug;
		presets_json = presets_json_;
		/*
		*/
	}
	ArrayList<Button> preset_buttons= new ArrayList<Button>();
	void add_preset_button(String button_label,int preset) {
		// println("button_label: "+button_label);
		y_pos+=20;
		// println("cp5: "+this.cp5);
		preset_buttons.add(cp5.addButton(button_label).setPosition(300,y_pos).setSize(100,18).setValue(preset).plugTo(this,"load_presets"));
	}
	void load_presets(int value) {
		// println("value: "+value);
		String var_name = (String)keys_strings[value];
		// println("var_name: "+var_name);
		JSONObject preset = presets_json.getJSONObject(var_name);
		println("preset: "+preset);

	}
	public ControlP5 control() {
		return cp5;
	}

	void keyPressed() {
		// println(key);
		// println(keyCode);
		if(keyCode==39||keyCode==37){
			if(keyCode==39){

				effectIndex++;
			}
			if(keyCode==37){

				effectIndex--;
			}
			int size = preset_buttons.size();
			for (int i = 0; i < size; ++i) {
				preset_buttons.get(i).remove();
			}
			preset_buttons.clear();
			show_presets_for_effectIndex();
		}
	}
	ControlP5 cp5;

	Object parent;

}
String[] generateRandomWords(int numberOfWords, int length){
	String[] randomStrings = new String[numberOfWords];
	Random random = new Random();
	for(int i = 0; i < numberOfWords; i++)
	{
		char[] word = new char[length]; // words of length 3 through 10. (1 and 2 letter words are boring.)
		for(int j = 0; j < word.length; j++)
		{
			word[j] = (char)('a' + random.nextInt(26));
		}
		randomStrings[i] = new String(word);
	}
	return randomStrings;
}
public void controlEvent(ControlEvent theEvent) {
  // println(theEvent.getController().getName());
  // n = 0;
}
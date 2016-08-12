class IcosahedronEffect extends KinectEffect{ 
	int ICOSUBDIVISION = 2;
	int ICOSUBDIVISION_MAX = 3;
	Icosahedron ico;
	int radius = 800;
        int MIN_RADIUS = 300;
        int MAX_RADIUS = 800;
	int radius_step = 20;
	IcosehedronDetails details;
	int polyhedronIndex = 0;
        PGraphics icoGraphics;
        
	IcosahedronEffect () {  
		println("IcosahedronEffect");
		println("1");
		ico = new Icosahedron();
		// println("2");
		setPyramidRest();
		// println("3");
		ico.init(ICOSUBDIVISION);
		// Pyramid pyramid = new Pyramid(2);
		boolean is_showing;
		is_showing = false;
		//is_showing = true;
		details = new IcosehedronDetails(ico,is_showing);
		colors_original();
                ico = createGraphics(displayWidth, displayHeight, OPENGL);

	} 
	void set_subdivisions(int subdivs) {
               // ico = new Icosahedron();
		println("subdivs: "+subdivs);
		ICOSUBDIVISION = (int)subdivs;
		try {
			ico.init(ICOSUBDIVISION);
			
		} catch (Exception e) {
			println("e: "+e);
		}
		
	}
	float rx=0;
	float ry=0;
	color c0,c1,c2,c3;
	void update() {
		// int amp = int(amplitude);
		radius = int(map(beatAmt,0,100,MIN_RADIUS,MAX_RADIUS));
		boolean is_translating = false;
		boolean is_rotating = true;
		boolean is_transforming = true;
		// float rx = frameCount / 800.f;
		rx +=rotXSpeed; 
		ry +=rotYSpeed; 
		// float ry = frameCount / 430.f;
		// ry = frameCount / 430.f;

		background(0);

		fill( 255,0,0 );
		PVector f1 = new PVector();
		PVector f2 = new PVector();
		PVector f3 = new PVector();
		int color_index = 0;
		//stroke( 0 );
                
                noStroke();

		pushMatrix();
               translate(render.width/2, render.height/2);
		if(is_transforming&&is_translating)translate( width * 0.5, height * 0.5, 0 );
		if (is_transforming&&is_rotating) {
			rotateX( rx );
			rotateY( ry );
		}
		int vertices_amount = ico.vertexList.size();
              //  println(vertices_amount);
		// since it's a list x,y,z,x,y,z,...etc there are 9 points in each vertex
		for ( int i = 0; i < vertices_amount-8; i+=9 ) {
			f1.x = ico.vertexList.get(i) * radius;
			f1.y = ico.vertexList.get(i+1) * radius;
			f1.z = ico.vertexList.get(i+2) * radius;
			f2.x = ico.vertexList.get(i+3) * radius;
			f2.y = ico.vertexList.get(i+4) * radius;
			f2.z = ico.vertexList.get(i+5) * radius;
			f3.x = ico.vertexList.get(i+6) * radius;
			f3.y = ico.vertexList.get(i+7) * radius;
			f3.z = ico.vertexList.get(i+8) * radius;
			if (color_index == 0) {
				fill(c0 );
				color_index++;
			} else if (color_index == 1) {
				fill(c1 );
				color_index++;
			} else if (color_index == 2) {
				fill(c2 );
				color_index++;
			} else {
				fill(c3 );
				color_index = 0;
			}
			beginShape();
			vertex( f1.x, f1.y, f1.z );
			vertex( f2.x, f2.y, f2.z );
			vertex( f3.x, f3.y, f3.z );
			endShape( CLOSE );
			details.repeatedVertices(f1,f2,f3,false);

		}
		details.verticesUnique(radius,false);
		details.verticesText(radius*1.1,true);
		popMatrix(); 
		// details.verticesUnique(f1,f2,f3);
		// 
		if(false){
			fill( 0,0,0 );
			text("icosahedron division: "+int( ICOSUBDIVISION ),20,40);
			text("vertices: "+int( ico.vertexList.size() ),20,60);
			text("fps: "+int(frameRate),20,80);
			text("press up & down to change division",20,100);
			text("press q & a to change radius",20,120);
		}
	}
	void colors_original() {
		int alpha = 255;

		c0= color( 255,60,0  ,alpha);
		c1= color( 100,255,0 ,alpha);
		c2= color( 255,180,0 ,alpha);
		c3= color( 0,255,255 ,alpha);
		
	}
	void colors_red() {
		int alpha = 255;

		c0= color( 255,60,0 ,alpha);
		c1= color( 255,60,0 ,alpha);
		c2= color( 255,60,0 ,alpha);
		c3= color( 255,60,0 ,alpha);
		
	}
	void colors_blues() {
		int alpha = 255;

		c0= color( 127,60,127 ,alpha);
		c1= color( 255,60,255 ,alpha);
		c2= color( 127,60,255 ,alpha);
		c3= color( 60,60,255 ,alpha);
		
	}
	void keyPressed() {
		println( keyCode );
		println( key );
		if ( keyCode == 38 ) { // [up]
			if ( ICOSUBDIVISION == ICOSUBDIVISION_MAX )
				return;
			ICOSUBDIVISION++;
			ico.init(ICOSUBDIVISION);

			// ico = new Icosahedron(ICOSUBDIVISION);
		} else if ( keyCode == 40 ) {  // [down]
			if ( ICOSUBDIVISION == 0 )
				return;
			ICOSUBDIVISION--;
			ico.init(ICOSUBDIVISION);

			// ico = new Icosahedron(ICOSUBDIVISION);
		} 
		if (keyCode==81) {// [q] 
			radius+=radius_step;
		}
		if(keyCode==65){// [a]
			radius-=radius_step;

		}
		if(keyCode==90){
			println("ico.vdata: "+ico.vdata.length);
			println("ico.vdata: "+ico.vdata[0].length);
		}
		if(keyCode==82){//[r]
			//cam.reset();
		}
		if(keyCode==49){//[1]
			setPyramid();
		}
		int polyhedronTypeAmount = 4;
		if(keyCode==37){//[left?]
			polyhedronIndex--;
			if(polyhedronIndex<0){
				polyhedronIndex=polyhedronTypeAmount-1;
			}
			println("polyhedronIndex: "+polyhedronIndex);
			setPolyhedron(polyhedronIndex);
		}
		if(keyCode==39){//[right?]
			polyhedronIndex++;
			if(polyhedronIndex>=polyhedronTypeAmount){
				polyhedronIndex=0;
			}
			println("polyhedronIndex: "+polyhedronIndex);
			setPolyhedron(polyhedronIndex);
		}
		if(key=='s'){
			colors_red();
		}
		if(key=='w'){
			colors_original();
		}
		if(key=='x'){
			colors_blues();
		}
	}
	public void setPolyhedron(int index) {
		switch (index) {
			case 0:
				ico = new Icosahedron();
			break;
			case 1:
				setPyramid();
			break;
			case 2:
				setPyramidRest();
			break;
			case 3:
				ico = (Icosahedron)new IcosahedronStripe();
			break;
			
		}
		ico.init(ICOSUBDIVISION);
	}
	void setPyramid() {
		
		ico = (Icosahedron)new Pyramid(0);
	}
	void setPyramidRest() {
		
		ico = (Icosahedron)new PyramidRest(0);
	}
} 

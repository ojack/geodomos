public class IcosehedronDetails{
	boolean is_showing = true;
	public Icosahedron ico;
	public IcosehedronDetails(Icosahedron ico_,boolean is_showing) {
		is_showing=is_showing;
		ico=ico_;
		println("ico: "+ico);
		int res = 5;
		sphereDetail(res);
	}
	public void update() {
	}
	public void repeatedVertices(PVector f1,PVector f2,PVector f3,boolean isShowing) {
		if(isShowing && is_showing){
			int radius = 10;
			sphereAt(f1,radius);
			/*
			sphereAt(f2,radius);
			sphereAt(f3,radius);
			pushMatrix();
			translate(f2.x, f2.y, f2.z);
			sphere(10);
			popMatrix();
			pushMatrix();
			translate(f3.x, f3.y, f3.z);
			sphere(10);
			popMatrix();
			*/
		}
		
	}
	private void sphereAt(PVector c, int r) {
		pushMatrix();
		translate(c.x, c.y, c.z);
		sphere(r);
		popMatrix();
	}
	private void sphereAt(float x,float y,float z, int r) {
		pushMatrix();
		translate(x,y,z);
		sphere(r);
		popMatrix();
	}
	private void sphereAt(float l[],float r, int sr) {
		pushMatrix();
		translate(l[0]*r,l[1]*r,l[2]*r);
		sphere(sr);
		popMatrix();
	}
	private void textAt(String content,float l[],float r) {
		pushMatrix();
		translate(l[0]*r,l[1]*r,l[2]*r);
		text(content,0,0);
		// sphere(sr);
		popMatrix();
	}
	public void verticesUnique(float radius,boolean isShowing) {
		if(isShowing && is_showing){
			// int vertices_amount = (int);
			int sphere_radius = 10;
			// println("sphere_radius: "+sphere_radius);

			// println("ico: "+ico);
			for (int i = 0; i < ico.vdata.length; ++i) {
				float xyz[]=ico.vdata[i];
				sphereAt(xyz,radius,sphere_radius);
			}
		}
	}
	public void verticesText(float radius,boolean isShowing) {
		if(isShowing && is_showing){
			// int vertices_amount = (int);
			int sphere_radius = 10;
			// println("sphere_radius: "+sphere_radius);
			fill(0);
			// println("ico: "+ico);
			for (int i = 0; i < ico.vdata.length; ++i) {
				float xyz[]=ico.vdata[i];
				textAt(""+int(i),xyz,radius);

			}
		}
	}
}
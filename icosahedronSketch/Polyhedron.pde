class Polyhedron{
	public List<Float> vertexNormalsList = new ArrayList<Float>();
	public List<Float> vertexList = new ArrayList<Float>();
	public float vdata[][];
	public int tindices[][];
	Polyhedron(){}
	void init(int ICOSUBDIVISION) {
		vertexNormalsList = new ArrayList<Float>();
		vertexList = new ArrayList<Float>();
		println("init");
	       println("po. tindices: "+tindices);
		// println("po. tindices: "+tindices.length);
		println("po. vdata: "+vdata);
		// Iterate over points
		// 
		try {
			for (int i = 0; i < tindices.length; ++i) {
				subdivide(
					vdata[tindices[i][0]], 
					vdata[tindices[i][1]],
					vdata[tindices[i][2]], ICOSUBDIVISION );
			}
			/*
			*/
			
		} catch (Exception e) {
			println("e: "+e);
		}
	}
	private void norm(float v[]){

		float len = 0;

		for(int i = 0; i < 3; ++i){
			len += v[i] *  v[i];
		}

		len = (float) Math.sqrt(len);

		for(int i = 0; i < 3; ++i){
			v[i] /= len;
		}
	}

	private void add(float v[]){
		for (int k = 0; k < 3; ++k) {
			vertexList.add(v[k]);
			vertexNormalsList.add(v[k]);
		}
	}

	private void subdivide(float v1[], float v2[], float v3[], int depth) {

		if (depth == 0) {
			add(v1);
			add(v2);
			add(v3);
			return;
		}

		float v12[] = new float[3];
		float v23[] = new float[3];
		float v31[] = new float[3];

		for (int i = 0; i < 3; ++i) {
			v12[i] = (v1[i] + v2[i]) / 2f;
			v23[i] = (v2[i] + v3[i]) / 2f;
			v31[i] = (v3[i] + v1[i]) / 2f;
		}

		norm(v12);
		norm(v23);
		norm(v31);

		subdivide(v1, v12, v31, depth - 1);
		subdivide(v2, v23, v12, depth - 1);
		subdivide(v3, v31, v23, depth - 1);
		subdivide(v12, v23, v31, depth - 1);
	}
}

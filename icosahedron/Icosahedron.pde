// copied and adapted from http://code.google.com/p/webgltimer/source/browse/src/net/icapsid/counter/client/Icosahedron.java?r=170e4fcc41bf20700dcb6dc67272073af112c65c
class Icosahedron extends Polyhedron {


	public float X = 0.525731112119133606f;
	public float Z = 0.850650808352039932f;

/*
*/
	Icosahedron() {
		tindices = new int[][]{ { 0, 4, 1 }, { 0, 9, 4 }, { 9, 5, 4 },
			{ 4, 5, 8 }, { 4, 8, 1 }, { 8, 10, 1 }, { 8, 3, 10 },
			{ 5, 3, 8 }, { 5, 2, 3 }, { 2, 7, 3 }, { 7, 10, 3 },
			{ 7, 6, 10 }, { 7, 11, 6 }, { 11, 0, 6 }, { 0, 1, 6 },
			{ 6, 1, 10 }, { 9, 0, 11 }, { 9, 11, 2 }, { 9, 2, 5 },
			{ 7, 2, 11 }
		};
		vdata = new float[][]{ 
			{ -X, 0.0f, Z }, 
			{ X, 0.0f, Z },
			{ -X, 0.0f, -Z }, 
			{ X, 0.0f, -Z }, 
			{ 0.0f, Z, X },
			{ 0.0f, Z, -X }, 
			{ 0.0f, -Z, X }, 
			{ 0.0f, -Z, -X },
			{ Z, X, 0.0f }, 
			{ -Z, X, 0.0f }, 
			{ Z, -X, 0.0f },
			{ -Z, -X, 0.0f }
		};
		// println("ic. tindices: "+tindices);
		println("ic. vdata: "+vdata);

		// super();
		// List<Float> texCoordsList = new ArrayList<Float>();
		// List<Integer> indicesList = new ArrayList<Integer>();

		// init(ICOSUBDIVISION);
		// verticesArray = floatListToFloatArray(vertexList);
		// texCoordsArray = floatListToFloatArray(texCoordsList);
		// vertexNormalsArray = floatListToFloatArray(vertexNormalsList);
		// indices = integerListToIntegerArray(indicesList);
		// vertexCount = vertexList.size() / 3;
	}

}

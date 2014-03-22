// Based on Code from Ira Greenberg et al. in the book
//  Processing: Creative Coding and Generative Art in Processing 2
//  By Ira Greenberg, Dianna Xu, and Deepak Kumar
//
//	rhazes


import controlP5.*;

//GENE CODES
//gene codes
final int RINGS = 0;
final int POINTS = 1;
final int OUTERRAD = 2;
final int IORATIO = 3;
final int BRIGHTNESS = 4;
final int ROTATION = 5;
final int HUE = 6;


ControlP5 cp;

// Asterias [] fs;
AsteriasPopulation asp;

Table t;
int rows  = 4;
int cols = 4;

void setup() {
	size(1000,1000);
	smooth(4);
	colorMode(HSB,360,100,100);

	cp = new ControlP5(this);

	float[] testGenes = new float[7];
	testGenes[RINGS] = 1.0;
	testGenes[POINTS] = 0;
	testGenes[OUTERRAD] = 0;
	testGenes[IORATIO] = 0;
	testGenes[BRIGHTNESS] = 0.95;
	testGenes[ROTATION] = 0.23;
	testGenes[HUE] = random(0,360);

	// fs = new Asterias[rows*cols];
	// for(int i=0; i < fs.length; ++i) {
	// 	// fs[i] = new Asterias(int(random(3, 20)), int(random(5, 15)), new PVector(50,200), random(.3,.9), color(255));
	// 	fs[i] = new Asterias(new AsteriasDNA(testGenes));
	// }

	t = new Table(rows,cols,width,height);
	asp = new AsteriasPopulation(0.1, t.rows*t.cols);
	// noLoop();

	//test DNA crossover

	float[] testGenes2 = new float[7];
	testGenes2[RINGS] = random(1);
	testGenes2[POINTS] = random(1);
	testGenes2[OUTERRAD] = random(1);
	testGenes2[IORATIO] = random(1);
	testGenes2[BRIGHTNESS] = random(1);
	testGenes2[ROTATION] = random(1);
	testGenes2[HUE] = random(0,360);	

	AsteriasDNA dna1 = new AsteriasDNA(testGenes);
	AsteriasDNA dna2 = new AsteriasDNA(testGenes2);

	println(dna1);
	println(dna2);
	AsteriasDNA child = dna1.crossover(dna2);
	println(child);
	child.mutate(1.0);
	println(child);
	
}

void draw() {
	background(255);
	translate(t.cellDim.x * 0.5 , t.cellDim.y * 0.5);
	asp.display(t);

	// for(int j=0; j < t.rows; ++j ) {
	// 	for(int i=0; i < t.cols; ++i) {
	// 		pushMatrix();
	// 		translate( i * t.cellDim.x, j * t.cellDim.y );
	// 		// scale(.4);			
	// 		fs[j * t.cols + i].display();
	// 		popMatrix();
	
	// 	}
	// }

}

void mousePressed() {
	t.getCellFromPos(mouseX, mouseY);
}

class Table {
	int rows;
	int cols;
	PVector cellDim;

	Table(int r, int c, float w, float h) {
		cellDim =  new PVector( w/c, h/r);
		rows = r;
		cols = c;
	}	

	int size() { return rows * cols; }

	int[] getCellFromPos(float x, float y) {
		int[] ret = new int[2];

		ret[0] = int(x / cellDim.x);
		ret[1] = int(y / cellDim.y);
		println(ret);

		return ret;
	}
}


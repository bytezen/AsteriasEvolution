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

	t = new Table(rows,cols,width,height);
	asp = new AsteriasPopulation(0.1, t.rows*t.cols);
	// noLoop();

}

void draw() {
	background(255);
	translate(t.cellDim.x * 0.5 , t.cellDim.y * 0.5);
	asp.display(t);
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


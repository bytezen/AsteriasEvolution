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
float tablePadding = 200;
Button btn;

void setup() {
	size(1200,1100);
	smooth(4);
	colorMode(HSB,360,100,100);
	textSize(24);

	cp = new ControlP5(this);

	t = new Table(rows,cols,width-tablePadding,800);
	asp = new AsteriasPopulation(0.1, t.rows*t.cols);
	// noLoop();

	btn = new Button(int(width * 0.5), int(height * 0.95), 150, 75, "Evolve It!");

}

void draw() {
	background(0,0,80);
	t.display();
	pushMatrix();
	translate((width * 0.5  - t.twidth * 0.5) + t.cellDim.x * 0.5 , 
			   (height * 0.5 - t.theight * 0.6) + t.cellDim.y * 0.5);
	asp.display(t);
	popMatrix();

	btn.display();
}

void mousePressed() {
	int[] cell = t.getCellFromPos(mouseX, mouseY);
	println(cell);
	// cell[1] * t.cols
}

class Table {
	int rows;
	int cols;
	PVector cellDim;
	float twidth,theight;

	Table(int r, int c, float w, float h) {
		cellDim =  new PVector( w/c, h/r);
		rows = r;
		cols = c;
		twidth = cellDim.x * cols;
		theight = cellDim.y * rows;		
	}	

	int size() { return rows * cols; }


	//return the row,col for this position
	int[] getCellFromPos(float x, float y) {
		int[] ret = new int[2];

		ret[0] = int(y / cellDim.y);	
		ret[1] = int(x / cellDim.x);

		return ret;
	}

	void display() {
		pushMatrix();
		pushStyle();
		strokeWeight(2.0);
		fill(200,100,20,50);
		translate(width * 0.5 - twidth * 0.5, height * 0.5 - theight *0.6);
		rectMode(CORNER);
		rect(0, 0, twidth, theight,2);


		for(int i = 0; i < cols; ++i) {
			float _x = i * cellDim.x;
			line(_x, 0, _x, theight);
		}

		for(int i = 0; i < rows; ++i) {
			float _y = i * cellDim.y;
			line(0, _y, twidth, _y);
		}

		popStyle();
		popMatrix();
	}
}


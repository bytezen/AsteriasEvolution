// Based on Code from Ira Greenberg et al. in the book
//  Processing: Creative Coding and Generative Art in Processing 2
//  By Ira Greenberg, Dianna Xu, and Deepak Kumar
//
//	rhazes


import controlP5.*;
import java.awt.Rectangle;

//GENE CODES
//gene codes
final int GENE_LEN = 8;

final int RINGS = 0;
final int POINTS = 1;
final int OUTERRAD = 2;
final int IORATIO = 3;
final int BRIGHTNESS = 4;
final int ROTATION = 5;
final int HUE = 6;
final int MIN_BRIGHT = 7;

//VALUES For GENES
//VALUES For GENES
// float MIN_HUE = 120;
// float MAX_HUE = 120;

int MIN_BRIGHT_LO = 20;
int MIN_BRIGHT_HI = 60;

// float MIN_BRIGHTNESS = 20;
float MAX_BRIGHTNESS = 200;

int MIN_RINGS = 3;
int MAX_RINGS = 20;

int MIN_POINTS = 5;
int MAX_POINTS = 15;

float MIN_ORADIUS = 100;
float MAX_ORADIUS = 250;

float MIN_IORATIO = 0.3;
float MAX_IORATIO = 0.95;

float MIN_ROTATION = radians(45);
float MAX_ROTATION = radians(100);

// long complexEnvironmentThreshold = 1000 * 60;
// boolean complexMode = false;


ControlP5 cp;

// Asterias [] fs;
AsteriasPopulation asp;

Table t;
float tableXOffset, tableYOffset;
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
	tableXOffset = width * 0.5 - t.twidth * 0.5;
	tableYOffset = height * 0.5 - t.theight * 0.6;

	asp = new AsteriasPopulation(0.1, t.rows*t.cols);
	// noLoop();

	btn = new Button(int(width * 0.5 - 75), int(height * 0.85), 150, 75, "Evolve It!");

}

void draw() {
	background(0,0,80);
	t.display();
	pushMatrix();
	translate(tableXOffset + t.cellDim.x * 0.5 , 
			   tableYOffset + t.cellDim.y * 0.5);
	asp.display(t);
	popMatrix();

	btn.rollover(mouseX,mouseY);		
	btn.display();

	// if(!complexMode && (millis() > complexEnvironmentThreshold) ) {
	// 	complexMode = true;
	// 	evolveGeneComplexity();
	// }
}



// void evolveGeneComplexity() {
// 	MIN_HUE = 0;
// 	MAX_HUE = 240;

// 	MIN_BRIGHTNESS = 10;
// 	MAX_BRIGHTNESS = 100;

// 	int MIN_RINGS = 3;
// 	int MAX_RINGS = 20;

// 	int MIN_POINTS = 5;
// 	int MAX_POINTS = 15;

// 	MIN_ORADIUS = 100;
// 	MAX_ORADIUS = 250;

// 	MIN_IORATIO = 0.3;
// 	MAX_IORATIO = 0.9;

// 	MIN_ROTATION = radians(90);
// 	MAX_ROTATION = radians(200);
// }

void mousePressed() {
	if(t.mouseOver()) {
		int[] cell = t.getCellFromMousePos();
		int ind = cell[1] * t.cols + cell[0];
		Asterias a = asp.get(ind);
		if(a != null )
			a.fitness++;
	}


  if (btn.clicked(mouseX,mouseY)) {
    asp.selection();
    asp.reproduction();
  }
}


void mouseReleased() {
	btn.released();
}

class Table {
	int rows;
	int cols;
	PVector cellDim;
	float twidth,theight;
	Rectangle bbox;

	color hoverColor = color(0,80,80);

	Table(int r, int c, float w, float h) {
		cellDim =  new PVector( w/c, h/r);
		rows = r;
		cols = c;
		twidth = cellDim.x * cols;
		theight = cellDim.y * rows;		
		bbox = new Rectangle(0,0,int(twidth),int(theight));
	}	

	int size() { return rows * cols; }


	//return the row,col for this position
	int[] getCellFromMousePos() {
		int[] ret = new int[2];

		ret[0] = int((mouseX - tableXOffset) / cellDim.x);
		ret[1] = int((mouseY - tableYOffset) / cellDim.y);	

		return ret;
	}

	void display() {
		pushMatrix();
		pushStyle();
		strokeWeight(2.0);
		translate(tableXOffset, tableYOffset);
		rectMode(CORNER);

		if( mouseOver() ) {
			int[] cell = getCellFromMousePos();
			pushStyle();
			fill(hoverColor);
			noStroke();
			rect(cell[0] * cellDim.x, cell[1] * cellDim.y, cellDim.x, cellDim.y);			
			popStyle();
			// c = hoverColor;
		}
		fill(200,200,20,100);

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

	boolean mouseOver() {
		return bbox.contains(mouseX-tableXOffset,mouseY-tableYOffset);
	}
}


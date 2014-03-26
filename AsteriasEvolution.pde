// Based on Code from Ira Greenberg et al. in the book
//  Processing: Creative Coding and Generative Art in Processing 2
//  By Ira Greenberg, Dianna Xu, and Deepak Kumar
//
//	rhazes


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
int MIN_BRIGHT_HI = 50;

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

PImage bg;

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
	textSize(36);

	
	t = new Table(rows,cols,width-tablePadding,800);
	tableXOffset = width * 0.5 - t.twidth * 0.5;
	tableYOffset = height * 0.5 - t.theight * 0.6;

	asp = new AsteriasPopulation(0.1, t.rows*t.cols);
	// noLoop();

	btn = new Button(int(width * 0.5 - 100), int(height * 0.85), 200, 75, "Evolve It!");

	//background
	PGraphics bgGraphics = createGraphics(width*2,height*2);
	int hLines = 1000;
	int vLines = 50;
	bgGraphics.beginDraw();
	bgGraphics.strokeWeight(0.5);
	// bgGraphics.stroke(color(229,35,53));
	bgGraphics.stroke(color(0,0,60));
	bgGraphics.translate(bgGraphics.width/2.0, bgGraphics.height/2.0);
	
	
	bgGraphics.rotate(PI/3.0);
	for(int i=0; i < vLines; ++i) {
		float _x = map(i,0,vLines,-bgGraphics.width/2.0,bgGraphics.width/2.0); 
		bgGraphics.line(_x,-bgGraphics.height/2.0, _x,bgGraphics.height/2.0);
	}
	bgGraphics.rotate(-2*PI/3.0);
	for(int i=0; i < hLines; ++i) {
		float _x = map(i,0,hLines,-bgGraphics.width/2.0,bgGraphics.width/2.0); 
		bgGraphics.line(_x,-bgGraphics.height/2.0, _x,bgGraphics.height/2.0);
	}			

	bgGraphics.endDraw();
	bg = bgGraphics.get();


}

void draw() {
	background(0,0,80);
	image(bg,width*0.5 - bg.width*0.5, height*0.5-bg.height*0.5);
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
		if(a != null ) {
			if(mouseButton == LEFT) 
				a.increaseFitness();
			else if(mouseButton == RIGHT)
				a.decreaseFitness();
			
		}
	}


  if (btn.clicked(mouseX,mouseY)) {
    asp.selection();
    asp.reproduction();
  }
}


void mouseReleased() {
	btn.released();
}




class Table {
	int rows;
	int cols;
	PVector cellDim;
	float twidth,theight;
	Rectangle bbox;

	color bgColor = color(206,11,56);
	color gridColor = color(223,23,55);
	color hoverColor = color(186,80,80);
	color textColor = color(186,10,90);

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
		fill(bgColor);
		stroke(gridColor);
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
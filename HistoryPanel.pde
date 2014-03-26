import java.awt.Rectangle;

class HistoryPanel {
	int x,y,w,h;
	PStyle style;
	Rectangle r;
	boolean hoverOn = false;
	int[][] data;

	int rows = 3;
	int cols = 4;

	Table t;

	HistoryPanel(int x, int y, int w, int h, PStyle style) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.style = style;
		r = new Rectangle(x,y,w,h);

		t = new Table(rows,cols,w,h);
	}

	void display(ArrayList<Asterias> data) {
		pushStyle();
		fill(style.fillColor);
		stroke(style.strokeColor);		
		fill(0);
		pushMatrix();
		translate(x,y);
		rect(0,0,w,h);

		if(t != null) {
			t.display();
		}

		translate(0,t.cellDim.y*0.5);
		drawHistory(data);

		popMatrix();
		popStyle();
	}

	void drawHistory(ArrayList<Asterias> data) {
		int gens = getGenerations(data.size());
		int ptr = 0;
		float offset = t.cellDim.x * 0.5;
		float cellSpacing = t.cellDim.x;

		if(gens >= 1 ) {
			for(int i=gens-1; i >= 0; --i) {				
				int revGenOrdinal = (gens-1) - i;
				float f 	= pow(2,revGenOrdinal);
				float _y 	= revGenOrdinal * t.cellDim.y;
				float _x 	= f * offset;				

				float spacing = f * cellSpacing;
				int count = int(pow(2,i));  
				
				pushMatrix();
				translate( f * offset,_y);
				
				for(int j=0; j < count; j++) {					
					pushMatrix();
					translate(j*spacing,0);
					// print((j*spacing) + "\t");

					if(i < gens-1) {
						line(0,0, 0, -t.cellDim.y);						
					}

					if(j % 2 == 0 && j < count - 1) {
						line(0,0,spacing,0);
					}
					
					if(ptr < data.size()) {
						if(data.get(i) != null) {
							data.get(i).display();
						}
						// devOnlyDrawData(data[ptr]);
						ptr++;		
					}
					popMatrix();			
				}
				// println();
				popMatrix();
			}
		}
	}

	int getGenerations(int totalCount) {
		int gen = 0;
		while(totalCount > 0 && gen <=10) {
			totalCount = totalCount >> 1;
			gen++;
		}
		return gen;
	}

	void devOnlyDrawData(int[] d) {
		pushStyle();
		fill(d[0]);
		stroke(d[1]);
		ellipse(0,0,t.cellDim.x*0.75, t.cellDim.y * 0.75);
		popStyle();
	}

	boolean mouseOver(float x, float y) {
		hoverOn = r.contains(x,y);
		return hoverOn;
	}

	void setData(int [][] d) {
		data = d;

		int generations = getGenerations(data.length);;
		int rows = generations;
		int cols = int(pow(2,generations-1));		
		float cellDim = min( ((w*1.0) / cols ) , ((h*1.0) / rows  ));

		t = new Table(rows,cols, cols*cellDim, rows*cellDim);				
	}
}

/* 
PStyle fields



float	ambientB 
float	ambientG 
float	ambientR 
int	colorMode 
float	colorModeA 
float	colorModeX 
float	colorModeY 
float	colorModeZ 
int	ellipseMode 
float	emissiveB 
float	emissiveG 
float	emissiveR 
boolean	fill 
int	fillColor 
int	imageMode 
int	rectMode 
int	shapeMode 
float	shininess 
float	specularB 
float	specularG 
float	specularR 
boolean	stroke 
int	strokeCap 
int	strokeColor 
int	strokeJoin 
float	strokeWeight 
int	textAlign 
int	textAlignY 
PFont	textFont 
float	textLeading 
int	textMode 
float	textSize 
boolean	tint 
int	tintColor 


*/
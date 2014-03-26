import java.awt.Rectangle;

class HistoryPanel {
	int x,y,w,h;
	PStyle style;
	Rectangle r;
	boolean hoverOn = false;
	int[][] data;

	Table t;

	HistoryPanel(int x, int y, int w, int h, PStyle style) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.style = style;
		r = new Rectangle(x,y,w,h);

		
	}

	void display() {
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

		translate(t.cellDim.x*0.5,100);
		drawHistory();

		popMatrix();
		popStyle();
	}

	void drawHistory() {
		int gens = getGenerations(data.length);
		
		int ptr = 0;
		if(gens >= 1 ) {
			//draw the first one
			
			for(int i=gens-1; i >= 0; --i) {				
				float _y = map(i,gens-1,0,0,500);
				float spacing = map(i,gens-1,0,0,gens*t.cellDim.x*0.5);
				int revGenOrdinal = (gens-1) - i;

				int count = int(pow(2,i));  //count in this generation
				
				pushMatrix();
				translate( revGenOrdinal * t.cellDim.x * 0.5,_y);
				
				for(int j=0; j < count; j++) {					
					pushMatrix();
					translate(j*t.cellDim.x* (revGenOrdinal + 1),0);
				
					if(ptr < data.length) { 
				
						devOnlyDrawData(data[ptr]);
						ptr++;		
					}
					popMatrix();			
				}
				popMatrix();
			}
		}
	}

	void devOnlyDrawData(int[] d) {
		pushStyle();
		fill(d[0]);
		stroke(d[1]);
		ellipse(0,0,t.cellDim.x*0.9, t.cellDim.y * 0.9);
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
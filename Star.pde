class Star {
	PShape s;
	PVector pos;

	int verts;
	float iRadius, oRadius;

	Star(int verts, float innerRadius, float outerRadius) {
		this.verts = verts;
		iRadius = innerRadius;
		oRadius = outerRadius;
		pos = new PVector(0,0);

		init();
	}

	void draw() {
		// pushStyle();
		pushMatrix();
		translate(pos.x, pos.y);		
		shape(s);
		popMatrix();
		// popStyle();
	}

	void setPosition(float x, float y) {
		pos.x = x;
		pos.y = y;
	}

	private void init() {
		
		float tempRadius;
		float theta = 0.0;
		float thetaRot = TWO_PI / (verts * 2);
		float _x, _y;

		s = createShape();
		s.setFill(color(255));		

		s.beginShape();
		// s.strokeWeight(4);		

		  for (int i=0; i<verts; i++) {
		    for (int j=0; j<2; j++) {		    	
		      		      
		      if (j%2==0) {
		        tempRadius = oRadius;
		      } else {
		      	tempRadius = iRadius;
		      }

		      _x = cos(theta)*tempRadius;
		      _y = sin(theta)*tempRadius;
		      s.vertex(_x, _y);
		      theta += thetaRot;
		    }
		  }		
		s.endShape(CLOSE);		
	}

	
}
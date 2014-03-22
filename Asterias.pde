 class Asterias {
 	AsteriasDNA dna;

	float hu;
	float sat = 80;
	float fitness = 0;

	final float MIN_HUE = 120;
	final float MAX_HUE = 120;

	final float MIN_BRIGHTNESS = 10;
	final float MAX_BRIGHTNESS = 100;

	final int MIN_RINGS = 3;
	final int MAX_RINGS = 20;

	final int MIN_POINTS = 5;
	final int MAX_POINTS = 15;

	final float MIN_ORADIUS = 200;
	final float MAX_ORADIUS = 400;

	final float MIN_IORATIO = 0.3;
	final float MAX_IORATIO = 0.9;

	final float MIN_ROTATION = radians(90);
	final float MAX_ROTATION = radians(200);


	Asterias(AsteriasDNA dna) {
		this.dna = dna;
		this.hu = dna.genes[HUE];
	}

	void drawStar(int verts, float innerRadius, float outerRadius) {		
		float tempRadius;
		float theta = 0.0;
		float thetaRot = TWO_PI / (verts * 2);
		float _x, _y;
		
		beginShape();
			
		  for (int i=0; i< verts; i++) {
		    for (int j=0; j<2; j++) {		    	
		      		      
		      if (j%2==0) {
		        tempRadius = outerRadius;
		      } else {
		      	tempRadius = innerRadius;
		      }

		      _x = cos(theta)*tempRadius;
		      _y = sin(theta)*tempRadius;
		      vertex(_x, _y);
		      theta += thetaRot;
		    }
		  }		
		endShape(CLOSE);		
	}


	void display() {
		//set the display variables based on the genetic code 
		float shadeColor 	=     lerp(MIN_BRIGHTNESS,MAX_BRIGHTNESS,dna.genes[BRIGHTNESS]);
		int rings 			= int(lerp(MIN_RINGS, MAX_RINGS, dna.genes[RINGS]));
		int points 			= int(lerp(MIN_POINTS,MAX_POINTS, dna.genes[POINTS]));
		float oRadius 		= lerp(MIN_ORADIUS,MAX_ORADIUS, dna.genes[OUTERRAD]);
		float iRadius       = oRadius * lerp(MIN_IORATIO,MAX_IORATIO, dna.genes[IORATIO]);
		float rotation      = lerp(MIN_ROTATION, MAX_ROTATION, dna.genes[ROTATION]); 			
		// float hu 			= 

		float t, c, cinv, rot ;

		pushMatrix();
		for(int i=0; i < rings; ++i) {
			t = norm(i,0,rings-1);
			c = lerp(MIN_BRIGHTNESS,shadeColor,t);
			cinv = lerp(shadeColor,MIN_BRIGHTNESS,t);
			rot = lerp(MIN_ROTATION,rotation,t);

			pushMatrix();			
			fill( hu, sat, c );
			// stroke( hu, sat, cinv, 100 );
			stroke(cinv, 100 );
			// star( points, );
			
			float s =  lerp(1.0,0.4,t);
			scale(s);
			rotate(rot);
			// rect(0,0,200,200);
			drawStar(points, iRadius, oRadius);
			popMatrix();
			

		}
		popMatrix();
		// float fillColor = map(dna.genes[dna.BRIGHTNESS],MIN_BRIGHTNESS,MAX_BRIGHTNESS);
		// float fillColor = map(dna.genes[dna.BRIGHTNESS],MIN_BRIGHTNESS,MAX_BRIGHTNESS);

	}

	float increaseFitness(float v) {
		fitness += v;
		return fitness;
	}

	// void draw() {
	// 	pushMatrix();
	// 	// translate(width / 2.0, height / 2.0);

	// 	float rot;
	// 	float count = shp.getChildCount();
	// 	for(int i =0; i < count; i++) {
	// 		rot = map(i,0,count-1,PI*1.25,PI*1.0);
	// 		pushMatrix();
	// 		rotate(rot);
	// 		shape(shp.getChild(i));
	// 		// shp.getChild(i).setFill(color(200,55));
	// 		popMatrix();
	// 	}
	// 	// shape(shp);
	// 	// s.draw();
	// 	popMatrix();
	// }
}
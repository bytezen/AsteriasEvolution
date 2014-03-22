// Based on Daniel Shiffman's Evolutionary Computing
// in Nature of Code
//

class AsteriasDNA implements DNA {
	float[] genes;
	int len = 7;
	Genes g = Genes.RINGS;

	AsteriasDNA() {
		genes = new float[len];
		for(int i=0; i < genes.length; ++i) {
			genes[i] = random(0,1);
		}
	}

	AsteriasDNA(float[] newgenes) {
		genes = newgenes;
	}

	//Create a new DNA strand from the mixture of this DNA and other
	AsteriasDNA crossover(AsteriasDNA other) {
		float[] childGenes = new float[this.genes.length];
		int crossoverPoint = int(random (this.genes.length));
		println( "\t ... crossover point =" + crossoverPoint);

		for(int i = 0; i < this.genes.length; ++i) {
			if( i > crossoverPoint)
				childGenes[i] = this.genes[i];
			else  {
				childGenes[i] = other.genes[i];				
			}
		}

		AsteriasDNA childDNA = new AsteriasDNA(childGenes);
		return childDNA;
	}

	void mutate(float m) {
		for( int i=0; i < genes.length; ++i) {
			if(random(1) < m) {
				println("mutating gene " + i);
				genes[i] = random(0,1);
			}
		}		
	}

	String toString() {
		String s = "";
		s += "rings: " + genes[RINGS] + " ";
		s += "points: " + genes[POINTS] + " ";
		s += "outerrad: " + genes[OUTERRAD] + " ";
		s += "ioratio: " + genes[IORATIO] + " ";
		s += "brightness: " + genes[BRIGHTNESS] + " ";
		s += "rotation: " + genes[ROTATION] + " ";
		s += "hue: " + genes[HUE] + " ";

		return s;
	}

}
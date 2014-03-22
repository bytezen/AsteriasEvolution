// Based on Population class from Daniel Shiffman's 
// Nature of Code

class AsteriasPopulation  {
	float mutationRate;
	Asterias[] population;
	ArrayList<Asterias> matingPool;
	int generations;

	AsteriasPopulation(float m, int num) {
		mutationRate = m;
		population = new Asterias[num];
		matingPool = new ArrayList<Asterias>();
		generations = 0;

		//initialize the population
		for(int i=0; i<population.length; ++i) {
			population[i] = new Asterias(new AsteriasDNA());
		}
	}



	void display() {
		for(int i=0; i < population.length; ++i ) {
			population[i].display();
		}
	}

	void display(Table t) {
		assert(t.rows*t.cols == population.length);

		for(int j=0; j < t.rows; ++j ) {
			for(int i=0; i < t.cols; ++i) {
				pushMatrix();

				translate( i * t.cellDim.x, j * t.cellDim.y );				
				scale(0.4);
				population[j * t.cols + i].display();
				popMatrix();				
			}
		}
	}

	// Method to generate the mating pool - i.e. a selection round
	// The mating pool is weighted to include more members with higher
	// fitness scores
	void selection() {
		matingPool.clear();

		float maxFit = getMaxFitness();
		float nFit;
		for(int i=0; i < population.length; ++i) {
			nFit = norm(population[i].fitness, 0, maxFit);
			int n = int( nFit * 100);
			n = max(n,1);		//make sure we add at least one
			for(int j=0; j < n; ++j) {
				matingPool.add(population[i]);
			}
		}
	}

	// Making the next generation from the mating pool
	void reproduction() {
		//Create a new population with the children from the mating pool
		for(int i=0; i< population.length; ++i) {
			int m = int(random(matingPool.size()));
			int d = int(random(matingPool.size()));

			Asterias mom = matingPool.get(m);
			Asterias dad = matingPool.get(d);

			// AsteriasDNA childGenes = mom.genes
		}
	}

	float getMaxFitness() {
	    float record = 0;
	    for (int i = 0; i < population.length; i++) {
	      if (population[i].fitness > record) {
	        record = population[i].fitness;
	      }
	    }
	    return record;
	}
}
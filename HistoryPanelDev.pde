HistoryPanel h;
int genes[][];
int tableXOffset = 0;
int tableYOffset = 0;

void setup(){
	size(1000, 1000);
	colorMode(HSB,360,100,100);
	int hPanelHeight = 1000;
	int hPanelWidth = 1000;

	PStyle p = new PStyle();
	h= new HistoryPanel(0,0,hPanelWidth,hPanelHeight,p);		
	
	genes = fakeHistory(3);
	h.setData(genes);
	noLoop();
}


void draw(){
	background(255);
	h.display();
}


int getGenerations(int totalCount) {
	int gen = 0;
	while(totalCount > 0 && gen <=10) {
		totalCount = totalCount >> 1;
		gen++;
	}
	return gen;
}



int[][] fakeHistory(int levels) {
	int len = 0;
	for(int i=0; i < levels; ++i) {
		len += pow(2,i);
	}

	int[][] ret = new int[len][2];
	for(int i=0; i < ret.length; ++i) {
		int[] genes = new int[2];
		genes[0] = int(random(100,255)); //color
		genes[1] = int(random(100,255)); //alpha

		ret[i] = genes;		
	}

	return ret;

}

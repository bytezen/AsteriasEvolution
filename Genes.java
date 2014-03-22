	public enum Genes {
		RINGS(0) , POINTS(1);
		private int value;

		private Genes(int value) { this.value = value;}
		public int id() { return value; }
	}
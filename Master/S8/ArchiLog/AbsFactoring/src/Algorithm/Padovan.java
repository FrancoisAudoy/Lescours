package Algorithm;

public class Padovan implements Algorithm {
	
	 public Padovan() {
		 
	 }

	@Override
	public int getVal(int i) {
		if(i <= 2)
			return 1;
		return getVal(i - 2) + getVal(i - 3);
	}

	@Override
	public String getName() {
		return "Padovan";
	}

}

package Algorithm;

public class Fibonacci implements Algorithm{

	public Fibonacci() {
		
	}
	
	@Override
	public String getName() {
		return "Fibonacci";
	}
	
	@Override
	public int getVal(int i) {
		if(i < 2)
			return i;
		
		return getVal(i - 1) + getVal(i - 2);
	}
}


package Algorithm;

import java.util.HashMap;

public abstract class AlgorithmProxy implements Algorithm {

	protected Algorithm algo;
	private HashMap<Integer, Integer> memory;
	
	public AlgorithmProxy() {
		memory = new HashMap<>();
		createAlgo();
	}
	
	protected abstract void createAlgo();
	
	@Override
	public int getVal(int i) {
		if( !memory.containsKey(i))
			memory.put(i, algo.getVal(i));
		return memory.get(i);
	}

	@Override
	public String getName() {
		return algo.getName();
	}

}

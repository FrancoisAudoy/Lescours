package AbstractFactoryAlgorithm;

import Algorithm.*;

public abstract class AlgoFactory implements AbsAlgoFacto {
	
	public AlgoFactory() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public Algorithm createFibo() {
		return new Fibonacci();
	}
	
	@Override
	public Algorithm createPado() {
		return new Padovan();
	}
}

package AbstractFactoryAlgorithm;

import Algorithm.Algorithm;
import Algorithm.FiboWithMemory;
import Algorithm.PadoWithMemory;

public class AlgoProxyFacto implements AbsAlgoFacto {

	@Override
	public Algorithm createFibo() {
		return new FiboWithMemory();
	}

	@Override
	public Algorithm createPado() {
		return new PadoWithMemory();
	}

}

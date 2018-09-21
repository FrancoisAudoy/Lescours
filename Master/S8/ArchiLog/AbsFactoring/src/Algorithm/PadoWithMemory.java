package Algorithm;

public class PadoWithMemory extends AlgorithmProxy{

	@Override
	protected void createAlgo() {
		this.algo = new Padovan();
	}
}

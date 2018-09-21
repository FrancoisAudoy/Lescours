package Algorithm;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AlgorithmTest {

	Fibonacci fibo;
	Padovan pado;
	FiboWithMemory fiboMemory;
	PadoWithMemory padoMemory;
	
	@Before
	public void init() {
		fibo = new Fibonacci();
		pado = new Padovan();
		fiboMemory = new FiboWithMemory();
		padoMemory = new PadoWithMemory();
	}
	
	@Test
	public void testFiboGetVal() {
		//Test Fibo
		assertEquals(1, fibo.getVal(1));
		assertEquals(0, fibo.getVal(0));
		assertEquals(1, fibo.getVal(2));
		assertEquals(55, fibo.getVal(10));
		assertEquals(6765, fibo.getVal(20));
	}
	
	@Test
	public void testPadoGetVal() {
		assertEquals(1, pado.getVal(0));
		assertEquals(1, pado.getVal(1));
		assertEquals(1, pado.getVal(2));
		assertEquals(12, pado.getVal(10));
	}
	
	@Test
	public void testGetName() {
		assertEquals("Fibonacci", fibo.getName());
		assertEquals("Padovan", pado.getName());
	}
	
	@Test
	public void testFibovsFiboWithMemory() {
		for(int i = 0; i <= 10; ++i)
			assertEquals(fiboMemory.getVal(i), fibo.getVal(i));
	}
	
	@Test
	public void testPadovsPadoWithMemory() {
		for(int i = 0; i <= 10; ++i)
			assertEquals(padoMemory.getVal(i), pado.getVal(i));
	}
	
	
	@After
	public void clean() {
		fibo = null;
		pado = null;
		padoMemory = null;
		fiboMemory = null;
	}

}

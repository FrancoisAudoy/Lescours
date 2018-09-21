package AbstractFactoryAlgorithm;

import Algorithm.Algorithm;

public class Introspection {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		
		if(args.length < 2) {
			System.out.println("Format attendu : [classe a instancier] [nombre iteration] \n");
			return;
		}
		
		try {
			
			Class<? extends AbsAlgoFacto> classe = (Class<? extends AbsAlgoFacto>)Class.forName(args[0]);
			AbsAlgoFacto facto = classe.newInstance();
			int val = Integer.parseInt(args[1]);
			
			Algorithm fibo = facto.createFibo();
			Algorithm pado = facto.createPado();
			
			System.out.println(fibo.getName() + " :" + fibo.getVal(val));
			System.out.println(pado.getName() + " : " + pado.getVal(val));
			
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}

}

package soldier.core;

public class CountVisitor implements Visitor {

	private int countSoldat = 0;
	private int countArmy = 0;
	
	@Override
	public void visit(Unit u) {
		
	}

	public void visit(Army a) {
		++countArmy;
	}
	
	public void printResult() {
		System.out.println("Ily a " + countArmy + " armées et " + countSoldat+ " Soldats");
	}

	@Override
	public void visit(UnitInfantry ui) {
		++countSoldat;	
	}

	@Override
	public void visit(UnitRider ur) {
		++countSoldat;
	}

	
}

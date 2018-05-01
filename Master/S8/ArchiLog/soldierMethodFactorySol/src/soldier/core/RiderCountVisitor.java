package soldier.core;

import java.util.ArrayList;

public class RiderCountVisitor implements Visitor {

	private int lifeLimit;
	private ArrayList<String> riders;
	
	public RiderCountVisitor(int lifeMin) {
		lifeLimit = lifeMin;
		riders = new ArrayList<>();
	}
	
	@Override
	public void visit(Unit u) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(Army a) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(UnitInfantry ui) {

	}

	@Override
	public void visit(UnitRider ur) {
		if(ur.getHealthPoints() >= lifeLimit)
			riders.add(ur.getName());
	}

	public void printResult() {
		StringBuilder string = new StringBuilder(); 
		string.append("Les unitRiders sont :");
		for(String s : riders) {
			string.append("\n\t");
			string.append(s);
		
		}
		System.out.println(string.toString());
	}
}

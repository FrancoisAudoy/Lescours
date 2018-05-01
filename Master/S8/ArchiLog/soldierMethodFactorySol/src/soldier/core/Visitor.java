package soldier.core;

public interface Visitor {

	public void visit(Unit u);
	public void visit(Army a);
	public void visit(UnitInfantry ui);
	public void visit(UnitRider ur);
}

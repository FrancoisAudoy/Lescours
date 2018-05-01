package soldier.core;

import java.util.Iterator;

public class VistEquipment implements Visitor {

	@Override
	public void visit(Unit u) {
		Iterator<Equipment> it = u.getWeapons();
		for(; it.hasNext();) {
			System.out.println("Le soldat " + u.getName() +" posséde " + it.next().getName());
		}
	}

	@Override
	public void visit(Army a) {
		// TODO Auto-generated method stub

	}

	@Override
	public void visit(UnitInfantry ui) {
		Iterator<Equipment> it = ui.getWeapons();
		for(; it.hasNext();) {
			System.out.println("Le soldat " + ui.getName() +" posséde " + it.next().getName());
		}

	}

	@Override
	public void visit(UnitRider ur) {
		Iterator<Equipment> it = ur.getWeapons();
		for(; it.hasNext();) {
			System.out.println("Le soldat " + ur.getName() +" posséde " + it.next().getName());
		}

	}
}

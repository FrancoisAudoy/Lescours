/**
 * D. Auber & P. Narbel
 * Solution TD Architecture Logicielle 2016 Universit� Bordeaux.
 */
package soldier.units;

import soldier.core.UnitRider;
import soldier.core.Visitor;
import soldier.core.Equipment;

public class UnitHorseMan extends UnitRider {

	public UnitHorseMan(String soldierName) {
		super(soldierName, new BehaviorSoldierStd(20, 120));
	}

	/**
	 * A HorseMan can only have two equipments, and one of each kind
	 */
	@Override
	public void addEquipment(Equipment w) {
		int nbW = nbWeapons();
		if (nbW < 2)
		if ( getWeapons().getClass() != w.getClass())
			super.addEquipment(w);
	}

	public void accept(Visitor v) {
		v.visit(this);
	}
	
}

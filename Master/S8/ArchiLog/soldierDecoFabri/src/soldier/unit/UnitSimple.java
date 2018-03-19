package soldier.unit;

import soldier.core.BehaviorSoldier;
import soldier.equipment.Equipement;

public abstract class UnitSimple {

	private BehaviorSoldier soldier;
	private int stuff = 0;
	
	public UnitSimple(BehaviorSoldier s) {
		soldier = s;
	}
	
	public void addEquipement(Equipement e) throws ImpossibleExtensionException {
		
		if(stuff >= 2)
			throw new ImpossibleExtensionException();
		stuff ++;
		
		soldier = e.createExtension(soldier);
	}
	
	public void parry(float damage) {
		soldier.parry(damage);
		
	}
	
	public float strike() {
		return soldier.strike();
	}
	
	public void removeEquipement(Equipement e) {
		
		
	}
	
}

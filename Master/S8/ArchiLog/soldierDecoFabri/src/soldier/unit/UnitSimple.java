package soldier.unit;

import soldier.core.BehaviorSoldier;
import soldier.equipment.Equipement;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

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
	
	public void removeEquipement(Equipement e) throws ImpossibleExtensionException {
		/*if(stuff == 0)
			throw new ImpossibleExtensionException("this soldier got no stuff");
		
		BehaviorExtension current, last = (BehaviorExtension) soldier;
		
		if(e.getExtension().getClass() == last.getClass())
			soldier = last.parent();
			
		for(int i = 0; i < stuff; ++i) {
			current = (BehaviorExtension) last.parent();
			if(e.getExtension().getClass() == current.getClass()) {
				last.reparent(current.parent());
				break;
			}
			last = current;
		}*/
		
		throw new NotImplementedException();
		
	}
	
}

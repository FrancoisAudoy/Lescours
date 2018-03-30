package soldier.equipment;

import soldier.core.BehaviorExtension;
import soldier.core.BehaviorSoldier;
import soldier.core.StdExtension;
import soldier.unit.ImpossibleExtensionException;

public class Sword extends LimitedEquipement{

	private StdExtension extension;
	
	@Override
	public BehaviorExtension createExtension(BehaviorSoldier s) throws ImpossibleExtensionException {
		if(!AlreadyEquiped()) {
			setEquiped();
			extension = new StdExtension(10, 0, s);
			return extension;		}
		throw new ImpossibleExtensionException("Sword Already Equiped");
	}
	
	public StdExtension getExtension() {
		return extension;
	}
	
	public void detach() {
		extension = null;
		setUnequiped();
	}
}

package soldier.equipment;

import soldier.core.BehaviorExtension;
import soldier.core.BehaviorSoldier;
import soldier.core.StdExtension;
import soldier.unit.ImpossibleExtensionException;

public class Shield extends LimitedEquipement {

	private StdExtension extension;

	@Override
	public BehaviorExtension createExtension(BehaviorSoldier s) throws ImpossibleExtensionException {
		if(!AlreadyEquiped()) {
		setEquiped();
		extension = new StdExtension(0, 5, s);
		return extension;
		}
		
		throw new ImpossibleExtensionException("Shield Already equiped");
	}

	public StdExtension getExtension() {
		return extension;
	}
	
	public void detach() {
		extension = null;
		setUnequiped();

	}
}

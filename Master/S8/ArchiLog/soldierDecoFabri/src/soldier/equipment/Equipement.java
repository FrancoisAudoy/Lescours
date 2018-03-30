package soldier.equipment;

import soldier.core.BehaviorExtension;
import soldier.core.BehaviorSoldier;
import soldier.core.StdExtension;
import soldier.unit.ImpossibleExtensionException;

public interface Equipement {
	public BehaviorExtension createExtension(BehaviorSoldier s) throws ImpossibleExtensionException;
	public StdExtension getExtension();
	public void detach();
}

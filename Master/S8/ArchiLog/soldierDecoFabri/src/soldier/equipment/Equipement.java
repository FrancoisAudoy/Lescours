package soldier.equipment;

import soldier.core.BehaviorExtension;
import soldier.core.BehaviorSoldier;

public interface Equipement {
	public BehaviorExtension createExtension(BehaviorSoldier s);

}

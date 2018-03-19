package soldier.equipment;

import soldier.core.BehaviorExtension;
import soldier.core.BehaviorSoldier;
import soldier.core.StdExtension;

public class Sword implements Equipement {

	@Override
	public BehaviorExtension createExtension(BehaviorSoldier s) {
		return new StdExtension(10, 0, s);
	}

}

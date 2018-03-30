package soldier.unit;

import soldier.core.LogPowBehavior;

public class HorseMan extends UnitSimple {

	public HorseMan(String name) {
		super(new LogPowBehavior(15, 10, 90,name));
		// TODO Auto-generated constructor stub
	}

}

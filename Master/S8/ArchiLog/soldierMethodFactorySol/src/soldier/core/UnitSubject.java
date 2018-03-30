package soldier.core;

import java.util.ArrayList;

public abstract class UnitSubject implements Unit {

	private ArrayList<UnitObserver> obs;
	
	public UnitSubject() {
		obs = new ArrayList<>();
	}
	
	@Override
	public void addObserver(UnitObserver o) {
		obs.add(o);
	}

	@Override
	public void detach(UnitObserver o) {
		obs.remove(o);

	}

	@Override
	public void Notify() {
		for(UnitObserver o : obs)
			o.update(this);

	}

}

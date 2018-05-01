package soldier.core;

import java.util.ArrayList;
import java.util.Iterator;

public class Army extends UnitSubject {

	private String armyName;
	private ArrayList<Unit> soldiers;

	public Army(String name) {
		armyName = name;
		soldiers = new ArrayList<>();
	}
	
	@Override
	public String getName() {
		return armyName;
	}

	@Override
	public float getHealthPoints() {
		float totalLife =0;
		for(Unit u : soldiers)
			totalLife += u.getHealthPoints();
		return totalLife;
	}

	@Override
	public boolean alive() {
		return getHealthPoints() > 0;
	}

	@Override
	public void heal() {
		for(Unit u : soldiers)
			u.heal();

	}

	@Override
	public float parry(float force) {
		Notify();
		float dammage = force / soldiers.size();
		float over = 0;
		
		for(Unit u : soldiers)
			over = u.parry(dammage + over);
		
		return over;
	}

	@Override
	public float strike() {
		float force = 0;
		for(Unit u: soldiers)
			force += u.strike();
		return force;
	}

	@Override
	public void addEquipment(Equipment w) {
		int totalEquipment = nbWeapons();
		for(Unit u : soldiers) {
			u.addEquipment(w);
			if(totalEquipment < nbWeapons())	
				return;
		}
	}

	@Override
	public void removeEquipment(Equipment w) {
		for(Unit u : soldiers)
			u.removeEquipment(w);
	}

	@Override
	public Iterator<Equipment> getWeapons() {
		Iterator<Equipment> it = null;
		if (soldiers.size() > 0)
			it = new Iterator<Equipment>() {

			private Iterator<Unit> it = soldiers.iterator();
			private Iterator<Equipment> ite;

			@Override
			public boolean hasNext() {
				if(ite == null || !ite.hasNext()) {
					while(it.hasNext()) {
						ite = it.next().getWeapons();
						if(it.hasNext())
							return true;
					}
					return false;
				}
				return true;
			}

			@Override
			public Equipment next() {
				
				return ite.next();
			}
		};
		return it;
	}

	@Override
	public int nbWeapons() {
		int totalWeapons = 0;
		for(Unit u : soldiers)
			totalWeapons += u.nbWeapons();

		return totalWeapons;
	}

	@Override
	public void addSoldier(Unit s) {
		int posNull = -1;

		if (soldiers.size() > 0)
			posNull = soldiers.indexOf(null);

		if(posNull != -1)
			soldiers.set(posNull, s);
		else
			soldiers.add(s);

	}

	@Override
	public void removeSoldier(Unit s) {
		soldiers.remove(s);
	}

	@Override
	public Iterator<Unit> getChildren() {
		return soldiers.iterator();
	}

	public void accept(Visitor v) {
		v.visit(this);
		
		for(Unit u : (ArrayList<Unit>)soldiers.clone())
			u.accept(v);
	}
	
}

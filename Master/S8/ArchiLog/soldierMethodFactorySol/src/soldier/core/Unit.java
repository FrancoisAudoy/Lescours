package soldier.core;

import java.util.Iterator;

public interface Unit extends Subject {

	public String getName();
	public float getHealthPoints();
	public boolean alive();
	public void heal();
	public float parry(float force);
	public float strike();
	public void addEquipment(Equipment w);
	public void removeEquipment(Equipment w);
	public Iterator<Equipment> getWeapons();
	public int nbWeapons();
	
	public void accept(Visitor v);
	
	public void addSoldier(Unit s);
	public void removeSoldier(Unit s);
	public Iterator<Unit> getChildren();
}

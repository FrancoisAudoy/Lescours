package soldier;

public abstract class SoldierWithEquipment implements Soldier {

	private Soldier deco;
	private int damageBlocked = 0;
	private int damageAdded = 0;

	public SoldierWithEquipment(Soldier soldier, int damageAdded, int damageBlocked) {
		deco = soldier;
		this.damageAdded = damageAdded;
		this.damageBlocked = damageBlocked;
	}

	@Override
	public int strike() {
		return deco.strike() + damageAdded;
	}

	@Override
	public void parry(int damage) {
		deco.parry(damage - damageBlocked);
	}
	
	@Override
	public boolean isAlive() {
		return deco.isAlive();
	}

	public Soldier getDeco() {
		return deco;
	}

	public void setDeco(Soldier deco) {
		this.deco = deco;
	}

	public int getDamageBlocked() {
		return damageBlocked;
	}

	public void setDamageBlocked(int damageBlocked) {
		this.damageBlocked = damageBlocked;
	}

	public int getDamageAdded() {
		return damageAdded;
	}

	public void setDamageAdded(int damageAdded) {
		this.damageAdded = damageAdded;
	}

}

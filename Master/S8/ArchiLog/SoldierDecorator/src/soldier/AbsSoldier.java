package soldier;

public abstract class AbsSoldier implements Soldier {

	private int lifePoint;
	private int damage;
	
	public AbsSoldier(int lifePoint, int initDamage) {
		this.lifePoint= lifePoint;
		this.damage = initDamage;
	}
	
	public int getLifePoint() {
		return lifePoint;
	}

	public void setLifePoint(int lifePoint) {
		this.lifePoint = lifePoint;
	}

	/**
	 * This method return the damage made by the soldier without any equipment
	 */
	public int strike() {
		return damage;
	}

	/**
	 * @param damage The amount of damage taken by the soldier whithout any equipment
	 */
	public void parry(int damage) {
		if(damage > 0)
			lifePoint -= damage;
	}

	/**
	 * Check if the life point is superior to 0
	 */
	public boolean isAlive() {
		return lifePoint > 0;
	}

}

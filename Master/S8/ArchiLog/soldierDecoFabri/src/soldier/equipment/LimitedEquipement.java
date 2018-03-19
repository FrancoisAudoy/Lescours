package soldier.equipment;


public abstract class LimitedEquipement implements Equipement {

	private boolean alreadyEquip = false;
	
	public boolean AlreadyEquiped() {
		return alreadyEquip;
	}
	
	public void setEquiped() {
		alreadyEquip = true;
	}
	
	public void setUnequiped() {
		alreadyEquip = false;
	}
	
	
}

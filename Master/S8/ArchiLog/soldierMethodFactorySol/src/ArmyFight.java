import soldier.core.Army;
import soldier.core.Equipment;
import soldier.core.Unit;
import soldier.equipment.WeaponShield;
import soldier.units.*;

public class ArmyFight {

	public static void main(String argv[]) {
		  Unit hm = new UnitHorseMan("Didier");
		  Unit im = new UnitCenturion("Thom");
		  Unit gr1 = new Army("combatant celui dontonneprononcepaslenom");
		  gr1.addSoldier(hm);
		  gr1.addSoldier(im);
		  Unit hm2 = new UnitCenturion("Brutus");
		  Unit im2 = new UnitHorseMan("Philippe");
		  Unit gr2 = new Army("qui va casser l'étoile noire");
		  gr2.addSoldier(hm2);
		  gr2.addSoldier(im2);
		  Unit gr3 = new Army("en direction du mordor");
		  gr3.addSoldier(gr1);
		  gr3.addSoldier(gr2);
		  Equipment shield = new WeaponShield();
		  gr3.addEquipment(shield);
		  System.out.println("la force de frappe de l'armée " + gr3.getName()  +" est de : " + gr3.strike());
		}

}

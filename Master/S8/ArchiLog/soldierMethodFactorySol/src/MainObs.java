import soldier.core.*;
import soldier.equipment.*;
import soldier.units.*;

class ReportObserver implements UnitObserver {
	  public void update(Unit unit) {
	    System.out.println("L'unité : " + unit.getName() + " a été touchée");
	  }
	}

public class MainObs {

	public static void main(String[] args) {
		UnitObserver obs = new ReportObserver(); 
		Unit hm = new UnitHorseMan("Carcatus Beurk");
		Unit im = new UnitCenturion("Nevil londuba");
		Unit gr1 = new Army("Dumbeldore Army");
		hm.addObserver(obs);
		im.addObserver(obs);
		gr1.addObserver(obs);
		gr1.addSoldier(hm);
		gr1.addSoldier(im);
		Unit hm2 = new UnitCenturion("Brutus");
		Unit im2 = new UnitHorseMan("Centaure");
		Unit gr2 = new Army("Les Romains");
		hm2.addObserver(obs);
		im2.addObserver(obs);
		gr2.addObserver(obs);
		gr2.addSoldier(hm2);
		gr2.addSoldier(im2);
		Unit gr3 = new Army("Les Spartiates");
		gr3.addSoldier(gr1);
		gr3.addSoldier(gr2);
		gr3.addObserver(obs);
		Equipment shield = new WeaponShield();
		gr3.addEquipment(shield);
		gr3.parry(3000);
	}

}

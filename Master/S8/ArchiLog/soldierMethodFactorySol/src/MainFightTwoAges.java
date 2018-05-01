import soldier.core.*;
import soldier.equipment.*;
import soldier.units.*;

class ReportObserver implements UnitObserver {
	  public void update(Unit unit) {
	    System.out.println("Les points de vie de " + unit.getName() + " ont changés");
	  }
	}

public class MainFightTwoAges {

	public static void main(String[] args) {
		UnitObserver obs = new ReportObserver(); 
		Unit hm = new UnitHorseMan("Carcatus Beurk");
		hm.addObserver(obs);
		hm.parry(20);
		hm.heal();
	}

}

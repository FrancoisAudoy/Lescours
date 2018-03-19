package test;

import soldier.unit.ImpossibleExtensionException;
import soldier.equipment.*;
import soldier.unit.*;

public class UniSimpleGame {

	public static void main(String argv[]) {
		  UnitSimple hm = new HorseMan("Robert");
		  UnitSimple im = new InfantryMan("Thimoté");
		  Equipement sw = new Sword();
		  Equipement sh = new Shield();
		  Equipement sw2 = new Sword();
		  try { 
		    im.parry(hm.strike());
		    im.addEquipement(sw);
		    //hm.addEquipement(sw); // Lève une exception car l'arme est déjà attaché
		  }catch(ImpossibleExtensionException e) {
			  e.printStackTrace();
		  }

		  try {
		   im.removeEquipement(sw);
		   hm.addEquipement(sw);
		   hm.addEquipement(sh);    
		   hm.addEquipement(sw2); // Lève une exception car deux armes maximum
		  }catch(ImpossibleExtensionException e) {
			  e.printStackTrace();
		  }
		}

}

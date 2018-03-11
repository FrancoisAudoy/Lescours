import soldier.*;

public class BattleField {

	public static void main(String[] args) {
		fight(new SoldierWithShield(new SoldierWithSword(new HorseMan())),
				new SoldierWithShield(new SoldierWithSword(new InfanteryMan())));
	}

	public static void fight(Soldier s1, Soldier s2) {
		Soldier attack = s1;
		Soldier defend = s2;
		while(s1.isAlive() && s2.isAlive()) {
			defend.parry(attack.strike());
			Soldier tmpSwap = attack;
			attack = defend;
			defend = tmpSwap;
		}
		if (s1.isAlive()) 
			System.out.println("Soldier 1  Won");
		else
			System.out.println("Soldier 2  Won");
	}

}

package testSoldier;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import soldier.*;

public class EquipmentTest {

	private InfanteryMan infant;
	private HorseMan horseman;
	@Before
	public void setUp() throws Exception {
		infant = new InfanteryMan();
		horseman = new HorseMan();
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testSoldierWithSword() {
		Soldier infantWithSword = new SoldierWithSword(infant);
		Soldier horsemanWithSword = new SoldierWithSword(horseman);
		assertEquals(15, infantWithSword.strike());
		assertEquals(20, horsemanWithSword.strike());
		
		infantWithSword = new SoldierWithSword(infantWithSword);
		horsemanWithSword = new SoldierWithSword(horsemanWithSword);
		assertEquals(20,  infantWithSword.strike());
		assertEquals(25, horsemanWithSword.strike());
	}
	
	@Test
	public void testSoldierWithShield() {
		Soldier s1 = new SoldierWithShield(infant);
		Soldier s2 = new SoldierWithShield(horseman);
		s1.parry(s2.strike());
		s2.parry(s1.strike());
		
		assertEquals(99,infant.getLifePoint() );
		assertEquals(90, horseman.getLifePoint());
	}

	@Test
	public void testSoldierDamage() {
		Soldier infantWithEquipment = new SoldierWithSword(infant);
		Soldier horsemanWithEquipment = new SoldierWithSword(horseman);
		
		infantWithEquipment.parry(horsemanWithEquipment.strike());
		horsemanWithEquipment.parry(infantWithEquipment.strike());
		
		assertEquals(82, infant.getLifePoint());
		assertEquals(77, horseman.getLifePoint());
	}
	
	
}

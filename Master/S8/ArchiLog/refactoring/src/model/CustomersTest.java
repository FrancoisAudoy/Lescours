package model;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javafx.scene.layout.Pane;
import movie.Movie;

public class CustomersTest {

	Customers bob;

	Movie ro, rdn, st3;

	Rental r1, r2, r3;

	@Before
	public void init() {
		bob = new Customers("Bob");
		ro = new Movie("Rogue One", Movie.NEW_RELEASE);
		rdn = new Movie("Reine des Neiges", Movie.CHILDRENS);
		st3 = new Movie("Star Wars III", Movie.REGULAR);

		r1 = new Rental(ro, 5);
		r2 = new Rental(rdn, 7);
		r3 = new Rental(st3, 4);

		bob.addRental(r1);
		bob.addRental(r2);
		bob.addRental(r3);
	}

	@Test
	public void testStatement() {
		//fail("Not yet implemented");
		String out = bob.statement();
		StringBuffer expect = new StringBuffer();
		expect.append("Rental Record for Bob\n" + 
				"	Rogue One	15.0 \n" + 
				"	Reine des Neiges	7.5 \n" + 
				"	Star Wars III	5.0 \n" + 
				"Amount owned is 27.5\n" + 
				"You earned 4 frequent renter points");
		assertEquals(out,expect.toString());
	}
	
	@Test
	public void testStatementHTML() {
		String out = bob.statementHTML();
		StringBuffer expect = new StringBuffer();
		expect.append("<!DOCTYPE html>\n" + 
				"<html>\n" + 
				"<head>\n" + 
				"	<title>Rental Record for Bob</title>\n" + 
				"</head>\n" + 
				"<body>\n" + 
				"	Rogue One	15.0 <br/>\n" + 
				"	Reine des Neiges	7.5 <br/>\n" + 
				"	Star Wars III	5.0 <br/>\n" + 
				"	Amount owned is 27.5<br/>\n" + 
				"	You earned 4 frequent renter points\n" + 
				"</body>\n" + 
				"</html>");
		assertEquals(out,expect.toString());
	}
	
	@Test
	public void testStatementFX() {
		Pane statement = bob.statementFX();
		
		
	}

	@After
	public void clean() {
		bob = null;
		ro = rdn = st3 = null;
		r1 = r2 = r3 = null;
	}

}

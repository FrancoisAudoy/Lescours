import model.Customers;
import model.Rental;
import movie.Movie;

@SuppressWarnings("deprecation")
public class Main {

	public static void main(String[] args) {
		Customers bob = new Customers("Bob");

		Movie ro = new Movie("Rogue One", Movie.NEW_RELEASE);
		Movie rdn = new Movie("Reine des Neiges", Movie.CHILDRENS);
		Movie st3 = new Movie ("Star Wars III", Movie.REGULAR);

		Rental r1 = new Rental(ro, 5);
		Rental r2 = new Rental(rdn, 7);
		Rental r3 = new Rental(st3, 4);

		bob.addRental(r1);
		bob.addRental(r2);
		bob.addRental(r3);

		System.out.println(bob.statement());
	}

}

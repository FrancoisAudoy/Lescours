package model;

import java.util.ArrayList;

public class Customer {

	private String name;
	private ArrayList<Rental> rentals = new ArrayList<>();

	public Customer(String name)
	{
		this.name=name;
	}

	public void addRental(Rental rental)
	{
		rentals.add(rental);
	}

	public String getName()
	{
		return name;
	}

	public String statement()
	{
		double totalAmount = 0;
		int frequentRenterPoints = 0;
		//Enumeration<Rental> rentals = this.rentals.elements();
		String result = "Rental Record for "+getName()+"\n";
		
		for (Rental each : this.rentals) {

					double thisAmount = each.price();

					frequentRenterPoints++;

					if( (each.getMovie().getPriceCode()== Movie.NEW_RELEASE)
							&& (each.getDaysRented()>1)) 
						frequentRenterPoints++;
					
					result +="\t" + each.getMovie().getTitle()+"\t"+
							String.valueOf(thisAmount) +" \n";
					totalAmount+=thisAmount;
		}
				result += "Amount owned is " + String.valueOf(totalAmount) +
						"\n";
				result += "You earned " + String.valueOf(frequentRenterPoints) +
						" frequent renter points";
				return result;

	}
	
}

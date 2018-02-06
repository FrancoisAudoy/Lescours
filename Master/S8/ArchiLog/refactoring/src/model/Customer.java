package model;

import java.util.ArrayList;

import movie.Movie;

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

	private int computeRenterPoint() {
		int points = 0;
		for(Rental each : this.rentals) {
			points++;
			if(each.getMovie().getPriceCode() == Movie.NEW_RELEASE)
				points++;
		}
		return points;
	}
	
	private void statement(StatementBuilder b) {
		double totalAmount = 0;
		int frequentRenterPoints = computeRenterPoint();
		b.beginStatement(getName());
		
		for(Rental each : this.rentals) {
			double thisAmount = each.price();

			b.addRental(each.getMovie().getTitle(), thisAmount);
			
			totalAmount+=thisAmount;
		}
		
		b.addSummary(totalAmount, frequentRenterPoints);
		b.endStatement();
	}
	
	public String statement()
	{
		TextStatementBuilder tsb = new TextStatementBuilder();
		
		statement(tsb);
		return tsb.getTextStatement().toString();
	}
	
	public String statementHTML() {
		HTMLStatementBuilder hsb = new HTMLStatementBuilder();
		statement(hsb);
		return hsb.getHTMLStatement().toString();
	}

}

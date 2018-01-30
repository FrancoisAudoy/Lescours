package model;

public class Rental {
    private Movie movie;
    private int daysRented;
    private Price pricing;
    
    public Rental(Movie movie, int daysRented)
    {
	this.movie=movie;
	this.daysRented=daysRented;
	this.pricing = movie.getPriceCode().clone();
    }
    
    public int getDaysRented()
    {
	return daysRented; 
    }
    
    public Movie getMovie()
    {
	return movie;
    }
    
    double price() {
    	return pricing.getPrice(daysRented);
    }
}

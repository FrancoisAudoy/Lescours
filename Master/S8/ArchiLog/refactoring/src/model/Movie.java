package model;

public class Movie {
	public static final Price CHILDRENS = new DefaultPrice(1.5, 3, 1.5);
	public static final Price REGULAR = new DefaultPrice(2, 2, 1.5);
	public static final Price NEW_RELEASE = new DefaultPrice(0, 0, 3);

	private String title;
	private Price priceCode;

	public Movie(String title,Price priceCode)
	{
		this.title=title;
		this.priceCode=priceCode;
	}

	public Price getPriceCode()
	{
		return priceCode;
	}

	public void setPriceCode(Price priceCode)
	{
		this.priceCode=priceCode;
	}
	public String getTitle()
	{
		return title;
	}

}

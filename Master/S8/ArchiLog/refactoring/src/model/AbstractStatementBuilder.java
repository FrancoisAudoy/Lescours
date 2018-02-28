package model;

public abstract class AbstractStatementBuilder implements StatementBuilder {

	
	public AbstractStatementBuilder() {}

	
	abstract public void addRental(String title, double amount);

	
	abstract public void addSummary(double totalAmount, int renterPoints);

	
	abstract public void endStatement();
	
	protected String nameString(String name) {
		StringBuffer nameStatement = new StringBuffer();
		nameStatement.append("Rental Record for ").append(name);
		return nameStatement.toString();
	}
	
	protected String rentalString(String title, double amount, String tab) {
		StringBuilder rental = new StringBuilder();
		rental.append(tab).append(title).append(tab).append(amount);
		return rental.toString();
	}
	
	protected String totalAmountString(double totalAmount) {
		StringBuffer amount= new StringBuffer();
		amount.append("Amount owed is ").append(totalAmount);
		return amount.toString();		
	}
	
	protected String totalRenterPoints(int totalPoints) {
		StringBuffer renterpoints = new StringBuffer();
		renterpoints.append("You earned ");
		renterpoints.append(totalPoints).append(" frequent renter points");
		return renterpoints.toString();
	}

}

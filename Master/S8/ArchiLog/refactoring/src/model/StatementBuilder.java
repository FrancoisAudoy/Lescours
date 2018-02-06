package model;

public interface StatementBuilder {
	
	public void beginStatement(String name);
	public void addRental(String title, double amount);
	public void addSummary(double totalAmount, int renterPoints);
	public void endStatement();
}

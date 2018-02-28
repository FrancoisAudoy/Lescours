package model;

public class TextStatementBuilder extends AbstractStatementBuilder {

	private StringBuffer buf;
	
	public TextStatementBuilder() {
		buf = new StringBuffer();
	}
	
	public void beginStatement(String name) {
		buf.append(super.nameString(name)).append("\n");


	}

	public void addRental(String title, double amount) {
		buf.append(super.rentalString(title, amount, "\t")).append(" \n");

	}

	public void addSummary(double totalAmount, int renterPoints) {
		buf.append(super.totalAmountString(totalAmount)).append("\n");
		buf.append(super.totalRenterPoints(renterPoints));

	}

	public void endStatement() {
	}
	
	public StringBuffer getTextStatement() {
		return buf;
	}

}

package model;

public class TextStatementBuilder implements StatementBuilder {

	private StringBuffer buf;
	
	public TextStatementBuilder() {
		buf = new StringBuffer();
	}
	
	public void beginStatement(String name) {
		buf.append("Rental Record for "+name+"\n");


	}

	public void addRental(String title, double amount) {
		buf.append("\t" + title + "\t" + String.valueOf(amount) + " \n");

	}

	public void addSummary(double totalAmount, int renterPoints) {
		buf.append("Amount owned is " + String.valueOf(totalAmount) + "\n");
		buf.append("You earned " + String.valueOf(renterPoints) + " frequent renter points");

	}

	public void endStatement() {
	}
	
	public StringBuffer getTextStatement() {
		return buf;
	}

}

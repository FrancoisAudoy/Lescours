package model;

import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.scene.text.Text;

public class FXStatementBuilder implements StatementBuilder {

	private GridPane custoPane, rentalPane;
	private int rentalLine = 0;
	
	public FXStatementBuilder() {
		custoPane = new GridPane();
		custoPane.setGridLinesVisible(true);
		rentalPane = new GridPane();
		rentalPane.setGridLinesVisible(true);
	}
	
	
	public void beginStatement(String name) {
		custoPane.add(new Text(name), 0, 0);
	}

	
	public void addRental(String title, double amount) {
		StringBuilder rental = new StringBuilder(title);
		rental.append("\t").append(amount);
		rentalPane.addRow(rentalLine, new Text(rental.toString()));
		rentalLine++;
	}

	
	public void addSummary(double totalAmount, int renterPoints) {

		StringBuilder amount = new StringBuilder("Amount owed is ");
		amount.append(totalAmount);
		StringBuilder points = new StringBuilder("You earned ");
		points.append(renterPoints).append(" frequent renter points");
		
		custoPane.add(new Text(amount.toString()), 0, 2);
		custoPane.add(new Text(points.toString()), 0, 3);
	}

	
	public void endStatement() {
		custoPane.add(rentalPane, 1, 1);
		//statementFinal = new Scene(custoPane);
	}
	
	public Pane getFXStatement() {
		return custoPane;
	}

}

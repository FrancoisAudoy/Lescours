package model;

import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.scene.text.Text;

public class FXStatementBuilder extends AbstractStatementBuilder {

	private GridPane custoPane, rentalPane;
	private int rentalLine = 0;
	
	public FXStatementBuilder() {
		custoPane = new GridPane();
		custoPane.setGridLinesVisible(true);
		rentalPane = new GridPane();
		rentalPane.setGridLinesVisible(true);
	}
	
	
	public void beginStatement(String name) {
		custoPane.add(new Text(super.nameString(name)), 0, 0);
	}

	
	public void addRental(String title, double amount) {
		String rental = super.rentalString(title, amount, "\t");
		rentalPane.addRow(rentalLine, new Text(rental));
		rentalLine++;
	}

	
	public void addSummary(double totalAmount, int renterPoints) {		
		custoPane.add(new Text(super.totalAmountString(totalAmount)), 0, 2);
		custoPane.add(new Text(super.totalRenterPoints(renterPoints)), 0, 3);
	}

	
	public void endStatement() {
		custoPane.add(rentalPane, 1, 1);
		//statementFinal = new Scene(custoPane);
	}
	
	public Pane getFXStatement() {
		return custoPane;
	}

}

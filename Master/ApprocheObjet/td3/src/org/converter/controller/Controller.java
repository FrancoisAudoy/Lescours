package org.converter.controller;

import org.converter.model.Model;
import org.converter.view.View;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.MenuButton;
import javafx.stage.Stage;

public class Controller implements EventHandler<ActionEvent> {
	private static Controller instance;

	private Model model;
	private View view;

	private Controller() {
		
	}

	public static Controller getInstance() {
		if (instance == null)
			instance = new Controller();
		return instance;
	}

	public void start(Stage primaryStage) {
		model = new Model();
		view = new View(primaryStage);
		view.setOnAction(this);
		
		view.Afficher();
	}
	
	@Override
	public void handle(ActionEvent event) {
		
		System.out.println(event.toString());
		Object source = event.getSource();
		if(source == view.getButtons() )
			onClickButtonConverter(event);
		if(source == view.getmButtonsTo())
			onClickmButtonTo(event);
		if(source == view.getFromDollar() || 
				source == view.getFromEuro())
			onClickmButtonFrom(event);			
		if( source == view.getToDollar() || 
				source == view.getToEuro() )
			onClickmButtonTo(event);
		
		
	}

private void onClickmButtonTo(ActionEvent event) {	
	MenuButton mb = view.getmButtonsTo();
	
	if(event.getSource() == view.getToDollar())
		mb.setText("Dollar");
	if(event.getSource() == view.getToEuro())
		mb.setText("Euro");
		System.out.println("To");
		
	}

private void onClickButtonConverter(ActionEvent e) {
	String s = view.gettFFrom().getText();
	String from = view.getmButtonsFrom().getText();
	String to = view.getmButtonsTo().getText();
	Double input;

	if(s.length() != 0) {
		try {
			input = Double.parseDouble(s);
			if(from != "Devise" && to != "Devise") {
				Double output = model.convert(input, from, to);
				view.gettFTo().setText(output.toString());
			}
			else
				System.out.println("Problème avec les devises");
		}catch(NumberFormatException except) {
			System.out.println("Rentrer un somme d'argent valide");
		}
	}
	else
		System.out.println("empty");
}

private void onClickmButtonFrom(ActionEvent event) {
	MenuButton mb =	view.getmButtonsFrom();
	
	if(event.getSource() == view.getFromDollar()) 
		mb.setText("Dollar");	
	if(event.getSource() == view.getFromEuro())
		mb.setText("Euro");	

}
}
package org.converter.controller;

import org.converter.model.Model;
import org.converter.view.View;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.MenuItem;
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
		
		view.Afficher();
	}
	
	@Override
	public void handle(ActionEvent event) {
		// TODO Auto-generated method stub
		
	}
}

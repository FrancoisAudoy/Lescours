package org.converter.view;

import org.converter.controller.Controller;

import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.MenuButton;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public class View {

	private  Stage mainStage;
	private Group g;
	Scene scene;
	private TextField tFFrom;
	private TextField tFTo;
	private Button buttons;
	private Label lResultat;
	private MenuButton mButtonsFrom;
	private MenuButton mButtonsTo;
	

	public View(Stage primaryStage) {
		// TODO Auto-generated constructor stub
		mainStage = primaryStage;
		g = new Group();
		scene = new Scene(g, 200, 150, Color.BURLYWOOD);
		GridPane gPane = new GridPane();
		Label lFrom = new Label("From");
		Label lTo = new Label("To");
		buttons = new Button("Convert");
		mButtonsFrom = new MenuButton("Devise");
		mButtonsTo = new MenuButton("Devise");
		mButtonsFrom.getItems().addAll(new MenuItem("Dollar"),
				new MenuItem("Euro"));
		mButtonsTo.getItems().addAll(new MenuItem("Dollar"),
				new MenuItem("Euro"));
		tFFrom = new TextField();
		tFTo = new TextField();
		lResultat = new Label("Res");

		gPane.add(lFrom, 0, 0);
		gPane.add(lTo, 0, 1);
		gPane.add(mButtonsFrom, 1, 0);
		gPane.add(mButtonsTo, 1, 1);
		gPane.add(tFFrom, 2, 0);
		gPane.add(tFTo, 2, 1);
		gPane.add(buttons, 1, 2);
		gPane.add(lResultat, 2, 2);
		
		g.getChildren().add(gPane);
		mainStage.setScene(scene);
	}
	
	public Label getlResultat() {
		return lResultat;
	}

	public void setOnAction() {
		mButtonsFrom.setOnAction(Controller.getInstance());
		mButtonsTo.setOnAction(Controller.getInstance());
		buttons.setOnAction(Controller.getInstance());
	}
	
	public void Afficher() {
		mainStage.show();
		
	}
}

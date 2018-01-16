package org.converter.view;


import javafx.event.ActionEvent;
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
	private MenuButton mButtonsFrom;
	private MenuButton mButtonsTo;
	private MenuItem fromDollar;
	private MenuItem toDollar;
	private MenuItem fromEuro;
	private MenuItem toEuro;
	
	

	public View(Stage primaryStage) {
		mainStage = primaryStage;
		g = new Group();
		scene = new Scene(g, 250, 150, Color.PAPAYAWHIP);
		GridPane gPane = new GridPane();
		Label lFrom = new Label("From");
		Label lTo = new Label("To");
		fromDollar = new MenuItem("Dollar");
		toDollar = new MenuItem("Dollar");
		fromEuro = new MenuItem("Euro");
		toEuro = new MenuItem("Euro");
		buttons = new Button("Convert");
		mButtonsFrom = new MenuButton("Devise");
		mButtonsTo = new MenuButton("Devise");
		mButtonsFrom.getItems().addAll(fromDollar,
				fromEuro);
		mButtonsTo.getItems().addAll(toDollar,
				toEuro);
		tFFrom = new TextField();
		tFTo = new TextField();
		tFTo.setEditable(false);

		gPane.add(lFrom, 0, 0);
		gPane.add(lTo, 0, 1);
		gPane.add(mButtonsFrom, 1, 0);
		gPane.add(mButtonsTo, 1, 1);
		gPane.add(tFFrom, 2, 0);
		gPane.add(tFTo, 2, 1);
		gPane.add(buttons, 2, 2);
		
		g.getChildren().add(gPane);
		mainStage.setScene(scene);
	}
	

	public void setOnAction(EventHandler<ActionEvent> e) {
		mButtonsFrom.setOnAction(e);
		mButtonsTo.setOnAction(e);
		buttons.setOnAction(e);
		fromDollar.setOnAction(e);
		fromEuro.setOnAction(e);
		toDollar.setOnAction(e);
		toEuro.setOnAction(e);
		
	}
	
	public void Afficher() {
		mainStage.show();
		
	}


	public TextField gettFFrom() {
		return tFFrom;
	}


	public TextField gettFTo() {
		return tFTo;
	}


	public Button getButtons() {
		return buttons;
	}


	public MenuButton getmButtonsFrom() {
		return mButtonsFrom;
	}


	public MenuButton getmButtonsTo() {
		return mButtonsTo;
	}


	public MenuItem getFromDollar() {
		return fromDollar;
	}


	public MenuItem getToDollar() {
		return toDollar;
	}


	public MenuItem getFromEuro() {
		return fromEuro;
	}


	public MenuItem getToEuro() {
		return toEuro;
	}
}

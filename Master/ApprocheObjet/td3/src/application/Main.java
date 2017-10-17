package application;
	
import org.converter.controller.Controller;

import javafx.application.Application;
import javafx.stage.Stage;


public class Main extends Application {
	
	static Controller controller;
	
	@Override
	public void start(Stage primaryStage) {
		controller.start(primaryStage);
		
	}
	
	public static void main(String[] args) {
		controller = Controller.getInstance();
		launch(args);
	}
}

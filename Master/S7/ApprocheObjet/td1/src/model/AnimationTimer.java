package model;

import java.awt.event.ActionListener;

import javax.swing.Timer;

public class AnimationTimer extends Timer {

	// Quelques constantes
	static int STEP = 15; // duree de rafraichissement de l'ecran: 15ms
	public static double MSSTEP = STEP / 1000.0;

	public AnimationTimer(ActionListener actionListener){
		super(STEP, actionListener);

	}

}

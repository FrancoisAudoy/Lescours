package controler;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import model.*;
import view.*;

public class Animation implements ActionListener {

	// Quelques constantes
	public static double GRAVITATION = 9.80665; // acceleration de la gravitation

	private ViewFrame viewFrame;
	private ViewBall viewBall;
	//private ViewBall viewball2;
	private Panel panel;
	private Ball ball;
	//private Ball ball2;
	private Box box;
	private ViewBox viewbox;
	// Objet permettant de provoquer une animation à temps réguliers
	private AnimationTimer timer;


	/*public Animation(String title, Ball modelBall) {
		this.ball = modelBall;
		panel = new Panel();
		viewBall = new ViewBall();
		viewFrame = new ViewFrame(title, Panel.WIDTH, Panel.HEIGHT,
				Panel.XMIN, Panel.YMIN, Panel.XMAX, Panel.YMAX,
				Panel.SCALE, Panel.MARGIN, viewBall);
		timer = new AnimationTimer(this);
		timer.start();
	}*/
	
	public Animation(String title) {
		this.ball = new Ball();
		//.ball2 = new Ball(3.0, 2.0);
		box = new Box((panel.XMAX - panel.XMIN) / 2,
				Panel.YMAX - Panel.YMIN, 0.25, 0.05);
		panel = new Panel();
		viewBall = new ViewBall();
		//viewball2 = new ViewBall();
		viewbox = new ViewBox();
		viewFrame = new ViewFrame(title, Panel.WIDTH, Panel.HEIGHT,
				Panel.XMIN, Panel.YMIN, Panel.XMAX, Panel.YMAX,
				Panel.SCALE, Panel.MARGIN, viewBall, viewbox);
		timer = new AnimationTimer(this);
		timer.start();
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		this.step();
		viewBall.setXY(ball.getX(), ball.getY(), 
				Ball.WIDTH, Ball.HEIGHT, 
				Panel.SCALE, Panel.MARGIN);
		//viewball2.setXY(ball2.getX(), ball2.getY(), 
		//		Ball.WIDTH, Ball.HEIGHT,
		//		Panel.SCALE, Panel.MARGIN);
		viewbox.setXY(box.getX(), box.getY(), box.getLongueur(),
				box.getLargeur(), Panel.SCALE, Panel.MARGIN);
		
		viewFrame.panel.repaint();
	}

	public void step() {
		ball.move(null);
		//ball2.step(ball);
	}


}

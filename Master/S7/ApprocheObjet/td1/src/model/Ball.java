package model;

import controler.Animation;

public class Ball {

	// Taille de la balle
	public static double WIDTH = 0.35; // 35 cm
	public static double HEIGHT = WIDTH;
	public static double RADIUS = WIDTH/2;

	// Masse de la balle
	public double MASS = 1.0;

	// données physiques
	private double x; // position
	private double y;
	private double vx; // vitesse
	private double vy;
	private double ax, ay; // acceleration
	private double x0, y0; // position initiale
	private double vx0; // vitesse initiale
	private double vy0;
	private double fx, fy; // force
	private double t; // temps relatif

	public Ball() {
		fx = 0; // force
		fy = MASS * Animation.GRAVITATION;
		ax = fx / MASS; // acceleration initiale
		ay = fy / MASS; 
		vx0 = vx = 1; // vitesse initiale 1 m/s
		vy0 = vy = 0;
		x0 = x = (Panel.XMIN + Panel.XMAX)/2; // position initiale
		y0 = x = (Panel.YMIN + Panel.YMAX)/2;
		t = 0;
	}

	public Ball(double x_start, double y_start){
		fx = 0; // force
		fy = MASS * Animation.GRAVITATION;
		ax = fx / MASS; // acceleration initiale
		ay = fy / MASS; 
		vx0 = vx = 1; // vitesse initiale 1 m/s
		vy0 = vy = 0;
		x0 = x = x_start; // position initiale
		y0 = x = y_start;
		t = 0;
	}

	public Ball(double x_start, double y_start, double force, double masse, double init_speed){
		fx = force;
		MASS = masse;
		fy = MASS * Animation.GRAVITATION;
		ax = fx / MASS;
		ay = fy / MASS;
		vx0 = vx = init_speed;
		vy0 = vy = 0;
		x0 = x_start;
		y0 = y_start;
		t=0;
	}

	/*
	 * Compute the ball's acceleration
	 */
	private void acceleration(){
		vx = vx0 + ax *t;
		vy = vy0 + ay *t;
	}

	/*
	 * This method compute the new ball's position
	 * with applying the acceleration
	 * and check if the ball bounce against a wall or balls 
	 */
	public void move(Ball otherBall){
		acceleration();
		
		double t2 = t*t;
		x = x0 + vx0 * t + (ax * t2) / 2;
		y = y0 + vy0 * t + (ay * t2) / 2;
		
		bounceAgainstWall();
		bounceAgainstBalls(otherBall);

		this.t += AnimationTimer.MSSTEP;

	}

	/*
	 * If the ball touch a wall, compute the new acceleration
	 * then do nothing
	 */
	public void bounceAgainstWall(){
		if(x > Panel.XMAX - Ball.WIDTH || x < Panel.XMIN){
			vx0 = -vx;
			vy0 = vy ;
			x0 = x;
			y0 = y;
			t = 0;
		}
		if(y > Panel.YMAX - Ball.HEIGHT || y < Panel.YMIN){
			vx0 = vx;
			vy0 = -vy;
			x0 = x;
			y0 = y;
			t = 0;
		}
	}

	public void bounceAgainstBalls(Ball otherball){
		if(null != otherball){
			if (Math.sqrt(Math.pow(otherball.x - x,2.0) + 
					Math.pow(otherball.y - y,2.0)) <= WIDTH){

				vx0 = otherball.vx;
				vy0 = otherball.vy;
				x0 = x;
				y0 = y;
				t = 0;

				otherball.vx0 = vx;
				otherball.vy0 = vy;
				otherball.x0 = otherball.x;
				otherball.y0 = otherball.y;
				otherball.t = 0;
				System.out.println("TOUCH");
			}
		}
	}

	public static double getWidth(){
		return WIDTH;
	}

	public static double getHEIGHT(){
		return HEIGHT;
	}

	public double getX() {
		return x;
	}

	public double getY() {
		return y;
	}

	public void setX(double x) {
		this.x = x;
	}

	public void setY(double y) {
		this.y = y;
	}

}

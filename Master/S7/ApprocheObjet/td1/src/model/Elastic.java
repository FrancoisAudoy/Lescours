package model;

public class Elastic {
	
	private double x0, y0; //correspond à la partie fix de l'elastique
	private double x1, y1; // partie accroché à la balle
	private double raideur;
	
	public Elastic (double x0, double y0, double x1,
			double y1, double raideur) 
	{
		this.x0 = x0;
		this.y0 = y0;
		this.x1 = x1;
		this.y1 = y1;
		this.raideur = raideur;
	}
	
	/*
	 * x, y are the position of the mobile part of the elastic
	 * return the force applied by the elastic
	 */
	public double move (double x, double y){
		x1 = x;
		y1 = y;
		return (-raideur * (Math.sqrt(Math.pow(x0 - x1, 2.0) + Math.pow(y0 - y1, 2.0))));
		
	}

}

package model;

public class Box {
	
	private double longueur;
	private double largeur;
	private static double MASS = 2.0; 
	
	private double x;
	private double y;
	
	public Box(double x, double y, double longueur, double largeur){
		this.largeur = largeur;
		this.longueur = longueur;
		
		this.x = x;
		this.y = y;
	}

	public double getLongueur() {
		return longueur;
	}

	public double getLargeur() {
		return largeur;
	}

	public double getX() {
		return x;
	}

	public double getY() {
		return y;
	}
	
	
	

}

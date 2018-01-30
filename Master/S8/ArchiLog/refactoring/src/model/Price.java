package model;

public interface Price extends Cloneable {
	
	double getPrice(double nbDaysRented);
	Price clone();

}

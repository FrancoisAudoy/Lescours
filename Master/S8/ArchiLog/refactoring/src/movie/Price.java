package movie;

public interface Price extends Cloneable {
	
	public double getPrice(double nbDaysRented);
	public Price clone();

}

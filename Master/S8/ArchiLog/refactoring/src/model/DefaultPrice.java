package model;

public class DefaultPrice implements Price {

	private double fee;
	private int bundleDuration;
	private double extraFee;
	
	public DefaultPrice(double fee, int bundleDuration, double extraFee) {
		this.fee = fee;
		this.bundleDuration = bundleDuration;
		this.extraFee = extraFee;
	} 
	
	@Override
	public double getPrice(double nbDaysRented) {
		double result = fee;
    	if(nbDaysRented > bundleDuration)
    		result += (nbDaysRented - bundleDuration) * extraFee;
    	return result;
	}

	@Override
	public Price clone() {
		try {
		return (Price) super.clone();
		}
		catch (CloneNotSupportedException e) {
		}
		return null;
	}

}

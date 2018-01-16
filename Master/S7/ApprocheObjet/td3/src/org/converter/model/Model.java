package org.converter.model;

import java.util.HashMap;

public class Model {
	
	private HashMap<String, Double> hm;
	
	public Model() {
		hm = new HashMap<>();
		hm.put("Euro", 1.15);
		hm.put("Dollar", 1.0);
	}

	public Double convert(Double input, String from, String to) {
		Double changefrom = hm.get(from);
		Double changeto = hm.get(to);
		
		Double output = (changeto.doubleValue() * input) / changefrom.doubleValue();
		return output;
	}
	
	
}

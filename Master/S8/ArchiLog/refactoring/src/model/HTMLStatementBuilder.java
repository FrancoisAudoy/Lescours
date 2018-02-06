package model;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class HTMLStatementBuilder implements StatementBuilder {

	private StringBuffer buf;
	private String name;
	
	public HTMLStatementBuilder() {
		buf = new StringBuffer();
	}
	
	@Override
	public void beginStatement(String name) {
		this.name = name;
		buf.append("<!DOCTYPE html>\n<html>\n<head>\n\t<title>Rental Record for "+name+"</title>\n</head>\n<body>\n");
	}

	@Override
	public void addRental(String title, double amount) {
		buf.append("\t" + title+"\t"+amount +" <br/>\n");

	}

	@Override
	public void addSummary(double totalAmount, int renterPoints) {
		buf.append("\tAmount owned is " + totalAmount +
				"<br/>\n");
		buf.append("\tYou earned " + renterPoints +
				" frequent renter points\n");

	}

	@Override
	public void endStatement() {
		buf.append("</body>\n</html>");
		
		FileOutputStream f;
		try {
			f = new FileOutputStream(new File(name+".html"));
			f.write(buf.toString().getBytes());
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public StringBuffer getHTMLStatement() {
		return buf;
	}

}

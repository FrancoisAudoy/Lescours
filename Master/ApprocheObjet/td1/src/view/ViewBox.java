package view;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;


public class ViewBox {
	private Rectangle2D.Double rect;
	
	public ViewBox(){
		rect = new Rectangle2D.Double();
	}
	
	public void paint( Graphics g){
		((Graphics2D)g).draw(rect);
	}
	
	public void setXY(double x, double y, double w, double h, double scale, int margin){
		rect.setFrame(x * scale + margin, y * scale + margin,
				w * scale + margin, h * scale + margin);
	}

}

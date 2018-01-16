package view;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;

public class ViewBall{

	// La balle
	Ellipse2D.Double ellipse;

	public ViewBall(){
		ellipse = new Ellipse2D.Double();
	}

	public void paint(Graphics g) {
		((Graphics2D)g).draw(ellipse);
		
	}

	// repositionne la balle selon ses coordonnees
	public void setXY(double x, double y, double width, double height, double scale, int margin) {
		ellipse.setFrame(x * scale + margin, 
				y * scale + margin, 
				width * scale, 
				height * scale);
	}

}

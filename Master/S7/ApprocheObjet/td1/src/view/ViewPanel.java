package view;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JPanel;


public class ViewPanel extends JPanel {

	// coordonnees du plan 
	double xmin, xmax, ymin, ymax;
	double scale;
	int margin;
	private ViewBall ball, ball2;
	private ViewBox box;
	

	public ViewPanel(int width, int height, double xmin, double ymin, 
			double xmax, double ymax, double scale, int margin,ViewBall ball, ViewBox box) {
		setBounds(new Rectangle(0, width, 0, height));
		this.xmin = xmin; // coordonnees du plan en metres
		this.ymin = ymin;
		this.xmax = xmax;
		this.ymax = ymax;
		this.scale = scale;
		this.margin = margin;
		this.ball = ball;
		//this.ball2 = ball2;
		this.box = box;
	}

	 public void paint(Graphics g){
		 super.paint(g);
		 ball.paint(g);
		 //ball2.paint(g);
		 box.paint(g);
		 java.awt.Toolkit.getDefaultToolkit().sync();
		((Graphics2D)g).drawLine(
				(int)(xmin * scale) + margin,
				(int)(ymax * scale) + margin,
				(int)(xmax * scale) + margin,
				(int)(ymax * scale) + margin);
		for (double i=xmin ; i<=xmax ; i++){
			((Graphics2D)g).drawLine(
					(int)(i * scale) + margin,
					(int)(ymax * scale) + margin - 2,
					(int)(i * scale) + margin,
					(int)(ymax * scale) + margin + 2);
		}
		((Graphics2D)g).drawLine(
				(int)(xmin * scale) + margin,
				(int)(ymin * scale) + margin,
				(int)(xmax * scale) + margin,
				(int)(ymin * scale) + margin);
		((Graphics2D)g).drawLine(
				(int)(xmin * scale) + margin,
				(int)(ymin * scale) + margin,
				(int)(xmin * scale) + margin,
				(int)(ymax * scale) + margin);
		for (double j=ymin ; j<=ymax ; j++){
			((Graphics2D)g).drawLine(
					(int)(xmin * scale) + margin - 2,
					(int)((ymax - j) * scale) + margin,
					(int)(xmin * scale) + margin + 2,
					(int)((ymax - j) * scale) + margin);
		}
		((Graphics2D)g).drawLine(
				(int)(xmax * scale) + margin,
				(int)(ymin * scale) + margin,
				(int)(xmax * scale) + margin,
				(int)(ymax * scale) + margin);
	}

}

package view;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JPanel;


public class ViewFrame extends JFrame {

	public ViewPanel panel;

	public ViewFrame(String string, int width, int height, double xmin, double ymin, double xmax, double ymax, 
			double scale, int margin,ViewBall ball, ViewBox box) {
		super(string);
		panel = new ViewPanel(width, height, xmin, ymin, xmax, ymax, scale, margin, ball, box);
		panel.setBounds(new Rectangle(0, width, 0, height));
		panel.setLayout(null);
		this.add(panel);	
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setSize(width, height);
		this.setLocationRelativeTo(null);
		this.setVisible(true);
	}


}

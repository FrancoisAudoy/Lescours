
public class Vertex implements Comparable<Vertex> {

	private int x, y;
	
	public Vertex(int x, int y) {
		// TODO Auto-generated constructor stub
		this.x =x;
		this.y = y;
	}

	public int getX() {
		return x;
	}


	public int getY() {
		return y;
	}

	@Override
	public int compareTo(Vertex o) {
		// TODO Auto-generated method stub
		if(this.x < o.x)
			return -1;
		if(this.x > o.x)
			return 1;
		else
			return 0;
				
	}

	@Override
	public String toString() {
		String s = "(x: " + x + " y: " + y + ")";
		return s;
	}

	
}

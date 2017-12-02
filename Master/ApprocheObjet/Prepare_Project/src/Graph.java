import java.util.Random;

import org.jgrapht.UndirectedGraph;
import org.jgrapht.graph.SimpleGraph;

public class Graph {

	public int init_x;
	public int init_y;
	
	private  UndirectedGraph<Vertex, Edge> graph;
	Random rand;
	
	public Graph() {
		// TODO Auto-generated constructor stub
		graph = new SimpleGraph<>(Edge.class);
		rand = new  Random();
	}
	
	public void generateGraph(int x, int y) {
		init_x = rand.nextInt(x);
		init_y = rand.nextInt(y);
		
		
	}

}

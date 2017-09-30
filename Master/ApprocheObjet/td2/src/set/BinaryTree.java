package set;

public abstract class BinaryTree implements IBinaryTree {
	
	private Object data;
	private IBinaryTree leftChild, rightChild;
	private int height;
	private int nodes; //numbers of nodes under this one
	
	public BinaryTree(Object data, IBinaryTree leftChild,
			IBinaryTree rightChild) {
		this.data = data;
		this.leftChild = leftChild;
		this.rightChild = rightChild;
	}

	public BinaryTree(Object o) {
		data = o;
		leftChild = null;
		rightChild = null;
		height = 0;
		nodes = 0;
	}
	
	
	public Object getData() {
		
		return data;
	}

	
	public void putData(Object data) {
		this.data = data;

	}

	
	public IBinaryTree getLeftChild() {
		
		return leftChild;
	}

	
	public IBinaryTree getRightChild() {
	
		return rightChild;
	}

	
	public void setLeftChild(IBinaryTree leftChild) {
		this.leftChild = leftChild; 

	}

	
	public void setRightChild(IBinaryTree rightChild) {
		this.rightChild = rightChild;

	}

	
	public boolean isLeaf() {
		// TODO Auto-generated method stub
		return (leftChild == null && rightChild == null);
	}

	
	public int getHeight() {
		// TODO Auto-generated method stub
		return height;
	}

	
	public int getNumberNodes() {
		// TODO Auto-generated method stub
		return nodes;
	}

	public String toString(){
		
		StringBuffer s = new StringBuffer();
		s.append("pere : ").append(data.toString()).append(',');
		if(leftChild != null)
			s.append("fils gauche :").append(leftChild.getData().toString()).append(',');
		if(rightChild != null)
			s.append("fils droit :").append(rightChild.getData().toString());
		s.append('\n');
		
		if(leftChild != null)
			s.append(leftChild.toString());
		if(rightChild != null)
			s.append(rightChild.toString());
		
		return s.toString();
		
	}
	
}

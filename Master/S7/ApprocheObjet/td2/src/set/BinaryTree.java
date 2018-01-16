package set;

public abstract class BinaryTree implements IBinaryTree {
	
	private Object data;
	private IBinaryTree leftChild, rightChild;
	private int height;
	private int nodes; //numbers of nodes under this one
	
	public BinaryTree(Object data, IBinaryTree leftChild,
			IBinaryTree rightChild) 
	{
		this.data = data;
		this.leftChild = leftChild;
		this.rightChild = rightChild;
		nodes = rightChild.getNumberNodes() + leftChild.getNumberNodes();
		height = 1 + Math.max(rightChild.getHeight(), leftChild.getHeight());
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
		if(data != null)
			this.data = data;
		else
			throw new Error("Data can't be null");
	}

	
	public IBinaryTree getLeftChild() {
		
		return leftChild;
	}

	
	public IBinaryTree getRightChild() {
	
		return rightChild;
	}

	
	public void setLeftChild(IBinaryTree leftChild) {
		if(leftChild != null) {
			nodes = this.rightChild.getNumberNodes() + leftChild.getNumberNodes() + 1;
			height = 1 + Math.max(rightChild.getHeight(), leftChild.getHeight());
		}
		this.leftChild = leftChild; 

	}

	
	public void setRightChild(IBinaryTree rightChild) {
		if( rightChild != null) {
			nodes = rightChild.getNumberNodes() + leftChild.getNumberNodes() + 1;
			height = 1 + Math.max(rightChild.getHeight(), leftChild.getHeight());
		}
		this.rightChild = rightChild;

	}

	
	public boolean isLeaf() {
		return (leftChild == null && rightChild == null);
	}

	
	public int getHeight() {
		return height;
	}

	
	public int getNumberNodes() {
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

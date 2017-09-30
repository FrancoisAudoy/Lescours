package set;

public abstract class BinaryTree implements IBinaryTree {
	
	private Object data;
	private IBinaryTree leftChild, rightChild;
	
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
	}
	
	@Override
	public Object getData() {
		
		return data;
	}

	@Override
	public void putData(Object data) {
		this.data = data;

	}

	@Override
	public IBinaryTree getLeftChild() {
		
		return leftChild;
	}

	@Override
	public IBinaryTree getRightChild() {
	
		return rightChild;
	}

	@Override
	public void setLeftChild(IBinaryTree leftChild) {
		this.leftChild = leftChild; 

	}

	@Override
	public void setRightChild(IBinaryTree rightChild) {
		this.rightChild = rightChild;

	}

	@Override
	public boolean isLeaf() {
		// TODO Auto-generated method stub
		return (leftChild == null && rightChild == null);
	}

	@Override
	public int getHeight() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getNumberNodes() {
		// TODO Auto-generated method stub
		return 0;
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
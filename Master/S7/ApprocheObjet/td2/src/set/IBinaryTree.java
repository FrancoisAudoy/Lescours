package set;

public interface IBinaryTree {

	Object getData();
	void putData(Object data);
	IBinaryTree getLeftChild();
	IBinaryTree getRightChild();
	void setLeftChild(IBinaryTree leftChild);
	void setRightChild(IBinaryTree rightChild);
	boolean isLeaf();
	int getHeight();
	int getNumberNodes();
}

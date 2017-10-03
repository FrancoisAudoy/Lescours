package set;

public class BreadthFirstIterator implements IIterator {

	private BinaryTreeQueue queue;
	
	
	 public BreadthFirstIterator(BinaryTree root) {
		 queue = new BinaryTreeQueue();
		 queue.push_front(root);
	}
	
	
	public boolean hasNext() {
		return queue.empty();
	}

	
	public Object next() {
		BinaryTree bt = (BinaryTree)queue.pop_back();
		if(bt.getLeftChild() != null)
			queue.push_front(bt.getLeftChild());
		if(bt.getRightChild() != null)
			queue.push_front(bt.getRightChild());
		return bt;
	}

}

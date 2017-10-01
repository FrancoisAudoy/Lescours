package set;

public class BreathFirstIterator implements IIterator {

	private BinaryTreeQueue queue;
	
	
	 public BreathFirstIterator(BinaryTree root) {
		 queue = new BinaryTreeQueue();
		 queue.push_front(root);
	}
	
	
	public boolean hasNext() {
		return queue.empty();
	}

	
	public Object next() {
		BinaryTree bt = (BinaryTree)queue.pop_back();
		if(bt.getRightChild() != null)
			queue.push_front(bt.getRightChild());
		if(bt.getLeftChild() != null)
			queue.push_front(bt.getLeftChild());
		return bt;
	}

}

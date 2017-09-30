package set;

public class BreathFirstIterator implements IIterator {

	private BinaryTreeQueue head;
	private BinaryTreeQueue next;
	
	
	 public BreathFirstIterator(BinaryTreeQueue root) {
		 
		 head = root;
		 next = null;
	}
	
	@Override
	public boolean hasNext() {
		
		return (next != null);
	}

	@Override
	public Object next() {
		return null;
	}

}

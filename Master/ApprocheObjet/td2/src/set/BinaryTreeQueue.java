package set;

public class BinaryTreeQueue implements IQueue {
	
	private BinaryTree table[];
	private int size;
	private int index;

	public BinaryTreeQueue() {
		size = 2 ;
		table = new BinaryTree[size];
		index = 0;
	}
	
	void allocate(){
		size *= 2;
		BinaryTree tmp[] = new BinaryTree[size];
		System.arraycopy(table, 0, tmp, 0, size/2);
		table = tmp;
	}
	
	@Override
	public void push_front(Object o) {
		if(index >= size)
			allocate();
		for(int i = index - 1; i >= 0; i--)
			table[i+1] = table[i];
		
		table[0] = (BinaryTree) o;
		index ++;

	}

	@Override
	public Object pop_back() {
		return table[index--];
		
	}

	@Override
	public boolean empty() {
		// TODO Auto-generated method stub
		return index == 0;
	}

	@Override
	public void clear() {
		while(!empty()){
			pop_back();
		}
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return size;
	}

}
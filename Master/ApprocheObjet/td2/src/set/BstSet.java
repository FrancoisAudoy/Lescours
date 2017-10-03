package set;

public class BstSet extends BinarySearchTree implements ISet {
	
	private int size;
	
	public BstSet(Object root)  {
		super(root);
		size ++;
	}

	public boolean countains(Object element)  {
		// TODO Auto-generated method stub
		return super.contains(element);
	}

	public ISet union(ISet set) {
		IIterator it = iterator();
		IIterator c_it = set.iterator();
		ISet res = null; 
		BinaryTree bt, c_bt;
		
		while(it.hasNext() && c_it.hasNext()) {
			bt = (BinaryTree) it.next();
			c_bt = (BinaryTree) c_it.next();
			
			if(((IComparable)bt.getData()).equals(c_bt.getData())){
				if(res == null)
					res = new BstSet(c_bt.getData());
				else
					res.add(c_bt.getData());
			}
		}
		
		return res;
	}

	public ISet intersect(ISet set) {
		IIterator it = iterator();
		IIterator c_it = set.iterator();
		ISet res = null; 
		BinaryTree bt, c_bt;
		
		while(it.hasNext() && c_it.hasNext()) {
			bt = (BinaryTree) it.next();
			c_bt = (BinaryTree) c_it.next();
			
			if(!((IComparable)bt.getData()).equals(c_bt.getData())){
				if(res == null)
					res = new BstSet(c_bt.getData());
				else
					res.add(c_bt.getData());
			}
		}
		
		return res;
	}

	public ISet diff(ISet set) {
		// TODO Auto-generated method stub
		return null;
	}

	public void add(Object element) {
		// TODO Auto-generated method stub
		if( element instanceof IComparable) {
			IComparable c = (IComparable)element;
			super.add(c);
			size++;
		}
		else
			throw new Error("The object must be IComparable");

	}

	public void remove(Object element) {
		// TODO Auto-generated method stub

	}

	public int size() {
		return size;
	}

	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return false;
	}
	
	public IIterator iterator() {
		return new BreadthFirstIterator(this);
	}

}

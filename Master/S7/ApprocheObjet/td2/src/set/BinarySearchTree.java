package set;


public class BinarySearchTree extends BinaryTree {

	public BinarySearchTree(Object o) {
		super(o);
		if(!(o instanceof IComparable))
			throw new Error("The Object must be an instance of IComparable");
	}

	public boolean contains(Object o) {
		BreadthFirstIterator iterator = new BreadthFirstIterator(this);
		IComparable comparaison;
		if(o instanceof IComparable){
			comparaison = (IComparable) o;
		}
		else
			throw new Error("The Object to compare is not an instance of IComparable");
		while(iterator.hasNext()){
			if(comparaison.equals(iterator.next()))
				return true;
		}

		return false;
	}

	public void add(IComparable element) {
		IComparable compare;
		IBinaryTree curseur = this;

		while( !curseur.isLeaf()) {
			compare = (IComparable)curseur.getData();
			int rep = compare.compareTo(element); 
			if(rep == -1) {
				if(curseur.getRightChild() != null)
					curseur = curseur.getRightChild();
				else
					curseur.setRightChild(new BinarySearchTree(element));
			}
			if(rep == 1) {
				if(curseur.getLeftChild() != null)
					curseur = curseur.getLeftChild();
				else
					curseur.setLeftChild(new BinarySearchTree(element));
			} else {
				IBinaryTree tmp = curseur.getLeftChild();
				curseur.setLeftChild(new BinarySearchTree(element));
				curseur.getLeftChild().setLeftChild(tmp);
			}
		}
	}

	//Override
	public void putData(Object data) {
		throw new Error("Impossible to modify data from a BinarySerchTree\n");
	}

	//Override
	public void setLeftChild(IBinaryTree leftChild) {
		throw new Error("Impossible to modify children from a BinarySerchTree\n");
	}

	//Override
	public void setRightChild(IBinaryTree rightChild) {
		throw new Error("Impossible to modify children from a BinarySerchTree\n");
	}

}

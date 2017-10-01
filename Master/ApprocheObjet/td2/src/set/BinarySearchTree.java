package set;

import javax.management.InstanceNotFoundException;

public class BinarySearchTree  {
	BinaryTree root;
	
	public BinarySearchTree(BinaryTree rootTree) {
		this.root = rootTree; 
		
	}
	
	boolean contains(Object o) throws InstanceNotFoundException{
		BreathFirstIterator iterator = new BreathFirstIterator(root);
		IComparable comparaison;
		if(o instanceof IComparable){
		comparaison = (IComparable) o;
		}
		else
			throw new InstanceNotFoundException("The Object to compare is not an instance of IComparable");
		while(iterator.hasNext()){
			if(comparaison.equals(iterator.next()))
				return true;
		}
				
		return false;
	}

}

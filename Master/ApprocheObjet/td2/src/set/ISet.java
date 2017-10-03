package set;

import javax.management.InstanceNotFoundException;

public interface ISet {
	
	boolean countains(Object element) throws InstanceNotFoundException;
	ISet union(ISet set);
	ISet intersect(ISet set);
	ISet diff(ISet set);
	void add(Object element);
	void remove(Object element);
	int size();
	boolean isEmpty();
	IIterator iterator();
}

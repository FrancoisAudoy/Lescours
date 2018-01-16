package set;

public interface IQueue {

	void push_front(Object o);
	Object pop_back();
	boolean empty();
	void clear();
	int size();
}

package soldier.core;

public interface Subject {

	public void addObserver(UnitObserver o);
	public void detach(UnitObserver o);
	public void Notify();
}

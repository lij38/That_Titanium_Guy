package enemies;

class EnemyFSM {
	public var activeState:Void->Void;
	
	public function new(?InitState:Void->Void):Void {
		activeState = InitState;
	}
	
	public function update():Void {
		if (activeState != null) {
			activeState();
		}
	}
	
}
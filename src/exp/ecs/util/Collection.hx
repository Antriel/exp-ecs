package exp.ecs.util;

using tink.CoreApi;

class Collection<Item> {
	var pending:Array<Pair<Item, Operation>>;
	var locked:Bool;

	public function new() {
		pending = [];
		locked = false;
	}

	public inline function lock() {
		locked = true;
	}

	public inline function unlock() {
		locked = false;
		update();
	}

	public function destroy() {}

	function schedule(item:Item, operation:Operation) {
		if (locked) {
			pending.push(new Pair(item, operation));
		} else {
			operate(item, operation);
		}
	}

	function update() {
		for (v in pending)
			operate(v.a, v.b);
		pending = [];
	}

	function operate(item:Item, operation:Operation) {}
}

enum abstract Operation(Int) {
	var Add;
	var Remove;
	var RemoveAndDestroy;
}

package system;

import ecs.Engine;
import ecs.Node;
import ecs.System;
import component.*;

using tink.CoreApi;

typedef MovementNode = Node<Position, Velocity>;

class MovementSystem extends NodeListSystem<MovementNode> {
	
	override function updateNode(node:MovementNode, dt:Float) {
		node.position.x += node.velocity.x * dt;
		trace(node.position.x);
	}
}
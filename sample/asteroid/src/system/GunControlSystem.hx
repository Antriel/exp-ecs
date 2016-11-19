package system;

import component.*;
import ecs.Node;
import ecs.System;
import util.*;

using tink.CoreApi;

class GunControlSystem extends NodeListSystem<{nodes:Node<GunControls, Position, Gun>}> {
	var input:Input;
	
	public function new(input) {
		super();
		this.input = input;
	}
	
	override function update(dt:Float) {
		for(node in nodes) {
			var control = node.gunControls;
			var position = node.position;
			var gun = node.gun;
			
			var triggered = input.isDown(control.trigger);
			gun.elapsed += dt;
			if(triggered && gun.elapsed > gun.interval) {
				engine.addEntity(new entity.Bullet(gun, position));
				gun.elapsed = 0;
			}
		}
	}
}
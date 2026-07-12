function EnemyWaveSpawn(_enemy,_x,_y,_target_x,_target_y,_state = "target_invulnerable",_collision_layer = COLLISION_LAYERS.A) constructor {
	
	enemy = _enemy;
	x = _x;
	y = _y;
	target_x = _target_x;
	target_y = _target_y;
	state = _state;
	collision_layer = _collision_layer;
	
	static spawn = function(){
		var enemy_ = instance_create_depth(x,y,layer_get_depth(global.collision_layers[? collision_layer]),enemy);
		enemy_.target_x = target_x;
		enemy_.target_y = target_y;
		enemy_.state.change(state);
		return enemy_;
	}
}
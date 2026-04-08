function EnemyWaveSpawn(_enemy,_x,_y,_target_x,_target_y,_state = "idle",_collision_layer = COLLISION_LAYERS.A) constructor {
	
	enemy = _enemy;
	x = _x;
	y = _y;
	target_x = _target_x;
	target_y = _target_y;
	state = _state;
	collision_layer = _collision_layer;
	
	static spawn = function(){
		var enemy_ = instance_create_depth(x,y,layer_get_depth(global.collision_layers[? collision_layer]),enemy,{
			state: state,
			target_x: target_x,
			target_y: target_y
		})
		return enemy_;	
	}
}
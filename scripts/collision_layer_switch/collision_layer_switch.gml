///@function collision_layer_switch()
function collision_layer_switch(activate_a,change_depth){
	
	if(activate_a){
		global.tile_collisions = layer_tilemap_get_id(obj_game.collision_A);
		if(change_depth) obj_pengu.depth = global.depth_a;	
	} else {
		global.tile_collisions = layer_tilemap_get_id(obj_game.collision_B);
		if(change_depth) obj_pengu.depth = global.depth_b;
	}	
	
	obj_game.active_collisions_A = activate_a;
	obj_game.show_collisions();

}
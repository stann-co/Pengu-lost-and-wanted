///@function collision_layer_switch()
///@desc changes active collision layer
///@param COLLISION_LAYERS
function collision_layer_switch(collision_layer,change_depth){
	
	switch (collision_layer) {
	    case COLLISION_LAYERS.A:
	        global.tile_collisions = layer_tilemap_get_id(obj_game.collision_A);
			obj_game.active_collisions = obj_game.collision_A;
			if(change_depth) obj_pengu.depth = global.depth_a;	
	        break;
		case COLLISION_LAYERS.B:
	        global.tile_collisions = layer_tilemap_get_id(obj_game.collision_B);
			obj_game.active_collisions = obj_game.collision_B;
			if(change_depth) obj_pengu.depth = global.depth_b;	
	        break;
		case COLLISION_LAYERS.C:
	        global.tile_collisions = layer_tilemap_get_id(obj_game.collision_C);
			obj_game.active_collisions = obj_game.collision_C;
			if(change_depth) obj_pengu.depth = global.depth_c;	
	        break;
	}
	obj_game.show_collisions();
}
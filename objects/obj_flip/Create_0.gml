//should be used in a one tile space,
//to flip pengu from sliding on the floor to the ceiling or vice versa

triggered = false;

trigger = function(){
	var on_layer = false
	if(depth_layer == "A"){
		on_layer = (global.tile_collisions == layer_tilemap_get_id(obj_game.collision_A))
	} else {
		on_layer = (global.tile_collisions == layer_tilemap_get_id(obj_game.collision_B))
	}
	
	if(!triggered && on_layer){
		triggered = true;
		with(obj_pengu){
			if(state.state_is("prone")){
				
				mirror = -mirror;
				
				ground_angle += 180;
				if(ground_angle >= 360) ground_angle-=360;
				image_angle = ground_angle;
				ground_spd = -ground_spd;
				input_h = -input_h;
			}
		}
	}
}


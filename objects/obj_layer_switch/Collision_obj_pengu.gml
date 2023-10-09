/// @description
var dir = point_direction(x,y,obj_pengu.x,obj_pengu.y)+90-image_angle;
if(dir > 360) dir-=360;

if(only_grounded){
	var ground_check = !obj_pengu.airborne;
} else var ground_check = true;

if(ground_check){
	//player is on yellow side
	if(dir <= 180){
		if(yellow_side_is == "A"){
			global.tile_collisions = layer_tilemap_get_id(obj_game.collision_A);
		} else {
			global.tile_collisions = layer_tilemap_get_id(obj_game.collision_B);
		}
	} else {
	//player is on orange side
		if(yellow_side_is == "A"){
			global.tile_collisions = layer_tilemap_get_id(obj_game.collision_B);
		} else {
			global.tile_collisions = layer_tilemap_get_id(obj_game.collision_A);
		}
	}
}















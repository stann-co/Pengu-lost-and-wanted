/// @description
global.t = 0;


collision_A = layer_get_id("collision_A");
collision_B = layer_get_id("collision_B");
//collision_A_oneway = layer_get_id("collision_A_oneway");
//collision_B_oneway = layer_get_id("collision_B_oneway");

//error reminders
if(room != rm_init && (collision_A == -1 || collision_B == -1)){// || collision_A_oneway == -1 || collision_B_oneway == -1)){
	show_error($"Missing collision layers in {room}",true);
}

if(room != rm_init && !instance_exists(obj_depth_set)){
	show_error($"Missing obj_depth_set in {room}",true);
}

//the active collision layer can be switched between
global.tile_collisions = layer_tilemap_get_id(collision_A);
//global.tile_collisions_oneway = layer_tilemap_get_id(collision_A_oneway);
obj_pengu.depth = global.depth_a;

show_collisions();
/// @description
collision_A = layer_get_id("collision_A");
collision_B = layer_get_id("collision_B");

if(room != rm_init && (collision_A == -1 || collision_B == -1)) show_error($"Missing collision layers in {room}",true);

//the active collision layer can be switched between
global.tile_collisions = layer_tilemap_get_id(collision_A);

if(show_collisions){
	layer_set_visible(collision_A,true);
	layer_set_visible(collision_B,true);	
} else {
	layer_set_visible(collision_A,false);
	layer_set_visible(collision_B,false);	
}
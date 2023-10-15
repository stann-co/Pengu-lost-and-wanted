/// @description
show_collisions = !show_collisions;

if(show_collisions){
	layer_set_visible(collision_A,true);
	layer_set_visible(collision_B,true);
	layer_set_visible(collision_A_oneway,true);
	layer_set_visible(collision_B_oneway,true);	
} else {
	layer_set_visible(collision_A,false);
	layer_set_visible(collision_B,false);	
	layer_set_visible(collision_A_oneway,false);
	layer_set_visible(collision_B_oneway,false);	
}
















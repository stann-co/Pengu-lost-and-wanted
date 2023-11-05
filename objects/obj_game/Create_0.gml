/// @description

/// feather ignore all in /Extensions/*

global.t = 0; //a global timer for different objects to refer to stay in sync even after being deactivated

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
0,360,22,22,45,
45,22,22,45,45,
31,12,12,31,45,
0 ,39,22,8 ,45,
45,8 ,22,39,45,22
];

global.depth_a = 300;
global.depth_b = 400;

global.activation_list = [];

global.debug = true;
active_collisions_A = true;

show_collisions = function(){
	layer_set_visible(collision_A,false);
	layer_set_visible(collision_B,false);	
	//layer_set_visible(collision_A_oneway,false);
	//layer_set_visible(collision_B_oneway,false);	
	layer_set_visible("backgrounds_1",false);
	
	if(global.debug){
		
		layer_set_visible("backgrounds_1",false);
		
		if(active_collisions_A){
			layer_set_visible(collision_A,true);
			//layer_set_visible(collision_A_oneway,true);
		}else{
			layer_set_visible(collision_B,true);
			//layer_set_visible(collision_B_oneway,true);	
		}
	}
}
	
	
	
//level stuff
global.score = 0;

room_goto_next();
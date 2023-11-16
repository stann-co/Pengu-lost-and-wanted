/// @description

saved_pengu = {
x: -1,
y: -1,

}
save_text = false;

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

#macro camera_outer_margin 200
#macro camera_inner_margin 100

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

background_sprites = [];
foreground_sprites = [];

///@function sprite_layer_parralax_init()
sprite_layer_parralax_init = function(layer_name){
	if(!layer_exists(layer_name)) return [];
	
	var sprites = layer_get_all_elements(layer_name);
	var array = [];
	for (var i = 0; i < array_length(sprites); ++i) {
	    array[i] = {
			sprite: sprites[i],
			x: layer_sprite_get_x(sprites[i]),
			y: layer_sprite_get_y(sprites[i])
		}
	}
	return array;
}

///@function sprite_layer_parralax()
sprite_layer_parralax = function(sprite_array,parralax_amount = 1.1){
	for (var i = 0; i < array_length(sprite_array); ++i) {
		var element = sprite_array[i];
		
		var offset_x = element.x - global.camera.x;
		var offset_y = element.y - global.camera.y;
		
		layer_sprite_x(element.sprite, global.camera.x + offset_x * parralax_amount );
		layer_sprite_y(element.sprite, global.camera.y + offset_y * parralax_amount );
	}
}



room_goto_next();
/// @description

//global.t = 0;


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

show_collisions();

//sets sprite layers to global array and saves their initial position, so they can be parralaxed
//background_sprites = sprite_layer_parralax_init("foreground_sprites");
//foreground_sprites = sprite_layer_parralax_init("background_sprites");

//checkpoint load
if(global.checkpoint != -1){
	obj_pengu.x = global.checkpoint.x;	
	obj_pengu.y = global.checkpoint.y;
	global.t = global.checkpoint.time;
	
	for (var i = 0; i < array_length(global.checkpoint.taken_points); ++i) {
		instance_destroy(global.checkpoint.taken_points[i]);
	}
}

/// @description
global.t = 0;
timer = 0;

collision_A = layer_get_id("collision_A");
collision_B = layer_get_id("collision_B");
collision_C = layer_get_id("collision_C");

active_collisions = collision_A

//error reminders
if(room != rm_init && (collision_A == -1)){
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

#region checkpoint load
if(global.checkpoint != -1){
	obj_pengu.x = global.checkpoint.x;	
	obj_pengu.y = global.checkpoint.y;
	global.t = global.checkpoint.time;
	
	for (var i = 0; i < array_length(global.checkpoint.taken_points); ++i) {
		instance_destroy(global.checkpoint.taken_points[i]);
	}
}
#endregion

#region tiles

ds_map_clear(global.tile_draw_layers)
//makes special drawing objects for tile layers
var layers =  layer_get_all();
for (var i = 0; i < array_length(layers); ++i) {
    var lay = layers[i];
	var name = layer_get_name(lay);
	if(string_starts_with(name,"decor_")){
		var layer_draw = instance_create_depth(0,0,layer_get_depth(lay),obj_layer_draw,{
			lay: lay
		});
		ds_map_set(global.tile_draw_layers,name,layer_draw);
		
	}
}
#endregion
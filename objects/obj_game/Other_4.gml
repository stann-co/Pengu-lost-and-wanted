/// @description
global.t = 0;

if(global.sidescroller){
    
    global.collision_layers[? COLLISION_LAYERS.A] = layer_tilemap_get_id("collision_A");
    global.collision_layers[? COLLISION_LAYERS.B] = layer_tilemap_get_id("collision_B");
    global.collision_layers[? COLLISION_LAYERS.C] = layer_tilemap_get_id("collision_C");
    set_active_collisions(COLLISION_LAYERS.A);
    
	//error reminders
	if(room != rm_init && (global.collision_layers[? COLLISION_LAYERS.A] == -1)){
		show_error($"Missing collision layers in {room}",true);
	}
	
	// tiles
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
}

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
/// @description
global.t = 0;

if(global.sidescroller){
    
    global.collision_layers[? COLLISION_LAYERS.A] = layer_tilemap_get_id("collision_A");
    global.collision_layers[? COLLISION_LAYERS.B] = layer_tilemap_get_id("collision_B");
    global.collision_layers[? COLLISION_LAYERS.C] = layer_tilemap_get_id("collision_C");
    set_active_collisions(COLLISION_LAYERS.A);
    
	//error reminders
	if(room != rm_init && (global.collision_layers[? COLLISION_LAYERS.A] == -1)){
		show_error($"Missing collision layers_ in {room}",true);
	}
	
	// tiles
	ds_map_clear(global.tile_draw_layers)
	//makes special drawing objects for tile layers_
	var layers_ =  layer_get_all();
	for (var i_ = 0; i_ < array_length(layers_); ++i_) {
	    var lay_ = layers_[i_];
		var name_ = layer_get_name(lay_);
		if(string_starts_with(name_,"decor_")){
			var layer_draw_ = instance_create_depth(0,0,layer_get_depth(lay_),obj_layer_draw,{
				lay: lay_
			});
			ds_map_set(global.tile_draw_layers,name_,layer_draw_);
		}
	}
}

#region checkpoint load
if(global.checkpoint != -1){
	obj_pengu.x = global.checkpoint.x;	
	obj_pengu.y = global.checkpoint.y;
	global.t = global.checkpoint.time;
		
	for (var i_ = 0; i_ < array_length(global.checkpoint.taken_points); ++i_) {
		instance_destroy(global.checkpoint.taken_points[i_]);
	}
}
#endregion
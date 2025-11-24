/// @description
global.t = 0;

if(global.sidescroller){
    
    global.collision_layers[? COLLISION_LAYERS.A] = layer_tilemap_get_id("collision_A");
    global.collision_layers[? COLLISION_LAYERS.B] = layer_tilemap_get_id("collision_B");
    global.collision_layers[? COLLISION_LAYERS.C] = layer_tilemap_get_id("collision_C");
    set_active_collisions(COLLISION_LAYERS.A);
    
	//error reminders
	if(room != rm_init && room != rm_intro && (global.collision_layers[? COLLISION_LAYERS.A] == -1)){
		show_error($"Missing collision layers_ in {room}",true);
	}
	
	// turns off automatic drawing for visual layers, and draws them manually with parralax and shaders
	var layers_ =  layer_get_all();
	for (var i_ = 0; i_ < array_length(layers_); ++i_) {
		var lay_id_ = layers_[i_];
		var name_ = layer_get_name(lay_id_);
		
		if(string_starts_with(name_,"decor")){
			
			instance_create_depth(0,0,layer_get_depth(lay_id_),obj_layer_draw,{
				layer_id : lay_id_,
	        	type : LAYER_TYPE.DECOR,
				name : name_
			})
			layer_set_visible(lay_id_,false);
	    } else
	    
	    if(string_starts_with(name_,"asset")){
			instance_create_depth(0,0,layer_get_depth(lay_id_),obj_layer_draw,{
				layer_id : lay_id_,
	        	type : LAYER_TYPE.ASSET,
				name : name_
			})
			layer_set_visible(lay_id_,false);
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
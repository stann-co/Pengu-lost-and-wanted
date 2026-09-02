///@function collision_layer_switch()
///@desc changes active collision layer
///@param Instance
///@param COLLISION_LAYERS
///@param change_depth
function collision_layer_switch(_inst,_collision_layer,_change_depth = false){
	
    if(_change_depth){
		_inst.depth = global.depths[? _collision_layer];
    }
    
    if(_inst.object_index == obj_pengu){
        set_active_collisions(_collision_layer);
    }
    
    _inst.collision_layer = _collision_layer;
}

///@function show_collisions()
///@desc show collision layers
///@param show
function show_collisions(_show){
	//TODO should be changed so it affects obj_tilemap and not the layer visibility itself probably
    if(_show){
        layer_set_visible("collision_A",true);
        layer_set_visible("collision_B",true);
        layer_set_visible("collision_C",true);
    } else {
        layer_set_visible("collision_A",false);
        layer_set_visible("collision_B",false);
        layer_set_visible("collision_C",false);
    }
}

///@function show_background()
///@desc show background layers
///@param show
function show_background(_show){
	if(_show){
        layer_set_visible("backgrounds_1",true);
    } else {
        layer_set_visible("backgrounds_1",false);
    }
}

///@function set_active_collisions()
///@desc set collision layer to emphasized
///@param active_layer
function set_active_collisions(_active_layer){
    switch (_active_layer) {
        case COLLISION_LAYERS.A:
            layer_shader("collision_A",sh_default)
            layer_shader("collision_B",sh_half_alpha)
            layer_shader("collision_C",sh_half_alpha)
            break;
        case COLLISION_LAYERS.B:
            layer_shader("collision_A",sh_half_alpha)
            layer_shader("collision_B",sh_default)
            layer_shader("collision_C",sh_half_alpha)
            break;
        case COLLISION_LAYERS.C:
            layer_shader("collision_A" ,sh_half_alpha)
            layer_shader("collision_B",sh_half_alpha)
            layer_shader("collision_C",sh_default)
            break;
    }
}
/// @desc rebuilds a level's layers array from _data (see level_serialize).
/// Each ASSET/INSTANCE element is spawned via
/// _place_element_fn(_layer,_name,_x,_y,_is_instance), returning the instance
/// @param _data
/// @param {Function} _place_element_fn
function level_deserialize(_data, _place_element_fn){
	var layers_ = [];
	global.level = _data.name;
	room_width = _data.room_width;
	room_height = _data.room_height;

	for (var i_ = 0; i_ < array_length(_data.layers); i_++) {
		var ld_ = _data.layers[i_];
		var layer_ = {
			name : ld_.name,
			parralax : ld_.parralax,
			type : ld_.type,
			layer : layer_create(ld_.depth, ld_.name),
			always : ld_.always,
			visible : ld_.visible,
			locked : ld_.locked,
			color : ld_.color,
			collision : ld_.collision,
		};
		layer_set_visible(layer_.layer, layer_.visible);

		if (layer_.type == LAYER_TYPE.TILEMAP) {
			layer_.tileset = asset_get_index(ld_.tileset);

			var h_ = array_length(ld_.tiles);
			var w_ = h_ > 0 ? array_length(ld_.tiles[0]) : 0;
			layer_.tilemap = layer_tilemap_create(layer_.name, 0, 0, layer_.tileset, w_, h_);
			for (var yy_ = 0; yy_ < h_; yy_++) {
				var row_ = ld_.tiles[yy_];
				for (var xx_ = 0; xx_ < w_; xx_++) {
					if (row_[xx_] != 0) tilemap_set(layer_.tilemap, row_[xx_], xx_, yy_);
				}
			}
			
			//draws/handles this tilemap from here on (hides the layer's own
			//auto-render itself) - layer_name/parralax are read by its own
			//Create event; visibility now targets this instance, not the layer
			layer_.obj_tilemap = instance_create_depth(0, 0, ld_.depth, obj_tilemap, {
				layer_name : layer_.name,
				parralax : layer_.parralax,
			});
			layer_.obj_tilemap.visible = layer_.visible;

		} else {
			var is_instance_ = ld_.type == LAYER_TYPE.INSTANCE;
			for (var e_ = 0; e_ < array_length(ld_.elements); e_++) {
				var ed_ = ld_.elements[e_];
				var inst_ = _place_element_fn(layer_, is_instance_ ? ed_.object_name : ed_.sprite_name, ed_.x, ed_.y, is_instance_);
				if (inst_ != noone && inst_ != undefined) {
					inst_.image_xscale = ed_.image_xscale;
					inst_.image_yscale = ed_.image_yscale;
					inst_.image_angle = ed_.image_angle;
					inst_.parralax = layer_.parralax;
				}
			}
		}

		array_push(layers_, layer_);
	}
	return layers_;
}

/// @desc loads a level JSON into the actual running room
/// @param {string} _path
function load_level(_path){
	var data_ = json_load(_path);
	if (data_ == undefined) return false;

	//level_deserialize now spawns obj_tilemap for every TILEMAP layer itself
	level_deserialize(data_, load_level_place_element);

	global.collision_layers[? COLLISION_LAYERS.A] = layer_get_id("collision_A");
	global.collision_layers[? COLLISION_LAYERS.B] = layer_get_id("collision_B");
	global.collision_layers[? COLLISION_LAYERS.C] = layer_get_id("collision_C");

	return true;
}

/// @desc spawns one ASSET/INSTANCE element as the real thing - level_deserialize
/// applies image_xscale/yscale/angle to whatever instance is returned here
function load_level_place_element(_layer, _name, _x, _y, _is_instance){
	if (_is_instance) {
		return instance_create_layer(_x, _y, _layer.name, asset_get_index(_name));
	}
	
	var inst_ = instance_create_layer(_x, _y, _layer.name, obj_sprite);
	inst_.sprite_index = asset_get_index(_name);
	inst_.mask_index = inst_.sprite_index;
	inst_.parralax = _layer.parralax;
	return inst_;
}
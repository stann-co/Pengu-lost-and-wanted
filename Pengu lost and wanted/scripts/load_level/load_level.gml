/// @desc rebuilds a level's layers array from _data (see level_serialize).
/// Each ASSET/INSTANCE element is spawned via
/// _place_element_fn(_layer,_name,_element_data,_is_instance)
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
				_place_element_fn(layer_, is_instance_ ? ed_.object_name : ed_.sprite_name, ed_, is_instance_);
			}
		}

		array_push(layers_, layer_);
	}
	return layers_;
}

/// @desc tears down whatever level is currently active, running every
/// instance's own Room End event first
function unload_level(){
	with (all) event_perform(ev_other, ev_room_end);
}

/// @desc loads a level JSON into the actual running room
/// @param {string} _path
function load_level(_path){
	var data_ = json_load(_path);
	if (data_ == undefined) return false;

	unload_level();

	//built up by load_level_place_element as instances are placed - REFERENCE
	//variables resolve against whatever's registered here so far (see
	//load_level_place_element), so a referenced instance has to come before
	//whatever references it in the level
	global.level_instance_names = {};

	//level_deserialize now spawns obj_tilemap for every TILEMAP layer itself
	level_deserialize(data_, load_level_place_element);

	with (all) event_perform(ev_other, ev_room_start);

	global.collision_layers[? COLLISION_LAYERS.A] = layer_get_id("collision_A");
	global.collision_layers[? COLLISION_LAYERS.B] = layer_get_id("collision_B");
	global.collision_layers[? COLLISION_LAYERS.C] = layer_get_id("collision_C");

	return true;
}

/// @desc looks up a placed instance by its element_name (see the Inspector's
/// Name field) - noone if the current level has nothing placed under that name
function instance_name(_name){
	return global.level_instance_names[$ _name];
}

/// @desc spawns one ASSET/INSTANCE element, passing its variables in the
/// instance_create_layer struct so they're set before the Create event runs
function load_level_place_element(_layer, _name, _ed, _is_instance){
	var vars_ = {
		image_xscale : _ed.image_xscale,
		image_yscale : _ed.image_yscale,
		image_angle : _ed.image_angle,
		parralax : _layer.parralax,
	};

	if (_is_instance) {
		//_ed.vars holds custom variable values (see editor_variable_float) -
		//merged in directly so eg spring_force is a plain instance var, set
		//before Create like everything else in vars_
		var custom_names_ = variable_struct_get_names(_ed.vars);
		for (var i_ = 0; i_ < array_length(custom_names_); i_++) {
			variable_struct_set(vars_, custom_names_[i_], _ed.vars[$ custom_names_[i_]]);
		}

		//_ed.ref_vars (see level_serialize) names which of vars_ hold a
		//referenced element's name string - resolved here to the real
		//instance id, so it's ready before the Create event runs
		for (var i_ = 0; i_ < array_length(_ed.ref_vars); i_++) {
			var ref_var_ = _ed.ref_vars[i_];
			var resolved_ = instance_name(vars_[$ ref_var_]);
			variable_struct_set(vars_, ref_var_, resolved_ != undefined ? resolved_ : noone);
		}

		vars_.element_name = _ed.element_name;

		var inst_ = instance_create_layer(_ed.x, _ed.y, _layer.name, asset_get_index(_name), vars_);
		variable_struct_set(global.level_instance_names, _ed.element_name, inst_);
		return inst_;
	}

	var sprite_ = asset_get_index(_name);
	vars_.sprite_index = sprite_;
	vars_.mask_index = sprite_;
	return instance_create_layer(_ed.x, _ed.y, _layer.name, obj_sprite, vars_);
}
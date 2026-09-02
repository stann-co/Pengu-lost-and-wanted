/// @desc builds a plain-data struct describing a level from a live _layers
/// array, ready for json_save - read back by level_deserialize
/// @param _layers
/// @param {real} _room_width
/// @param {real} _room_height
function level_serialize(_layers, _room_width, _room_height){
	var layers_data_ = [];
	for (var i_ = 0; i_ < array_length(_layers); i_++) {
		var layer_ = _layers[i_];
		var ld_ = {
			name : layer_.name,
			depth : layer_get_depth(layer_.layer),
			type : layer_.type,
			always : layer_.always,
			visible : layer_.visible,
			locked : layer_.locked,
			color : layer_.color,
			parralax_x : layer_.parralax_x,
			parralax_y : layer_.parralax_y,
			collision : layer_.collision,
			fx_index : layer_.fx_index,
			fx_params : layer_.fx_params,
		};

		if (layer_.type == LAYER_TYPE.TILEMAP) {
			ld_.tileset = layer_.tileset != undefined ? tileset_get_name(layer_.tileset) : undefined;

			var w_ = tilemap_get_width(layer_.tilemap);
			var h_ = tilemap_get_height(layer_.tilemap);
			var tiles_ = array_create(h_);
			for (var yy_ = 0; yy_ < h_; yy_++) {
				var row_ = array_create(w_);
				for (var xx_ = 0; xx_ < w_; xx_++) {
					row_[xx_] = tilemap_get(layer_.tilemap, xx_, yy_);
				}
				tiles_[yy_] = row_;
			}
			ld_.tiles = tiles_;
		} else if (layer_.type == LAYER_TYPE.BACKGROUND) {
			var bg_valid_ = instance_exists(layer_.obj_background);
			ld_.sprite = (bg_valid_ && layer_.obj_background.sprite_index != -1) ? sprite_get_name(layer_.obj_background.sprite_index) : "";
			ld_.mode = bg_valid_ ? layer_.obj_background.background_mode : BACKGROUND_MODE.NONE;
			ld_.x = bg_valid_ ? layer_.obj_background.x : 0;
			ld_.y = bg_valid_ ? layer_.obj_background.y : 0;
		} else {
			//vars holds each INSTANCE element's custom variable values (see
			//editor_variable_float/instance_variables) - always empty on ASSET
			//layers, since sprite elements aren't tied to an object
			var elements_ = [];
			var sorted_ = sorted_layer_elements(layer_.layer);
			for (var si_ = 0; si_ < array_length(sorted_); si_++) {
				var elem_ = sorted_[si_];
				with (elem_) {
					if (editor_only) continue;
					var ed_ = {
						x : x, y : y,
						image_xscale : image_xscale, image_yscale : image_yscale, image_angle : image_angle,
						vars : {},
					};
					if (layer_.type == LAYER_TYPE.INSTANCE) {
						ed_.object_name = variable_instance_exists(id,"object_name") ? object_name : "";
						ed_.element_name = variable_instance_exists(id,"element_name") ? element_name : "";
						ed_.ref_vars = [];
						ed_.script_vars = [];
						ed_.io_connections = variable_instance_exists(id,"io_connections") ? io_connections : [];
						if (variable_instance_exists(id,"instance_variables")) {
							var var_names_ = variable_struct_get_names(instance_variables);
							for (var vi_ = 0; vi_ < array_length(var_names_); vi_++) {
								var var_name_ = var_names_[vi_];
								var var_def_ = instance_variables[$ var_name_];
								variable_struct_set(ed_.vars, var_name_, var_def_.value);
								if (var_def_.type == EDITOR_VARIABLE_TYPES.REFERENCE) array_push(ed_.ref_vars, var_name_);
								if (var_def_.type == EDITOR_VARIABLE_TYPES.SCRIPT) array_push(ed_.script_vars, var_name_);
							}
						}
					} else {
						ed_.sprite_name = variable_instance_exists(id,"sprite_name") ? sprite_name : "";
					}
					array_push(elements_, ed_);
				}
			}
			ld_.elements = elements_;
		}

		array_push(layers_data_, ld_);
	}

	return {
		name : global.level,
		version : 1,
		room_width : _room_width,
		room_height : _room_height,
		layers : layers_data_,
	};
}

/// @desc rebuilds a level's layers array from _data (see level_serialize).
/// Each ASSET/INSTANCE element is spawned via
/// _place_element_fn(_layer,_name,_element_data,_is_instance) - every layer
/// (tilemaps included) exists before any element is placed, so _layers_ready_fn
/// runs in between with every raw layer/tilemap already there (eg to resolve
/// global.collision_layers before anything reads it from its own Create event)
/// @param _data
/// @param {Function} _place_element_fn
/// @param {Function} [_layers_ready_fn]
function level_deserialize(_data, _place_element_fn, _layers_ready_fn = function(){}){
	var layers_ = [];
	global.level = _data.name;
	room_width = _data.room_width;
	room_height = _data.room_height;

	for (var i_ = 0; i_ < array_length(_data.layers); i_++) {
		var ld_ = _data.layers[i_];
		var layer_ = {
			name : ld_.name,
			parralax_x : ld_.parralax_x,
			parralax_y : ld_.parralax_y,
			type : ld_.type,
			layer : layer_create(ld_.depth, ld_.name),
			always : ld_.always,
			visible : ld_.visible,
			locked : ld_.locked,
			color : ld_.color,
			collision : ld_.collision,
			fx_index : ld_[$ "fx_index"] ?? 0, //?? fallback for levels saved before this feature existed
			fx_params : ld_[$ "fx_params"] ?? [],
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
				parralax_x : layer_.parralax_x,
				parralax_y : layer_.parralax_y,
			});
			layer_.obj_tilemap.visible = layer_.visible;
		}

		if (layer_.type == LAYER_TYPE.BACKGROUND) {
			layer_.obj_background = instance_create_layer(ld_.x, ld_.y, layer_.name, obj_background, {
				sprite_index : ld_.sprite != "" ? asset_get_index(ld_.sprite) : -1,
				background_mode : ld_.mode,
				parralax_x : layer_.parralax_x,
				parralax_y : layer_.parralax_y,
			});
		}

		if (layer_.fx_index != 0) layer_fx_apply(layer_.layer, layer_.fx_index, layer_.fx_params);

		array_push(layers_, layer_);
	}

	_layers_ready_fn();

	for (var i_ = 0; i_ < array_length(_data.layers); i_++) {
		var ld_ = _data.layers[i_];
		if (ld_.type == LAYER_TYPE.TILEMAP || ld_.type == LAYER_TYPE.BACKGROUND) continue;
		var layer_ = layers_[i_];
		var is_instance_ = ld_.type == LAYER_TYPE.INSTANCE;
		for (var e_ = 0; e_ < array_length(ld_.elements); e_++) {
			var ed_ = ld_.elements[e_];
			_place_element_fn(layer_, is_instance_ ? ed_.object_name : ed_.sprite_name, ed_, is_instance_);
		}
	}

	return layers_;
}

/// @desc tears down whatever level is currently active, running every
/// instance's own Room End event first
function unload_level(){
	instance_activate_all();
	var culled_objects_ = [obj_entity, obj_tilemap];
	with(all){
		var is_culled_ = object_index == obj_entity || object_is_ancestor(object_index,obj_entity) || object_index == obj_tilemap;
		if (!is_culled_) event_perform(ev_other, ev_room_end);
	}
	for (var o_ = 0; o_ < array_length(culled_objects_); o_++) {
		var obj_ = culled_objects_[o_];
		for (var i_ = instance_number(obj_) - 1; i_ >= 0; i_--) {
			with (instance_find(obj_, i_)) event_perform(ev_other, ev_room_end);
		}
	}
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

	//level_deserialize now spawns obj_tilemap for every TILEMAP layer itself -
	//collision_layers is resolved once every layer exists but before any
	//element is placed, so eg obj_tiles_area can already read it in Create_0
	level_deserialize(data_, load_level_place_element, function(){
		global.collision_layers[? COLLISION_LAYERS.A] = layer_get_id("collision_A");
		global.collision_layers[? COLLISION_LAYERS.B] = layer_get_id("collision_B");
		global.collision_layers[? COLLISION_LAYERS.C] = layer_get_id("collision_C");
	});

	resolve_io_connections();
	with (all) event_perform(ev_other, ev_room_start);

	return true;
}

/// @desc looks up a placed instance by its element_name (see the Inspector's
/// Name field) - noone if the current level has nothing placed under that name
function instance_name(_name){
	return global.level_instance_names[$ _name];
}

/// @desc resolves every placed instance's io_connections_resolved
/// target_name strings to real instance ids - run once every instance in
/// the level exists, so I/O wiring (unlike REFERENCE) doesn't depend on
/// placement order
function resolve_io_connections(){
	with (all) {
		if (!variable_instance_exists(id, "io_connections_resolved")) continue;
		for (var i_ = 0; i_ < array_length(io_connections_resolved); i_++) {
			var conn_ = io_connections_resolved[i_];
			var resolved_ = instance_name(conn_.target_name);
			conn_.target = resolved_ != undefined ? resolved_ : noone;
		}
	}
}

/// @desc spawns one ASSET/INSTANCE element, passing its variables in the
/// instance_create_layer struct so they're set before the Create event runs
function load_level_place_element(_layer, _name, _ed, _is_instance){
	var vars_ = {
		image_xscale : _ed.image_xscale,
		image_yscale : _ed.image_yscale,
		image_angle : _ed.image_angle,
		parralax_x : _layer.parralax_x,
		parralax_y : _layer.parralax_y,
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

		for (var i_ = 0; i_ < array_length(_ed.script_vars); i_++) {
			var script_var_ = _ed.script_vars[i_];
			var script_ = Catspeak.compile(Catspeak.parseString(vars_[$ script_var_]));
			variable_struct_set(vars_, script_var_, script_);
		}

		//io_connections resolve at ev_room_start (see load_level/resolve_io_connections),
		//not here - unlike REFERENCE, I/O wiring shouldn't require the target
		//to already be placed
		var io_src_ = _ed[$ "io_connections"] ?? []; //?? fallback for levels saved before this feature existed
		var io_resolved_ = [];
		for (var i_ = 0; i_ < array_length(io_src_); i_++) {
			var src_ = io_src_[i_];
			array_push(io_resolved_, {
				output: src_.output, target_name: src_.target_name, target: noone,
				input: src_.input, param: src_.param, delay: src_.delay,
				fire_once: src_.fire_once, fired: false,
			});
		}
		vars_.io_connections_resolved = io_resolved_;

		vars_.element_name = _ed.element_name;

		var inst_ = instance_create_layer(_ed.x, _ed.y, _layer.name, asset_get_index(_name), vars_);
		variable_struct_set(global.level_instance_names, _ed.element_name, inst_);

		//runs the same User Event 1 an editor instance runs on placement -
		//lets an object define variables/functions shared by both sides
		with (inst_) event_user(1);

		return inst_;
	}

	var sprite_ = asset_get_index(_name);
	vars_.sprite_index = sprite_;
	vars_.mask_index = sprite_;
	return instance_create_layer(_ed.x, _ed.y, _layer.name, obj_sprite, vars_);
}
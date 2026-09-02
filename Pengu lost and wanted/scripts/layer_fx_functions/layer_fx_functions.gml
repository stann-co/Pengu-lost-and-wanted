#region Layer FXs
	#region color tint fx
	function fx_setup_color(_entry){
		_entry.surf = -1;
		_entry.shader = sh_color;
		_entry.u_color = shader_get_uniform(sh_color,"u_color");
		_entry.u_intensity = shader_get_uniform(sh_color,"u_intensity");

		layer_script_begin(_entry.layer_id, method(_entry, function(){
			if (event_type != ev_draw) return;
			if (event_number != ev_draw_begin && event_number != ev_draw_normal && event_number != ev_draw_end) return;
			layer_fx_begin_capture(self);
		}));
		layer_script_end(_entry.layer_id, method(_entry, function(){
			if (event_type != ev_draw) return;
			if (event_number != ev_draw_begin && event_number != ev_draw_normal && event_number != ev_draw_end) return;
			layer_fx_end_capture(self);
			if (!surface_exists(surf)) return;
			shader_set(shader);
			shader_set_uniform_f(u_color, params[0], params[1], params[2]);
			shader_set_uniform_f(u_intensity, params[3]);
			layer_fx_composite(surf);
			shader_reset();
		}));
	}

	function fx_clear_color(_entry){
		layer_script_begin(_entry.layer_id, -1);
		layer_script_end(_entry.layer_id, -1);
		if (surface_exists(_entry.surf)) surface_free(_entry.surf);
	}
	#endregion

	#region blur fx
	function fx_setup_blur(_entry){
		_entry.surf = -1;
		_entry.shader = sh_blur;
		_entry.u_size = shader_get_uniform(sh_blur,"u_size");

		layer_script_begin(_entry.layer_id, method(_entry, function(){
			if (event_type != ev_draw) return;
			if (event_number != ev_draw_begin && event_number != ev_draw_normal && event_number != ev_draw_end) return;
			layer_fx_begin_capture(self, 0.25);
		}));
		layer_script_end(_entry.layer_id, method(_entry, function(){
			if (event_type != ev_draw) return;
			if (event_number != ev_draw_begin && event_number != ev_draw_normal && event_number != ev_draw_end) return;
			layer_fx_end_capture(self);
			if (!surface_exists(surf)) return;
			var w_ = surface_get_width(surf);
			var h_ = surface_get_height(surf);
			gpu_set_texfilter(true);
			shader_set(shader);
			shader_set_uniform_f(u_size, w_, h_, params[0]);
			layer_fx_composite(surf, 4);
			shader_reset();
			gpu_set_texfilter(false);
		}));
	}

	function fx_clear_blur(_entry){
		layer_script_begin(_entry.layer_id, -1);
		layer_script_end(_entry.layer_id, -1);
		if (surface_exists(_entry.surf)) surface_free(_entry.surf);
	}
	#endregion

#endregion

#region dispatcher

///@desc finds _layer_id's entry in global.layer_fx_list, or noone
function layer_fx_find(_layer_id){
	for (var i_ = 0; i_ < ds_list_size(global.layer_fx_list); i_++) {
		var entry_ = global.layer_fx_list[| i_];
		if (entry_.layer_id == _layer_id) return entry_;
	}
	return noone;
}

///@desc clears whatever fx _layer_id currently has, then registers _fx_index
///with its starting _params - safe to call any time the fx itself changes
function layer_fx_apply(_layer_id, _fx_index, _params){
	layer_fx_clear(_layer_id);

	var fx_ = global.LAYER_FX[_fx_index];
	if (fx_.setup == undefined) return; //"None"

	var entry_ = {layer_id: _layer_id, fx_index: _fx_index, params: _params};
	ds_list_add(global.layer_fx_list, entry_);
	fx_.setup(entry_);
}

///@desc removes whatever fx _layer_id currently has (calls that fx's own
///clear, which un-hooks layer_script and frees whatever it allocated)
function layer_fx_clear(_layer_id){
	for (var i_ = 0; i_ < ds_list_size(global.layer_fx_list); i_++) {
		var entry_ = global.layer_fx_list[| i_];
		if (entry_.layer_id != _layer_id) continue;

		var fx_ = global.LAYER_FX[entry_.fx_index];
		if (fx_.clear != undefined) fx_.clear(entry_);
		ds_list_delete(global.layer_fx_list, i_);
		return;
	}
}

#endregion

#region capture utilities

///@desc (re)creates _state.surf if it doesn't match the camera's current size
function layer_fx_ensure_surface(_state, _scale = 1){
	if (!surface_exists(global.camera.surface)) return;
	var w_ = surface_get_width(global.camera.surface) * _scale;
	var h_ = surface_get_height(global.camera.surface) * _scale;
	if (!surface_exists(_state.surf) || surface_get_width(_state.surf) != w_ || surface_get_height(_state.surf) != h_){
		if (surface_exists(_state.surf)) surface_free(_state.surf);
		_state.surf = surface_create(w_,h_);
	}
}

///@desc saves the view/projection (surface_set_target is about to reset
///them), targets _state.surf, and clears it
function layer_fx_begin_capture(_state, _scale = 1){
	layer_fx_ensure_surface(_state, _scale);
	if (!surface_exists(_state.surf)) return;
	_state.view = matrix_get(matrix_view);
	_state.proj = matrix_get(matrix_projection);
	surface_set_target(_state.surf);
	draw_clear_alpha(c_black, 0);
	matrix_set(matrix_view, _state.view);
	matrix_set(matrix_projection, _state.proj);
}

///@desc resets the render target and restores the camera's view/projection,
///ready for a shader_set + layer_fx_composite call
function layer_fx_end_capture(_state){
	surface_reset_target();
	matrix_set(matrix_view, _state.view);
	matrix_set(matrix_projection, _state.proj);
}

///@desc draws _surf back at the camera's real view position
function layer_fx_composite(_surf, _scale = 1){
	draw_surface_ext(_surf, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), _scale, _scale, 0, c_white, 1);
}

#endregion
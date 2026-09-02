///@desc editor and game post-create event


//layer scripts run outside normal instance scope, so state goes through
//global.layer_shader_test instead of instance variables
layer_fx = function(){
	global.layer_shader_test = {
		surf : -1,
		shader : sh_blur,
		u_size : shader_get_uniform(sh_blur,"u_size"),
	}

	layer_script_begin("foreground 1",function(){
		if (event_type == ev_draw){
			if (event_number == ev_draw_begin || event_number == ev_draw_normal || event_number == ev_draw_end){
				var w_ = surface_get_width(global.camera.surface);
				var h_ = surface_get_height(global.camera.surface);
				var surf_ = global.layer_shader_test.surf;
				if (!surface_exists(surf_) || surface_get_width(surf_) != w_ || surface_get_height(surf_) != h_){
					if (surface_exists(surf_)) surface_free(surf_);
					global.layer_shader_test.surf = surface_create(w_,h_);
				}

				//surface_set_target resets the projection to fit the new
				//surface - restore the camera's own view/projection after,
				//so this surface's content lines up the same way application_surface's does
				global.layer_shader_test.view = matrix_get(matrix_view);
				global.layer_shader_test.proj = matrix_get(matrix_projection);

				surface_set_target(global.layer_shader_test.surf);
				draw_clear_alpha(c_black, 0);
				matrix_set(matrix_view, global.layer_shader_test.view);
				matrix_set(matrix_projection, global.layer_shader_test.proj);
				
				gpu_set_texfilter(true);
			}
		}
	})

	layer_script_end("foreground 1",function(){
		if (event_type == ev_draw){
			if (event_number == ev_draw_begin || event_number == ev_draw_normal || event_number == ev_draw_end){
				surface_reset_target();
				matrix_set(matrix_view, global.layer_shader_test.view);
				matrix_set(matrix_projection, global.layer_shader_test.proj);

				var w_ = surface_get_width(global.layer_shader_test.surf);
				var h_ = surface_get_height(global.layer_shader_test.surf);

				shader_set(global.layer_shader_test.shader);
				shader_set_uniform_f(global.layer_shader_test.u_size, w_/4, h_/4, 20);
				//view_to_room_x/y use the exact zoom, but the surface/view are
				//sized with ceil(zoom) - view_camera[0] reads the real view GameMaker
				//is actually using, avoiding that rounding mismatch entirely
				draw_surface(global.layer_shader_test.surf, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
				shader_reset();
				gpu_set_texfilter(false);
			}
		}
	})
}

layer_fx_clear = function(){
	layer_script_begin("foreground 1", -1);
	layer_script_end("foreground 1", -1);

	if (surface_exists(global.layer_shader_test.surf)) surface_free(global.layer_shader_test.surf);
}

layer_fx();

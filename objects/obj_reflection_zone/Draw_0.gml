if(global.debug) draw_self();

if(global.draw_reflections){
	var cam_surf = global.camera.surface;
	
	if(!surface_exists(refl_surf)){
		refl_surf = surface_create(sprite_width,sprite_height);
	}
	
	var x_offset = global.camera.get_x() - bbox_left;
	var y_offset = global.camera.get_y() - (bbox_top-sprite_height);
	
	surface_set_target(refl_surf);
		draw_clear_alpha(black,1)
		
		switch(distortion_type) {
			case "none":
				break;
			case "ice":
				shader_set(sh_reflection)
				shader_set_uniform_f(u_speed,0)
				shader_set_uniform_f(u_time,0)
				shader_set_uniform_f(u_brightness,2);
				var color = cyan;
				shader_set_uniform_f(u_tint,color_get_red(color)/255,color_get_green(color)/255,color_get_blue(color)/255);
				shader_set_uniform_f(u_scale,0.07,0.07);
				shader_set_uniform_f(u_distortion,0.135);
				
				shader_set_uniform_f(u_size,image_xscale,image_yscale);
				
				y_offset+=7;
				break;
				
			case "waterfall":
				shader_set(sh_reflection)
				shader_set_uniform_f(u_speed,0.13)
				shader_set_uniform_f(u_time,global.t)
				shader_set_uniform_f(u_brightness,1.4);
				var color = pink;
				shader_set_uniform_f(u_tint,color_get_red(color)/255,color_get_green(color)/255,color_get_blue(color)/255);
				shader_set_uniform_f(u_scale,1,0.085);
				shader_set_uniform_f(u_distortion,0.06)
				
				shader_set_uniform_f(u_size,image_xscale,image_yscale);
				y_offset+=2;
				break;
		}
	
	
		draw_surface(cam_surf,x_offset,y_offset)
		
		shader_reset();
	surface_reset_target()
	
	gpu_set_colourwriteenable(1,1,1,0);
	
	
	shader_set(sh_bottom_fade)
	draw_surface_ext(refl_surf,bbox_left,bbox_bottom,1,-1,0,-1,0.5);
	shader_reset()
	
	gpu_set_colourwriteenable(1,1,1,1);
}
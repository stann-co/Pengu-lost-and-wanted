/// @description

var invulnerable_flash_ = 0;
if(invulnerable != 0){
	invulnerable_flash_ = round( animcurve_read(ac_invulnerable,0,1-(invulnerable/invulnerable_duration)))
}

var invulnerable_alpha_ = (invulnerable_flash_ == 0) ? 1 : 0.5;

//super speed trace_
if(super_speed_fadeout > 0){
	if(global.t mod super_speed_trace_offset == 0){
		var trace_ = {
			sprite_index: sprite_index,
			subimg: subimg,
			x: x,
			y: y,
			scale_x: scale_x,
			scale_y, scale_y,
			facing: facing,
			image_angle: image_angle,
			color: super_speed_colors[(global.t / super_speed_trace_offset) mod array_length(super_speed_colors)]
		}
		array_insert(super_speed_trace_arr,0,trace_);
        
		if(array_length(super_speed_trace_arr) > super_speed_trace_count) array_resize(super_speed_trace_arr,super_speed_trace_count);
	}
	
	var fadeout_ = (super_speed_fadeout / super_speed_fadeout_time);
	
	shader_set(sh_color);
	
	for (var i_ = array_length(super_speed_trace_arr)-1; i_ >= 0; --i_) {
		var trace_ = super_speed_trace_arr[i_];
		
		shader_set_uniform_f(super_speed_u_color,
			color_get_red(	 trace_.color)/255,
			color_get_green( trace_.color)/255,
			color_get_blue(	 trace_.color)/255
		)
		
		shader_set_uniform_f(super_speed_u_intensity,1);
		
		var alpha_ = (animcurve_read(ac_super_speed_alpha,0,i_/super_speed_trace_count) * fadeout_)*invulnerable_alpha_;
		gpu_set_colourwriteenable(1,1,1,0);
		draw_sprite_ext(trace_.sprite_index,trace_.subimg,trace_.x,trace_.y,trace_.scale_x*trace_.facing,trace_.scale_y,trace_.image_angle,-1,alpha_);
		gpu_set_colourwriteenable(1,1,1,1);
	}
	shader_reset();
}

state.draw();
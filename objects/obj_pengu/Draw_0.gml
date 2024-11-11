/// @description

draw_sensor(x,y,vec_l,-90,sensor_length_base);
draw_sensor(x,y,vec_r,+90,sensor_length_base);


draw_sensor(x,y,vec_bl,0,sensor_length_base);
draw_sensor(x,y,vec_b,0,sensor_length_base);
draw_sensor(x,y,vec_br,0,sensor_length_base);


draw_sensor(x,y,vec_tl,180,sensor_length_base);
draw_sensor(x,y,vec_t, 180,sensor_length_base);
draw_sensor(x,y,vec_tr,180,sensor_length_base);

var invulnerable_flash = 0;
if(invulnerable != 0){
	invulnerable_flash = round( animcurve_read(ac_invulnerable,0,1-(invulnerable/invulnerable_duration)))
}

var invulnerable_alpha = (invulnerable_flash == 0) ? 1 : 0.5;

//super speed trace
if(super_speed_fadeout != 0){
	if(global.t mod super_speed_trace_offset == 0){
		var trace = {
			sprite_index: sprite_index,
			subimg: subimg,
			x: x,
			y: y,
			scale_x: scale_x,
			scale_y, scale_y,
			mirror: mirror,
			image_angle: image_angle,
			color: super_speed_colors[(global.t / super_speed_trace_offset) mod array_length(super_speed_colors)]
		}
		array_insert(super_speed_trace_arr,0,trace);

		if(array_length(super_speed_trace_arr) > super_speed_trace_count) array_resize(super_speed_trace_arr,super_speed_trace_count);
	}
	
	
}

if(super_speed_fadeout != 0){
	var fadeout = (super_speed_fadeout / super_speed_fadeout_time);
	
	shader_set(sh_color);
	
	for (var i = array_length(super_speed_trace_arr)-1; i >= 0; --i) {
		var trace = super_speed_trace_arr[i];
		
		shader_set_uniform_f(super_speed_u_color,
			color_get_red(	 trace.color)/255,
			color_get_green( trace.color)/255,
			color_get_blue(	 trace.color)/255
		)
		
		shader_set_uniform_f(super_speed_u_intensity,1);
		
		var alpha = (animcurve_read(ac_super_speed_alpha,0,i/super_speed_trace_count) * fadeout)*invulnerable_alpha;
		
		draw_sprite_ext(trace.sprite_index,trace.subimg,trace.x,trace.y,trace.scale_x*trace.mirror,trace.scale_y,trace.image_angle,-1,alpha);
	}
	shader_reset();
}

state.draw();



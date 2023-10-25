/// @description

//super speed trace
if(super_speed){
	if(global.t mod super_speed_trace_offset == 0){
		var trace = {
			sprite_index: sprite_index,
			subimg: subimg,
			x: x,
			y: y,
			scale_x: scale_x,
			scale_y, scale_y,
			mirror: mirror,
			image_angle: image_angle
		}
		array_insert(super_speed_trace_arr,0,trace);

		if(array_length(super_speed_trace_arr) > super_speed_trace_count) array_resize(super_speed_trace_arr,super_speed_trace_count);
	}
	
	for (var i = 0; i < array_length(super_speed_trace_arr); ++i) {
		var trace = super_speed_trace_arr[i];
		draw_sprite_ext(trace.sprite_index,trace.subimg,trace.x,trace.y,trace.scale_x*trace.mirror,trace.scale_y,trace.image_angle,-1,1-(i/super_speed_trace_count));
	}
}
state.draw();



/// @description


if(active){		
	last_x = x;
	last_y = y;
	last_rot = rotation;
	
	var global_time = (global.t + offset_duration);
	var total_duration = duration + pause_duration
	
	if(cycle != "do once"){
		t = global_time - total_duration * (global_time div total_duration );
	} else {
		t++;
		if(t >= total_duration){
			active = false;	
		}
	}
	
	if(t == 0){
		switch (cycle) {
		   case "cycle":
		    break;
		case "cycle rotation continue":		
			var new_end_rot = end_rot_ - start_rot_;
			start_rot_ = end_rot_;
			end_rot_ += new_end_rot;					
		    break;
		case "ping pong":
			forward = !forward;
			if(forward){
				//go forwards
				if(info_target != -1){
					start_x_ = info_target.x;
					start_y_ = info_target.y;
					end_x_ = xstart;
					end_y_ = ystart;
				}
				
				start_rot_ = start_rotation;
				end_rot_ = end_rotation;
				
			} else {
				//go backwards
				if(info_target != -1){
					start_x_ = xstart;
					start_y_ = ystart;
					end_x_ = info_target.x;
					end_y_ = info_target.y;
				}
				start_rot_ = end_rotation;
				end_rot_ = start_rotation;
			}
		    break;
		};
	};
	
	var clamp_t = clamp(t,0,duration);
	var val = animcurve_read(animcurve,0,clamp_t/duration);
	
	if(info_target != -1){
		x = lerp(start_x_,end_x_,val);
		y = lerp(start_y_,end_y_,val);
	}
	
	if(end_rotation != 0){
		rotation = lerp(start_rot_,end_rot_,val);
		image_angle = rotation mod 360;
	}
	x_change = x - last_x;
	y_change = y - last_y;
	
	rot_change = rotation - last_rot;
}


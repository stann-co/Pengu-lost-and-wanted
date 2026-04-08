/// @description
if(CAN_MOVE){
	if(active){
		var global_time_ = (global.t + offset_duration);
		var total_duration_ = duration + pause_duration
		
		switch (cycle) {
			case "do once":
				t++;
				if(t >= total_duration_){
					active = false;	
				}
				break;
			case "powered":
				if(powered) t++;
				else t--;
				t = clamp(t,0,total_duration_);
				break;
			default:
				t = global_time_ - total_duration_ * (global_time_ div total_duration_ );
				break;
		}
		
		if(t == 0){
			switch (cycle) {
				case "cycle":
					break;
				case "cycle rotation continue":		
					var new_end_rot_ = end_rot_ - start_rot_;
					start_rot_ = end_rot_;
					end_rot_ += new_end_rot_;					
					break;
				case "ping pong":
					forward = !forward;
					if(forward){
						//go forwards
						if(info_target != -1){
							start_x_ = xstart;
							start_y_ = ystart;
							end_x_ = info_target.x;
							end_y_ = info_target.y;
						}
						
						start_rot_ = start_rotation;
						end_rot_ = end_rotation;
						
					} else {
						//go backwards
						if(info_target != -1){
							start_x_ = info_target.x;
							start_y_ = info_target.y;
							end_x_ = xstart;
							end_y_ = ystart;
						}
						start_rot_ = end_rotation;
						end_rot_ = start_rotation;
					}
					break; 
				case "powered":
					break;
				};
		};
		
		var clamp_t_ = clamp(t,0,duration);
		var val_ = animcurve_read(animcurve,animcurve_channel,clamp_t_/duration);
		
		if(info_target != -1){
			set_x(round(lerp(start_x_,end_x_,val_)));
			set_y(round(lerp(start_y_,end_y_,val_)));
		}
		
		if(end_rotation != 0){
			rotation = lerp(start_rot_,end_rot_,val_);
			//TODO add set_angle from obj_entity
			image_angle = rotation mod 360;
		}
	}
}
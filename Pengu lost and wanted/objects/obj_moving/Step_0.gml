/// @description
if(CAN_MOVE){
	if(active){
		var global_time_ = (global.t + offset_duration);
		var total_duration_ = duration + pause_duration
		
		//0 "cycle", 1 "ping pong", 2 "cycle rotation continue", 3 "powered"
		switch (cycle) {
			case 3: //powered
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
				case 0: //cycle
					break;
				case 2: //cycle rotation continue
					var new_end_rot_ = end_rot_ - start_rot_;
					start_rot_ = end_rot_;
					end_rot_ += new_end_rot_;
					break;
				case 1: //ping pong
					forward = !forward;
					if(forward){
						//go forwards
						if(end_target != -1){
							start_x_ = xstart;
							start_y_ = ystart;
							end_x_ = end_target.x;
							end_y_ = end_target.y;
						}

						start_rot_ = start_rotation;
						end_rot_ = end_rotation;

					} else {
						//go backwards
						if(end_target != -1){
							start_x_ = end_target.x;
							start_y_ = end_target.y;
							end_x_ = xstart;
							end_y_ = ystart;
						}
						start_rot_ = end_rotation;
						end_rot_ = start_rotation;
					}
					break;
				case 3: //powered
					break;
				};
		};
		
		var clamp_t_ = clamp(t,0,duration);
		var val_ = animcurve_read(ac_basic,interpolation,clamp_t_/duration);
		
		set_x(round(lerp(start_x_,end_x_,val_)));
		set_y(round(lerp(start_y_,end_y_,val_)));
		
		if(end_rotation != 0){
			rotation = lerp(start_rot_,end_rot_,val_);
			set_angle(rotation mod 360);
		}
	}
}

x_speed = x - xprevious;
y_speed = y - yprevious;
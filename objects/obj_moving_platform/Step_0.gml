/// @description
last_x = x;
last_y = y;
last_rot = rotation;

if(active){
	if(t != duration){
		t++
	} else {
		if(t_pause != pause_duration){
			t_pause++
		} else {
			
			switch (cycle) {
		    case "cycle":
				t = 0;	
				t_pause = 0;
		        break;
			case "cycle rotation continue":
				t = 0;	
				t_pause = 0;
				
				var new_end_rot = end_rot_ - start_rot_;
				start_rot_ = end_rot_;
				end_rot_ += new_end_rot;					
		        break;
			case "do once":
		        active = false;
		        break;
			case "ping pong":
		        t = 0;	
				t_pause = 0;
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
	};
	
	var val = animcurve_read(animcurve,0,t/duration);
	
	if(info_target != -1){
		x = lerp(start_x_,end_x_,val);
		y = lerp(start_y_,end_y_,val);
	}
	
	if(end_rotation != 0){
		rotation = lerp(start_rot_,end_rot_,val);
		image_angle = rotation mod 360;
	}
}


x_change = x - last_x;
y_change = y - last_y;

rot_change = rotation - last_rot;
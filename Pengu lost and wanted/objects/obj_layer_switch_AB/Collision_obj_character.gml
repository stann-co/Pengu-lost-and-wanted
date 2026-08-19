/// @description
if(active){
	var mid_x_ = lerp(bbox_right ,bbox_left,0.5);
	var mid_y_ = lerp(bbox_bottom ,bbox_top,0.5);
	var dir_ = point_direction(mid_x_,mid_y_,other.x,other.y)+90-image_angle;
	if(dir_ >= 360) dir_-=360;
	else if(dir_ < 0) dir_+=360;
	
	if(only_grounded){
		var ground_check_ = !other.airborne;
	} else var ground_check_ = true;
	
	if(ground_check_){
		//player is on left side
		if(dir_ > 180){
			collision_layer_switch(other,left_side,change_depth)
		} else {
			collision_layer_switch(other,right_side,change_depth)
		}
	}
}
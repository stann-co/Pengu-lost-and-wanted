/// @description

if(falling){
		
	var val = animcurve_read(ac_falling_platform,0,t/duration) * max_speed;
	var shake_val = animcurve_read(ac_falling_platform,1,t/duration);
	if(t < duration) t++;
	
	y+=val;
	
	shake_x = random_range(-shake_val,shake_val);
	shake_y = random_range(-shake_val,shake_val);
	
	//if origin and the platform iteself is out of view it resets
	
	var y_offset = y - ystart;
	if (bounds_out_of_view() && bounds_out_of_view(,,bbox_top-y_offset,bbox_bottom-y_offset)){
		falling = false;
		t = 0;
		shake_x = 0;
		shake_y = 0;
		subimg = 0;
		x = xstart;
		y = ystart;
	}
	
}











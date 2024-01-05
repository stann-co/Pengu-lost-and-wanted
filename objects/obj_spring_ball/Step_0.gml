/// @description 

if(springing){
	var val = animcurve_read(ac_spring_ball,0,(t/duration));
	
	ball_vec.x = lengthdir_x(launch_speed,dir)*val*5;
	ball_vec.y = lengthdir_y(launch_speed,dir)*val*5;
	
	if(grabbed_on){
		
		obj_pengu.x = x+ball_vec.x;
		obj_pengu.y = y+ball_vec.y;
		
		//when duration is halfway done pengu flys off
		if(t >= (duration*0.25)){
			grabbed_on = false;
			with(obj_pengu){
				
				controlled = true;
				state.change("fall_up");
				x_speed = -lengthdir_x(other.launch_speed,other.dir);
				y_speed = -lengthdir_y(other.launch_speed,other.dir);
			}
		}
	}
	
	//when duration is completly done it's back in resting position
	if(t == duration){
		springing = false;
		t = 0;
	} else t++;
}











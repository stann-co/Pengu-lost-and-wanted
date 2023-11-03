/// @description
if(moving){
	
	var val = animcurve_read(ac_skilift,0,t/(duration*2));
	var wheel_val = animcurve_read(ac_skilift_wheel,0,t/(duration*2));
	
	pole.image_speed = wheel_val;
	
	t++;
	
	x = lerp(point1.x,point2.x,val);
	y = lerp(point1.y,point2.y,val);

	if(t >= duration){
		if(seated){
			seated = false;
			with(obj_pengu){
				var dir = point_direction(other.point1.x,other.point1.y,other.point2.x,other.point2.y);
				x_speed = lengthdir_x(10,dir);
				y_speed = lengthdir_y(10,dir);
				controlled = true;		
				state.change("jump");
			}
		}
	} else {
		with(obj_pengu){
			x = other.x+8;
			y = other.y+35;
		}	
	}
	
	if(t == duration*2){
		moving = false;
		t = 0;
	}
}








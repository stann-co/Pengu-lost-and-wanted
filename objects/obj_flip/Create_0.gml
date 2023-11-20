//should be used in a one tile space,
//to flip pengu from sliding on the floor to the ceiling or vice versa

triggered = false;

trigger = function(){
	if(!triggered){
		triggered = true;
		with(obj_pengu){
			if(state.state_is("prone")){
				
				//x += lengthdir_x(6,ground_angle+90);
				//y += lengthdir_y(6,ground_angle+90);
				
				mirror = -mirror;
				
				ground_angle += 180;
				if(ground_angle >= 360) ground_angle-=360;
				image_angle = ground_angle;
				ground_spd = -ground_spd;
			}
		}
	}
}


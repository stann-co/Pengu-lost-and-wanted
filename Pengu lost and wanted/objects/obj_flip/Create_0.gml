//should be used in a one tile space,
//to flip pengu from sliding on the floor to the ceiling or vice versa
event_inherited();

triggered = false;

trigger = function(){
	if(!triggered && active){
		triggered = true;
		with(obj_pengu){ //TODO maybe this should be changed to work with other entities also
			if(state.state_is("prone")){
				
				facing = -facing;
				
				ground_angle += 180;
				if(ground_angle >= 360) ground_angle-=360;
				image_angle = ground_angle;
				ground_spd = -ground_spd;
				input_h = -input_h;
			}
		}
	}
}

setActive = function(_active){
	active = _active;
}
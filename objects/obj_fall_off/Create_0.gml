//will make pengu start falling off if he's sliding/walking
//and is faster than minimum speed, default being 0


trigger = function(){
	with(obj_pengu){
		if(!state.state_is("airborne") && abs(ground_spd) > other.minimum_speed){
			state.change("begin_fall");	
		}
	}
}


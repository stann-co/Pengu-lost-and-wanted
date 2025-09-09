/// @description 
if(CAN_MOVE){
	state.step();
	
	//dissapears after a while
	if(disappear){
		if(global.t >= start_time + disappear_duration) instance_destroy();
	}
}
/// @description 
saved_pengu = {
	x: obj_pengu.x,
	y: obj_pengu.y,
	state: obj_pengu.state.get_current_state()
}

save_text = true;

call_later(1,time_source_units_seconds,function(){
	save_text = false;	
})









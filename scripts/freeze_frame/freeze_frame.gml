function freeze_frame(_wait_time = 0.30){
	global.freeze_frame = true;
	call_later(_wait_time,time_source_units_seconds,function(){
		global.freeze_frame = false;
	})
}
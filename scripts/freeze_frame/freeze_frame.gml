function freeze_frame(){
	global.freeze_frame = true;
	call_later(0.08,time_source_units_seconds,function(){
		global.freeze_frame = false;
	})
}
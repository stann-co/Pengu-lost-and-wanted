/// @description
if(!triggered){
	triggered = true;
	with(obj_pengu){
		path_start(other.path,other.spd,path_action_stop,true);
		ground_spd = other.spd;
		state.change("tube");
	}
	
	call_later(5,time_source_units_seconds,function(){
		triggered = false;	
	})
}
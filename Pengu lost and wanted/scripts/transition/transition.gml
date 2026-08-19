function transition(_callback,_time = SECOND*0.5){
	_time = round(_time);
	obj_game.transition_in = true;
	obj_game.transition_callback = _callback;
	obj_game.transition_duration = _time;
	obj_game.transition_t = _time;
}
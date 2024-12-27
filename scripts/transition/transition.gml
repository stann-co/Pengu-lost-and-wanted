function transition(callback,time = game_speed*0.5){
	time = round(time);
	obj_game.transition_in = true;
	obj_game.transition_callback = callback;
	obj_game.transition_duration = time;
	obj_game.transition_t = time;
}
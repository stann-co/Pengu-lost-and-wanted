/// @description
if(global.debug){
	draw_set_halign(fa_right)
	var text = [
		$"{airborne} : AIRBORNE",
		$"{ground_spd} : GROUND SPEED",
		$"{ground_angle} : GROUND ANGLE",
		$"{x_speed} : X SPEED",
		$"{y_speed} : Y SPEED",
		$"{control_lock} : CONTROL LOCK",
		$"{depth} : DEPTH",
	]
	
	for (var i = 0; i < array_length(text); ++i) {
	    draw_text(global.game_w-5,5+(14*i),text[i]);
	}
	
	draw_set_halign(fa_left)
}

state.draw_gui();

/// @description
if(global.debug){
	var text = [
		$"airborne: {airborne}",
		$"ground speed: {ground_spd}",
		$"ground angle: {ground_angle}",
		$"x speed: {x_speed}",
		$"y speed: {y_speed}",
		$"control lock: {control_lock}",
	]
	
	for (var i = 0; i < array_length(text); ++i) {
	    draw_text(5,5+(14*i),text[i]);
	}
	
}

state.draw_gui();

/// @description
if(global.debug){
	draw_set_halign(fa_right)
	var text_ = [
		$"{airborne} : AIRBORNE",
		$"{ground_spd} : GROUND SPEED",
		$"{ground_angle} : GROUND ANGLE",
		$"{x_speed} : X SPEED",
		$"{y_speed} : Y SPEED",
		$"{control_lock} : CONTROL LOCK",
		$"{depth} : DEPTH",
	]
	
	for (var i_ = 0; i_ < array_length(text_); ++i_) {
	    draw_text(global.game_w-5,5+(14*i_),text_[i_]);
	}
	
	draw_set_halign(fa_left)
}

state.draw_gui();

for (var i_ = 0; i_ < ds_list_size(attack_list); i_++) {
	draw_text(0,10*i_,attack_list[|i_])
}
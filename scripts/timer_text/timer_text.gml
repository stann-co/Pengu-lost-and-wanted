function timer_text(time_){
	if(time_ == undefined) return "#\"##'##"
	
	var minutes = time_ div (game_speed * 60);
	var seconds = string_format(time_ div (game_speed) mod 60,2,0);
	var frames =  string_format(time_ mod game_speed,2,0);
	
	return string_replace_all($"{minutes}\"{seconds}'{frames}"," ","0");
}
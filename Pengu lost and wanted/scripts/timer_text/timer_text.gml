function timer_text(_time){
	if(_time == undefined) return "#\"##'##"
    
	var minutes_ = _time div (SECOND * 60);
	var seconds_ = string_format(_time div (SECOND) mod 60,2,0);
	var frames_ =  string_format(_time mod SECOND,2,0);
	
	return string_replace_all($"{minutes_}\"{seconds_}'{frames_}"," ","0");
}
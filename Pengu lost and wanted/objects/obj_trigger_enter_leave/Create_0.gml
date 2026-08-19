/// @description When colliding with this, on_enter get's triggered when entered,  on_leave when you leave (duh)
event_inherited();

triggering = false;
has_left = false;
has_entered = false;

trigger = function(_inst){ //dont override this one
	triggering = true;
	has_left = false;
	if(!has_entered){
		has_entered = true;
		on_enter();
	}
}

on_enter = function(){
	show_debug_message("ENTERED!")
}

on_leave = function(){
	show_debug_message("LEFT!")
}
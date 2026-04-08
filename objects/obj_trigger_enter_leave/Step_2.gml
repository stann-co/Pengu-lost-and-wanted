/// @description
if(!triggering){
	if(!has_left){
		has_left = true;
		has_entered = false;
		on_leave();
	}
}

triggering = false;

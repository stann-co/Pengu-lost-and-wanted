/// @description
if(!triggering){
	if(!has_left){
		has_left = true;
		has_entered = false;
		fire_output("leave");
	}
}

triggering = false;

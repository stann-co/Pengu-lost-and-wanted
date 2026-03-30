/// @description

if(active){
	if(only_grounded){
		var ground_check_ = !other.airborne;
	} else var ground_check_ = true;
	
	if(ground_check_){
		collision_layer_switch(other,switch_layer,change_depth)
	}
}
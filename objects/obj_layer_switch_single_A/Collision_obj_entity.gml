/// @description

if(only_grounded){
	var ground_check = !other.airborne;
} else var ground_check = true;

if(ground_check){
	collision_layer_switch(switch_layer,change_depth)
}
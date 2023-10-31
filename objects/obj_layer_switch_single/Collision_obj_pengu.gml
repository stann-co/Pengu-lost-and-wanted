/// @description
if(only_grounded){
	var ground_check = !obj_pengu.airborne;
} else var ground_check = true;

if(ground_check){
	var activate_a = false
	if(switch_to_layer == "A"){
		activate_a = true
	}
	
	//player is on yellow side
	collision_layer_switch(activate_a,change_depth)
}















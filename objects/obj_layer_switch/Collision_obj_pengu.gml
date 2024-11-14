/// @description
var dir = point_direction(x,y,obj_pengu.x,obj_pengu.y)+90-image_angle;
if(dir >= 360) dir-=360;
else if(dir < 0) dir+=360;

if(only_grounded){
	var ground_check = !obj_pengu.airborne;
} else var ground_check = true;

if(ground_check){
	
	if(yellow_side_is == "A"){
		var activate_a = true
	} else {
		var activate_a = false
	}
	
	//player is on yellow side
	if(dir > 180) activate_a = !activate_a;
	collision_layer_switch(activate_a,change_depth)
}













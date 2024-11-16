/// @description
var mid_x = lerp(bbox_right ,bbox_left,0.5);
var mid_y = lerp(bbox_bottom ,bbox_top,0.5);
var dir = point_direction(mid_x,mid_y,obj_pengu.x,obj_pengu.y)+90-image_angle;
if(dir >= 360) dir-=360;
else if(dir < 0) dir+=360;

if(only_grounded){
	var ground_check = !obj_pengu.airborne;
} else var ground_check = true;

if(ground_check){
	//player is on left side
	if(dir > 180){
		collision_layer_switch(left_side,change_depth)
	} else {
		collision_layer_switch(right_side,change_depth)
	}
}

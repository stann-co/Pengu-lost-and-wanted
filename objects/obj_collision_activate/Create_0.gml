/// @description

parent = noone;
standing_on = false; //true as long as player stands on it
triggering = false;

x_offset = 0;
y_offset = 0;

trigger = function(){
	if(parent != noone) parent.trigger();
}

trigger_leave = function(){
	if(parent != noone) parent.trigger_leave();	
}

move_to_parent = function(){
	var vec_parent = new Vector2(x_offset,y_offset);
	vec_parent = vec_parent.rotated(-parent.image_angle);
	x = parent.x+vec_parent.x;
	y = parent.y+vec_parent.y;
	image_angle = parent.image_angle;
}

angle_previous = 0;
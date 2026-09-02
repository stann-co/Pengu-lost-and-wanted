/// @description
event_inherited();

pause_duration *= SECOND
duration *= SECOND;
offset_duration *= SECOND;

t = 0;

start_rotation = image_angle;

rotation = image_angle;

start_rot_ =  start_rotation;
end_rot_ = end_rotation;

start_x_ = x;
start_y_ = y;

end_x_ = target_x;
end_y_ = target_y;
	
var start_target_ = instance_create_depth(x,y,depth,obj_info_target);
//a target gets places at start, so even if the platform is out of view
//it's active as long as start or end pos is in view
end_target = instance_create_depth(target_x,target_y,depth,obj_info_target);
	
//if either self or target is in view, the platform will move
activation_link(self,start_target_,end_target);

forward = true;
powered = false; // cycle is set to "powered" this makes the platform, go to it's target, or to default position

trigger = function(){
	return false; //not solid
}

SetActive = function(_active){
	active = _active;
}

SetPowered = function(_powered){
	powered = _powered;
}
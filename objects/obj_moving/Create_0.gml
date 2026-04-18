/// @description
event_inherited();

pause_duration = pause_duration_seconds * GAME_SPEED
duration = duration_seconds * GAME_SPEED;
offset_duration = offset_duration_seconds * GAME_SPEED;

t = 0;

start_rotation = image_angle;

rotation = image_angle;

start_rot_ =  start_rotation;
end_rot_ = end_rotation;

start_x_ = x;
start_y_ = y;

if(info_target != -1){
	end_x_ = info_target.x;
	end_y_ = info_target.y;
	
	//a target gets places at start, so even if the platform is out of view
	//it's active as long as start or end pos is in view
	var start_target_ = instance_create_depth(x,y,depth,obj_info_target);
	
	//if either self or target is in view, the platform will move
	activation_link(self,info_target,start_target_);
}

forward = true;
powered = false; // cycle is set to "powered" this makes the platform, go to it's target, or to default position

trigger = function(){
	return false; //not solid
}
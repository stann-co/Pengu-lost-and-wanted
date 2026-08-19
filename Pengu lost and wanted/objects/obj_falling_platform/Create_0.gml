event_inherited();

falling = false;
shake_x = 0;
shake_y = 0;
t = 0;
duration = SECOND*0.5;

subimg = 0;
max_speed = 4;

origin = instance_create_depth(x,y,depth,obj_info_target);

activation_link(self.id,origin.id);

trigger = function(side_,object_){
	if(!falling){
		falling = true;	
		subimg = 1;
	}
	return true;
}
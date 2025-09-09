/// @description

if(squish_t < squish_dur) squish_t++;

if(colliding){
	if !place_meeting(x,y,obj_pengu){
		colliding = false;
		var dir_ = point_direction(0,0,obj_pengu.x_speed,obj_pengu.y_speed);
		var cone_ = 30;
		
		var part_ = particle_get_type(ps_winter_tree_leaves_explode);
		part_type_direction(part_,dir_-cone_,dir_+cone_,0,0);
		part_particles_burst(ps, obj_pengu.x,y, part_);
	}
}
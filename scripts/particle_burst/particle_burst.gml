///@function particle_burst
function particle_burst(particle_,x_=x,y_=y,dir_ = 0){
	instance_create_depth(x,y,depth,obj_particle_host,{
		particle: particle_,
		dir: dir_
	});
}
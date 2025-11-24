///@function particle_burst
function particle_burst(_particle,_x=x,_y=y,_dir = 0){
	instance_create_depth(_x,_y,depth,obj_particle_host,{
		particle: _particle,
		dir: _dir
	});
}
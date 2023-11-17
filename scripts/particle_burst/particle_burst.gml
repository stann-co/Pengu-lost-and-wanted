///@function particle_burst
function particle_burst(particle_,x_=x,y_=y,){
	instance_create_depth(x,y,depth,obj_particle_host,{
		particle: particle_	
	});
}
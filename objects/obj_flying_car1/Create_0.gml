/// @description
event_inherited();

depth = global.depth_a;

//make extra collision box
child = add_collision_child(-12,-17,30,14);

trigger = function(){
	var max_val = 5;
	var x_force = clamp(other.x_speed,-max_val,max_val);
	var y_force = clamp(other.y_speed,-max_val,max_val);
	phys.force(x_force,y_force);
}

trigger_leave = function(){
	
}

phys = new verlet(x,y,4);


//thruster
srf = -1;
srf_normal = -1;
srf_distortion = -1;

s_normal	 = shader_get_sampler_index(sh_distortion,"s_Normal");
s_distortion = shader_get_sampler_index(sh_distortion,"s_Distortion");

tex_normal = -1;
tex_distortion = -1;

thruster_subimg = 0;
normal_subimg = 0;


draw_thruster = function(_x,_y){
	
	
	
	if(!surface_exists(srf)){
		srf = surface_create(32,32);
	}
		
	surface_set_target(srf)
		draw_surface(global.camera.surface,global.camera.get_x()-_x+16,global.camera.get_y()-_y+11);
	surface_reset_target();

	shader_set(sh_distortion);
	texture_set_stage(s_normal,tex_normal);
	texture_set_stage(s_distortion,tex_distortion);
	draw_surface(srf,_x-16,_y-11);
	shader_reset();
	
	draw_sprite(spr_thruster,thruster_subimg,_x,_y);
		
		
}

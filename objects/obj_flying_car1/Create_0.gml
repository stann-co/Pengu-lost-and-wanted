/// @description
event_inherited();

depth = global.depth_a;

last_x = x;
last_y = y;



//make extra collision box
//child = add_collision_child(-12,-17,30,14);

standing_on = false;
triggering = false;

trigger = function(_side,_object){
	if(!standing_on){
		var max_val = 5;
		var x_force = clamp(_object.x_speed,-max_val,max_val);
		var y_force = clamp(_object.y_speed,-max_val,max_val);
		phys.force(x_force,y_force);
		standing_on = true;
	}
	
	triggering = true;
	
	_object.x+= x - last_x;
	
	return true;
}

phys = new Verlet(x,y,4);


//thruster
srf = -1;
srf_mask = -1;

s_mask = shader_get_sampler_index(sh_distortion,"s_Mask");
u_delta = shader_get_uniform(sh_distortion,"u_Delta");

tex_mask = -1;

thruster_subimg = 0;
normal_subimg = 0;


draw_thruster = function(_x,_y){

	if(!surface_exists(srf)){
		srf = surface_create(32,32);
	}
		
	surface_set_target(srf)
		draw_surface(global.camera.surface,global.camera.get_x()-_x+16,global.camera.get_y()-_y+11);
	surface_reset_target();
	
	//mask
	if(!surface_exists(srf_mask)){
		srf_mask = surface_create(32,32,surface_r8unorm);	
	}
	
	surface_set_target(srf_mask)
		draw_clear(BLACK)
		draw_sprite_ext(spr_thruster_mask,0,16,11,1,1,0,-1,0.1);
	surface_reset_target();
	tex_mask = surface_get_texture(srf_mask);
	

	shader_set(sh_distortion);
	
	texture_set_stage(s_mask,tex_mask);
	shader_set_uniform_f(u_delta,global.t);
	
	draw_surface(srf,_x-16,_y-11);
	
	shader_reset();
	
	draw_sprite(spr_thruster,thruster_subimg,_x,_y);
		
}

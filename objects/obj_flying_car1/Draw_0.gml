//normal
thruster_subimg += sprite_get_speed(spr_thruster);
normal_subimg += 0.5;

if(!surface_exists(srf_normal)){
	srf_normal = surface_create(32,32,surface_rg8unorm);	
}
surface_set_target(srf_normal)
draw_sprite(spr_noise,normal_subimg,0,0);
surface_reset_target();
tex_normal = surface_get_texture(srf_normal);


//distortion
if(!surface_exists(srf_distortion)){
	srf_distortion = surface_create(32,32,surface_r8unorm);	
}
surface_set_target(srf_distortion)
	draw_clear(black)
	draw_sprite_ext(spr_thruster_mask,0,16,11,1,1,0,-1,0.1);
surface_reset_target();
tex_distortion = surface_get_texture(srf_distortion);


draw_thruster(x-30,y+19);
draw_thruster(x+11,y+19);

draw_thruster(x-14,y+20);
draw_thruster(x+28,y+20);


draw_self();
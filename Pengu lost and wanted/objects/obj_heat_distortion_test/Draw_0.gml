/// @description
////background
//if(!surface_exists(srf)){
//	srf = surface_create(32,32);	
//}
//surface_set_target(srf)
//draw_surface(global.camera.surface,global.camera.get_x()-x,global.camera.get_y()-y);
//surface_reset_target();


////normal
//if(!surface_exists(srf_normal)){
//	srf_normal = surface_create(32,32,surface_rg8unorm);	
//}
//surface_set_target(srf_normal)
//draw_sprite(sprite_index,image_index,0,0);
//surface_reset_target();
//var tex_normal = surface_get_texture(srf_normal);


////distortion
//if(!surface_exists(srf_distortion)){
//	srf_distortion = surface_create(32,32,surface_r8unorm);	
//}
//surface_set_target(srf_distortion)
//draw_sprite(spr_thruster_mask,0,16,11);
//surface_reset_target();
//var tex_distortion = surface_get_texture(srf_distortion);


shader_set(sh_distortion);
shader_set_uniform_f(u_delta,global.t);
shader_set_uniform_f(u_distortion,2);
draw_self()
shader_reset();
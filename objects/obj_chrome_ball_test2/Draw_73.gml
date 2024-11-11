/// @description


if(!surface_exists(srf_tex)){
	srf_tex = surface_create(size*scale,size*scale);
}

surface_set_target(srf_tex);
draw_clear(black);
draw_surface_part(global.camera.surface,
					x - global.camera.get_x() - size*scale/2,
					y - global.camera.get_y() - size*scale/2,
					size*scale, size*scale, 0, 0
					);
surface_reset_target();



shader_set(sh_cubemap);
var tex = sprite_get_texture(spr_normal_sphere,0);
texture_set_stage(s_normal,tex);
shader_set_uniform_f(u_strength,strength);

draw_surface_ext(srf_tex,x-(size/2),y-(size/2),1/scale,1/scale,0,-1,1);

shader_reset();
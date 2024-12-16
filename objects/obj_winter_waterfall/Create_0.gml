/// @description

// Inherit the parent event
event_inherited();

width  = bbox_right-bbox_left;
height = bbox_bottom-bbox_top;

water_surf = -1;

u_tint = shader_get_uniform(sh_waterfall,"u_tint");
u_brightness = shader_get_uniform(sh_waterfall,"u_brightness");
u_scale = shader_get_uniform(sh_waterfall,"u_scale");
u_speed = shader_get_uniform(sh_waterfall,"u_speed");
u_time = shader_get_uniform(sh_waterfall,"u_time");
u_distortion = shader_get_uniform(sh_waterfall,"u_distortion");
u_size = shader_get_uniform(sh_waterfall,"u_size");

brightness = 1.36;
scale_x = 1;
scale_y = 0.085;
distortion = 0.06;
spd_y = -0.326;
overlay_spd = 2.456;

Inspectron()
	.Section("waterfall")
	.Slider("brightness",0,5)
	.Slider("scale_x",0,1)
	.Slider("scale_y",0,1)
	.Slider("distortion",0,1)
	.Slider("spd_y",-0.5,0.5)
	.Slider("overlay_spd",0,5)
	.render()

#region particles
if(splash_particles){
	ps = part_system_create();
	emitter = part_emitter_create(ps)
	part_emitter_region(ps, emitter, -(sprite_width/2), (sprite_width/2), 0, 0, ps_shape_line, ps_distr_linear);
	part_system_position(ps,x+(sprite_width/2),bbox_bottom);
	part_system_automatic_draw(ps, false);
	
	var part = particle_get_type(ps_winter_waterfall);
	part_emitter_stream(ps,emitter,part,2);
}
#endregion



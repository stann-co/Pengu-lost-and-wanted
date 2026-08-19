/// @description

if(global.draw_reflections){
	var cam_surf_ = global.camera.surface;
	
	if(!surface_exists(water_surf)){
		water_surf = surface_create(width,height);
	}
	
	surface_set_target(water_surf);
	
	var x_offset_ = global.camera.get_x() - x;
	var y_offset_ = global.camera.get_y() - y;
	
	draw_surface(cam_surf_,x_offset_,y_offset_);
	
	surface_reset_target();
	
	shader_set(sh_reflection);
	shader_set_uniform_f(u_tint,242/255,113/255,178/255);
	shader_set_uniform_f(u_brightness,brightness);
	shader_set_uniform_f(u_scale,scale_x,scale_y);
	shader_set_uniform_f(u_time,global.t);
	shader_set_uniform_f(u_distortion,distortion);
	shader_set_uniform_f(u_speed,0,spd_y);
	shader_set_uniform_f(u_size,image_xscale,image_yscale);
	draw_surface(water_surf,x,y);
}

draw_sprite_tiled_area_ext(spr_winter_waterfall,0,0,global.t*overlay_spd,bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,,,,0.2)

gpu_set_blendmode(bm_add)
draw_sprite_tiled_area_ext(spr_winter_waterfall,1,0,global.t*overlay_spd,bbox_left,bbox_top,bbox_right-1,bbox_bottom-1)

//waterfall edges
draw_sprite_tiled_area_ext(spr_winter_waterfall_sides,0,bbox_left ,global.t*overlay_spd,bbox_left ,bbox_top,bbox_left+10,bbox_bottom-1,,,,0.5)
draw_sprite_tiled_area_ext(spr_winter_waterfall_sides,0,bbox_right,global.t*overlay_spd,bbox_right,bbox_top,bbox_right+10,bbox_bottom-1,-1,,,0.5)

draw_sprite_stretched_ext(spr_winter_waterfall_top,0,x,y,sprite_width,32,-1,0.2);
gpu_set_blendmode(bm_normal)

shader_reset()

if(splash_particles){
	gpu_set_colorwriteenable(true,true,true,false);
	part_system_drawit(ps);
	gpu_set_colorwriteenable(true,true,true,true);
}
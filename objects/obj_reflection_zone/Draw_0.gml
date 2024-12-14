if(global.debug) draw_self();

var cam_surf = global.camera.surface;

if(!surface_exists(refl_surf)){
	refl_surf = surface_create(width,height);
}

var x_offset = global.camera.get_x() - (bbox_left - x_refl);
var y_offset = global.camera.get_y() - (bbox_top  - y_refl);

surface_set_target(refl_surf);
draw_clear_alpha(black,0)


switch(distortion) {
	case "none":
		break;
	case "waterfall":
		shader_set(sh_waterfall)
		
		shader_set_uniform_f(u_speed,spd)
		shader_set_uniform_f(u_frequency,frequency)
		shader_set_uniform_f(u_size,size)
		shader_set_uniform_f(u_time,global.t)
		
		break;
}
draw_surface(cam_surf,x_offset,y_offset)
shader_reset();

surface_reset_target()

gpu_set_colourwriteenable(1,1,1,0);


shader_set(sh_bottom_fade)
draw_surface_ext(refl_surf,bbox_left+x_draw,bbox_top+y_draw,xscale,yscale,0,-1,0.5);
shader_reset()

gpu_set_colourwriteenable(1,1,1,1);
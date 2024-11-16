if(global.debug) draw_self();

var cam_surf = global.camera.surface;

if(!surface_exists(refl_surf)){
	refl_surf = surface_create(width,height);
}

var x_offset = global.camera.get_x() - (bbox_left - x_refl);
var y_offset = global.camera.get_y() - (bbox_top  - y_refl);

surface_set_target(refl_surf);
draw_clear_alpha(black,0)

draw_surface(cam_surf,x_offset,y_offset)

surface_reset_target()


//gpu_set_blendmode(bm_max)
gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_src_color)
draw_surface_ext(refl_surf,bbox_left+x_draw,bbox_top+y_draw,xscale,yscale,0,-1,1);
gpu_set_blendmode(bm_normal)
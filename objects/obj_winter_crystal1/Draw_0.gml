var cam_surf_ = global.camera.surface;

if(!surface_exists(refract_surf)){
	refract_surf = surface_create(sprite_width,sprite_height);
}

var x_offset_ = global.camera.get_x() - bbox_left;
var y_offset_ = global.camera.get_y() - bbox_top;

surface_set_target(refract_surf)
	draw_clear_alpha(BLACK,0)
	draw_surface(cam_surf_,x_offset_,y_offset_)
surface_reset_target()

var texture_ = surface_get_texture_(refract_surf);

var uvs_ = sprite_get_uvs_(sprite_index,image_index);
array_resize(uvs_,4);

shader_set(sh_refraction)
texture__set_stage(s_texture_,texture_);
shader_set_uniform_f_array(u_uvs_,uvs_);
shader_set_uniform_f(u_refract,refract);
shader_set_uniform_f(u_amount,amount);

draw_self()

shader_reset()

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,-1,0.1);
gpu_set_blendmode(bm_normal);


//surface_reset_target()

//draw_surface(refract_surf,bbox_left,bbox_top)
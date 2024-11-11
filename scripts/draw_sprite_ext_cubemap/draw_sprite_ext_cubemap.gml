function draw_sprite_ext_cubemap(_sprite,_subimg,_x,_y,_normal,_texture,_roughness,_n_strength = 1,_r_strength = 1,_scale = 1,_offset_scale = 1,_xscale=1,_yscale=1,_rot = 0){
	
	var width_	= sprite_get_width(_sprite);
	var height_ = sprite_get_height(_sprite);
	var _origin_x = sprite_get_xoffset(_sprite);
	var _origin_y = sprite_get_yoffset(_sprite);
	
	var srf_sprite = surface_create(width_,height_);
	
	//surface
	surface_set_target(srf_sprite);
		draw_sprite(_sprite,_subimg,_origin_x,_origin_y);
	surface_reset_target();
	
	draw_surface_ext_cubemap(srf_sprite,_x,_y,_origin_x,_origin_y,_normal,_roughness,_texture,_n_strength,_r_strength,_scale,_offset_scale,_xscale,_yscale,_rot)
	
	surface_free(srf_sprite);
	
}

///@function draw_surface_ext_cubemap()
///@desc takes diffuse surface, and sprites with roughness normal texture, and draws them with shiny shader
function draw_surface_ext_cubemap(_surface,_x,_y,_origin_x,_origin_y,_normal,_roughness,_texture,_n_strength = 1,_r_strength = 1,_scale = 1,_offset_scale = 1,_xscale=1,_yscale=1,_rot = 0){
	
	//could change this to be nearest power of 2 maybe
	var width_	= surface_get_width(_surface);
	var height_ = surface_get_height(_surface);
	
	//normal
	var srf_normal = surface_create(width_,height_,surface_rg8unorm);
	surface_set_target(srf_normal)
	draw_sprite_stretched(_normal,0,0,0,width_,height_);
	surface_reset_target()
	
	//roughness
	var srf_roughness = surface_create(width_,height_,surface_r8unorm);
	surface_set_target(srf_roughness)
	draw_sprite_stretched(_roughness,0,0,0,width_,height_);
	surface_reset_target()
	
	draw_surfaces_cubemap(_surface,_x,_y,_origin_x,_origin_y,srf_normal,srf_roughness,_texture,_n_strength,_r_strength,_scale,_offset_scale,_xscale,_yscale,_rot)

	surface_free(srf_normal);
	surface_free(srf_roughness);

}

///@function draw_surfaces_cubemap()
///@desc takes surfaces with roughness normal diffuse and texture and draws them with shiny shader
function draw_surfaces_cubemap(_surface,_x,_y,_origin_x,_origin_y,_srf_normal,_srf_roughness,_texture,_n_strength = 1,_r_strength = 1,_scale = 1, _offset_scale = 1,_xscale=1,_yscale=1,_rot = 0){
	//samples
	var s_normal =		shader_get_sampler_index(sh_shine,"s_Normal");
	var s_texture =		shader_get_sampler_index(sh_shine,"s_Texture");
	var s_roughness =	shader_get_sampler_index(sh_shine,"s_Roughness");
	
	//uniforms
	var u_normal_strength =		shader_get_uniform(sh_shine,"u_normal_strength");
	var u_roughness_strength =	shader_get_uniform(sh_shine,"u_roughness_strength");
	var u_texture_ratio = shader_get_uniform(sh_shine,"u_texture_ratio");
	var u_texture_offset = shader_get_uniform(sh_shine,"u_texture_offset");
	var u_texture_scale = shader_get_uniform(sh_shine,"u_texture_scale");
		
	shader_set(sh_shine);
	
	var n_tex = surface_get_texture(_srf_normal);
	var r_tex = surface_get_texture(_srf_roughness);
	var t_tex = sprite_get_texture(_texture,0);
	gpu_set_tex_repeat_ext(s_texture,true);
	
	texture_set_stage(s_normal,n_tex);
	texture_set_stage(s_roughness,r_tex);
	texture_set_stage(s_texture,t_tex);
	
	shader_set_uniform_f(u_normal_strength,_n_strength);
	shader_set_uniform_f(u_roughness_strength,_r_strength);
	
	var ratio_x = sprite_get_width(_texture) / surface_get_width(_surface);
	var ratio_y = sprite_get_height(_texture) / surface_get_height(_surface);
	shader_set_uniform_f(u_texture_ratio,ratio_x,ratio_y);
	
	var scale_multiply = surface_get_width(_surface) / sprite_get_width(_texture)
	
	var scale_x = scale_multiply * _scale;
	var scale_y = scale_multiply * _scale / ((surface_get_width(_surface) / surface_get_height(_surface)) / (sprite_get_width(_texture) / sprite_get_height(_texture)  ));
	shader_set_uniform_f(u_texture_scale,scale_x,scale_y);
	
	var tex_offset_x = (_x - (global.camera.get_x() * _offset_scale) ) / sprite_get_width(_texture);
	var tex_offset_y = (_y - (global.camera.get_y() * _offset_scale) ) / sprite_get_height(_texture);
	
	shader_set_uniform_f(u_texture_offset,tex_offset_x,tex_offset_y);
		
	var matrix_base = matrix_get(matrix_world);
	var new_mat = matrix_build(_x, _y, 0, 0, 0, _rot, _xscale, _yscale, 1);
	matrix_set(matrix_world, new_mat);
	draw_surface_ext(_surface,-_origin_x,-_origin_y,1,1,0,white,1);
	matrix_set(matrix_world, matrix_base);

	shader_reset();
}
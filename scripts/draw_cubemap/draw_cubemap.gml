function draw_sprite_cubemap(_sprite,_subimg,_x,_y,_texture,_n_strength = 0.5,_r_strength = 1,_scale = 1,_offset_scale = -0.25,_xscale=1,_yscale=1,_rot = 0, _opacity = 1.0){
	
	var s_texture =	shader_get_sampler_index(sh_shine,"s_Texture");

	//uniforms
	var u_normal_strength		= shader_get_uniform(sh_shine,"u_normal_strength");
	var u_roughness_strength	= shader_get_uniform(sh_shine,"u_roughness_strength");
	var u_dimensions			= shader_get_uniform(sh_shine,"u_dimensions");
	var u_texture_offset		= shader_get_uniform(sh_shine,"u_texture_offset");
	var u_texture_scale			= shader_get_uniform(sh_shine,"u_texture_scale");
	var u_opacity				= shader_get_uniform(sh_shine,"u_opacity");
	
	var u_texcoord_n = shader_get_uniform(sh_shine,"u_texcoord_n");
	var u_texcoord_r = shader_get_uniform(sh_shine,"u_texcoord_r");
		
	shader_set(sh_shine);
	
	shader_set_uniform_f(u_opacity,_opacity)
	
	var t_tex = sprite_get_texture(_texture,0);

	var sprite_name = sprite_get_name(_sprite);
	
	var uvs = sprite_get_uvs(_sprite,_subimg)
	
	//gets normal sprite coordinate offset
	var _normal = asset_get_index(sprite_name+"_n");
	if(_normal != -1){
		var uvs_n = sprite_get_uvs(_normal,_subimg)
		shader_set_uniform_f(u_texcoord_n,uvs[0]-uvs_n[0],uvs[1]-uvs_n[1]);
	} else {
		shader_set_uniform_f(u_texcoord_n,-1,-1);
	}
	
	//gets roughness sprite coordinate offset
	var _roughness = asset_get_index(sprite_name+"_r");
	if(_roughness != -1){
		var uvs_r = sprite_get_uvs(_roughness,_subimg)
		shader_set_uniform_f(u_texcoord_r,uvs[0]-uvs_r[0],uvs[1]-uvs_r[1]);
	} else {
		shader_set_uniform_f(u_texcoord_r,-1,-1);
	}
	
	gpu_set_tex_repeat_ext(s_texture,true);
	texture_set_stage(s_texture,t_tex);
	
	shader_set_uniform_f(u_normal_strength,_n_strength);
	shader_set_uniform_f(u_roughness_strength,_r_strength);
	
	shader_set_uniform_f(u_dimensions,sprite_get_width(_texture),sprite_get_height(_texture));
	shader_set_uniform_f(u_texture_scale,_scale);
	
	var tex_offset_x = (_x - (global.camera.get_x() * _offset_scale) ) / sprite_get_width(_texture);
	var tex_offset_y = (_y - (global.camera.get_y() * _offset_scale) ) / sprite_get_height(_texture);
	shader_set_uniform_f(u_texture_offset,tex_offset_x,tex_offset_y);
	
	//new matrix is to be able to draw sprite at different size or angle easily
	//var matrix_base = matrix_get(matrix_world);
	var new_mat = matrix_build(_x, _y, 0, 0, 0, _rot, _xscale, _yscale, 1);
	matrix_set(matrix_world, new_mat);
	
	draw_sprite(_sprite,_subimg,0,0)
	
	matrix_set(matrix_world, matrix_build_identity());

	shader_reset();	
}

function draw_tilemap_cubemap(_tilemap,_texture,_n_strength = 0.5,_r_strength = 1 ,_scale = 1 ,_offset_scale = -0.25, _opacity = 1.0){
	
	var _tileset = tilemap_get_tileset(_tilemap);
	
	var s_texture =	shader_get_sampler_index(sh_shine,"s_Texture");

	//uniforms
	var u_normal_strength		= shader_get_uniform(sh_shine,"u_normal_strength");
	var u_roughness_strength	= shader_get_uniform(sh_shine,"u_roughness_strength");
	var u_dimensions			= shader_get_uniform(sh_shine,"u_dimensions");
	var u_texture_offset		= shader_get_uniform(sh_shine,"u_texture_offset");
	var u_texture_scale			= shader_get_uniform(sh_shine,"u_texture_scale");
	var u_opacity				= shader_get_uniform(sh_shine,"u_opacity");
	
	var u_texcoord_n = shader_get_uniform(sh_shine,"u_texcoord_n");
	var u_texcoord_r = shader_get_uniform(sh_shine,"u_texcoord_r");
		
	shader_set(sh_shine);
	
	shader_set_uniform_f(u_opacity,_opacity)
	
	var t_tex = sprite_get_texture(_texture,0);

	var tileset_name = tileset_get_name(_tileset);
	
	var uvs = tileset_get_uvs(_tileset)
	
	//gets normal sprite coordinate offset
	var _normal = asset_get_index(tileset_name+"_n");
	if(_normal != -1){
		var uvs_n = tileset_get_uvs(_normal)
		shader_set_uniform_f(u_texcoord_n,uvs[0]-uvs_n[0],uvs[1]-uvs_n[1]);
	} else {
		shader_set_uniform_f(u_texcoord_n,-1,-1);
	}
	
	//gets roughness sprite coordinate offset
	var _roughness = asset_get_index(tileset_name+"_r");
	if(_roughness != -1){
		var uvs_r = tileset_get_uvs(_roughness)
		shader_set_uniform_f(u_texcoord_r,uvs[0]-uvs_r[0],uvs[1]-uvs_r[1]);
	} else {
		shader_set_uniform_f(u_texcoord_r,-1,-1);
	}
	
	gpu_set_tex_repeat_ext(s_texture,true);
	texture_set_stage(s_texture,t_tex);
	
	shader_set_uniform_f(u_normal_strength,_n_strength);
	shader_set_uniform_f(u_roughness_strength,_r_strength);
	
	shader_set_uniform_f(u_dimensions,sprite_get_width(_texture),sprite_get_height(_texture));
	shader_set_uniform_f(u_texture_scale,_scale);
	
	var tex_offset_x = (global.camera.get_x() * _offset_scale) / sprite_get_width(_texture);
	var tex_offset_y = (global.camera.get_y() * _offset_scale) / sprite_get_height(_texture);
	shader_set_uniform_f(u_texture_offset,tex_offset_x,tex_offset_y);
	
	draw_tilemap(_tilemap,0,0)

	shader_reset();	
}
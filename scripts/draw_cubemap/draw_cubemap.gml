function draw_sprite_cubemap(_sprite,_subimg,_x,_y,_texture,_n_strength = 0.5,_r_strength = 1,_scale = 1,_offset_scale = -0.25,_xscale=1,_yscale=1,_rot = 0, _opacity = 1.0){
	if(global.draw_shine){
		var s_texture_ =	shader_get_sampler_index(sh_shine,"s_texture_");
		
		//uniforms
		var u_normal_strength_		= shader_get_uniform(sh_shine,"u_normal_strength_");
		var u_roughness_strength_	= shader_get_uniform(sh_shine,"u_roughness_strength_");
		var u_dimensions_			= shader_get_uniform(sh_shine,"u_dimensions_");
		var u_texture_offset_		= shader_get_uniform(sh_shine,"u_texture_offset_");
		var u_texture_scale_			= shader_get_uniform(sh_shine,"u_texture_scale_");
		var u_opacity_				= shader_get_uniform(sh_shine,"u_opacity_");
		
		var u_texcoord_n_ = shader_get_uniform(sh_shine,"u_texcoord_n_");
		var u_texcoord_r_ = shader_get_uniform(sh_shine,"u_texcoord_r_");
			
		shader_set(sh_shine);
		
		shader_set_uniform_f(u_opacity_,_opacity)
		
		var t_tex_ = sprite_get_texture(_texture,0);
		
		var sprite_name_ = sprite_get_name(_sprite);
		
		var uvs_ = sprite_get_uvs(_sprite,_subimg)
		
		//gets normal sprite coordinate offset
		var normal_ = asset_get_index(sprite_name_+"_n");
		if(normal_ != -1){
			var uvs_n_ = sprite_get_uvs(normal_,_subimg)
			shader_set_uniform_f(u_texcoord_n_,uvs_[0]-uvs_n_[0],uvs_[1]-uvs_n_[1]);
		} else {
			shader_set_uniform_f(u_texcoord_n_,-1,-1);
		}
		
		//gets roughness sprite coordinate offset
		var roughness_ = asset_get_index(sprite_name_+"_r");
		if(roughness_ != -1){
			var uvs_r_ = sprite_get_uvs(roughness_,_subimg)
			shader_set_uniform_f(u_texcoord_r_,uvs_[0]-uvs_r_[0],uvs_[1]-uvs_r_[1]);
		} else {
			shader_set_uniform_f(u_texcoord_r_,-1,-1);
		}
		
		gpu_set_tex_repeat_ext(s_texture_,true);
		texture_set_stage(s_texture_,t_tex_);
		
		shader_set_uniform_f(u_normal_strength_,_n_strength);
		shader_set_uniform_f(u_roughness_strength_,_r_strength);
		
		shader_set_uniform_f(u_dimensions_,sprite_get_width(_texture),sprite_get_height(_texture));
		shader_set_uniform_f(u_texture_scale_,_scale);
		
		var tex_offset_x_ = (_x - (global.camera.get_x() * _offset_scale) ) / sprite_get_width(_texture);
		var tex_offset_y_ = (_y - (global.camera.get_y() * _offset_scale) ) / sprite_get_height(_texture);
		shader_set_uniform_f(u_texture_offset_,tex_offset_x_,tex_offset_y_);
		
		var new_mat_ = matrix_build(_x, _y, 0, 0, 0, _rot, _xscale, _yscale, 1);
		matrix_set(matrix_world, new_mat_);
		
		draw_sprite(_sprite,_subimg,0,0)
		
		matrix_set(matrix_world, matrix_build_identity());
		
		shader_reset();	
	} else {
		draw_sprite_ext(_sprite,_subimg,_x,_y,_xscale,_yscale,_rot, -1, _opacity)
	}
}

function draw_tilemap_cubemap(_tilemap,_texture,_n_strength = 0.5,_r_strength = 0.6 ,_scale = 1 ,_offset_scale = 0.55, _opacity = 1.0, _depth = 1.){
	if(global.draw_shine){
        #region old code
        //var camx = global.camera.get_x();
        //var camy = global.camera.get_y();
        //
		//var _tileset = tilemap_get_tileset(_tilemap);
        //var tileset_name = tileset_get_name(_tileset);
		//var uvs_ = tileset_get_uvs(_tileset)
		//
		//var s_texture_ =	shader_get_sampler_index(sh_shine,"s_texture_");
		//
		////uniforms
		//var u_normal_strength_		= shader_get_uniform(sh_shine,"u_normal_strength_");
		//var u_roughness_strength_	= shader_get_uniform(sh_shine,"u_roughness_strength_");
		//var u_dimensions_			= shader_get_uniform(sh_shine,"u_dimensions_");
		//var u_texture_offset_		= shader_get_uniform(sh_shine,"u_texture_offset_");
		//var u_texture_scale_			= shader_get_uniform(sh_shine,"u_texture_scale_");
		//var u_opacity_				= shader_get_uniform(sh_shine,"u_opacity_");
		//
		//var u_texcoord_n_ = shader_get_uniform(sh_shine,"u_texcoord_n_");
		//var u_texcoord_r_ = shader_get_uniform(sh_shine,"u_texcoord_r_");
        //var u_texcoord_d = shader_get_uniform(sh_shine,"u_texcoord_d");
			//
		//shader_set(sh_shine);
        //
        ////depth map
        //var srf_depth = surface_create(global.game_w,global.game_h);
        //surface_set_target(srf_depth);
        //draw_clear(black);
         //
        ////gets depthness sprite coordinate offset
		//var _depthness = asset_get_index(tileset_name+"_d");
		//if(_depthness != -1){
			//var uvs_d = tileset_get_uvs(_depthness)
			//shader_set_uniform_f(u_texcoord_d,uvs_[0]-uvs_d[0],uvs_[1]-uvs_d[1]);
            //
            //draw_tilemap(_tilemap,-camx,-camy);
            //
		//} 
        //
        ////after depthmap has been drawn, texcoord is reset, so the shader knows to do the rest
        //shader_set_uniform_f(u_texcoord_d,-1);
        //
        //surface_reset_target()
        //
        ////rest of the shine shader
        //var srf_tiles = surface_create(global.game_w,global.game_h);
        //surface_set_target(srf_tiles);
		//
		//shader_set_uniform_f(u_opacity_,_opacity)
		//
		//var t_tex_ = sprite_get_texture(_texture,0);
		//
		////gets normal sprite coordinate offset
		//var normal_ = asset_get_index(tileset_name+"_n");
		//if(normal_ != -1){
			//var uvs_n_ = tileset_get_uvs(normal_)
			//shader_set_uniform_f(u_texcoord_n_,uvs_[0]-uvs_n_[0],uvs_[1]-uvs_n_[1]);
		//} else {
			//shader_set_uniform_f(u_texcoord_n_,0,0);
		//}
		//
		////gets roughness sprite coordinate offset
		//var roughness_ = asset_get_index(tileset_name+"_r");
		//if(roughness_ != -1){
			//var uvs_r_ = tileset_get_uvs(roughness_)
			//shader_set_uniform_f(u_texcoord_r_,uvs_[0]-uvs_r_[0],uvs_[1]-uvs_r_[1]);
		//} else {
			//shader_set_uniform_f(u_texcoord_r_,0,0);
		//}
		//
		//gpu_set_texrepeat(true);
		//texture_set_stage(s_texture_,t_tex_);
		//
		//shader_set_uniform_f(u_normal_strength_,_n_strength);
		//shader_set_uniform_f(u_roughness_strength_,_r_strength);
		//
		//shader_set_uniform_f(u_dimensions_,sprite_get_width(_texture),sprite_get_height(_texture));
		//shader_set_uniform_f(u_texture_scale_,_scale);
		//
		//var tex_offset_x_ = (camx * _offset_scale) / sprite_get_width(_texture);
		//var tex_offset_y_ = (camy * _offset_scale) / sprite_get_height(_texture);
		//shader_set_uniform_f(u_texture_offset_,tex_offset_x_,tex_offset_y_);
		//
		//draw_tilemap(_tilemap,-camx,-camy);
		//
		//gpu_set_texrepeat(false);
		//shader_reset();
        //surface_reset_target();
        //
        ////depth shader
        //
        //shader_set(sh_tile_depth)
        //var u_depth = shader_get_uniform(sh_tile_depth,"u_depth");
        //var s_depth = shader_get_sampler_index(sh_tile_depth,"s_depth");
        //
        //shader_set_uniform_f(u_depth,_depth);
        //
        //var s_depthmap = surface_get_texture(srf_depth);
        //texture_set_stage(s_depth,s_depthmap);
        //surface_free(srf_depth);
        //
        //draw_surface(srf_tiles,camx,camy);
        //
        //surface_free(srf_tiles);
        //
        //shader_reset();
        #endregion
        
        
        
        
	} else {
		draw_tilemap(_tilemap,0,0)	
	}
}
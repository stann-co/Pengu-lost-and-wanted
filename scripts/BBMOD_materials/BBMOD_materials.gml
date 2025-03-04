function material(_texture = sprite_get_texture(spr_white,0)) constructor {
	BaseOpacity = _texture;
	static apply = function(_vertexFormat){
		shader_set(sh_3d);
		var s_matcap = shader_get_sampler_index(sh_3d,"s_matcap");
		texture_set_stage(s_matcap,sprite_get_texture(spr_matcap_bubble,0));
		return true;
	}
}

function material_animated(_texture = sprite_get_texture(spr_white,0)) constructor {
	BaseOpacity = _texture;
	static apply = function(_vertexFormat){
		shader_set(sh_3d_animated);
		var s_matcap = shader_get_sampler_index(sh_3d_animated,"s_matcap");
		texture_set_stage(s_matcap,sprite_get_texture(spr_matcap_bubble,0));
		return true;
	}
}

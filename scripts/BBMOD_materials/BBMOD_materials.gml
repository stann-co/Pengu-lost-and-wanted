/// Feather ignore all

function material(_texture = sprite_get_texture(spr_white,0)) constructor {
	BaseOpacity = _texture;
	static apply = function(_vertexFormat){
		shader_set(sh_3d);
		var s_texture = shader_get_sampler_index(sh_3d,"s_texture");
		texture_set_stage(s_texture,BaseOpacity);
		return true;
	}
}

function material_matcap(_texture = sprite_get_texture(spr_white,0)) constructor {
	BaseOpacity = _texture;
	static apply = function(_vertexFormat){
		shader_set(sh_3d_matcap);
		var s_matcap = shader_get_sampler_index(sh_3d_matcap,"s_matcap");
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


///unique materials
function material_policesiren() constructor {
	BaseOpacity = 1.;
	static apply = function(_vertexFormat){
		shader_set(sh_3d_policesiren);
		return true;
	}
}


function draw_sprite_wavey(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,_opacity = 1,_speed = 0.2,_x_freq = 10000, _x_size = 0.05){
	
	var uvs_ = sprite_get_uvs(_sprite,_subimg);
	
	var u_sprite_size_ = shader_get_uniform(sh_wave,"u_spriteSize");
	
	var u_speed_ = shader_get_uniform(sh_wave,"u_speed");
	var u_time_ = shader_get_uniform(sh_wave,"u_time");
	var u_x_frequency_ = shader_get_uniform(sh_wave,"u_xFrequency");
	var u_x_size_ = shader_get_uniform(sh_wave,"u_xSize");

	shader_set(sh_wave)
	shader_set_uniform_f(u_sprite_size_,uvs_[2]-uvs_[0],uvs_[3]-uvs_[1]);
	shader_set_uniform_f(u_speed_,_speed);
	shader_set_uniform_f(u_time_,global.t);
	shader_set_uniform_f(u_x_frequency_,_x_freq);
	shader_set_uniform_f(u_x_size_,_x_size);
	
	draw_sprite_ext(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,WHITE,_opacity);
	shader_reset();
}

function draw_sprite_uv_move(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,_opacity = 1,_x_speed = 0.2,_y_speed = 0.2){
	
	
	var uvs_ = sprite_get_uvs(_sprite,_subimg);
	
	var u_sprite_size_ = shader_get_uniform(sh_wave,"u_spriteSize");
	var u_speed_ = shader_get_uniform(sh_wave,"u_speed");
	var u_time_ = shader_get_uniform(sh_wave,"u_time");
	
	gpu_set_tex_repeat(true);
	
	shader_set(sh_uv_move)
	shader_set_uniform_f(u_sprite_size_,uvs_[2]-uvs_[0],uvs_[3]-uvs_[1]);
	shader_set_uniform_f(u_speed_,_x_speed,_y_speed);
	shader_set_uniform_f(u_time_,global.t);
	
	
	draw_sprite_ext(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,WHITE,_opacity);
	
	shader_reset()
	gpu_set_tex_repeat(false);

}
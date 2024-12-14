function draw_sprite_wavey(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,_opacity = 1,_speed = 0.2,_x_freq = 10000, _x_size = 0.05){
	
	var uvs = sprite_get_uvs(_sprite,_subimg);
	
	u_spriteSize = shader_get_uniform(sh_wave,"u_spriteSize");
	
	u_speed = shader_get_uniform(sh_wave,"u_speed");
	u_time = shader_get_uniform(sh_wave,"u_time");
	u_xFrequency = shader_get_uniform(sh_wave,"u_xFrequency");
	u_xSize = shader_get_uniform(sh_wave,"u_xSize");

	shader_set(sh_wave)
	shader_set_uniform_f(u_spriteSize,uvs[2]-uvs[0],uvs[3]-uvs[1]);
	shader_set_uniform_f(u_speed,_speed);
	shader_set_uniform_f(u_time,global.t);
	shader_set_uniform_f(u_xFrequency,_x_freq);
	shader_set_uniform_f(u_xSize,_x_size);
	
	draw_sprite_ext(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,white,_opacity);
	shader_reset()

}

function draw_sprite_uv_move(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,_opacity = 1,_xSpeed = 0.2,_ySpeed = 0.2){
	
	
	var uvs = sprite_get_uvs(_sprite,_subimg);
	
	u_spriteSize = shader_get_uniform(sh_wave,"u_spriteSize");
	u_speed = shader_get_uniform(sh_wave,"u_speed");
	u_time = shader_get_uniform(sh_wave,"u_time");
	
	gpu_set_tex_repeat(true);
	
	shader_set(sh_uv_move)
	shader_set_uniform_f(u_spriteSize,uvs[2]-uvs[0],uvs[3]-uvs[1]);
	shader_set_uniform_f(u_speed,_xSpeed,_ySpeed);
	shader_set_uniform_f(u_time,global.t);
	
	
	draw_sprite_ext(_sprite,_subimg,_x,_y,_xscale,_yscale,_angle,white,_opacity);
	
	shader_reset()
	gpu_set_tex_repeat(false);

}
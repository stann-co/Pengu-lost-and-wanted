///@function draw_percentage_donut
function draw_percentage_donut(_completion,_radius,_x,_y,_col1=WHITE,_col2=GREEN){
	
	var surf_ = surface_create(_radius*2,_radius*2)	
	surface_set_target(surf_);

	draw_clear_alpha(WHITE,0);
	draw_sprite_stretched(spr_donut,0,0,0,_radius*2,_radius*2);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_zero);

	shader_set(sh_clip_gradient)
	
	var u_percentage_ = shader_get_uniform(sh_clip_gradient,"percentage");
	shader_set_uniform_f(u_percentage_,
		_completion
	)
	
	var u_color1_ = shader_get_uniform(sh_clip_gradient,"color1");
	shader_set_uniform_f(u_color1_,
		color_get_red(_col1)/255,
		color_get_green(_col1)/255,
		color_get_blue(_col1)/255
	)
	
	var u_color2_ = shader_get_uniform(sh_clip_gradient,"color2");
	shader_set_uniform_f(u_color2_,
		color_get_red(_col2)/255,
		color_get_green(_col2)/255,
		color_get_blue(_col2)/255
	)

	draw_sprite_stretched(spr_conic_gradient,0,0,0,_radius*2,_radius*2);
	gpu_set_blendmode(bm_normal);
	shader_reset();
	
	surface_reset_target()

	draw_surface(surf_,_x-_radius,_y-_radius)
	
	surface_free(surf_);
}
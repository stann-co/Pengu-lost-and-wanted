///@function draw_percentage_donut
function draw_percentage_donut(completion,radius,x_,y_,col1=white,col2=green){
	
	var surf = surface_create(radius*2,radius*2)	
	surface_set_target(surf);

	draw_clear_alpha(white,0);
	draw_sprite_stretched(spr_donut,0,0,0,radius*2,radius*2);
	gpu_set_blendmode_ext(bm_dest_alpha,bm_zero);

	shader_set(sh_clip_gradient)
	
	var u_percentage = shader_get_uniform(sh_clip_gradient,"percentage");
	shader_set_uniform_f(u_percentage,
		completion
	)
	
	var u_color1 = shader_get_uniform(sh_clip_gradient,"color1");
	shader_set_uniform_f(u_color1,
		color_get_red(col1)/255,
		color_get_green(col1)/255,
		color_get_blue(col1)/255
	)
	
	var u_color2 = shader_get_uniform(sh_clip_gradient,"color2");
	shader_set_uniform_f(u_color2,
		color_get_red(col2)/255,
		color_get_green(col2)/255,
		color_get_blue(col2)/255
	)

	draw_sprite_stretched(spr_conic_gradient,0,0,0,radius*2,radius*2);
	gpu_set_blendmode(bm_normal);
	shader_reset();
	
	surface_reset_target()

	draw_surface(surf,x_-radius,y_-radius)
	
	surface_free(surf);
}
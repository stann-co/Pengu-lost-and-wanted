/// @description
stanncam_init(576,324,1920*0.8,1080*0.8);
global.camera = new stanncam(global.game_w,global.game_h);
global.camera.room_constrain = true;

global.camera.bounds_w = 2;
global.camera.bounds_h = 2;

global.background = function(){ //empty background function, gets replaced in each level

}

zoom_level = 1;


draw_sprite_layer = function(layer_name_,parralax_){
	
	var scalex = 1/stanncam_get_res_scale_x();
	var scaley = 1/stanncam_get_res_scale_y();
	
	layer_name = layer_name_;
	parralax = parralax_;
	
	if(layer_exists(layer_name)){
		
		global.camera.draw_special(function(){
			
			draw_layer_parralaxed(layer_name,parralax);
			
		},0,0,global.res_w,global.res_h,scalex,scaley);
	}
}
	
	
final_surface = surface_create(window_get_width(),window_get_height());
	
//shader vars

srf_bloom_loom = -1;
srf_blur_hor = -1;
srf_blur_ver = -1;
srf_bloom = -1;

u_bloom_threshold		= shader_get_uniform(sh_bloom_loom, "bloom_threshold");
u_bloom_range			= shader_get_uniform(sh_bloom_loom, "bloom_range");

u_blur_steps	= shader_get_uniform(sh_blur, "blur_steps");
u_blur_vector	= shader_get_uniform(sh_blur, "blur_vector");
u_texel_size	= shader_get_uniform(sh_blur, "texel_size");
u_sigma			= shader_get_uniform(sh_blur, "sigma");

u_bloom_intensity		= shader_get_uniform(sh_bloom_blend, "bloom_intensity");
u_bloom_darken			= shader_get_uniform(sh_bloom_blend, "bloom_darken");
u_bloom_saturation		= shader_get_uniform(sh_bloom_blend, "bloom_saturation");
u_bloom_texture			= shader_get_sampler_index(sh_bloom_blend, "bloom_texture");

bloom_texture			= -1;

texel_w			= 1 / window_get_width();
texel_h			= 1 / window_get_height();

blur_steps_D	= 30.0;		// blur steps for discrete samples
sigma_D			= 0.2;		// sigma for discrete samples
bloom_threshold = 0.293;
bloom_range		= 0.467;
bloom_intensity	= 0.23;
bloom_darken	= 1.0;
bloom_saturation= 2.0;


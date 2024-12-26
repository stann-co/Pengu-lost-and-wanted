/// @description
//var game_res = stanncam_get_preset_resolution(STANNCAM_RES_PRESETS.PLAYSTATION_512_X_224)
stanncam_init(480,270,1920*0.8,1080*0.8);
stanncam_set_keep_aspect_ratio(true);

global.camera = new stanncam(global.game_w, global.game_h);
//global.camera.smooth_draw = false;
global.camera.surface_extra_on = true;
global.camera.room_constrain = true;
global.camera.bounds_w = 16;
global.camera.bounds_h = 4;
global.camera.spd = 1;
global.camera.spd_threshold = 1;


global.background = function(){ //empty background function, gets replaced in each level

}

//zoom_level = 1;

//draw_sprite_layer = function(layer_name_,parralax_){
	
//	var scalex = 1/stanncam_get_res_scale_x();
//	var scaley = 1/stanncam_get_res_scale_y();
	
//	layer_name = layer_name_;
//	parralax = parralax_;
	
//	if(layer_exists(layer_name)){
		
//		global.camera.draw_special(function(){
			
//			draw_layer_parralaxed(layer_name,parralax);
			
//		},0,0,global.res_w,global.res_h,scalex,scaley);
//	}
//}
	
#region shader vars

srf_game = -1;
srf_monitor = -1;

srf_crt_blur = -1;

//srf_bloom_loom = -1;
//srf_blur_hor = -1;
//srf_blur_ver = -1;
//srf_bloom = -1;
//
//u_bloom_threshold		= shader_get_uniform(sh_bloom_loom, "bloom_threshold");
//u_bloom_range			= shader_get_uniform(sh_bloom_loom, "bloom_range");

u_blur_steps	= shader_get_uniform(sh_blur, "blur_steps");
u_blur_vector	= shader_get_uniform(sh_blur, "blur_vector");
u_texel_size	= shader_get_uniform(sh_blur, "texel_size");
u_sigma			= shader_get_uniform(sh_blur, "sigma");

//u_bloom_intensity		= shader_get_uniform(sh_bloom_blend, "bloom_intensity");
//u_bloom_darken			= shader_get_uniform(sh_bloom_blend, "bloom_darken");
//u_bloom_saturation		= shader_get_uniform(sh_bloom_blend, "bloom_saturation");
//u_bloom_texture			= shader_get_sampler_index(sh_bloom_blend, "bloom_texture");

//bloom_texture			= -1;

texel_w			= 1 / window_get_width();
texel_h			= 1 / window_get_height();

blur_steps_D	= 30.0;		// blur steps for discrete samples
sigma_D			= 0.2;		// sigma for discrete samples
//bloom_threshold = 0.293;
//bloom_range		= 0.467;
//bloom_intensity	= 0.23;
//bloom_darken	= 1.0;
//bloom_saturation= 2.0;

//u_blend_texture			= shader_get_sampler_index(sh_bloom_blend, "bloom_texture");

#endregion

//background
bg_speed_x = 2;
bg_speed_y = 0;
bg_x = 0;
bg_y = 0;
bg_layer = -1

#region debugging
	//dbg_section("Shaders")
	//dbg_slider(ref_create(self,"blur_steps_D"),0,30);
	//dbg_slider(ref_create(self,"sigma_D"),0,1);
	//dbg_slider(ref_create(camera,"bloom_threshold"),0,1);
	//dbg_slider(ref_create(camera,"bloom_range"),0,1);
	//dbg_slider(ref_create(camera,"bloom_intensity"),0,2);
	//dbg_slider(ref_create(camera,"bloom_darken"),0,1);
	//dbg_slider(ref_create(camera,"bloom_saturation"),0,2);
	
	
	//dbg_slider(ref_create(self, "crt_scale"),0,400,"CRT scale");
	//dbg_slider(ref_create(self, "crt_radius"),0.001,4,"CRT radius");
	//dbg_slider(ref_create(self, "crt_sharpness"),0,4,"CRT sharpness");
	//dbg_slider(ref_create(self, "crt_test1"),0,4,"CRT test1");
	//dbg_slider(ref_create(self, "crt_test2"),0,2,"CRT test2");
#endregion


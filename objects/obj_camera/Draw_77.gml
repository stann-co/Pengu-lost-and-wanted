/// @description

var image_w			= window_get_width();
var image_h			= window_get_height();

if(!surface_exists(final_surface)){
	final_surface = surface_create(image_w,image_h);
}

surface_set_target(final_surface);

//the parralax drawing is scaled down again
var scalex = 1/stanncam_get_res_scale_x();
var scaley = 1/stanncam_get_res_scale_y();

draw_clear(white);
global.camera.draw_special(global.background,0,0,global.res_w,global.res_h,scalex,scaley);
//background sprites
draw_sprite_layer("background_sprites_2",-0.06);
draw_sprite_layer("background_sprites_1",-0.04);
global.camera.draw(0,0);
//foreground sprites
draw_sprite_layer("foreground_sprites_2",0.06);
draw_sprite_layer("foreground_sprites_1",0.04);
surface_reset_target();



var blur_steps		= ceil(blur_steps_D / 2);			// only half the steps needed when lerping
var kernel_D		= 2 * blur_steps_D + 1;
var kernel			= 2 * blur_steps + 1;
var sigma			= sigma_D * kernel_D / kernel;		// multiply by 2 and kernel ratio to get the same strength as in discrete sampling

// Create pass surfaces and resize if needed:
if (!surface_exists(srf_bloom_loom)) {
	srf_bloom_loom = surface_create(image_w, image_h);
}	
if (!surface_exists(srf_blur_hor)) {
	srf_blur_hor = surface_create(image_w, image_h);
}
if (!surface_exists(srf_blur_ver)) {
	srf_blur_ver = surface_create(image_w, image_h);
	bloom_texture = surface_get_texture(srf_blur_ver);
}
if (!surface_exists(srf_bloom)) {
	srf_bloom = surface_create(image_w, image_h);
}
	
// 1st pass: Draw brights to bloom surface:
// final_surface -> srf_bloom_loom
shader_set(sh_bloom_loom);
shader_set_uniform_f(u_bloom_threshold,		bloom_threshold);
shader_set_uniform_f(u_bloom_range,			bloom_range);

surface_set_target(srf_bloom_loom);
draw_surface(final_surface,0,0);

var tex_filter = gpu_get_tex_filter();
surface_reset_target();

// 2nd pass: horizontal:
// srf_bloom_loom -> srf_blur_hor
gpu_set_tex_filter(true);
shader_set(sh_blur);

shader_set_uniform_f(u_blur_steps, blur_steps);			// half of the blur kernel size, whole number >= 1
shader_set_uniform_f(u_sigma, sigma);					// lower sigma: less blur, but less blocky
shader_set_uniform_f(u_blur_vector, 1, 0);				// 1,0: horizontal blur | 0,1: vertical blur
shader_set_uniform_f(u_texel_size, texel_w, texel_h);

surface_set_target(srf_blur_hor);
draw_surface(srf_bloom_loom,0,0);
surface_reset_target();
	
// 3rd pass: vertical
// srf_blur_hor -> srf_blur_ver
shader_set_uniform_f(u_blur_vector, 0, 1);				// 1,0: horizontal blur | 0,1: vertical blur

surface_set_target(srf_blur_ver);
draw_surface(srf_blur_hor, 0, 0);
surface_reset_target();
shader_reset();
gpu_set_tex_filter(false);

// 4th pass: Blend bloom surface with final_surface
// final_surface & srf_blur_ver -> screen
shader_set(sh_bloom_blend);

	shader_set_uniform_f(u_bloom_intensity, bloom_intensity);
	shader_set_uniform_f(u_bloom_darken, bloom_darken);
	shader_set_uniform_f(u_bloom_saturation, bloom_saturation);
	texture_set_stage(u_bloom_texture, bloom_texture);
	gpu_set_tex_filter_ext(u_bloom_texture, true);
	
	draw_surface(final_surface, 0, 0);
	gpu_set_tex_filter(false);
	
shader_reset();
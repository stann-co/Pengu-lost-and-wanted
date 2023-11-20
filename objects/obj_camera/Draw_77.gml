/// @description

if(!surface_exists(final_surface)){
	final_surface = surface_create(global.res_w,global.res_h);
}

surface_set_target(final_surface);

//the parralax drawing is scaled down again
var scalex = 1/stanncam_get_res_scale_x();
var scaley = 1/stanncam_get_res_scale_y();

draw_clear(white);


global.camera.draw_special(global.background,0,0,global.res_w,global.res_h,scalex,scaley,function(){
	shader_set(sh_blur)
	var u_blur = shader_get_uniform(sh_blur,"size")
	shader_set_uniform_f(u_blur,blursize,blursize,radius);	
});
shader_reset()

//background sprites
draw_sprite_layer("background_sprites_2",-0.06);
draw_sprite_layer("background_sprites_1",-0.04);

global.camera.draw(0,0);

//foreground sprites
draw_sprite_layer("foreground_sprites_2",0.06);
draw_sprite_layer("foreground_sprites_1",0.04);

surface_reset_target();

draw_surface(final_surface,0,0);

shader_reset();

draw_text(0,100,radius);
draw_text(0,200,blursize);
/// @description

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
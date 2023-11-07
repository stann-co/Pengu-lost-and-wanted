/// @description

var width = global.res_w;
var height = global.res_h;

//the parralax drawing is scaled down again
var scalex = 1/stanncam_get_res_scale_x();
var scaley = 1/stanncam_get_res_scale_y();

//if(!global.debug){

draw_clear(white);


	global.camera.draw_special(global.background,0,0,width,height,scalex,scaley);
//}
global.camera.draw(0,0);




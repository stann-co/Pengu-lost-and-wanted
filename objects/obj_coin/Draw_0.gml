/// @description

var t = (global.t mod duration) / duration

var y_offset = animcurve_read(ac_coin,0,t) * y_offset_max;
var rot_offset = animcurve_read(ac_coin,1,t) * rot_offset_max;

draw_sprite_ext(sprite,0,x,y+y_offset,1,1,rot_offset,-1,1);











/// @description
var spd_			= 0.08;
var x_frequency_	= 20.0;
var x_size_		= 0.005;

var val_ = animcurve_read(ac_squish2,0,squish_t/squish_dur);

var xscale_ = lerp(1,0.95,val_);
var yscale_ = lerp(1,1.11,val_);

draw_sprite_wavey(spr_winter_tree1,2,x,y,xscale_,yscale_,image_angle,1,spd_,x_frequency_,x_size_) //leaves
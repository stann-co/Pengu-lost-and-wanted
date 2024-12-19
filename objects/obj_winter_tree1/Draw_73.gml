/// @description
var spd			= 0.08;
var xFrequency	= 20.0;
var xSize		= 0.005;

var val = animcurve_read(ac_squish2,0,squish_t/squish_dur);

var xscale = lerp(1,0.95,val);
var yscale = lerp(1,1.11,val);

draw_sprite_wavey(spr_winter_tree1,2,x,y,xscale,yscale,image_angle,1,spd,xFrequency,xSize) //leaves
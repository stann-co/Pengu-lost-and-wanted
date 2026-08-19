/// @description

if(reveal && t < duration) t ++;
else if (t > 0) t --;

var val = animcurve_read(ac_basic,0,t/duration);

global.tile_draw_layers[? layer_name].opacity = 1 - val;

reveal = false;
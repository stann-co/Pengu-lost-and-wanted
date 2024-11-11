/// @description
var rope_length = 90;
var rope_segments = 16;

var x_offset = (sprite_width / 2) - 15;

rope1 = new verlet_rope(x-x_offset,y,x-x_offset,y-rope_length,rope_segments);
rope2 = new verlet_rope(x-x_offset,y,x-x_offset,y-rope_length,rope_segments);
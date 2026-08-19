/// @description
var rope_length_ = 90;
var rope_segments_ = 16;

var x_offset_ = (sprite_width / 2) - 15;

rope1 = verlet_rope(x-x_offset_,y,x-x_offset_,y-rope_length_,rope_segments_);
rope2 = verlet_rope(x-x_offset_,y,x-x_offset_,y-rope_length_,rope_segments_);
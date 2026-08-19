//offset-only parallax - unlike obj_tilemap, the sprite itself doesn't get
//scaled, just shifted away from screen center by the same amount obj_tilemap's
//view-matrix scale would move a point at this position
var effective_parralax_ = parralax_effective(parralax);
var scale_ = effective_parralax_ / TILE_SIZE;
var origin_ = parralax_offset(0, 0, effective_parralax_);

//pixel-snap only the camera-driven shift (shared by every sprite on this
//parralax) so instances move in lockstep - snapping each instance's own
//final position instead made them snap to pixels at different times
var x_ = x * scale_ + round(origin_.x);
var y_ = y * scale_ + round(origin_.y);

draw_sprite_ext(sprite_index,image_index,x_,y_,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
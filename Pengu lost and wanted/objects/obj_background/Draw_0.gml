if (sprite_index == -1) exit;

if (background_mode == BACKGROUND_MODE.FILL) {
	var x_ = global.camera.view_to_room_x(0);
	var y_ = global.camera.view_to_room_y(0);
	draw_sprite_stretched_ext(sprite_index,image_index,x_,y_,global.game_w,global.game_h,image_blend,image_alpha);
} else {

	//offset-only parallax - the sprite doesn't get scaled or repositioned by
	//parralax itself, just shifted by the camera-driven origin; x/y stays a
	//fixed offset regardless of the parralax value
	var origin_ = parralax_offset(0, 0, parralax_effective(parralax_x), parralax_effective(parralax_y));

	//pixel-snap only the camera-driven shift (shared by every sprite on this
	//parralax) so instances move in lockstep - snapping each instance's own
	//final position instead made them snap to pixels at different times
	var x_ = x + round(origin_.x);
	var y_ = y + round(origin_.y);

	if (background_mode == BACKGROUND_MODE.TILED) {
		//draw_sprite_tiled_ext has no angle parameter - tiling only supports offset/scale
		draw_sprite_tiled_ext(sprite_index,image_index,x_,y_,image_xscale,image_yscale,image_blend,image_alpha);
	} else {
		draw_sprite_ext(sprite_index,image_index,x_,y_,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
}
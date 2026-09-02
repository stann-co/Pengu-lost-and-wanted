/// @desc scales how far _parralax deviates from _baseline ("no depth") by
/// global.parralax - 0 collapses to _baseline (off, not a zero scale),
/// 1 leaves _parralax unchanged, 2 doubles the deviation
function parralax_effective(_parralax, _baseline = TILE_SIZE){
	return _baseline + (_parralax - _baseline) * global.parralax;
}

/// @desc offsets _x,_y away from the camera center by _parralax_x/_parralax_y
/// over TILE_SIZE (TILE_SIZE = no offset) per axis - also its own inverse:
/// pass in (TILE_SIZE*TILE_SIZE)/_parralax_x and .../_parralax_y to undo it
/// (eg. mouse -> world position); _parralax_y defaults to _parralax_x for
/// callers that still want a single uniform value
function parralax_offset(_x, _y, _parralax_x, _parralax_y = _parralax_x){
	var scale_x_ = _parralax_x / TILE_SIZE;
	var scale_y_ = _parralax_y / TILE_SIZE;
	var center_x_ = global.camera.get_x() + global.camera.width * 0.5;
	var center_y_ = global.camera.get_y() + global.camera.height * 0.5;
	return {
		x : center_x_ + (_x - center_x_) * scale_x_,
		y : center_y_ + (_y - center_y_) * scale_y_,
	};
}

function parralax_snapped(_x,_y,_parralax_x = 16,_parralax_y = _parralax_x){
	//offset-only parallax - unlike obj_tilemap, the sprite itself doesn't get
	//scaled, just shifted away from screen center by the same amount obj_tilemap's
	//view-matrix scale would move a point at this position

	var effective_parralax_x_ = parralax_effective(_parralax_x);
	var effective_parralax_y_ = parralax_effective(_parralax_y);
	var scale_x_ = effective_parralax_x_ / TILE_SIZE;
	var scale_y_ = effective_parralax_y_ / TILE_SIZE;
	var origin_ = parralax_offset(0, 0, effective_parralax_x_, effective_parralax_y_);

	//pixel-snap only the camera-driven shift (shared by every sprite on this
	//parralax) so instances move in lockstep - snapping each instance's own
	//final position instead made them snap to pixels at different times
	var x_ = _x * scale_x_ + round(origin_.x);
	var y_ = _y * scale_y_ + round(origin_.y);
	
	return {
		x: x_,
		y: y_
	}
	
}
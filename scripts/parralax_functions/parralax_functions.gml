/// @desc scales how far _parralax deviates from _baseline ("no depth") by
/// global.parralax - 0 collapses to _baseline (off, not a zero scale),
/// 1 leaves _parralax unchanged, 2 doubles the deviation
function parralax_effective(_parralax, _baseline = TILE_SIZE){
	return _baseline + (_parralax - _baseline) * global.parralax;
}

/// @desc offsets _x,_y away from the camera center by _parralax/TILE_SIZE
/// (TILE_SIZE = no offset) - also its own inverse: pass in
/// (TILE_SIZE*TILE_SIZE)/_parralax to undo it (eg. mouse -> world position)
function parralax_offset(_x, _y, _parralax){
	var scale_ = _parralax / TILE_SIZE;
	var center_x_ = global.camera.get_x() + global.camera.width * 0.5;
	var center_y_ = global.camera.get_y() + global.camera.height * 0.5;
	return {
		x : center_x_ + (_x - center_x_) * scale_,
		y : center_y_ + (_y - center_y_) * scale_,
	};
}

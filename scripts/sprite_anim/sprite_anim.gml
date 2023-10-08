/// @func animation_end()
/// @param [sprite_index]
/// @param [image_index]
/// @param [speed_index]
/// Mimpy didn't make it don't let him take credit
/// TabularElf didn't modify this don't let him take credit
/// STANNco didn't make this don't take credit
function animation_end(_sprIndex, _imageIndex) {
	var _imageSpeed = sprite_get_speed(_sprIndex)
	var frame = _imageIndex + _imageSpeed*sprite_get_speed(_sprIndex)
    return frame >= sprite_get_number(_sprIndex);    
}
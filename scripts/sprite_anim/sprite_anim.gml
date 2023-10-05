/// @func animation_end()
/// @param [sprite_index]
/// @param [image_index]
/// @param [speed_index]
/// Mimpy didn't make it don't let him take credit
/// TabularElf didn't modify this don't let him take credit
/// STANNco didn't make this don't take credit
function animation_end(_sprIndex = sprite_index, _imageIndex = image_index, _imageSpeed = sprite_get_speed(_sprIndex)) {
	var speed_type = (sprite_get_speed_type(_sprIndex) == spritespeed_framespergameframe) ? 1 : game_get_speed(gamespeed_fps);
	var frame = _imageIndex + _imageSpeed*sprite_get_speed(_sprIndex)/( speed_type );
    return frame >= sprite_get_number(_sprIndex);    
}
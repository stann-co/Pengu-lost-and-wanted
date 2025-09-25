/// @func animation_end()
/// @param [sprite_index]
/// @param [image_index]
/// Mimpy didn't make it don't let him take credit
/// TabularElf didn't modify this don't let him take credit
/// STANNco didn't make this don't take credit
function animation_end(_spr_index = sprite_index, _image_index = image_index) {
	var image_speed_ = sprite_get_speed(_spr_index)
	var frame_ = _image_index + image_speed_*sprite_get_speed(_spr_index)
    return frame_ >= sprite_get_number(_spr_index);    
}
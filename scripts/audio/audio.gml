///@function audio_play_sound_random
///@param {real} pitch
///@param {real} priority
///@param sounds...
function audio_play_sound_random(pitch = 1,priority = 0){
	var sound_count = argument_count - 3
	var sound = argument[irandom(sound_count) + 2];
	
	audio_play_sound(sound,priority,false)

}
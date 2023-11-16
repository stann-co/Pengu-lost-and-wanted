///@function audio_play_sound_random
///@param {real} pitch
///@param {real} priority
///@param sounds...
function audio_play_sound_random(pitch = 1,priority = 0){
	var sound_count = argument_count - 3
	var sound = argument[irandom(sound_count) + 2];
	
	audio_play_sound(sound,priority,false)

}

///@description resets all conductor beat variables
//function conductor_reset() {
//	global.process = 0;
//	global.step = 0;
//	global.steps = 0;
//
//	global.on_bar = false;
//	global.on_half_bar = false;
//	global.on_beat = false;
//	global.on_half_beat = false;
//	global.on_quad_beat = false;
//	global.on_eighth_beat = false;
//	
//	global.bpm_change = 0;
//	show_debug_message("reset")
//}

/// @function pitch_change(semitones)
/// @param	semitones
/// @description use with audio_sound_pitch to pitch up x amount of semitones
function pitch_change(semitones) {
	return power(power(2, (1/12)),semitones);
}

/// @function random_pitch
/// @description returns random pitch change from scale_pitch constant, use with audio_sound_pitch
//function random_pitch() {
//	var array = scale_pitches;
//	global.scale_pitches_i++;
//	if (global.scale_pitches_i == array_length(array)) global.scale_pitches_i = 0;
//	return pitch_change(array[global.scale_pitches_i]);
//}
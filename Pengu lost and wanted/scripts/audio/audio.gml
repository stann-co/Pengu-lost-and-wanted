///@function audio_play_sound_random
///@param {real} pitch_
///@param {real} priority
///@param sounds...
function audio_play_sound_random(_pitch = 1,_priority = 0){
	var sound_count_ = argument_count - 3
	var sound_ = argument[irandom(sound_count_) + 2];
	
	audio_play_sound(sound_,_priority,false)
}

///@function sound_play_random
///@param {real,array} sound_
///@param {real} pitch_bend
function sound_play_random(_sound,_pitch_bend){
    if(is_array(_sound)){
        var index_ = irandom_range(0,array_length(_sound)-1);
        _sound = _sound[index_];
    }
    
    var pitch_ = random_range(1-_pitch_bend,1+_pitch_bend);
    return audio_play_sound(_sound,1,false,1,0,pitch_)
}

/// @desc  resets all conductor beat variables  pitch_change(semitones)  use with audio_sound_pitch to pitch_ up x amount of semitones
/// @param {real} semitones
/// @returns {real}
function pitch_change(_semitones) {
	return power(power(2, (1/12)),_semitones);
}

/// @function random_pitch
/// @description returns random pitch_ change from scale_pitch constant, use with audio_sound_pitch
//function random_pitch() {
//	var array = scale_pitches;
//	global.scale_pitches_i++;
//	if (global.scale_pitches_i == array_length(array)) global.scale_pitches_i = 0;
//	return pitch_change(array[global.scale_pitches_i]);
//}

/// @function play_music
function play_music(_song){
	global.song = audio_play_sound(_song,1000,true);
}
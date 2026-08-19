/// @desc  animcurve_read()
/// @param {any*} animcurve
/// @param {any*} channel
/// @param {real} posx
/// @returns {real}
function animcurve_read(_animcurve,_channel,_posx){
	var animcurve_channel_ = animcurve_get_channel(_animcurve,_channel);
	return animcurve_channel_evaluate(animcurve_channel_,_posx)
}
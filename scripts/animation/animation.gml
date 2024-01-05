///@function animcurve_read()
function animcurve_read(animcurve,channel,posx){
	var animcurve_channel = animcurve_get_channel(animcurve,channel);
	return animcurve_channel_evaluate(animcurve_channel,posx)
}
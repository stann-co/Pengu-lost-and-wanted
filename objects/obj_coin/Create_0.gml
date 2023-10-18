/// @description
// Inherit the parent event
event_inherited();

trigger = function(){
	global.score++;
	instance_destroy();	
}
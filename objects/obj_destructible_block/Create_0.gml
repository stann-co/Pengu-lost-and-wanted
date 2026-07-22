event_inherited();

/// @description
trigger = function(){
	global.camera.shake_screen(4,SECOND*0.5);
	particle_burst(ps_block_explode);
	instance_destroy();
}

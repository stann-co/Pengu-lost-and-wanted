/// @description
trigger = function(){
	global.camera.shake_screen(4,GAME_SPEED*0.5);
	particle_burst(ps_block_explode);
	instance_destroy();
}
















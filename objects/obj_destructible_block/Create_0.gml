/// @description
trigger = function(){
	global.camera.shake_screen(4,game_speed*0.5);
	instance_create_depth(x,y,depth,obj_particle_host);
	instance_destroy();
}
















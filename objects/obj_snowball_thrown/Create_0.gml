event_inherited();

trigger = function(){
	global.camera.shake_screen(4,GAME_SPEED*0.5);
	with(obj_pengu){
		hurt(sign(x-other.x));
	}
	
	instance_destroy();
}

h_speed = 0;
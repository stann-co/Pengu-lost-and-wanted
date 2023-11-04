/// @description
stanncam_init(480,270,1920*0.8,1080*0.8);
global.camera = new stanncam(global.game_w,global.game_h);
global.camera.room_constrain = true;

global.camera.bounds_w = 2;
global.camera.bounds_h = 2;

global.background = function(){ //empty background function, gets replaced in each level
	
}

zoom_level = 1;
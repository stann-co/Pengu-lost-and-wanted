/// @description
stanncam_init(480,270,1920*0.8,1080*0.8);
global.camera = new stanncam(global.game_w,global.game_h);
global.camera.room_constrain = true;

global.camera.bounds_w = 2;
global.camera.bounds_h = 2;

global.background = function(){ //empty background function, gets replaced in each level

}

zoom_level = 1;


draw_sprite_layer = function(layer_name_,parralax_){
	
	var scalex = 1/stanncam_get_res_scale_x();
	var scaley = 1/stanncam_get_res_scale_y();
	
	layer_name = layer_name_;
	parralax = parralax_;
	
	if(layer_exists(layer_name)){
		
		global.camera.draw_special(function(){
			
			draw_layer_parralaxed(layer_name,parralax);
			
		},0,0,global.res_w,global.res_h,scalex,scaley);
	}
}
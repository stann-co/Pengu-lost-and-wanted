function set_background_workshop1(){
	global.background = function(){
		//the background is scaled up so it appears smooth when being parralaxed
		draw_background_depth(spr_bg_workshop_sky1,0);
		draw_background_depth(spr_bg_workshop1,0.2);
		draw_background_depth(spr_bg_workshop3,0.267);
		draw_background_depth(spr_bg_workshop3,0.4);
		draw_background_depth(spr_bg_workshop2,0.6);
		
	}
}


function draw_background_depth(_sprite,_depth){
	var cam_ = global.camera;
	var scalex = stanncam_get_res_scale_x();
	var scaley = stanncam_get_res_scale_y();
		
	//the offset the camera is from the middle of the room
	var offset_x = ((-cam_.get_x() -cam_.x_frac) * scalex)*_depth;
	var offset_y = ((-cam_.get_y() -cam_.y_frac) * scaley)*_depth;
	
	draw_sprite_tiled_ext(_sprite,0,offset_x,offset_y,scalex,scaley,-1,1);
}
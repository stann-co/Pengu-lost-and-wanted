function set_background_workshop1(){
	global.background = function(){
		//the background is scaled up so it appears smooth when being parralaxed
		draw_background_depth(spr_bg_workshop_sky1	,0, 0	);
		draw_background_depth(spr_bg_workshop1		,0, 0.2	);
		draw_background_depth(spr_bg_workshop3		,0, 0.267);
		draw_background_depth(spr_bg_workshop3		,0, 0.4	);
		draw_background_depth(spr_bg_workshop2		,0, 0.6	);
		
	}
}

function set_background_up_mountain(){
	global.background = function(){
		//the background is scaled up so it appears smooth when being parralaxed
		draw_background_depth(spr_mountain,0,0		,true);
		
		gpu_set_colorwriteenable(1,1,1,0);
		
		draw_background_depth(spr_mountain,1,0.125	,true);
		draw_background_depth(spr_mountain,2,0.25	,true);
		draw_background_depth(spr_mountain,3,0.375	,true);
		draw_background_depth(spr_mountain,4,0.5	,true);
		draw_background_depth(spr_mountain,5,0.625	,true);
		draw_background_depth(spr_mountain,6,0.75	,true);
		draw_background_depth(spr_mountain,7,0.875	,true);
		
		gpu_set_colorwriteenable(1,1,1,1);
	}
}


function draw_background_depth(_sprite,_subimg,_depth,only_horizontal = false){
	var cam_ = global.camera;
	var scalex = stanncam_get_res_scale_x();
	var scaley = stanncam_get_res_scale_y();
		
	//the offset the camera is from the middle of the room
	var offset_x = ((-cam_.get_x() -cam_.x_frac) * scalex)*_depth;
	
	var offset_y = 0;	
	if(!only_horizontal){
		offset_y = ((-cam_.get_y() -cam_.y_frac) * scaley)*_depth;
	}
	
	draw_sprite_tiled_ext(_sprite,_subimg,offset_x,offset_y,scalex,scaley,-1,1);
}
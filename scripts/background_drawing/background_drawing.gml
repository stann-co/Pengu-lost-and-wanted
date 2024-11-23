#region backgrounds

function set_background_workshop1(){
	global.background = function(){
		//the background is scaled up so it appears smooth when being parralaxed
		
		draw_clear(black);
		gpu_set_colorwriteenable(1,1,1,0);
		draw_background_depth(spr_bg_workshop_sky,0, 0		,,,,,false);
		draw_background_depth(spr_bg_workshop,1, 0.1	,,,,,true);
		draw_background_depth(spr_bg_workshop,2, 0.4	,,,,,false);
		draw_background_depth(spr_bg_workshop,3, 0.6	,,,,,false);
		draw_background_depth(spr_bg_workshop,4, 0.8	,,,,,false);
		gpu_set_colorwriteenable(1,1,1,1);
	}
	
	with(obj_camera){
		blur_steps_D	= 30.0;		// blur steps for discrete samples
		sigma_D			= 0.2;		// sigma for discrete samples
		bloom_threshold = 0.293;
		bloom_range		= 0.467;
		bloom_intensity	= 0.23;
		bloom_darken	= 1.0;
		bloom_saturation= 2.0;
	}
}

function set_background_up_mountain(){
	global.background = function(){
		
		draw_background_depth(spr_bg_original,0,0		,,,,,true);
		draw_background_depth(spr_bg_original,1,0.01	,,,,,true);
		draw_background_depth(spr_bg_original,2,0.04	,,80,,,true);
		draw_background_depth(spr_bg_original,3,0.06	,,80,,,true);
		draw_background_depth(spr_bg_original,4,0.08	,,80,,,true);
		draw_background_depth(spr_bg_original,5,0.1	,,80,,,true);
		
		draw_background_depth(spr_bg_original,6,0.12	,,200,,,true);
		draw_background_depth(spr_bg_original,7,0.15	,,200,,,true);	
	}
	
	with(obj_camera){
	  blur_steps_D		= 30.0;
	  sigma_D			= 0.25699999928474426;
	  bloom_threshold	= 0.80299997329711914;
	  bloom_range		= 0.24699999392032623;
	  bloom_intensity	= 0.15600000321865082;
	  bloom_darken		= 0.95599997043609619;
	  bloom_saturation	= 2.0;
	}
}

function set_background_original(){
	global.background = function(){
		
		with(obj_camera){
			if(!surface_exists(bg_layer)){
				bg_layer = surface_create(global.game_w,global.game_h);
			}
			surface_set_target(bg_layer);
		
			draw_clear(#162451);
			draw_background_depth(spr_bg_original,0,0.05,0,0,1,1,true);
			draw_background_depth(spr_bg_original,1,0.1 ,0,0,1,1,true);
			draw_background_depth(spr_bg_original,2,0.15,0,0,1,1,true);
			draw_background_depth(spr_bg_original,3,0.2 ,0,0,1,1,true);
		
			for (var i = 0; i < 16; ++i) {
			    draw_sprite_tiled_area(spr_bg_ocean,0,(-global.camera.get_x()+global.t)*(0.25+(i*0.05)),130,0,i*5+130,global.game_w,(i*5)+135);
			}
		
			surface_reset_target();
		
			draw_surface(bg_layer,global.camera.get_x(),global.camera.get_y())
		
		  blur_steps_D		= 30.0;
		  sigma_D			= 0.25699999928474426;
		  bloom_threshold	= 0.80299997329711914;
		  bloom_range		= 0.24699999392032623;
		  bloom_intensity	= 0.15600000321865082;
		  bloom_darken		= 0.95599997043609619;
		  bloom_saturation	= 2.0;
		}
	}
}
	
function set_background_original_red(){
	global.background = function(){
		
		with(obj_camera){
			if(!surface_exists(bg_layer)){
				bg_layer = surface_create(global.game_w,global.game_h);
			}
			surface_set_target(bg_layer);
		
			draw_clear(#162451);
			draw_background_depth(spr_bg_original_red,0,0.05,0,0,1,1,true);
			draw_background_depth(spr_bg_original_red,1,0.1 ,0,0,1,1,true);
			draw_background_depth(spr_bg_original_red,2,0.15,0,0,1,1,true);
			draw_background_depth(spr_bg_original_red,3,0.2 ,0,0,1,1,true);
		
			for (var i = 0; i < 16; ++i) {
			    draw_sprite_tiled_area(spr_bg_ocean_red,0,(-global.camera.get_x()+global.t)*(0.25+(i*0.05)),130,0,i*5+130,global.game_w,(i*5)+135);
			}
		
			surface_reset_target();
		
			draw_surface(bg_layer,global.camera.get_x(),global.camera.get_y())
		
		  blur_steps_D		= 30.0;
		  sigma_D			= 0.25699999928474426;
		  bloom_threshold	= 0.80299997329711914;
		  bloom_range		= 0.24699999392032623;
		  bloom_intensity	= 0.15600000321865082;
		  bloom_darken		= 0.95599997043609619;
		  bloom_saturation	= 2.0;
		}
	}
}

#endregion

function draw_background_depth(_sprite,_subimg,_depth,offset_x=0,offset_y=0,scalex=1,scaley=1,only_horizontal = false){
	var cam_ = global.camera;

	//the offset the camera is from the middle of the room
	offset_x += (-cam_.get_x() * scalex)*_depth;
		
	if(!only_horizontal){
		offset_y += (-cam_.get_y() * scaley)*_depth;
	}
	
	if(only_horizontal){
		draw_sprite_tiled_ext2(_sprite,_subimg,offset_x mod (sprite_get_width(_sprite)*scalex),offset_y,3,1,scalex,scaley,-1,1);
	} else {
		draw_sprite_tiled_ext(_sprite,_subimg,offset_x,offset_y,scalex,scaley,-1,1);
	}
}

function draw_layer_parralaxed_old(layer_name, parralax){
	var element_array = layer_get_all_elements(layer_name);
	var scalex = stanncam_get_res_scale_x();
	var scaley = stanncam_get_res_scale_y();
	var cam_ = global.camera;
	
	for (var i = 0; i < array_length(element_array); ++i) {
		var element = element_array[i];
		
		var x_ = layer_sprite_get_x(element) ;
		var y_ = layer_sprite_get_y(element) ;
		
	    var offset_x = (x_ - (cam_.get_x() + cam_.width )) * parralax;
		var offset_y = (y_ - (cam_.get_y() + cam_.height)) * parralax;
		
		var sprite = layer_sprite_get_sprite(element);
		var angle = layer_sprite_get_angle(element);
		
		var display_x = global.camera.room_to_display_x(x_ + offset_x);
		var display_y = global.camera.room_to_display_y(y_ + offset_y);
		
		draw_sprite_ext(sprite,0,display_x,display_y,scalex,scaley,angle,-1,1);
	}	
}

///@function draw_layer_parralaxed()
function draw_layer_parralaxed(layer_name, parralax){
	var element_array = layer_get_all_elements(layer_name);
	var cam_ = global.camera;
	
	for (var i = 0; i < array_length(element_array); ++i) {
		var element = element_array[i];
		
		var x_ = layer_sprite_get_x(element) ;
		var y_ = layer_sprite_get_y(element) ;
		
	    var offset_x = (x_ - (cam_.get_x() + cam_.width )) * parralax;
		var offset_y = (y_ - (cam_.get_y() + cam_.height)) * parralax;
		
		var sprite = layer_sprite_get_sprite(element);
		var angle = layer_sprite_get_angle(element);
		
		var display_x = global.camera.room_to_display_x(x_ + offset_x);
		var display_y = global.camera.room_to_display_y(y_ + offset_y);
		
		draw_sprite_ext(sprite,0,display_x,display_y,scalex,scaley,angle,-1,1);
	}	
}
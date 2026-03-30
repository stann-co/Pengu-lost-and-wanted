#region backgrounds

function set_background_beginning_obelisq(){
	global.background = function(){
        var x_ = global.camera.get_x();
        var y_ = global.camera.get_y();
        var width_ = sprite_get_width(spr_bg_beginning_obelisq);
        var height_ = sprite_get_height(spr_bg_beginning_obelisq);
        
        shader_set(sh_bg_morph);
        var u_resolution = shader_get_uniform(sh_bg_morph,"u_resolution");
        var u_t = shader_get_uniform(sh_bg_morph,"u_t");
        
        shader_set_uniform_f(u_resolution,width_,height_);
        shader_set_uniform_f(u_t ,global.t);
        
        gpu_set_tex_filter(true)
        
        draw_sprite(spr_bg_beginning_obelisq,0,x_,y_);
        gpu_set_tex_filter(false)
        
        shader_reset();
	}
}

//function set_background_workshop1(){
	//global.background = function(){
		////the background is scaled up so it appears smooth when being parralaxed
		//
		//draw_clear(BLACK);
		//gpu_set_colorwriteenable(1,1,1,0);
		//draw_background_depth(spr_bg_workshop_sky,0, 0		,,,,,false);
		//draw_background_depth(spr_bg_workshop,1, 0.1	,,,,,true);
		//draw_background_depth(spr_bg_workshop,2, 0.4	,,,,,false);
		//draw_background_depth(spr_bg_workshop,3, 0.6	,,,,,false);
		//draw_background_depth(spr_bg_workshop,4, 0.8	,,,,,false);
		//gpu_set_colorwriteenable(1,1,1,1);
	//}
	//
	//with(obj_camera){
		//blur_steps_d	= 30.0;		// blur steps for discrete samples
		//sigma_d			= 0.2;		// sigma for discrete samples
		//bloom_threshold = 0.293;
		//bloom_range		= 0.467;
		//bloom_intensity	= 0.23;
		//bloom_darken	= 1.0;
		//bloom_saturation= 2.0;
	//}
//}

//function set_background_up_mountain(){
	//global.background = function(){
		//
		//draw_background_depth(spr_bg_original,0,0		,,,,,true);
		//draw_background_depth(spr_bg_original,1,0.01	,,,,,true);
		//draw_background_depth(spr_bg_original,2,0.04	,,80,,,true);
		//draw_background_depth(spr_bg_original,3,0.06	,,80,,,true);
		//draw_background_depth(spr_bg_original,4,0.08	,,80,,,true);
		//draw_background_depth(spr_bg_original,5,0.1	,,80,,,true);
		//
		//draw_background_depth(spr_bg_original,6,0.12	,,200,,,true);
		//draw_background_depth(spr_bg_original,7,0.15	,,200,,,true);	
	//}
	//
	//with(obj_camera){
	  //blur_steps_d		= 30.0;
	  //sigma_d			= 0.25699999928474426;
	  //bloom_threshold	= 0.80299997329711914;
	  //bloom_range		= 0.24699999392032623;
	  //bloom_intensity	= 0.15600000321865082;
	  //bloom_darken		= 0.95599997043609619;
	  //bloom_saturation	= 2.0;
	//}
//}

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
		
			for (var i_ = 0; i_ < 16; ++i_) {
			    draw_sprite_tiled_area_ext(spr_bg_ocean,0,(-global.camera.get_x()+global.t)*(0.25+(i_*0.05)),130,0,i_*5+130,global.game_w,(i_*5)+135);
			}
		
			surface_reset_target();
		
			draw_surface(bg_layer,global.camera.get_x(),global.camera.get_y())
			//global.camera.draw_surf(bg_layer,0,0);
		
		  blur_steps_d		= 30.0;
		  sigma_d			= 0.25699999928474426;
		  bloom_threshold	= 0.80299997329711914;
		  bloom_range		= 0.24699999392032623;
		  bloom_intensity	= 0.15600000321865082;
		  bloom_darken		= 0.95599997043609619;
		  bloom_saturation	= 2.0;
		}
	}
}

function set_background_snow_train(){
	global.background = function(){
		global.background = function(){
	        var x_ = global.camera.get_x();
	        var y_ = global.camera.get_y();
	        var width_ = sprite_get_width(spr_bg_snow_floor);
	        var height_ = sprite_get_height(spr_bg_snow_floor);
			
			draw_sprite(spr_bg_snow_back,0,x_,y_+global.game_h/2);
			
			shader_set(sh_depth_plane)
			var u_t = shader_get_uniform(sh_depth_plane,"u_t");
			shader_set_uniform_f(u_t ,global.t);
			gpu_set_tex_repeat(true);
			gpu_set_tex_mip_filter(tf_linear);
			
			draw_sprite_stretched(spr_bg_snow_floor,0,x_,y_+global.game_h/2,global.game_w,room_height-(y_+global.game_h/2));
			
			//gpu_set_tex_mip_filter(tf_point);
			gpu_set_tex_repeat(false)
			shader_reset()
			
			
		}
	}
}

function set_background_city(){
	global.background = function(){
		
		with(obj_camera){
			if(!surface_exists(bg_layer)){
				bg_layer = surface_create(global.game_w,global.game_h);
			}
			surface_set_target(bg_layer);
			
			var offset_ = global.t * 6;
			
			draw_clear(WHITE);			
			draw_background_depth(spr_bg_future_city,0,0.1	,offset_,0,1,1,true);
			draw_background_depth(spr_bg_future_city,1,0.2	,offset_,0,1,1,true);
			draw_background_depth(spr_bg_future_city,2,0.3	,offset_,0,1,1,true);
			draw_background_depth(spr_bg_future_city,3,0.4	,offset_,0,1,1,true);
			draw_background_depth(spr_bg_future_city,4,0.5	,offset_,0,1,1,true);
			
			surface_reset_target();
			draw_surface(bg_layer,global.camera.get_x(),global.camera.get_y())
		}
	}
}

function set_background_devzone(){
    
    global.background = function(){
        with(obj_camera){
			if(!surface_exists(bg_layer)){
				bg_layer = surface_create(global.game_w,global.game_h);
			}
			surface_set_target(bg_layer);
            draw_clear(LIGHT_GRAY)
            
            surface_reset_target();
			draw_surface(bg_layer,global.camera.get_x(),global.camera.get_y())
        }
    }
}

#endregion

function draw_background_depth(_sprite,_subimg,_depth,_offset_x=0,_offset_y=0,_scalex=1,_scaley=1,_only_horizontal = false){
	var cam_ = global.camera;

	//the offset_ the camera is from the middle of the room
	_offset_x += (-cam_.get_x() * _scalex);
		
	if(!_only_horizontal){
		_offset_y += (-cam_.get_y() * _scaley);
	}
	
	if(_only_horizontal){
		var width_ = sprite_get_width(_sprite) *_scalex;
		draw_sprite_tiled_ext2(_sprite,_subimg,_offset_x*_depth mod (width_) - width_,_offset_y*_depth,4,1,_scalex,_scaley,-1,1);
	} else {
		draw_sprite_tiled_ext(_sprite,_subimg,_offset_x*_depth,_offset_y*_depth,_scalex,_scaley,-1,1);
	}
}

///@function draw_layer_parralaxed()
function draw_layer_parralaxed(_layer_name, _parralax){
	var element_array_ = layer_get_all_elements(_layer_name);
	var cam_ = global.camera;
	
	for (var i_ = 0; i_ < array_length(element_array_); ++i_) {
		var element_ = element_array_[i_];
		
		var x_ = layer_sprite_get_x(element_) ;
		var y_ = layer_sprite_get_y(element_) ;
		
	    var offset_x_ = (x_ - (cam_.get_x() + cam_.width )) * _parralax;
		var offset_y_ = (y_ - (cam_.get_y() + cam_.height)) * _parralax;
		
		var sprite_ = layer_sprite_get_sprite(element_);
		var angle_ = layer_sprite_get_angle(element_);
		
		var display_x_ = global.camera.room_to_display_x(x_ + offset_x_);
		var display_y_ = global.camera.room_to_display_y(y_ + offset_y_);
		
		draw_sprite_ext(sprite_,0,display_x_,display_y_,scalex,scaley,angle_,-1,1);
	}	
}
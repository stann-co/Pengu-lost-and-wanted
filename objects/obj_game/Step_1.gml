/// @description

//steamworks specific (when done with browser this if can be removed)
if(!IN_BROWSER){
	steam_update()
}

state.step();

if(global.freeze_duration > 0) global.freeze_duration--;

global.t_always++;

if(CAN_MOVE){
	global.t++;
	
	if(!tallying) timer++;
	
	if(transition_t == 0){
		//deactivates objects out of view
		
		var margin_ = CAMERA_OUTER_MARGIN;
		
		var left_ = global.camera.get_x() -margin_;
		var top_ = global.camera.get_y() -margin_;
		
		var width_ = global.camera.width   +	(margin_*2);
		var height_ = global.camera.height +	(margin_*2);
		
		instance_deactivate_region(left_, top_, width_, height_, false,true);
		instance_activate_region(left_, top_, width_, height_, true);
        
        for(var i_ = 0; i_ < array_length(global.persistent_objects);i_++){
            instance_activate_object(global.persistent_objects[i_]);    
        }

		//connected instances will all be active if just one of them is active
		for (var i1_ = 0; i1_ < array_length(global.activation_list); ++i1_) {
			var linked_array_ = global.activation_list[i1_];
			
			var any_active_ = false;
			
			for (var i2_ = 0; i2_ < array_length(linked_array_); ++i2_) {
				   if (instance_exists(linked_array_[i2_])){
					   any_active_ = true;
					   break;
				   }
			}
			
			if(any_active_){
				for (var i2_ = 0; i2_ < array_length(linked_array_); ++i2_) {
				   instance_activate_object(linked_array_[i2_]);
				}
			}
		}
		
		//score multiplier reset
		if(global.score_combo_t > 0){
			global.score_combo_t--;
		}
		else{
			global.score_mult = 1;
		}
	}
}
	
#region transition fade to WHITE
if(transition_t != 0 || transition_in){
	if(transition_t != 0){
		transition_t--;		
	} else if(transition_in){
		transition_in = false //transitions out again
		transition_t = transition_duration;
		transition_callback();
	}
	transition_val = (transition_t / transition_duration);
	if(transition_in) transition_val = 1 - transition_val;
}
#endregion

#region particle test

if mouse_check_button_pressed(mb_left){
    var mx_ = global.camera.get_mouse_x();
    var my_ = global.camera.get_mouse_y();
    part_particles_create(global.particles,mx_,my_,global.part_stars,4);
}

#endregion

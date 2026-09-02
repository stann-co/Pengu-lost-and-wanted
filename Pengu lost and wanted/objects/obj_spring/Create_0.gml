event_inherited();

control_lock_time *= SECOND;

/// @description
animate = false;
subimg = 0;

cooldown = false;

trigger = function(_side,_object){
	if(!cooldown && _side != SIDES.BOTTOM){
		
		audio_play_sound(snd_bouncepad,0,false)
		
		cooldown = true;
		call_later(0.2,time_source_units_seconds,function(){
			cooldown = false;	
		})
		
		
		if (_object.object_index == obj_pengu) with(_object){
			var angle_ = other.image_angle
			if(airborne && !other.only_grounded){
				
				other.animate = true;
				
				if(other.change_layer != noone){
					collision_layer_switch(other.change_layer,true);
				}
				
				x_speed =	 dcos(angle_+90) * other.spring_force;
				y_speed =	 dsin(angle_+90) * -other.spring_force;
				state.change("fall_up");
				double_jump_count = 0;
				dash_air_count = 0;
				
			} else if(!airborne){
				
				other.animate = true;
				
				if(other.change_layer != noone){
					collision_layer_switch(other.change_layer ,true);
				}
				
				set_control_lock(other.control_lock_time);
				ground_spd = (dcos(angle_+90-image_angle))  * other.spring_force;	
				
				input_h = sign(ground_spd);
				
				if(abs(angle_difference(angle_,ground_angle)) < 90){
					x_speed =	 dcos(angle_+90) * other.spring_force;	
					y_speed =	 dsin(angle_+90) * -other.spring_force;
					state.change("fall_up");
					
				} else state.change("sliding");
				
			}		
		}
	}
	return false
}
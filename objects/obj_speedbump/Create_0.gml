event_inherited();

/// @description
subimg = 0;

cooldown = false;

trigger = function(){
	if(!cooldown){
		cooldown = true;
		call_later(0.5,time_source_units_seconds,function(){
			cooldown = false;	
		})
		
		with(obj_pengu){
			if(!airborne){				
				if(other.change_layer != noone){
					collision_layer_switch(other.change_layer == "A",true);
				}
				set_control_lock(other.control_lock_time);
				ground_spd = other.force * other.image_xscale;
				input_h = sign(ground_spd);
				state.change("sliding");		
				audio_play_sound(snd_dashing,1,false);
			}
		}
	}
}
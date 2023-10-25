/// @description
animate = false;
subimg = 0;

cooldown = false;

trigger = function(){
	if(!cooldown){
		cooldown = true;
		call_later(0.2,time_source_units_seconds,function(){
			cooldown = false;	
		})
		animate = true;
		
		with(obj_pengu){
			var angle = other.image_angle
			if(airborne && !other.only_grounded){
				if(other.change_layer != noone){
					collision_layer_switch(other.change_layer == "A",true);
				}
				
				x_speed =	 dcos(angle+90) * other.spring_force;	
				y_speed =	 dsin(angle+90) * -other.spring_force;
				
			} else if(!airborne){
				if(other.change_layer != noone){
					collision_layer_switch(other.change_layer == "A" ,true);
				}
				
				set_control_lock(game_speed);
				ground_spd = dcos(angle+90)  * other.spring_force;	
				
				input_h = sign(ground_spd);
				
				if(abs(angle_difference(angle,ground_angle)) < 90){
					x_speed =	 dcos(angle+90) * other.spring_force;	
					y_speed =	 dsin(angle+90) * -other.spring_force;
					state.change("fall");
					
				} else state.change("sliding");
				
			}		
		}
	}
}
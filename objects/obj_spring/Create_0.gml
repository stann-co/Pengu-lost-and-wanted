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
			if(airborne){
				
				x_speed =	 dcos(angle+90) * other.spring_force;	
				y_speed =	 dsin(angle+90) * -other.spring_force;
				
			} else {
				input_h = 0;
				set_control_lock(game_speed);
				ground_spd = dcos(angle+90)  * other.spring_force;	
				if(abs(angle_difference(angle,ground_angle)) < 90){
					x_speed =	 dcos(angle+90) * other.spring_force;	
					y_speed =	 dsin(angle+90) * -other.spring_force;
					state.change("fall");
					
				}
				
			}		
		}
	}
}
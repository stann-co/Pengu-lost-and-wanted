// Inherit the parent event
event_inherited();

inst.step(TIMESTEP);

/// @description

if (CONTROLLED){
	if (InputPressed(INPUT_VERB.INTERACT)){
		instance_create_layer(x,y,"Instances",obj_pengu);
		global.camera.follow = obj_pengu;
		global.camera.zoom(base_zoom_level,SECOND*0.5);
		state.change("standby_start");
	}
	
	input_h = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
	input_v = InputCheck(INPUT_VERB.UP) - InputCheck(INPUT_VERB.DOWN);
	
	if(input_h != 0){
		facing = input_h;
		//if top speed has already been exceeded before this event
		//that becomes the new temporary top speed
		//like for speed ramps and springs and dashing
		var ground_top_speed_ = (abs(ground_spd) > top_speed) ? abs(ground_spd) : top_speed;
		ground_top_speed_ = min(ground_top_speed_,absolute_top_speed);
		
		//if pressing in the opposite direction of ground_spd it decelerates
		if(ground_spd != 0 && sign(ground_spd) != input_h){ //decelerates
			
			//deceleration speed is a bit higher than acceleration speed. but it's only used if ground_speed has already surpassed it
			if(abs(ground_spd) >= deceleration_speed){
				ground_spd += deceleration_speed * input_h;
			} else {
				ground_spd += acceleration_speed * input_h;
			}
			
		} else { //accelerate
			ground_spd += acceleration_speed * input_h;
		}
		
		//clamps to top speed
		ground_spd = clamp(ground_spd,-ground_top_speed_,ground_top_speed_);
	
	} else { //stop | apply friction
		ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
	}

	//speed depends on the angle of the floor
	ground_spd-=slope_factor * dsin(ground_angle);	
	
	// Calculate x and y_speed from ground_speed
	x_speed = ground_spd * dcos(ground_angle)
	y_speed = ground_spd * -dsin(ground_angle)
	
	
	x+=x_speed;
	y+=y_speed;
	
}

roty = lerp(roty,y_rot_amount*facing,0.06);

state.step()
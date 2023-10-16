/// @description step

subimg+= (sprite_get_speed(sprite_index)*anim_speed);

state.step();

#region input

if(control_lock == 0){
	
	input_h = (input_check("right") - input_check("left"));
	input_v = (input_check("down") - input_check("up"));
	
	if(!airborne && !sliding && input_v == 1){
		state.change("begin_slide");
	} else
	
	if(input_v == -1 && !airborne && !state.state_is("end_slide") && !state.state_is("look_up")){
		if(sliding){
			state.change("end_slide");			
		} else if(abs(ground_spd) < 2){
			state.change("look_up");
		}
	}
	
	if(input_check_pressed("dash")){
		if(airborne){
			if(dash_air_count == 0){
				state.change("dash_air_charge");
			}
		} else if(ground_angle <= 45 || ground_angle >= 315) {
			state.change("dash_charge");
		}
	}
	
	
}

if(input_check_pressed("jump")){
	vec_t = new Vector2(0,-h_radius-1);
	if(sliding && sensor(vec_t,snap_to_90(sensor_angle)+180,sensor_length_base) != noone){
		//if sliding it checks if you're under a block
		squish(0.8,1.2,game_speed*0.2);
	} else {
		if(!airborne) state.change("jump");
		else if(double_jump_count == 0) state.change("double_jump");
	}
}

#endregion

#region movement on ground
if(!airborne){
	
	//inclines above 45 degrees force you to slide
	if(!sliding && !force_slide_false){
		state.change("begin_slide")
	}
	
	if(input_h != 0){
		//if top speed has already been exceeded before this event
		//that becomes the new temporary top speed
		//like for speed ramps and springs and dashing
		if(abs(ground_spd) > top_speed) var ground_top_speed = abs(ground_spd); 
		else ground_top_speed = top_speed;
		ground_top_speed = min(ground_top_speed,absolute_top_speed);
		
		
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
		ground_spd = clamp(ground_spd,-ground_top_speed,ground_top_speed);
		
	} else { //stop | apply friction
		ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
	}
	
	ground_spd-=slope_factor * dsin(ground_angle);	
	
	// Calculate x and y_speed from ground_speed
	x_speed = ground_spd * dcos(ground_angle)
	y_speed = ground_spd * -dsin(ground_angle)

	//slipping and floor detatching
	if(control_lock == 0){
		//should player slip
		var slip = false;
		
		if(abs(ground_spd) < ground_slip_min_spd_ceiling && (ground_angle > force_slide_angle_ceiling && ground_angle < 360-force_slide_angle_ceiling)){
			slip = true;	
		} else if(abs(ground_spd) < ground_slip_min_spd && (ground_angle > force_slide_angle && ground_angle < 360-force_slide_angle)){
			slip = true;
		}
		
		if(slip){
			set_control_lock(slip_control_lock_time);
			//should player detatch
			if(ground_angle >= force_detatch_angle && ground_angle <= 360-force_detatch_angle){
				state.change("fall");
			}
		}
		
	}
}
#endregion

#region movement airborne
else {
	//if top speed has already been exceeded before this event
	//that becomes the new temporary top speed
	//like for speed ramps and springs and dashing
	if(abs(x_speed) > air_horizontal_top_speed) var x_top_speed = abs(x_speed); 
	else x_top_speed = air_horizontal_top_speed;
	x_top_speed = min(x_top_speed,absolute_top_speed);
	
	if(abs(y_speed) > air_vertical_top_speed) var y_top_speed = abs(y_speed); 
	else y_top_speed = air_vertical_top_speed;
	y_top_speed = min(y_top_speed,absolute_top_speed);
	
	x_speed += air_acceleration_speed * input_h;
	y_speed += gravity_force;
	
	//air drag
	if (y_speed < 0 && y_speed > -4){
		x_speed -= floor(x_speed / 0.125) / 256;
	}

	x_speed = clamp(x_speed,-x_top_speed,x_top_speed);
	y_speed = clamp(y_speed,-y_top_speed,y_top_speed);
	
	image_angle -= angle_difference(image_angle,0) * rotation_speed;	
}
#endregion

x+=x_speed;
y+=y_speed;

//when airborne sensors aren't rotated at all
sensor_angle = (airborne) ? 0 : ground_angle;

#region push sensors
var push_sensor = noone;
	var push_height = (sliding) ? 0 : -8;
if((!airborne && ground_spd < 0) || (airborne && x_speed < 0)) { //left
	vec_l = new Vector2(-w_radius,push_height);
	vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
	if(airborne){
		push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_base,abs(x_speed));
	} else {
		push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_base,abs(ground_spd));
	}
} else if((!airborne && ground_spd > 0) || (airborne && x_speed > 0)){ //right
	vec_r = new Vector2(w_radius,push_height);
	vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
	if(airborne){
		push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_base,abs(x_speed));
	} else {
		push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_base,abs(ground_spd));
	}
	
}

if(push_sensor != noone && push_sensor.distance < 1){
	x+= push_sensor.x;
	y+= push_sensor.y;
	
	if(abs(angle_difference(push_sensor.angle,ground_angle)) >= 50){
		if(!airborne && !sliding && !state.state_is("pushing")) state.change("pushing");
		//else if(state.state_is("pushing")) pick_move_state();
		
		ground_spd = 0;
		x_speed = 0;
	}
}
#endregion

if(on_land) on_land = false;

#region ground sensors
if(!airborne || (airborne && y_speed > 0)){
	//bottom
	vec_b = new Vector2(0,h_radius+1);
	vec_b = vec_b.rotated(-snap_to_90(sensor_angle));
	//bottom left
	vec_bl = new Vector2(-w_radius,h_radius);
	vec_bl = vec_bl.rotated(-snap_to_90(sensor_angle));
	//bottom right
	vec_br = new Vector2(w_radius,h_radius);
	vec_br = vec_br.rotated(-snap_to_90(sensor_angle));
	
	
	var bl_sensor = sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_base);
	var br_sensor = sensor(vec_br,snap_to_90(sensor_angle),sensor_length_base);
	
	//sensors check which is closest to the ground
	var updown_sensor = noone;
	
		if(bl_sensor != noone && br_sensor != noone){
			//if both sensors collide, the one with the shortest distance wins
			if(bl_sensor.distance < br_sensor.distance) updown_sensor = bl_sensor;
			else updown_sensor = br_sensor;	
		}
		else if(bl_sensor != noone) updown_sensor = bl_sensor;
		else if(br_sensor != noone) updown_sensor = br_sensor;
	
	
	if(updown_sensor != noone){
		x+= updown_sensor.x;
		y+= updown_sensor.y;
		ground_angle = updown_sensor.angle;	
		
		if(airborne){ //just as you land from being airborne
			image_to_ground_angle = true;
			airborne = false;
			on_land = true;
			dash_air_count = 0;
			double_jump_count = 0;
			set_ground_spd_from_air_spd();
		}
		
	} else if(!airborne){ //going off ledges
		airborne = true;
		
		if(sliding){ //when sliding off a surface, you are angled
			if(ground_spd > 0){
				image_angle -= 90;
				mirror = 1;
			} else{
				image_angle += 90;
				mirror = 1;
			}
		}	
		//falling
		state.change("begin_fall");
	}
} else

#endregion

if(on_ceiling) on_ceiling = false;
#region ceiling sensors
if(airborne && y_speed < 0){
	//top
	vec_t = new Vector2(0,-h_radius-1);
	vec_t = vec_t.rotated(-snap_to_90(sensor_angle));
	//top left
	vec_tl = new Vector2(-w_radius,-h_radius);
	vec_tl = vec_tl.rotated(-snap_to_90(sensor_angle));
	//top right
	vec_tr = new Vector2(w_radius,-h_radius);
	vec_tr = vec_tr.rotated(-snap_to_90(sensor_angle));
	
	
	var tl_sensor = sensor(vec_tl,snap_to_90(sensor_angle)+180,sensor_length_base);
	var tr_sensor = sensor(vec_tr,snap_to_90(sensor_angle)+180,sensor_length_base);
	
	//sensors check which is closest to the ground
	var updown_sensor = noone;
	if(airborne && y_speed < 0){
		if(tl_sensor != noone && tr_sensor != noone){
			//if both sensors collide, the one with the shortest distance wins
			if(tl_sensor.distance < tr_sensor.distance) updown_sensor = tl_sensor;
			else updown_sensor = tr_sensor;	
		}
		else if(tl_sensor != noone) updown_sensor = tl_sensor;
		else if(tr_sensor != noone) updown_sensor = tr_sensor;
		
		//ceiling sensors doesn't do anything if it's a oneway tile
		if(updown_sensor != noone && !updown_sensor.oneway && updown_sensor.distance < 0){
			x+= updown_sensor.x;
			y+= updown_sensor.y;
						
			on_ceiling = true;
		}
	}
	
	//up slipping, if you bump head on the ceiling at an edge, and there's space on the left/right you move in that direction
	if(airborne && (tl_sensor != noone xor tr_sensor != noone) && !point_sensor(vec_t)){
		if(tl_sensor){
			x_speed += 0.1;
			x += 1;
		} else {
			x_speed  -= 0.1;
			x -= 1;
		}
	}
}

#endregion

#region edge slipping animation
if(!state.state_is("edge") && !airborne && !sliding && (bl_sensor != noone xor br_sensor != noone) && !point_sensor(vec_b) && ground_angle == 0 && ground_spd == 0){
	if(bl_sensor) mirror = 1;
	else mirror = -1;
	state.change("edge");
}
#endregion

#region squish scale_x & scale_y
if(squishing){
	if(squishing_t != squishing_duration){
		var channel = animcurve_get_channel(ac_squish,0);
		var val = animcurve_channel_evaluate(channel, squishing_t/squishing_duration);
		
		scale_x = lerp(1,scale_x_squish,val);
		scale_y = lerp(1,scale_y_squish,val);
		
		squishing_t++;
	} else squishing = false;	
}
#endregion

if(image_to_ground_angle){
	image_angle += angle_difference(ground_angle,image_angle)*0.5;
}

if(control_lock != 0) control_lock--;


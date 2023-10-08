/// @description step

subimg+= sprite_get_speed(sprite_index);

state.step();

#region input
if(!airborne && !sliding && input_check_pressed("down")){
	state.change("begin_slide");
}

if(input_check_pressed("up") && !airborne){
	airborne = true;
	y_speed = - jump_force - gravity_force //subtracting gravity force cancels out gravity for one frame
	state.change("jump");
}

if(input_check_pressed("action")){
	state.change("dash_ball");
}

input_h = (input_check("right") - input_check("left"));

#endregion

#region force slide on incline
//inclines above 45 degrees force you to slide
if(!sliding && !force_slide_false && !airborne){
	state.change("begin_slide")
}
#endregion

#region movement on ground
if(!airborne){
	if(input_h != 0){
		//if top speed has already been exceeded before this event
		//that becomes the new temporary top speed
		//like for speed ramps and springs and dashing
		if(abs(ground_spd) > top_speed) var ground_top_speed = abs(ground_spd); 
		else ground_top_speed = top_speed;
		
		
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
	
	x += x_speed;
	y += y_speed;
}
#endregion

#region movement airborne
else {
	//if top speed has already been exceeded before this event
	//that becomes the new temporary top speed
	//like for speed ramps and springs and dashing
	if(abs(x_speed) > air_top_speed) var x_top_speed = abs(x_speed); 
	else x_top_speed = air_top_speed;
	
	if(abs(y_speed) > air_top_speed) var y_top_speed = abs(y_speed); 
	else y_top_speed = air_top_speed;
	
	x_speed += air_acceleration_speed * input_h;
	y_speed += gravity_force;
	
	//air drag
	if (y_speed < 0 && y_speed > -4){
		x_speed -= floor(x_speed / 0.125) / 256;
	}

	
	x_speed = clamp(x_speed,-x_top_speed,x_top_speed);
	y_speed = clamp(y_speed,-y_top_speed,y_top_speed);
	
	x += x_speed;
	y += y_speed;
	
	image_angle -= angle_difference(image_angle,0) * rotation_speed;
	ground_spd = (x_speed * dcos(ground_angle)) + (y_speed * dsin(ground_angle));
	
}
#endregion

//when airborne sensors aren't rotated at all
sensor_angle = (airborne) ? 0 : ground_angle;

#region push sensors
var push_sensor = noone;
if((!airborne && ground_spd < 0) || (airborne && x_speed < 0)) { //left
	vec_l = new Vector2(-w_radius,0);
	vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
	push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_push(),1);
} else if((!airborne && ground_spd > 0) || (airborne && x_speed > 0)){ //right
	vec_r = new Vector2(w_radius,0);
	vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
	push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_push(),1);
}

if(push_sensor != noone && push_sensor.distance < 0){
	show_debug_message("");
}

if(push_sensor != noone && abs(angle_difference(push_sensor.angle,ground_angle)) >= 50 && push_sensor.distance < 0){
	x+= push_sensor.x;
	y+= push_sensor.y;
	
	if(!airborne && !sliding && !state.state_is("pushing")) state.change("pushing");
	
	ground_spd = 0;
	x_speed = 0;
}
	
#endregion

#region ground sensors

//bottom
vec_b = new Vector2(0,h_radius+1);
vec_b = vec_b.rotated(-snap_to_90(sensor_angle));
//bottom left
vec_bl = new Vector2(-w_radius,h_radius);
vec_bl = vec_bl.rotated(-snap_to_90(sensor_angle));
//bottom right
vec_br = new Vector2(w_radius,h_radius);
vec_br = vec_br.rotated(-snap_to_90(sensor_angle));


var bl_sensor = sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_vertical(),1);
var br_sensor = sensor(vec_br,snap_to_90(sensor_angle),sensor_length_vertical(),1);

//sensors check which is closest to the ground
var winning_sensor = noone;
if(!airborne || (airborne && y_speed > 0)){
	if(bl_sensor != noone && br_sensor != noone){
		//if both sensors collide, the one with the shortest distance wins
		if(bl_sensor.distance < br_sensor.distance) winning_sensor = bl_sensor;
		else winning_sensor = br_sensor;	
	}
	else if(bl_sensor != noone) winning_sensor = bl_sensor;
	else if(br_sensor != noone) winning_sensor = br_sensor;
}


if(winning_sensor != noone){
	x+= winning_sensor.x;
	y+= winning_sensor.y;
	ground_angle = winning_sensor.angle;	
	airborne = false;
	
} else if(!airborne){ //going off ledges
	
	var test = sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_vertical(),1);
	var test = sensor(vec_br,snap_to_90(sensor_angle),sensor_length_vertical(),1);
	
	airborne = true;
	
	if(sliding){ //when sliding off a surface, you are angled
		if(ground_spd > 0){
			ground_angle -= 90;
			mirror = 1;
		} else{
			ground_angle += 90;
			mirror = 1;
		}
	}
	
	//falling
	state.change("begin_fall");
	
	//rising
}

#endregion

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
	
	
	var tl_sensor = sensor(vec_tl,snap_to_90(sensor_angle)+180,sensor_length_vertical(),1);
	var tr_sensor = sensor(vec_tr,snap_to_90(sensor_angle)+180,sensor_length_vertical(),1);
	
	//sensors check which is closest to the ground
	winning_sensor = noone;
	if(airborne && y_speed < 0){
		if(tl_sensor != noone && tr_sensor != noone){
			//if both sensors collide, the one with the shortest distance wins
			if(tl_sensor.distance < tr_sensor.distance) winning_sensor = tl_sensor;
			else winning_sensor = tr_sensor;	
		}
		else if(tl_sensor != noone) winning_sensor = tl_sensor;
		else if(tr_sensor != noone) winning_sensor = tr_sensor;
		
		if(winning_sensor != noone && winning_sensor.distance < 0){
			x+= winning_sensor.x;
			y+= winning_sensor.y;
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

if(image_to_ground_angle) image_angle = ground_angle;
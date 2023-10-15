/// @description
state.step();

ground_spd = top_speed * input_h;
	
ground_spd-=slope_factor * dsin(ground_angle);	

// Calculate x and y_speed from ground_speed
x_speed = ground_spd * dcos(ground_angle)
y_speed = ground_spd * -dsin(ground_angle)

x+=x_speed;
y+=y_speed;

#region push sensors
var side_sensor = noone;
	var push_height = -8;
if(ground_spd < 0) { //left
	vec_l = new Vector2(-w_radius,push_height);
	vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
	side_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_base,abs(ground_spd));
	
} else if(ground_spd > 0){ //right
	vec_r = new Vector2(w_radius,push_height);
	vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
	side_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_base,abs(ground_spd));
	
}

if(side_sensor != noone && side_sensor.distance < 1){
	x+= side_sensor.x;
	y+= side_sensor.y;
	
	ground_spd = 0;
	x_speed = 0;
	state.change("turn");
}
#endregion

#region ground sensors
	//bottom
	vec_b = new Vector2(0,h_radius+1);
	vec_b = vec_b.rotated(-snap_to_90(sensor_angle));	
	
	var b_sensor = sensor(vec_b,snap_to_90(sensor_angle),sensor_length_base);
	
	if(b_sensor != noone){
		x+= b_sensor.x;
		y+= b_sensor.y;
		ground_angle = b_sensor.angle;	
		
	} else {
		state.change("turn");
	}

#endregion

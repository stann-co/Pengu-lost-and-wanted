/// @description

if(can_move){

state.step();

x+=x_speed;
y+=y_speed;

if(on_land) on_land = false;

if(!state.state_is("die")){
	#region push sensors
	var side_sensor = noone;
		var push_height = -8;
	if(ground_spd < 0) { //left
		vec_lt = new Vector2(-w_radius,push_height);
		vec_lt = vec_lt.rotated(-snap_to_90(sensor_angle));
		
		vec_lb = new Vector2(-w_radius,0);
		vec_lb = vec_lb.rotated(-snap_to_90(sensor_angle));
		
		side_sensor = sensor(vec_lt,snap_to_90(sensor_angle)-90,sensor_length_base,abs(ground_spd));
		if(side_sensor == noone){
			side_sensor = sensor(vec_lb,snap_to_90(sensor_angle)-90,sensor_length_base,abs(ground_spd));
		}
		
	} else if(ground_spd > 0){ //right
		vec_rt = new Vector2(w_radius,push_height);
		vec_rt = vec_rt.rotated(-snap_to_90(sensor_angle));
		
		vec_rb = new Vector2(w_radius,0);
		vec_rb = vec_rb.rotated(-snap_to_90(sensor_angle));
		
		side_sensor = sensor(vec_rt,snap_to_90(sensor_angle)+90,sensor_length_base,abs(ground_spd));
		if(side_sensor == noone){
			side_sensor = sensor(vec_rb,snap_to_90(sensor_angle)+90,sensor_length_base,abs(ground_spd));
		}
	}
	
	if(side_sensor != noone && side_sensor.distance < 1){
		if(abs(angle_difference(side_sensor.angle,ground_angle)) >= 50){
			x+= side_sensor.x;
			y+= side_sensor.y;
			touch_wall();
		}
	}
	#endregion
	
	#region ground sensors
	//bottom
	vec_b = new Vector2(0,h_radius+1);
	vec_b = vec_b.rotated(-snap_to_90(sensor_angle));	
	
	var b_sensor = sensor(vec_b,snap_to_90(sensor_angle),sensor_length_base);
	
	if(b_sensor != noone){
		if(airborne && y_speed > 0){
			airborne = false;
			on_land = true;
		}
		
		x+= b_sensor.x;
		y+= b_sensor.y;
		ground_angle = b_sensor.angle;	
	} else if(!airborne){
		no_floor();
	}
}

#endregion

}
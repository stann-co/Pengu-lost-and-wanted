/// @description

state.step();

#region input
if(grounded && !sliding && input_check_pressed("down")){
	state.change("begin_slide");
}

if(sliding && input_check_pressed("up") && force_slide_false){
	state.change("idle");
}

input_h = (input_check("right") - input_check("left"));

#endregion

//inclines above 45 degrees force you to slide
if(!sliding && !force_slide_false){
	state.change("begin_slide")
}

#region movement
if(input_h != 0){
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
	ground_spd = clamp(ground_spd,-top_speed,top_speed);
	
} else { //stop | apply friction
	ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
}

ground_spd-=slope_factor * dsin(ground_angle);

// Calculate x and y Speed from ground_speed
x_speed = ground_spd * dcos(ground_angle)
y_speed = ground_spd * -dsin(ground_angle)

x += x_speed;
y += y_speed;
#endregion

#region ground collisions

//bottom left
vec_bl = new Vector2(-w_radius,h_radius);
vec_bl = vec_bl.rotated(-snap_to_90(ground_angle));
//bottom right
vec_br = new Vector2(w_radius,h_radius);
vec_br = vec_br.rotated(-snap_to_90(ground_angle));


var bl_sensor = sensor(vec_bl,snap_to_90(ground_angle),h_radius,1);
var br_sensor = sensor(vec_br,snap_to_90(ground_angle),h_radius,1);

//sensors check which is closest to the ground
var winning_sensor = undefined;

if(bl_sensor != noone && br_sensor != noone){
	//if both sensors collide, the one with the shortest distance wins
	if(bl_sensor.distance < br_sensor.distance) winning_sensor = "left";
	else winning_sensor = "right";	
}
else if(bl_sensor != noone) winning_sensor = "left";
else if(br_sensor != noone) winning_sensor = "right";

if(winning_sensor == "left"){
	x+= bl_sensor.x;
	y+= bl_sensor.y;
	ground_angle = bl_sensor.angle;
} else if(winning_sensor == "right") {
	x+= br_sensor.x;
	y+= br_sensor.y;
	ground_angle = br_sensor.angle;
} else show_debug_message("no ground")

image_angle = ground_angle;
#endregion

#region side collisions

var side_sensor = noone;

//left
if(ground_spd < 0) {

	vec_l = new Vector2(-w_radius,0);
	vec_l = vec_l.rotated(-snap_to_90(ground_angle));
	side_sensor = sensor(vec_l,snap_to_90(ground_angle)-90,w_radius,1);

} else if (ground_spd > 0){ //right
	vec_r = new Vector2(w_radius,0);
	vec_r = vec_r.rotated(-snap_to_90(ground_angle));
	side_sensor = sensor(vec_r,snap_to_90(ground_angle)+90,w_radius,1);
}

if(side_sensor != noone && side_sensor.distance < 0){
	x+= side_sensor.x;
	y+= side_sensor.y;
	ground_spd = 0;
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
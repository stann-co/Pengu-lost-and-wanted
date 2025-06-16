/// @description

if(can_move){
    state.step();
	#region input
    if(controlled && global.control){
		
		input_h = (input_check("right") - input_check("left"));
		input_v = (input_check("down") - input_check("up"));
		
		if(input_check_pressed("jump")){
			if(!airborne) state.change("jump_charge");
		}
    }
		
	#endregion
	
	
	#region movement on ground
	if(!airborne){		
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
		
		// Calculate x and y_speed from ground_speed
		x_speed = ground_spd * dcos(ground_angle)
		y_speed = ground_spd * -dsin(ground_angle)
	}
	#endregion
	
	#region movement airborne
	else {		
		x_speed += air_acceleration_speed * input_h;
		y_speed += gravity_force;
		
		//air drag
		if (y_speed < 0 && y_speed > -4){
			x_speed -= floor(x_speed / 0.125) / 256;
		}
	
		x_speed = clamp(x_speed,-air_horizontal_top_speed,air_horizontal_top_speed);
		y_speed = clamp(y_speed,-air_vertical_top_speed,air_vertical_top_speed);
	}
	#endregion
	
	x+=x_speed;
	y+=y_speed;
	
	#region push sensors
	var push_sensor = noone;

	if((!airborne && ground_spd < 0) || airborne) { //left
		push_sensor = sensor(vec_l,-90,sensor_length_base,abs(x_speed));
		
		if(push_sensor != noone && push_sensor.distance < 1){		
			if (sensor_trigger(push_sensor)){
				x+= push_sensor.x;
				y+= push_sensor.y;
				x_speed = 0;
			}
		} 
	}  
	
	if((!airborne && ground_spd > 0) || airborne) { //right
		push_sensor = sensor(vec_r,90,sensor_length_base,abs(x_speed));
		
		if(push_sensor != noone && push_sensor.distance < 1){		
			if (sensor_trigger(push_sensor)){
				x+= push_sensor.x;
				y+= push_sensor.y;
				x_speed = 0;
			}
		} 
	}  
	
	#endregion
	
	if(on_land) on_land = false;
	#region ground sensors
	if(!airborne || (airborne && y_speed > 0)){
		
		var sensor_length = sensor_length_base;
		
		var bl_sensor = sensor(vec_bl,0,sensor_length);
		var br_sensor = sensor(vec_br,0,sensor_length);
		var b_sensor = sensor(vec_b,0,sensor_length);
		
		//sensors check which is closest to the ground
		var updown_sensor = noone;
		
		if(b_sensor != noone) updown_sensor = b_sensor;
		if(updown_sensor == noone || (bl_sensor != noone && bl_sensor.distance < updown_sensor.distance)) updown_sensor = bl_sensor;
		if(updown_sensor == noone || (br_sensor != noone && br_sensor.distance < updown_sensor.distance)) updown_sensor = br_sensor;		
		
		if(updown_sensor != noone){
            if (sensor_trigger(updown_sensor)){
			    x+= updown_sensor.x;
			    y+= updown_sensor.y;
			    
			    x+=updown_sensor.x_change;
			    y+=updown_sensor.y_change;
                
                if(airborne){
			    	on_land = true;
                    airborne = false;
			    }
            }

		} else if(!airborne){ //going off ledges
			state.change("airborne");
		}
	}	
	#endregion
	


    if(abs(x_speed) > min_flip_speed) mirror = sign(x_speed);
    
    mirror_component = lerp(mirror_component,mirror,0.05);
    
    vec_leg_l = new Vector2(-26 * mirror_component, 26); 
    vec_leg_r = new Vector2( 26 * mirror_component, 26);
    
    vec_leg_l = vec_leg_l.rotated(body_angle_component);
    vec_leg_r = vec_leg_r.rotated(body_angle_component);
    
    vec_foot_l = new Vector2(-foot_dist * mirror_component,h_radius); 
    vec_foot_r = new Vector2(foot_dist  * mirror_component,h_radius);
    
    foot_l.update_anchors(vec_foot_l,vec_leg_l);
    foot_r.update_anchors(vec_foot_r,vec_leg_r);
    
    
    //on ground
    if(!airborne){
    	if(foot_left_right){
    		if(foot_l.too_far() && !foot_l.stepping){
    			foot_l.set_target_to_ground();
    		}
    	} else {
    		if(foot_r.too_far() && !foot_r.stepping){
    			foot_r.set_target_to_ground();
    		}
    	}
    	foot_l.step();
    	foot_r.step();
    	
    	body.update(body_drag);
    	
    	var body_target_x = lerp(foot_l.x,foot_r.x,0.5);
    	var body_target_y = lerp(foot_l.y,foot_r.y,0.5) - legs_height + (y_speed * 2);
    	
    	body_target_x = lerp(body_target_x,x,0.4);
    	body_target_x += dsin(body_angle_component) * 20; //moves based on rotation
    	
    	body.spring(body_target_x,body_target_y,body_stiffness);
    	
    	if(!foot_l.stepping && !foot_r.stepping ){
    		var left = noone;
    		var right = noone;
    		if(foot_l.x < foot_r.x){
    			left = foot_l;
    			right = foot_r;
    		} else {
    			left = foot_r;
    			right = foot_l;
    			
    		}
    		body_angle = (-point_direction(left.x,left.y,right.x,right.y) * 0.5);
    		if(body_angle < -90) body_angle+=180;
    		
    		var extra_rotation = (x - body.x ) * 0.5;
    		extra_rotation = clamp(extra_rotation,-10,10);
    		
    		body_angle+=extra_rotation;
    	}
    	
    	foot_l.set_knee_pos();
    	foot_r.set_knee_pos();
    
    } else {
    //in air
    	vec_body.x = lerp(vec_body.x,0,0.01)
    	vec_body.y = lerp(vec_body.y,-10,0.1)
    
    	body.x = x + vec_body.x;
    	body.y = y + vec_body.y;
    	body.x_prev = body.x;
    	body.y_prev = body.y;
    	
    	var drag = 0.34;
    	
    	foot_l.update(drag);
    	foot_r.update(drag);
    	
    	var foot_l_x = x+vec_foot_l.x+vec_body.x + (x_speed * 4);
    	var foot_l_y = y+vec_foot_l.y+vec_body.y + (x_speed * mirror_component * 1.2);
    	
    	var foot_r_x = x+vec_foot_r.x+vec_body.x + (x_speed * 4);
    	var foot_r_y = y+vec_foot_r.y+vec_body.y - (x_speed * mirror_component * 1.2);
    	
    	foot_l.spring(foot_l_x,foot_l_y,0.2);
    	foot_r.spring(foot_r_x,foot_r_y,0.2);
    	
    	foot_l.set_knee_pos();
    	foot_r.set_knee_pos();
    }
    
    body_angle_component -= angle_difference(body_angle_component,body_angle) * 0.1;
    
    dome.update(0.4);
    dome.spring(body.x,body.y, 0.5);
    dome.x = body.x;
    vec_dome = new Vector2(-1,-33);
    vec_dome = vec_dome.rotated(body_angle_component);
    
    //dice
    vec_dice = new Vector2(8*mirror_component,-56);
    vec_dice = vec_dice.rotated(body_angle_component);
    
    var x_ = dome.x+vec_dice.x;
    var y_ = dome.y+vec_dice.y;
    
    die1.update(0.0);
    die1.move_relative(x_,y_,0.92);
    die1.get_first_point().set_pos(x_,y_);
    die2.update(0.0);
    die2.move_relative(x_,y_,0.92);
    die2.get_first_point().set_pos(x_,y_);
    
    
    //seperate dice
    
    var p1 = die1.get_last_point();
    var p2 = die2.get_last_point();
    
    var dist = point_distance(p1.x,p1.y,p2.x,p2.y) / 2;
    var dir = point_direction(p1.x,p1.y,p2.x,p2.y);
    
    if(dist < 2) {
    	p1.x -= lengthdir_x(0.1,dir);	
    	p1.y -= lengthdir_y(0.1,dir);					
    	p2.x += lengthdir_x(0.1,dir);	
    	p2.y += lengthdir_y(0.1,dir);
    }
    
    
    for (var i = 0; i < die1.segment_num; ++i) {
        
    	p1 = die1.points[i];
    	var dist1 = point_distance(p1.x,p1.y,dome.x+vec_dome.x,dome.y+vec_dome.y);
    	var dir1 = point_direction(p1.x,p1.y,dome.x+vec_dome.x,dome.y+vec_dome.y);
    	
    	p2 = die2.points[i];
    	var dist2 = point_distance(p2.x,p2.y,dome.x+vec_dome.x,dome.y+vec_dome.y);
    	var dir2 = point_direction(p2.x,p2.y,dome.x+vec_dome.x,dome.y+vec_dome.y);
    	
    	if(dist1 > dome_radius){
    		p1.x = dome.x + vec_dome.x - lengthdir_x(dome_radius,dir1);
    		p1.y = dome.y + vec_dome.y - lengthdir_y(dome_radius,dir1);
    	}
    	
    	if(dist2 > dome_radius){		
    		p2.x = dome.x + vec_dome.x - lengthdir_x(dome_radius,dir2);
    		p2.y = dome.y + vec_dome.y - lengthdir_y(dome_radius,dir2);
    	}
    }
    
    die1.gravity_force();
    die2.gravity_force();
    
}
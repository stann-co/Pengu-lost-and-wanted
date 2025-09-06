/// @description

if(can_move){
    state.step();
     
    if(on_land) on_land = false;
    if(on_ceiling) on_ceiling = false;
    if(on_wall) on_wall = false;
    if(on_no_floor) on_no_floor = false;
    
    var substeps = 1
    if(!airborne) substeps += abs(ground_spd) div 10;
    //additional substeps if you are going fast
    
    repeat(substeps){
        
        x+=x_speed;
        y+=y_speed;
        
        if(colliding){
            
        	#region push sensors
        	var push_sensor = noone;
            //var push_height = -8;
            
        	if(x_speed < 0) { //left
        		vec_l = new Vector2(-w_radius,0);
        		vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
        		
                if(airborne){
                    push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_base/2,abs(x_speed));
                } else {
                    push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,sensor_length_base/2,abs(ground_spd));
                }
                
        		if(push_sensor != noone && push_sensor.distance < 1){ 
                    x+= push_sensor.x; 
                    y+= push_sensor.y;
                    on_wall = true;
        	    }
        	}
            
            if(x_speed > 0){ //right
                vec_r = new Vector2(w_radius,0);
                vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
                if(airborne){
                    push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_base/2,abs(x_speed));
                } else {
                    push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,sensor_length_base/2,abs(ground_spd));
                }
                if(push_sensor != noone && push_sensor.distance < 1){		
                    
                    x+= push_sensor.x;
                    y+= push_sensor.y;
                    on_wall = true;
                } 
            }
        	#endregion
        	
        	#region ground sensors
        	//bottom
        	vec_b = new Vector2(0,h_radius+1);
        	vec_b = vec_b.rotated(-snap_to_90(sensor_angle));	
        	
        	var b_sensor = sensor(vec_b,snap_to_90(sensor_angle),sensor_length_base);
        	
        	if(b_sensor != noone && ( !airborne || (airborne && b_sensor.y < 0) )){
                x+= b_sensor.x;
        		y+= b_sensor.y;
                
                ground_angle = b_sensor.angle;
                
        		if(airborne){
        			airborne = false;
        			on_land = true;
                    set_ground_spd_from_air_spd();
        		}
        	} else if(!airborne){
                airborne = true;
        		on_no_floor = true;
        	}
            #endregion
            
            #region ceiling sensors
            if(airborne){
                //top
                vec_t = new Vector2(0,-h_radius-1);
                vec_t = vec_t.rotated(-snap_to_90(sensor_angle)); 
                
                var t_sensor = sensor(vec_t,snap_to_90(sensor_angle)+180,sensor_length_base);
    
                if(airborne && y_speed < 0){ 
                    if (t_sensor != noone && t_sensor.distance < 0){
                        x+= t_sensor.x;
                        y+= t_sensor.y;
                        
                        on_ceiling = true
                    }
                }
            } 
            #endregion
        }
    }
}
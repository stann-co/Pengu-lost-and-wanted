/// @description step
if(can_move){
	
    subimg+= (sprite_get_speed(sprite_index)*anim_speed);
    
    state.step();
    
    if(godmode){
    	input_h = (input_check("right") - input_check("left"));
    	input_v = (input_check("down") - input_check("up"));
    	
    	x+=input_h * 4;
    	y+=input_v * 4;
    	
    } else {
        if(controlled && global.control){
        	#region input
        	//if(control){
            if(control_lock == 0){
                input_h = (input_check("right") - input_check("left"));
                input_v = (input_check("down") - input_check("up"));
                
                if(!airborne && !sliding && input_v == 1){
                    state.change("begin_slide");
                } else
                
                if(input_v == -1 && !airborne && !state.state_is("end_slide") && !state.state_is("look_up")){
                    if(sliding){
                        if(force_slide_false && !collision_line(x-w_radius_normal-1,y-h_radius_normal-2,x+w_radius_normal+1,y-h_radius_normal-2,[global.tile_collisions,obj_collision],true,true)){
                            state.change("end_slide");
                        }
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
                
                if(input_check_pressed("attack")){
                    if(attack_count == 0 && (ground_angle <= 45 || ground_angle >= 315)) {
                        state.change("attack_1");
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
        		
        		var slippery = 1;
        		if(place_meeting(x,y,obj_slippery)){
        			slippery = slippery_multiplier
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
        					ground_spd += deceleration_speed * input_h * slippery;
        				} else {
        					ground_spd += acceleration_speed * input_h * slippery;
        				}
        				
        			} else { //accelerate
        				ground_spd += acceleration_speed * input_h;
        			}
        			
        			//clamps to top speed
        			ground_spd = clamp(ground_spd,-ground_top_speed,ground_top_speed);
        			
        		} else if(slippery == 1) { //stop | apply friction
        			ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
        		}
        		
        		//speed depends on the angle of the floor
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
            	if(abs(angle_difference(image_angle,0)) < 1 ) image_angle = 0;
            }
        	#endregion
        	
        	if(on_land) on_land = false;
            if(on_ceiling) on_ceiling = false;
        	
        	var substeps = 1
        	if(!airborne) substeps += abs(ground_spd) div 10;
        	//additional substeps if you are going fast
        	
        	repeat(substeps){
                #region speed
        	
        		x+=x_speed / substeps;
        		y+=y_speed / substeps;
        	
        		//when airborne sensors aren't rotated at all
        		sensor_angle = (airborne) ? 0 : ground_angle;
        	
        		//super speed 
        		if(abs(ground_spd) >= super_speed_threshold && !super_speed){
        			super_speed = true;
        			super_speed_fadeout = super_speed_fadeout_time;
        			super_speed_trace_arr = [];
        		} else
        	
        		if(super_speed){		
        			var abs_speed = airborne ? point_distance(0,0,x_speed,y_speed) : abs(ground_spd);
        			if(abs_speed < super_speed_min){
        				super_speed = false;
        			}
        		} else{
        			if(super_speed_fadeout != 0){
        				super_speed_fadeout--;
        			}
        		}
                #endregion
                
        		#region push sensors
        		var push_sensor = noone;
        		//push sensors start from the center of the player if sliding or airborne
        		var push_height = (sliding || airborne) ? 0 : -8;
        		if((!airborne && ground_spd < 0) || airborne) { //left
        			vec_l = new Vector2(-w_radius,push_height);
        			vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
        			if(airborne){
        				push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,4,abs(x_speed));
        			} else {
        				push_sensor = sensor(vec_l,snap_to_90(sensor_angle)-90,4,abs(ground_spd));
        			}
        			if(push_sensor != noone && push_sensor.distance < 1){
        				if (sensor_trigger(push_sensor)){
        					x+= push_sensor.x;
        					y+= push_sensor.y;
        					
        					if(abs(angle_difference(push_sensor.angle,ground_angle)) >= 50){
        						if(!airborne && !sliding && !state.state_is("pushing")) state.change("pushing");
        						ground_spd = 0;
        						x_speed = 0;
        					}
        				}
        			} 
        		}  
        		if((!airborne && ground_spd > 0) || airborne){ //right
        			vec_r = new Vector2(w_radius,push_height);
        			vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
        			if(airborne){
        				push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,4,abs(x_speed));
        			} else {
        				push_sensor = sensor(vec_r,snap_to_90(sensor_angle)+90,4,abs(ground_spd));
        			}
        			if(push_sensor != noone && push_sensor.distance < 1){		
        				
        				if (sensor_trigger(push_sensor)){
        					x+= push_sensor.x;
        					y+= push_sensor.y;
        					
        					if(abs(angle_difference(push_sensor.angle,ground_angle)) >= 50){
        						if(!airborne && !sliding && !state.state_is("pushing")) state.change("pushing");
        						ground_spd = 0;
        						x_speed = 0;
        					}
        				}
        			} 
        		}
        		#endregion
                
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
            
                    var sensor_length = airborne ? sensor_length_base+y_speed : sensor_length_base;
            
                    var bl_sensor = sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_base,sensor_length);
                    var br_sensor = sensor(vec_br,snap_to_90(sensor_angle),sensor_length_base,sensor_length);
            
                    //sensors check which is closest to the ground
                    var updown_sensor = noone;
            
                        if(bl_sensor != noone && br_sensor != noone){
                            //if both sensors collide, the one with the shortest distance wins
                            if(bl_sensor.distance < br_sensor.distance) updown_sensor = bl_sensor;
                            else updown_sensor = br_sensor;	
                        }
                        else if(bl_sensor != noone) updown_sensor = bl_sensor;
                        else if(br_sensor != noone) updown_sensor = br_sensor;
            
                    //if airborne, you only get snapped to the ground, when sensor is inside the ground
                    if(updown_sensor != noone && ( !airborne || (airborne && updown_sensor.y < 0) )){
                        
                        if (sensor_trigger(updown_sensor)){
                            x+= updown_sensor.x;
                            y+= updown_sensor.y;
                            
                            ground_angle = updown_sensor.angle;	
                            
                            if(airborne){ //just as you land from being airborne
                                image_to_ground_angle = true;
                                airborne = false;
                                on_land = true;
                                dash_air_count = 0;
                                attack_count = 0;
                                double_jump_count = 0;
                                set_ground_spd_from_air_spd();
                            }
                        }
    
                    } else if(!airborne){ //going off ledges
                        airborne = true;
                
                        if(sliding){ //when sliding off a surface, you are angled
                            if(ground_spd > 0){
                                image_angle -= 90;
                                mirror = 1;
                            } else{
                                image_angle += 90;
                                mirror = -1;
                            }
                        }	
                        //falling
                        if(y_speed < 0) state.change("fall_up");
                        else state.change("begin_fall");
                    }
                } else
        
                #endregion
                
        		#region ceiling sensors
        		if(airborne){
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
        	
        			//sensors check which is closest to the ceiling
        			var updown_sensor = noone;
        			if(airborne && y_speed < 0){
        				if(tl_sensor != noone && tr_sensor != noone){
        					//if both sensors collide, the one with the shortest distance wins
        					if(tl_sensor.distance < tr_sensor.distance) updown_sensor = tl_sensor;
        					else updown_sensor = tr_sensor;	
        				}
        				else if(tl_sensor != noone) updown_sensor = tl_sensor;
        				else if(tr_sensor != noone) updown_sensor = tr_sensor;
        				
        				if (updown_sensor != noone && updown_sensor.distance < 0 && sensor_trigger(updown_sensor)){
        					x+= updown_sensor.x;
        					y+= updown_sensor.y;
        					
        					on_ceiling = true
        						
        					//up slipping, if you bump head on the ceiling at an edge, and there's space on the left/right you move in that direction
        					if((tl_sensor != noone xor tr_sensor != noone) && !point_sensor(vec_t)){
        						if(tl_sensor){
        							x_speed += 0.1;
        							x += 1;
        						} else
        						if(tr_sensor){
        							x_speed  -= 0.1;
        							x -= 1;
        						}
        					}
        				}
        			}
        		}
                #endregion
                
        	}
        
        	
            #region edge slipping animation
            if(!state.state_is("edge") && !airborne && !sliding && (bl_sensor != noone xor br_sensor != noone) && !point_sensor(vec_b) && ground_angle == 0 && ground_spd == 0){
            	if(bl_sensor) mirror = 1;
            	else mirror = -1;
            	state.change("edge");
            }
            
            
            #endregion
        
            #region hitbox collisions
            var list_ = ds_list_create()
            var num_ = instance_place_list(x,y,obj_trigger_hitbox,list_,false);
            if (num_ > 0){
                for (var i = 0; i < num_; ++i;)
                {
                    list_[| i].trigger(id);
                }
            }
            ds_list_clear(list_);
            
            //enemy collisions
            num_ = instance_place_list(x,y,obj_enemy,list_,false);
            for (var i = 0; i < num_; ++i;){
                var entity_ = list_[| i];
                if (ds_list_find_index(attack_list,entity_) == -1 && entity_.invulnerable == 0){ 
                    
                    //Landing on enemy
                    var side = find_side(x,y,entity_);
                    if(airborne && side == SIDES.Top && y_speed > 0){
                        invulnerable++
                        
                        state.change("enemy_jump");
                        double_jump_count = 0;
                        dash_air_count = 0;
                        
                        entity_.x_speed = random_range(-1,1);
                        entity_.y_speed = -1;
                        entity_.state.change("stunned")
                        entity_.hurt();
                        
                        //global.camera.shake_screen(4,game_speed*0.5);
                        //freeze_frame(0.05);
                        //part_particles_create(global.particles,entity_.x,entity_.y,global.part_stars,1);
                        
                    } else if(super_speed){	
                        //Dashing into enemy
                        ds_list_add(attack_list,entity_)
                        
                        
                        
                        entity_.x_speed = sign(-x_speed) * 1;
                        entity_.y_speed = -3;
                        entity_.state.change("stunned")
                        entity_.hurt();
                        
                        //global.camera.shake_screen(4,game_speed*0.5);
                        //freeze_frame(0.12);
                        //part_particles_create(global.particles,entity_.x,entity_.y,global.part_stars,3);
                    }
                }
            } 
            
            //removes entities from attack list when no longer colliding
            for (var i = 0; i < ds_list_size(attack_list); ++i;){
                var entity_ = attack_list[|i];
                if (ds_list_find_index(list_,entity_) == -1){
                    ds_list_delete(attack_list,i);
                    i--;
                }
            }
            
            
            ds_list_destroy(list_)
            
            #endregion
        }
        
        #region audio
        
        if(sliding){
        	if(!audio_is_playing(sound_slide)){
        		sound_slide = audio_play_sound(snd_slide,0,true,1,0,1.2);
        	}
        	
        	var gain = (abs(ground_spd) / slide_top_speed)
        	audio_sound_gain(sound_slide,gain,0);
        	
        } else if(audio_is_playing(sound_slide)){
        	audio_stop_sound(sound_slide);
        }
        
        
        #endregion
        
        #region squish scale_x & scale_y
        if(squishing){
        	if(squishing_t != squishing_duration){
        		var val = animcurve_read(ac_squish,0,squishing_t/squishing_duration)
        		
        		scale_x = lerp(1,scale_x_squish,val);
        		scale_y = lerp(1,scale_y_squish,val);
        		
        		squishing_t++;
        	} else squishing = false;	
        }
        
        //scale_x = lerp(scale_x,1,0.5);
        //scale_y = lerp(scale_y,1,0.5);
        #endregion
        
        if(image_to_ground_angle){
        	image_angle += angle_difference(ground_angle,image_angle)*0.5;
        }
        
        if(invulnerable > 0) invulnerable--;
        
        if(control_lock != 0) control_lock--;
    }
}
/// @description step
if(CAN_MOVE){
    subimg+= (sprite_get_speed(sprite_index)*anim_speed);
    
    state.step();
    
    if(godmode){
        input_h = (InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT));
        input_v = (InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP));
        
        x+=input_h * 4;
        y+=input_v * 4;
        
    } else {
        if(controlled && global.control){
            #region input
            if(control_lock == 0){
                input_h = (InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT));
                input_v = (InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP));
                
                if(!airborne && !sliding && input_v == 1){
                    state.change("begin_slide");
                } else if(input_v == -1 && !airborne && !state.state_is("end_slide") && !state.state_is("look_up")){
                    if(sliding){
                        if(FORCE_SLIDE_FALSE && !collision_line(x-w_radius_normal-1,y-h_radius_normal-2,x+w_radius_normal+1,y-h_radius_normal-2,ENTITY_COLLISION_LAYER,true,true)){
                            state.change("end_slide");
                        }
                    } else if(abs(ground_spd) < 2){
                        state.change("look_up");
                    }
                }
                
                if(InputBufferPressed(INPUT_VERB.DASH,10)){ 
                    if(airborne){ 
                        if(dash_air_count == 0){ 
                            state.change("dash_air_charge"); 
                        }
                    } else if(ground_angle <= 45 || ground_angle >= 315) {
                        state.change("dash_charge");
                    }
                }
                if(InputBufferPressed(INPUT_VERB.ATTACK,10)){
                    if(attack_count == 0 && attack_cooldown == 0 && (ground_angle <= 45 || ground_angle >= 315)) {
                        state.change("attack_1");
                    }
                }
            }
            if(InputPressed(INPUT_VERB.JUMP)){
                vec_t = new Vector2(0,-h_radius-1);
                if(sliding && sensor(vec_t,snap_to_90(sensor_angle)+180,sensor_length_base) != noone){
                    //if sliding it checks if you're under a block
                    squish(0.8,1.2,GAME_SPEED*0.2);
                } else {
                    if(!airborne) state.change("jump");
                    else if(double_jump_count == 0) state.change("double_jump");
                }
            }
            #endregion
            
            #region movement on ground
            if(!airborne){
                
                //inclines above 45 degrees force you to slide
                if(!sliding && !FORCE_SLIDE_FALSE){
                    state.change("begin_slide")
                }
                
                var slippery_ = 1;
                if(place_meeting(x,y,obj_slippery)){
                    slippery_ = slippery_multiplier
                }
                
                if(input_h != 0){
                    //if top speed has already been exceeded before this event
                    //that becomes the new temporary top speed
                    //like for speed ramps and springs and dashing
                    if(abs(ground_spd) > top_speed) var ground_top_speed_ = abs(ground_spd); 
                    else ground_top_speed_ = top_speed;
                    ground_top_speed_ = min(ground_top_speed_,absolute_top_speed);
                    
                    //if pressing in the opposite direction of ground_spd it decelerates
                    if(ground_spd != 0 && sign(ground_spd) != input_h){ //decelerates
                        
                        //deceleration speed is a bit higher than acceleration speed. but it's only used if ground_speed has already surpassed it
                        if(abs(ground_spd) >= deceleration_speed){
                            ground_spd += deceleration_speed * input_h * slippery_;
                        } else {
                            ground_spd += acceleration_speed * input_h * slippery_;
                        }
                        
                    } else { //accelerate
                        ground_spd += acceleration_speed * input_h;
                    }
                    
                    //clamps to top speed
                    ground_spd = clamp(ground_spd,-ground_top_speed_,ground_top_speed_);
                    
                } else if(slippery_ == 1) { //stop | apply friction
                    ground_spd -= min(abs(ground_spd), friction_speed) * sign(ground_spd); //decelerate
                }
                
                //speed depends on the angle of the floor
                ground_spd-=slope_factor * dsin(ground_angle);	
                
                // Calculate x and y_speed from ground_speed
                x_speed = ground_spd * dcos(ground_angle)
                y_speed = ground_spd * -dsin(ground_angle)
            
                //slipping and floor detatching
                if(control_lock == 0){
                    //should player slip_
                    var slip_ = false;
                    
                    if(abs(ground_spd) < ground_slip_min_spd_ceiling && (ground_angle > force_slide_angle_ceiling && ground_angle < 360-force_slide_angle_ceiling)){
                        slip_ = true;	
                    } else if(abs(ground_spd) < ground_slip_min_spd && (ground_angle > force_slide_angle && ground_angle < 360-force_slide_angle)){
                        slip_ = true;
                    }
                    
                    if(slip_){
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
                if(abs(x_speed) > air_horizontal_top_speed) var x_top_speed_ = abs(x_speed); 
                else x_top_speed_ = air_horizontal_top_speed;
                x_top_speed_ = min(x_top_speed_,absolute_top_speed);
                
                if(abs(y_speed) > air_vertical_top_speed) var y_top_speed_ = abs(y_speed); 
                else y_top_speed_ = air_vertical_top_speed;
                y_top_speed_ = min(y_top_speed_,absolute_top_speed);
                
                x_speed += air_acceleration_speed * input_h;
                y_speed += gravity_force;
                
                //air drag
                if (y_speed < 0 && y_speed > -4){
                    x_speed -= floor(x_speed / 0.125) / 256;
                }
            
                x_speed = clamp(x_speed,-x_top_speed_,x_top_speed_);
                y_speed = clamp(y_speed,-y_top_speed_,y_top_speed_);
                
                image_angle -= angle_difference(image_angle,0) * rotation_speed;
                if(abs(angle_difference(image_angle,0)) < 1 ) image_angle = 0;
            }
            #endregion
            
            if(on_land) on_land = false;
            if(on_ceiling) on_ceiling = false;
            
            var substeps_ = 1
            if(!airborne) substeps_ += abs(ground_spd) div 10;
            //additional substeps_ if you are going fast
            
            repeat(substeps_){
                #region speed
                
                x+=x_speed / substeps_;
                y+=y_speed / substeps_;
                
                //when airborne sensors aren't rotated at all
                sensor_angle = (airborne) ? 0 : ground_angle;
                
                //super speed 
                if(abs(ground_spd) >= super_speed_threshold && !super_speed){
                    super_speed = true;
                    super_speed_fadeout = super_speed_fadeout_time;
                    super_speed_trace_arr = [];
                } else
                
                if(super_speed){		
                    var abs_speed_ = airborne ? point_distance(0,0,x_speed,y_speed) : abs(ground_spd);
                    if(abs_speed_ < super_speed_min){
                        super_speed = false;
                    }
                } else{
                    if(super_speed_fadeout != 0){
                        super_speed_fadeout--;
                    }
                }
                #endregion
                
                #region push sensors
                var push_sensor_ = noone;
                //push sensors start from the center of the player if sliding or airborne
                var push_height_ = (sliding || airborne) ? 0 : -8;
                if((!airborne && ground_spd < 0) || airborne) { //left
                    vec_l = new Vector2(-w_radius,push_height_);
                    vec_l = vec_l.rotated(-snap_to_90(sensor_angle));
                    if(airborne){
                        push_sensor_ = sensor(vec_l,snap_to_90(sensor_angle)-90,4,abs(x_speed));
                    } else {
                        push_sensor_ = sensor(vec_l,snap_to_90(sensor_angle)-90,4,abs(ground_spd));
                    }
                    if(push_sensor_ != noone && push_sensor_.distance < 1){
                        if (sensor_trigger(push_sensor_)){
                            x+= push_sensor_.x;
                            y+= push_sensor_.y;
                            
                            if(abs(angle_difference(push_sensor_.angle,ground_angle)) >= 50){
                                if(!airborne && !sliding && !state.state_is("pushing")) state.change("pushing");
                                ground_spd = 0;
                                x_speed = 0;
                            }
                        }
                    } 
                }  
                if((!airborne && ground_spd > 0) || airborne){ //right
                    vec_r = new Vector2(w_radius,push_height_);
                    vec_r = vec_r.rotated(-snap_to_90(sensor_angle));
                    if(airborne){
                        push_sensor_ = sensor(vec_r,snap_to_90(sensor_angle)+90,4,abs(x_speed));
                    } else {
                        push_sensor_ = sensor(vec_r,snap_to_90(sensor_angle)+90,4,abs(ground_spd));
                    }
                    if(push_sensor_ != noone && push_sensor_.distance < 1){		
                        
                        if (sensor_trigger(push_sensor_)){
                            x+= push_sensor_.x;
                            y+= push_sensor_.y;
                            
                            if(abs(angle_difference(push_sensor_.angle,ground_angle)) >= 50){
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
                    
                    var sensor_length_ = airborne ? sensor_length_base+y_speed : sensor_length_base;
                    
                    var bl_sensor_ = sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_base,sensor_length_);
                    var br_sensor_ = sensor(vec_br,snap_to_90(sensor_angle),sensor_length_base,sensor_length_);
                    
                    //sensors check which is closest to the ground
                    var updown_sensor_ = noone;
                    
                        if(bl_sensor_ != noone && br_sensor_ != noone){
                            //if both sensors collide, the one with the shortest distance wins
                            if(bl_sensor_.distance < br_sensor_.distance) updown_sensor_ = bl_sensor_;
                            else updown_sensor_ = br_sensor_;	
                        }
                        else if(bl_sensor_ != noone) updown_sensor_ = bl_sensor_;
                        else if(br_sensor_ != noone) updown_sensor_ = br_sensor_;
                    
                    //if airborne, you only get snapped to the ground, when sensor is inside the ground
                    if(updown_sensor_ != noone && ( !airborne || (airborne && updown_sensor_.y < 0) )){
                        
                        if (sensor_trigger(updown_sensor_)){
                            x+= updown_sensor_.x;
                            y+= updown_sensor_.y;
                            
                            ground_angle = updown_sensor_.angle;	
                            
                            //on land
                            if(airborne){
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
                    
                    var tl_sensor_ = sensor(vec_tl,snap_to_90(sensor_angle)+180,sensor_length_base);
                    var tr_sensor_ = sensor(vec_tr,snap_to_90(sensor_angle)+180,sensor_length_base);
                    
                    //sensors check which is closest to the ceiling
                    var updown_sensor_ = noone;
                    if(airborne && y_speed < 0){
                        if(tl_sensor_ != noone && tr_sensor_ != noone){
                            //if both sensors collide, the one with the shortest distance wins
                            if(tl_sensor_.distance < tr_sensor_.distance) updown_sensor_ = tl_sensor_;
                            else updown_sensor_ = tr_sensor_;	
                        }
                        else if(tl_sensor_ != noone) updown_sensor_ = tl_sensor_;
                        else if(tr_sensor_ != noone) updown_sensor_ = tr_sensor_;
                        
                        if (updown_sensor_ != noone && updown_sensor_.distance < 0 && sensor_trigger(updown_sensor_)){
                            x+= updown_sensor_.x;
                            y+= updown_sensor_.y;
                            
                            on_ceiling = true
                                
                            //up slipping, if you bump head on the ceiling at an edge, and there's space on the left/right you move in that direction
                            if((tl_sensor_ != noone xor tr_sensor_ != noone) && !point_sensor(vec_t)){
                                if(tl_sensor_){
                                    x_speed += 0.1;
                                    x += 1;
                                } else
                                if(tr_sensor_){
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
            if(!state.state_is("edge") && !airborne && !sliding && (bl_sensor_ != noone xor br_sensor_ != noone) && !point_sensor(vec_b) && ground_angle == 0 && ground_spd == 0){
                if(bl_sensor_) mirror = 1;
                else mirror = -1;
                state.change("edge");
            }
            
            
            #endregion
        
            #region hitbox collisions
            var list_ = ds_list_create()
            var num_ = instance_place_list(x,y,obj_trigger_hitbox,list_,false);
            if (num_ > 0){
                for (var i_ = 0; i_ < num_; ++i_;)
                {
                    list_[| i_].trigger(id);
                }
            }
            ds_list_clear(list_);
            
            if(!state.state_is("attack_1")){
                //enemy collisions
                num_ = instance_place_list(x,y,obj_enemy,list_,false);
                for (var i_ = 0; i_ < num_; ++i_;){
                    var entity_ = list_[| i_];
                    if (ds_list_find_index(attack_list,entity_) == -1 && entity_.invulnerable == 0){ 
                        
                        //Landing on enemy
                        var side_ = find_side(x,y,entity_);
                        if(airborne && entity_.jump_attackable && side_ == SIDES.TOP && y_speed > 0){
                            invulnerable++
                            
                            state.change("enemy_jump");
                            double_jump_count = 0;
                            dash_air_count = 0;
                            attack_count = 0;
                            
                            entity_.x_speed = random_range(-1,1);
                            entity_.y_speed = -1;
                            entity_.state.change("stunned")
                            entity_.hurt();
                            
                        } else if(super_speed){	
                            //Dashing into enemy
                            ds_list_add(attack_list,entity_)
                            
                            entity_.x_speed = sign(-x_speed) * 1;
                            entity_.y_speed = -3;
                            entity_.state.change("stunned")
                            entity_.hurt();
                        }
                    }
                } 
                
                //removes entities from attack list when no longer colliding
                for (var i_ = 0; i_ < ds_list_size(attack_list); ++i_;){
                    var entity_ = attack_list[|i_];
                    if (ds_list_find_index(list_,entity_) == -1){
                        ds_list_delete(attack_list,i_);
                        i_--;
                    }
                }
                
                ds_list_destroy(list_)
            }
            
            #endregion
        }
        
        #region audio
        
        if(sliding){
            if(!audio_is_playing(sound_slide)){
                sound_slide = audio_play_sound(snd_slide,0,true,1,0,1.2);
            }
            
            var gain_ = (abs(ground_spd) / slide_top_speed)
            audio_sound_gain(sound_slide,gain_,0);
            
        } else if(audio_is_playing(sound_slide)){
            audio_stop_sound(sound_slide);
        }
        
        
        #endregion
        
        #region squish scale_x & scale_y
        if(squishing){
            if(squishing_t != squishing_duration){
                var val_ = animcurve_read(ac_squish,0,squishing_t/squishing_duration)
                
                scale_x = lerp(1,scale_x_squish,val_);
                scale_y = lerp(1,scale_y_squish,val_);
                
                squishing_t++;
            } else squishing = false;	
        }

        #endregion
        
        if(image_to_ground_angle){
            image_angle += angle_difference(ground_angle,image_angle)*0.5;
        }
        
        if(invulnerable > 0) invulnerable--;
        if(control_lock > 0) control_lock--;
        if(attack_cooldown > 0) attack_cooldown--;
        
        
    }
}
/// @description

global.camera.follow = self;
global.camera.move(x,y,0);

#region variables
godmode = false;

input_h = 0;
input_v = 0;

x_speed = 0;
y_speed = 0;

normal_acceleration_speed = 0.1;
normal_deceleration_speed = 0.2;
normal_friction_speed = 0.24;
normal_top_speed = 3;

slide_acceleration_speed = 0.05;
slide_deceleration_speed = 0.4;
slide_friction_speed = 0.08;
slide_top_speed = 8;

slippery_multiplier = 0.2;

absolute_top_speed = 12;

normal_gravity_force = 0.21875;
gravity_force = normal_gravity_force;

air_acceleration_speed = 0.15;
air_horizontal_top_speed = 4;
air_vertical_top_speed = 7;

jump_force = 6.5;
jump_release_force = 4;
double_jump_force = 4;
double_jump_count = 0;
enemy_jump_force = 5.4;

hurt_x_force = 2;
hurt_y_force = -5.4;
hurt_gravity_force = 0.1875;

dash_air_force = 5.4;
dash_air_windup = game_speed*0.2;
dash_air_count = 0;

dash_ground_force_min = 4;
dash_ground_force_max = 12;
dash_ground_force = undefined;
dash_ground_windup = game_speed*1; //you can hold it down longer, but after this it's hit max potential

rotation_speed = 0.0215 * 2; //when going airborne how fast you rotate to be back upright

normal_slope_factor = 0.129;
slide_slope_factor  = 0.255;
slope_factor = normal_slope_factor;

acceleration_speed = normal_acceleration_speed;
deceleration_speed = normal_deceleration_speed;
friction_speed = normal_friction_speed;
top_speed = normal_top_speed;

ground_spd = 0; //how fast it's moving on the ground
ground_angle = 0; //the grounds angle

force_slide_angle = 45; //if you walk on an incline above this angle you're forced into sliding
#macro force_slide_false (ground_angle < force_slide_angle || ground_angle > 360-force_slide_angle)

force_detatch_angle = 120;

ground_slip_min_spd = 4 //if abs ground_speed is less than this, and on steep slopes you will start slipping or even detatching
ground_slip_min_spd_ceiling = 5

force_slide_angle_ceiling = 170; //above this angle ground_slip_min_spd_ceiling is used

slip_control_lock_time = game_speed * 0.2;

w_radius_normal = 6;
h_radius_normal = 9;
w_radius_slide	= 8; 
h_radius_slide	= 6; 
w_radius		= w_radius_normal; //width radius
h_radius		= h_radius_normal; //height radius`?=)

airborne = false;
sliding = false;

super_speed = false;
super_speed_min = 4;
super_speed_threshold = 10;
super_speed_trace_arr = [];
super_speed_trace_count = 6;
super_speed_trace_offset = 1;
super_speed_fadeout = 0;
super_speed_fadeout_time = game_speed * 1;
super_speed_colors = [red,red,red,red,red,red,white,white,white,white,white,white]//[white,red,white,yellow,white,green,white,blue,white,pink];

super_speed_u_color = shader_get_uniform(sh_color,"u_color");
super_speed_u_intensity = shader_get_uniform(sh_color,"u_intensity");

attack_jump_force = 3;
attack_count = 0;
attacking = false;

//after attacking there's a slim window where you can extend the combo
attack_combo_max = 26; 
attack_combo_min = 3;
attack_combo_launch = 8; //at this time the entity will be launched away
attack_combo_t = 0;
//offset from origin where attack radius occurs
attack_x = 16;
attack_y = -8;
attack_radius = 16;
meteor_radius = 18;
//enemies/entities currently being attacked
attack_list = ds_list_create()

on_land = false; //this is true on the frame you land again
on_ceiling = false; //this is true whenever you are touching the ceiling

mirror = 1; //+1 right | -1 left

//squishing
scale_x = 1;
scale_y = 1;
scale_x_squish = 1;
scale_y_squish = 1;
squishing = false;
squishing_t = 0;
squishing_duration = 0;

subimg = 0;
anim_speed = 1; //set to -1 to reverse

t = 0; //used for some states as a timer
t2 = 0; //a secondary timer
image_to_ground_angle = true;

control_lock = 0; //When control lock is non-zero input is disabled, for when slipping down super steep slopes, or springs/speed ramps
controlled = true;
invulnerable = 0; //when over 0, pengu flashes and cannot take damage
invulnerable_duration = game_speed * 1.6;

//sounds
sound_slide = -1;

#endregion

///@function set_control_lock()
///@param duration
set_control_lock = function(duration = game_speed*1){
	control_lock = duration;
	input_h = 0;
}

///@function hurt()
hurt = function(x_side = 0){
	//nothing happens if invulnerable
	if(invulnerable == 0){
		global.camera.shake_screen(4,game_speed*0.5);
		x_speed = hurt_x_force * x_side;
		state.change("hurt");
	}
}

///@function squish()
///@param scale_x_
///@param scale_y_
///@param duration
squish = function(scale_x_,scale_y_,duration = game_speed*0.4){
	scale_x = scale_x_;
	scale_y = scale_y_;
	scale_x_squish = scale_x_;
	scale_y_squish = scale_y_;
	squishing = true;
	squishing_t = 0;
	squishing_duration = duration;
}

#region sensors

vec_r = new Vector2(0,0); //right
vec_l = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom
vec_t = new Vector2(0,0); //top

vec_bl = new Vector2(0,0); //bottom left
vec_br = new Vector2(0,0); //bottom right

vec_tl = new Vector2(0,0); //top left
vec_tr = new Vector2(0,0); //top right

sensor_angle = 0;
sensor_length_base = 8;

#endregion

pick_move_state = function(include_idle = true){
	if (input_h != 0){
		if( input_h != mirror ) state.change("turning");
		else if( !state.state_is("running") )state.change("running");
	} else if(include_idle && !state.state_is("idle")){
		state.change("idle");
	}
}


#region states
// feather disable gm1065
state = new SnowState("idle");

	state.event_set_default_function("draw",function(){
		//when rotated on slopes, pengu appears a few pixels off
		var slope_offset_y = 0;
		if(!airborne) slope_offset_y = abs(dsin(ground_angle*2)) * sign(dcos(ground_angle))  * 4 //the pixel offset when at a 45deg angle
		draw_sprite_ext(sprite_index,subimg,x,y+slope_offset_y,scale_x*mirror,scale_y,image_angle,-1,1);
	})
	
	state.event_set_default_function("draw_gui",function(){
		
	})
	
	//parent states
	state.add("tall",{
		enter: function(){
			mask_index = spr_pengu_hitbox_tall;
			w_radius = w_radius_normal;
			h_radius = h_radius_normal;
			subimg = 0;
			anim_speed = 1;
			image_to_ground_angle = true;
			airborne = false;
			sliding = false;
		
			acceleration_speed	= normal_acceleration_speed;
			deceleration_speed	= normal_deceleration_speed;
			friction_speed		= normal_friction_speed;
			top_speed			= normal_top_speed;
			
			slope_factor		= normal_slope_factor;
		}
	})

	state.add("prone",{
		enter: function(){
			mask_index = spr_pengu_hitbox_prone;
			w_radius = w_radius_slide;
			h_radius = h_radius_slide;
			subimg = 0;
			anim_speed = 1;
			image_to_ground_angle = true;
			airborne = false;
			sliding = true;
			
			acceleration_speed	= slide_acceleration_speed;
			deceleration_speed	= slide_deceleration_speed;
			friction_speed		= slide_friction_speed;
			top_speed			= slide_top_speed;
			
			slope_factor		= slide_slope_factor;
		
		}
	})

	state.add("airborne",{
		enter: function(){
			mask_index = spr_pengu_hitbox_tall;
			w_radius = w_radius_normal;
			h_radius = h_radius_normal;
			subimg = 0;
			anim_speed = 1;
			image_to_ground_angle = false;
			airborne = true;
			sliding = false;
		}
	})
	
	//states where pengu is controlled by some object
	state.add_child("airborne","skilift", {
		enter: function() {
			image_angle = 0;
			super_speed = false;
			state.inherit();
			sprite_index = spr_pengu_sitting;
			controlled = false;
			
		}
	})
	
	state.add_child("airborne","spring_ball", {
		enter: function() {
			super_speed = false;
			state.inherit();
			sprite_index = spr_pengu_grab_on;
			controlled = false;
			
		}
	})
	
	state.add_child("airborne","tube", {
		enter: function() {
			state.inherit();
			sprite_index = spr_pengu_spinning;
			controlled = false;
			active_layer = obj_game.active_collisions_A;
			
		},
		step: function(){
			image_angle = point_direction(xstart,ystart,x,y)-90;
			xstart = x;
			ystart = y;

			if(path_position == 1){
				x_speed = lengthdir_x(ground_spd,image_angle+90);
				y_speed = lengthdir_y(ground_spd,image_angle+90);
				
				collision_layer_switch(active_layer,true);
				controlled = true;		
				state.change("launch");
			}	
		}
	})

	//child states
	state.add_child("tall","idle", {
		enter: function() {
			state.inherit();
			sprite_index = spr_pengu_idle;
			
		},
		step: function() {
			pick_move_state();
		}
	})

	state.add_child("tall","turning", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_turn;
			
			mirror = -mirror;
			
			squish(1.2,0.8);
	    },
		step:function(){
			if(animation_end(sprite_index,subimg)){
				pick_move_state();	
			}
		}
	})

	state.add_child("tall","running", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_idle;
	    },
		step: function() {
			pick_move_state();
		}
	})

	state.add_child("tall","pushing", {
	    enter: function() {
			state.inherit()
			mirror = sign(ground_spd);
			sprite_index = spr_pengu_pushing;
	    },
		
		step: function(){
			//need to find a better solution than this
			if(input_h != mirror){
				pick_move_state();
			}
		}
	})
		
	state.add_child("tall","look_up", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_look_up;
	    },
		
		step: function(){
			subimg = clamp(subimg,0,1);
			if(input_v == 0){
				state.change("look_up_end")	
			}
			
			pick_move_state(false);
		}
	})
	
	state.add_child("tall","look_up_end", {
	    enter: function() {
			var _subimg = subimg;
			state.inherit()
			subimg = _subimg;
			sprite_index = spr_pengu_look_up;
			anim_speed = -1;
	    },
		
		step: function(){
			if(subimg <= 0){
				state.change("idle")	
			}
			pick_move_state(false);
		}
	})
	
	state.add_child("tall","edge", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_edge;
	    },
		step: function() {
			pick_move_state(false);
		}
	})
		
	state.add_child("airborne","fall_up", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_jump;
			ground_angle = 0;
	    },
		step: function(){
			if(on_ceiling && y_speed < -jump_release_force){
				y_speed = -jump_release_force;	
			}
			if(y_speed > 0) state.change("begin_fall");
			if(on_land) {
				squish(1.4,0.8,game_speed);
				if(force_slide_false) state.change("idle");
				else state.change("sliding");	
			}
		}
	})
	
	state.add_child("airborne","begin_fall", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_begin_fall;
	    },
		step: function() {
			if (animation_end(sprite_index,subimg)){
				state.change("fall");
			}
		}
	})
	
	state.add_child("airborne","fall", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_fall;
			ground_angle = 0;
	    },
		step: function(){
			if(on_land){
				squish(1.4,0.8,game_speed);
				if(force_slide_false) state.change("idle");
				else state.change("sliding");	
			}
		}
	})
	
	state.add_child("airborne","jump", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_jump;

			var up_down = (ground_angle > 90 && ground_angle < 270) ? -1 : 1;
			
			y_speed = (-jump_force*up_down) - gravity_force //subtracting gravity force cancels out gravity for one frame
			x_speed -= jump_force *dsin(ground_angle) * 0.5;
			
			if(x_speed != 0) mirror = sign(x_speed);
			
			image_angle -= 90 * dsin(ground_angle);
			
			squish(0.4,1.4,game_speed*0.4);
			
			//when jumping from a slide you start rotated
			if(state.get_previous_state() == "sliding"){
				image_angle -= 90 * mirror;
			}
			
			audio_play_sound_random(0,0,snd_jump1,snd_jump2)
	    },
		step: function() {
			if((input_check_released("jump") || on_ceiling) && y_speed < -jump_release_force){
				y_speed = -jump_release_force;	
			}
	
			if(y_speed > 0) state.change("begin_fall");
			if(on_land) pick_move_state();
		}
	})
	
	state.add_child("airborne","launch", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_spinning;		
			
			squish(0.4,2.1);
			
			anim_speed = 0;
			
	    },
		step: function() {
			var spin_spd = point_distance(0,0,x_speed,y_speed);
			subimg+=spin_spd/10;
			
			if (y_speed > 0) state.change("launch_end")
			if(!airborne){
				pick_move_state();
			}
		},
		leave: function(){
			if x_speed != 0{
				if x_speed > 0 mirror = 1;
				else mirror = -1;
			}
		}
	})

	state.add_child("airborne","launch_end", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_spinning_end;
	    },
		step: function() {
			if (animation_end(sprite_index,subimg)){
				state.change("begin_fall");
			}
			if(!airborne){
				//scaleY = 0.7;
				//scaleX = 1.3;
				pick_move_state();
			}
		},
	})
	
	state.add_child("jump","enemy_jump", {
	    enter: function() {
			state.inherit()
			audio_play_sound_random(0,0,snd_jump1,snd_jump2)
			
			var up_down = (ground_angle > 90 && ground_angle < 270) ? -1 : 1;
			y_speed = (-enemy_jump_force*up_down) - gravity_force //subtracting gravity force cancels out gravity for one frame
			x_speed -= enemy_jump_force *dsin(ground_angle) * 0.5;

	    },
	})
	
	state.add_child("jump","hurt", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_hurt;
			var sound = audio_play_sound(snd_hurt,0,false);
			audio_sound_pitch(sound,pitch_change(random_range(2,10)));			
			
			if (global.coins == 0){
				transition(function(){
					obj_game.state.change("level_checkpoint_start");	
					state.change("idle");
				})
				
				
			}else{
				var points = min(global.coins,16);
				point_scatter(points,false,false);
				global.coins = 0;
			}
			
			gravity_force = hurt_gravity_force;			
			invulnerable = invulnerable_duration;
			
			set_control_lock(game_speed*0.8);
			
			y_speed = hurt_y_force;

	    },
		step: function() {	
			
			if(on_land) {
				gravity_force = normal_gravity_force;
				x_speed = 0;
				y_speed = 0;
				ground_spd = 0;
				state.change("idle");
			}
		}
	})
	
	state.add_child("airborne","double_jump", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_flap;

			double_jump_count++;
			y_speed = -double_jump_force;	
			x_speed *= 0.6;
	
			squish(0.4,1.4,game_speed*0.4);
			
			audio_play_sound_random(0,0,snd_wingflap1,snd_wingflap2);
	    },
		step: function() {			
			if(y_speed > 0) state.change("begin_fall");
			if(on_land) state.change("idle");
		},
	})
	
	state.add_child("airborne","attack_1", {
	    enter: function() {
			state.inherit()
            
            if(attack_count == 0 && input_h != 0){
                mirror = input_h;
            }
			
			attack_count++;
            
            attack_combo_t = 0
			attacking = true;
			
			sprite_index = spr_pengu_attack_1;

			y_speed = -attack_jump_force;	
			x_speed *= 0.6;
	
			squish(0.4,1.4,game_speed*0.4);
            
            attack_launch_x = 2;
            attack_launch_y = -2;
            
            attack_hit = false;
            
            attack_next = function(){
                state.change("attack_2");
            }
	    },
		step: function() {
            
            if(attack_combo_t < attack_combo_max){
                if(attack_combo_t < attack_combo_launch){
                    //hits enemies/entities
                    var attack_list_check_ = ds_list_create();
                    
                    var attack_x_ = x+(attack_x*mirror)
                    var attack_y_ = y+attack_y;
                    
                    var num_ = collision_circle_list(attack_x_,attack_y_,attack_radius,obj_enemy,true,true,attack_list_check_,true);
                    
                    for (var i = 0; i < num_; i++) {
                        //does not add entities that are already being hit to the attack list
                        var entity = attack_list_check_[|i];
                        if (ds_list_find_index(attack_list,entity) == -1){
                            ds_list_add(attack_list,entity)
                            entity.state.change("stunned")
                            entity.x_speed = x_speed + attack_launch_x*mirror + random_range(-2,2);
                            entity.y_speed = y_speed + attack_launch_y + random_range(-2,2);
                            
                            entity.hurt();
                            
                            //global.camera.shake_screen(4,game_speed*0.5);
                            //part_particles_create(global.particles,entity.x,entity.y,global.part_stars,4);
                            //freeze_frame();
                            attack_hit = true;
                        }
                    }
                    ds_list_destroy(attack_list_check_)
                    
                    for (var i = 0; i < ds_list_size(attack_list); i++) {
                    	var entity = attack_list[|i];
                        with (entity) {
                            
                            var toward_x_ = sign(attack_x_ - x);
                            var toward_y_ = sign(attack_y_ - y);
                            
                            x = attack_x_;
                            y = attack_y_;
                            
                            //snaps entity to not be inside walls
                            while (place_meeting(x,y,global.tile_collisions)) {
                            	x -= toward_x_;
                                y -= toward_y_;
                            }
                        }
                    }
                }
                //combo can only be continued if your attack hit something
                if(attack_combo_t > attack_combo_min && input_check_pressed("attack") && attack_hit){
                    attack_next()
                }
                
            } else {
                attacking = false
                
                if(y_speed > 0) state.change("begin_fall");
                if(!airborne) state.change("idle");
            }
            
            attack_combo_t++
            
		},
		leave: function(){
			attacking = false;
            ds_list_clear(attack_list)
		}
	})

    state.add_child("attack_1","attack_2",{
        enter: function(){
            state.inherit()
            sprite_index = spr_pengu_attack_2;
            attack_next = function(){
                state.change("attack_3");
            }
            attack_launch_x = 3;
            attack_launch_y = -3;
        }
    })

    state.add_child("attack_1","attack_3",{
        enter: function(){
            state.inherit()
            sprite_index = spr_pengu_attack_3;
            attack_next = function(){
                //no more attacks
            }
            attack_launch_x = 4;
            attack_launch_y = -5;
        }
    })
		
	state.add_child("airborne","dash_air_charge",{
		enter: function(){
			state.inherit();
			sprite_index = spr_pengu_dash_charge_air;
			image_angle = 0;
			y_speed = -2;
			x_speed *= 0.8;
			
			t = 0;
			dash_air_count++;
			
			if(input_h != 0) mirror = input_h;
			else if (x_speed != 0) mirror = sign(x_speed);
			
			squish(1.4,1.4,dash_air_windup);
			
		},
		step: function(){
			
			var posx = (t/dash_air_windup);
			image_angle = animcurve_read(ac_dash_ball_rotate,0,posx)*360 * -mirror;
			t++
			if(t == dash_air_windup){
				state.change("dash_air");	
			}
            
            var attack_list_check_ = ds_list_create();
            var num_ = collision_circle_list(x,y,meteor_radius,obj_enemy,true,true,attack_list_check_,true);
            for (var i = 0; i < num_; i++) {
            	var inst = attack_list_check_[|i];
                if(!inst.invulnerable){
                    inst.invulnerable = true;
                    inst.x_speed = 8*mirror;
                    inst.y_speed = -3;
                    inst.state.change("meteor");
                    
                    inst.hurt();
                }
                
            }
            ds_list_destroy(attack_list_check_)
		},	
	})
	
	state.add_child("prone","dash_air", {
	    enter: function() { 
			
			global.camera.shake_screen(2,game_speed*0.2);
			
			state.inherit();
			airborne = true;
			image_to_ground_angle = false;
			
			sprite_index = spr_pengu_dash;
			
			if(input_h != 0) x_speed += dash_air_force * input_h;
			else x_speed += dash_air_force * mirror;
			y_speed += -4;
			
			image_angle = (mirror) ? 22 : 338;
			
			mirror = sign(x_speed);
			
			squish(1.2,1.2,game_speed*0.2);
			
			super_speed = true;
			super_speed_fadeout = super_speed_fadeout_time;
			super_speed_trace_arr = [];
            
            var attack_list_check = ds_list_create();
            var num = instance_place_list(x,y,obj_enemy,attack_list_check,false);
            for (var i = 0; i < num; i++) {
            	var inst = attack_list_check[|i];
                if(!inst.invulnerable){
                    inst.invulnerable = true;
                    inst.x_speed = 4*-mirror;
                    inst.y_speed = -3;
                    inst.state.change("launched");
                }
                
            }
            ds_list_destroy(attack_list_check)
			
			audio_play_sound(snd_dashing,0,false)
	    },
		step: function() {
			if(on_land){
				state.change("sliding");
			}
		}
	})
	
	state.add_child("prone","dash_charge", {
	
		enter: function(){
			state.inherit();
			sprite_index = spr_pengu_dash_charge;
			
			if(input_h != 0) mirror = input_h;
			
			dash_ground_force = dash_ground_force_min;
			t = 0;
			//t2 = 0;
			//flash = false;
			control_lock = 10;
			input_h = 0;
			
			squish(0.8,1.2,game_speed*0.5);
		},
		step: function(){
			
			control_lock = 10;
			input_h = 0;
			
			if(t < dash_ground_windup) t++;
			if(input_check_released("dash")){
				state.change("dash");
			}
			
			var amount = t/dash_ground_windup;
			dash_ground_force = lerp(dash_ground_force_min,dash_ground_force_max,amount);
			scale_x = lerp(1,1.2,amount);
			scale_y = lerp(1,0.9,amount);
			
		},
		draw_gui: function(){
			var offset = 18;
			var radius = 6;
			
			var x_ = global.camera.room_to_gui_x(x-(offset*mirror));
			var y_ = global.camera.room_to_gui_y(y-offset);
			
			draw_percentage_donut((t/dash_ground_windup),radius,x_,y_,pengu_blue,pengu_white);
		}
	})
	
	state.add_child("prone","dash", {
	    enter: function() {
			
			global.camera.shake_screen(2,game_speed*0.2);
			
			state.inherit()
			sprite_index = spr_pengu_dash;
			ground_spd = dash_ground_force * mirror
			
			squish(1.2,1.2,game_speed*0.8);
			
			t = 0;
			
			super_speed = true;
			super_speed_fadeout = super_speed_fadeout_time;
			super_speed_trace_arr = [];
			
			audio_play_sound(snd_dashing,0,false)
	    },
		step: function() {
			
			t++;
			if(t >= game_speed*1){
				state.change("sliding");
			}
	
		},
	})
	
	state.add_child("prone","begin_slide", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_begin_slide;

	    },
		step: function() {
			if (animation_end(sprite_index,subimg)){
				state.change("sliding");
			}
		},
	})
	
	state.add_child("tall","end_slide", {
	    enter: function() {
			state.inherit()
			subimg = 1;
			sprite_index = spr_pengu_begin_slide;
			anim_speed = -0.8;
			ground_spd *=0.4;
	    },
		step: function() {
			if (subimg <= 0){
				squish(0.8,1.1);
				pick_move_state();
			}
		},
	})
	
	state.add_child("prone","sliding", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_sliding;

			squish(1.4,0.8);

			if(mirror == 1) sliding_subimg = 12; //decides wether to start pointing left or right
			else sliding_subimg = 0;
			
			subimg = sliding_subimg;
			mirror = 1;
	    },
		step: function() {
			sliding_subimg+=ground_spd/20;
			sliding_subimg = clamp(sliding_subimg,0,12);
			subimg = sliding_subimg;
		},
		leave: function() {			
			if(sliding_subimg<6) mirror = -1;
		}
	})

#endregion
// feather restore gm1065

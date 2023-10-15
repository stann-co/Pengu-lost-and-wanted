/// @description
debug = false;

global.camera.follow = self;

#region variables
input_h = 0;

x_speed = 0;
y_speed = 0;

normal_acceleration_speed = 0.1;
normal_deceleration_speed = 0.2;
normal_friction_speed = 0.24;
normal_top_speed = 3;

slide_acceleration_speed = 0.04;
slide_deceleration_speed = 0.4;
slide_friction_speed = 0.08;
slide_top_speed = 10 //8;

absolute_top_speed = 12;

gravity_force = 0.21875;
air_acceleration_speed = 0.0937;
air_horizontal_top_speed = 4;
air_vertical_top_speed = 7;

jump_force = 6.5;
jump_release_force = 4;
double_jump_force = 4;
double_jump_count = 0;

dash_air_force = 5.4;
dash_air_windup = game_speed*0.2;
dash_air_count = 0;

dash_ground_force_min = 4;
dash_ground_force_max = 12;
dash_ground_force = undefined;
dash_ground_windup = game_speed*1; //you can hold it down longer, but after this it's hit max potential

rotation_speed = 0.0215; //when going airborne how fast you rotate to be back upright

normal_slope_factor = 0.215;
slide_slope_factor = 0.425;
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

ground_slip_min_spd = 2 //if abs ground_speed is less than this, and on steep slopes you will start slipping or even detatching
ground_slip_min_spd_ceiling = 4

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

t = 0; //used for some states as a timer
t2 = 0; //a secondary timer
image_to_ground_angle = true;

control_lock = 0; //When control lock is non-zero input is disabled, for when slipping down super steep slopes, or springs/speed ramps

#endregion

///@function set_control_lock()
///@param duration
set_control_lock = function(duration = game_speed*1){
	control_lock = duration;
	input_h = 0;
}

///@function squish()
///@param scale_x_
///@param scale_y_
///@param duration
squish = function(scale_x_,scale_y_,duration = game_speed*0.8){
	scale_x = scale_x_;
	scale_y = scale_y_;
	scale_x_squish = scale_x_;
	scale_y_squish = scale_y_;
	squishing = true;
	squishing_t = 0;
	squishing_duration = duration;
}

set_ground_spd_from_air_spd = function(){
	if(ground_angle <= 23 || ground_angle >= 339){ //landing on mostly flat surface
		ground_spd = x_speed;
	} else if(ground_angle <= 45 || ground_angle >= 316){ //landing on mostly sloped surface
		if( abs(x_speed) >= abs(y_speed) ){ //moving mostly left/right
			ground_spd = x_speed;	
		} else {
			ground_spd = y_speed * -sign(dsin(ground_angle)) * 0.5;
		}				
	} else { //landing on mostly steep surface
		if( abs(x_speed) >= abs(y_speed) ){ //moving mostly left/right
			ground_spd = x_speed;	
		} else {
			ground_spd = y_speed * -sign(dsin(ground_angle));
		}				
	}
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

//sensor_length_push = function(){
//	if(airborne){
//		return sensor_length_base + (abs(x_speed) *	dcos(ground_angle));
//	} else {
//		return sensor_length_base + abs(ground_spd);
//	}
//}

//sensor_length_vertical = function(){
//	if(airborne){
//		return sensor_length_base + (abs(y_speed) * dsin(ground_angle));
//	} else {
//		return sensor_length_base + abs(ground_spd);
//	}
//}

#endregion

pick_move_state = function(include_idle = true){
	if (input_h != 0){
		if( input_h != mirror ) state.change("turning");
		else state.change("running");
	} else if(include_idle && !state.state_is("idle")){
		state.change("idle");
	}
}


#region states
state = new SnowState("idle");
state
	.event_set_default_function("draw",function(){
		draw_sprite_ext(sprite_index,subimg,x,y,scale_x*mirror,scale_y,image_angle,-1,1);
	})
	//parent states
	.add("tall",{
		enter: function(){
			mask_index = spr_pengu_hitbox_tall;
			w_radius = w_radius_normal;
			h_radius = h_radius_normal;
			subimg = 0;
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

	.add("prone",{
		enter: function(){
			mask_index = spr_pengu_hitbox_prone;
			w_radius = w_radius_slide;
			h_radius = h_radius_slide;
			subimg = 0;
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


	.add("airborne",{
		enter: function(){
			mask_index = spr_pengu_hitbox_tall;
			w_radius = w_radius_normal;
			h_radius = h_radius_normal;
			subimg = 0;
			image_to_ground_angle = false;
			airborne = true;
			sliding = false;
		
		}
	})

	//child states

	.add_child("tall","idle", {
		enter: function() {
			state.inherit();
			sprite_index = spr_pengu_idle;
			
		},
		step: function() {
			pick_move_state();
		}
	})

	.add_child("tall","turning", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_idle;
			
			mirror = -mirror;
			
			squish(1.2,0.8);
			
			
	    },
		step:function(){
			if(animation_end(sprite_index,subimg)){
				pick_move_state();	
			}
		}
	})

	.add_child("tall","running", {
	    enter: function() {
			state.inherit();
			sprite_index = spr_pengu_idle;
	    },
		step: function() {
			pick_move_state();
		}
	})

	.add_child("tall","pushing", {
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
	
	.add_child("tall","edge", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_edge;
	    },
		step: function() {
			pick_move_state(false);
		}
	})
	
	.add_child("airborne","begin_fall", {
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
	
	.add_child("airborne","fall", {
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
	
	.add_child("airborne","jump", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_jump;

			var up_down = (ground_angle > 90 && ground_angle < 270) ? -1 : 1;
			
			y_speed = (-jump_force*up_down) - gravity_force //subtracting gravity force cancels out gravity for one frame
			x_speed -= jump_force *dsin(ground_angle) * 0.5;
			
			if(x_speed != 0) mirror = sign(x_speed);
			
			image_angle -= 90 * dsin(ground_angle);
			
			squish(0.4,1.4,game_speed*1);
			
			//when jumping from a slide you start rotated
			if(state.get_previous_state() == "sliding"){
				image_angle -= 90 * mirror;
			}
	    },
		step: function() {
			if((input_check_released("jump") || on_ceiling) && y_speed < -jump_release_force){
				y_speed = -jump_release_force;	
			}
	
			if(y_speed > 0) state.change("begin_fall");
			if(on_land) state.change("idle");
		}
	})
	
	.add_child("jump","hurt", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_hurt;

	    },
		step: function() {	
			if(on_land) state.change("idle");
		}
	})
	
	.add_child("airborne","double_jump", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_flap;

			double_jump_count++;
			y_speed = -double_jump_force;	
			x_speed *= 0.6;
	
			squish(0.4,1.4,game_speed*1);
	    },
		step: function() {			
			if(y_speed > 0) state.change("begin_fall");
			if(on_land) state.change("idle");
		},
	})
		
	.add_child("airborne","dash_air_charge",{
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
		},	
	})
	
	.add_child("prone","dash_air", {
	    enter: function() { 
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
	    },
		step: function() {
			if(on_land){
				state.change("sliding");
			}
		}
	})
	
	.add_child("prone","dash_charge", {
	
		enter: function(){
			state.inherit();
			sprite_index = spr_pengu_dash_charge;
			
			if(input_h != 0) mirror = input_h;
			
			dash_ground_force = dash_ground_force_min;
			t = 0;
			t2 = 0;
			flash = false;
			control_lock = 10;
			input_h = 0;
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
			
			var flash_steps = round(lerp(game_speed*0.2,game_speed*0.05,amount));
			
			t2++;
			
			if(t2 > flash_steps){
				flash = !flash
				t2 = 0;
			}
			
		},
		draw: function(){
			gpu_set_fog(flash,white,0,0);
			draw_sprite_ext(sprite_index,subimg,x,y,scale_x*mirror,scale_y,image_angle,-1,1);
			gpu_set_fog(false,c_black,0,1);
		}
	})
	
	.add_child("prone","dash", {
	    enter: function() {
			state.inherit()
			sprite_index = spr_pengu_dash;
			ground_spd = dash_ground_force * mirror
			
			squish(1.2,1.2,game_speed*0.2);
			
			t = 0;
	    },
		step: function() {
			
			t++;
			if(t >= game_speed*1){
				state.change("sliding");
			}
	
		},
	})
	
	.add_child("prone","begin_slide", {
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
	
	.add_child("prone","sliding", {
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
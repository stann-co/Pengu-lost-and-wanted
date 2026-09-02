/// @description
event_inherited();

//depth-=10; //by default pengu is above other entities

global.camera.follow = self;
global.camera.move(x,y,0);
global.camera.zoom(1,0);

#region variables
godmode = false;

input_h = 0;
input_v = 0;

normal_acceleration_speed = 0.1;
normal_deceleration_speed = 0.2;
normal_friction_speed = 0.24;
normal_top_speed = 3.073112;

slide_acceleration_speed = 0.05;
slide_deceleration_speed = 0.4;
slide_friction_speed = 0.08;
slide_top_speed = 9;//8.2144;

slippery_multiplier = 0.2;

absolute_top_speed = 12;

normal_gravity_force = 0.21875;
gravity_force = normal_gravity_force;

air_acceleration_speed = 0.15;
air_horizontal_top_speed = 4;
air_vertical_top_speed = 7;

jump_force = 6.3;
jump_absolute_force = 9;
jump_release_force = 4;
double_jump_force = 4;
double_jump_count = 0;
enemy_jump_force = 5.4;

hurt_x_force = 2;
hurt_y_force = -5.4;
hurt_gravity_force = 0.1875;

dash_air_force = 5.4;
dash_air_windup = SECOND*0.2;
dash_air_count = 0;

dash_ground_force_min = 4;
dash_ground_force_max = slide_top_speed;
dash_ground_force = undefined;
dash_ground_windup = SECOND*1; //you can hold it down longer, but after this it's hit max potential

rotation_speed = 0.0215 * 2; //when going airborne how fast you rotate to be back upright

normal_slope_factor = 0.129;
slide_slope_factor  = 0.22;//0.255;
slope_factor = normal_slope_factor;

acceleration_speed = normal_acceleration_speed;
deceleration_speed = normal_deceleration_speed;
friction_speed = normal_friction_speed;
top_speed = normal_top_speed;

force_slide_angle = 45; //if you walk on an incline above this angle you're forced into sliding
#macro FORCE_SLIDE_FALSE (ground_angle < force_slide_angle || ground_angle > 360-force_slide_angle)

force_detatch_angle = 120;

ground_slip_min_spd = 4; //if abs ground_speed is less than this, and on steep slopes you will start slipping or even detatching
ground_slip_min_spd_ceiling = 5.6;

force_slide_angle_ceiling = 170; //above this angle ground_slip_min_spd_ceiling is used

slip_control_lock_time = SECOND * 0.2;

w_radius_normal = 6;
h_radius_normal = 9;
w_radius_slide	= 8; 
h_radius_slide	= 6; 
w_radius		= w_radius_normal; //width radius
h_radius		= h_radius_normal; //height radius

sliding = false;

super_speed = false;
super_speed_min = 4;
super_speed_threshold = 10;
super_speed_trace_arr = [];
super_speed_trace_count = 6;
super_speed_trace_offset = 1;
super_speed_fadeout = 0;
super_speed_fadeout_time = SECOND * 1;
super_speed_colors = [RED,RED,RED,RED,RED,RED,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE]//[WHITE,RED,WHITE,YELLOW,WHITE,GREEN,WHITE,blue,WHITE,PINK];

super_speed_u_color = shader_get_uniform(sh_color,"u_color");
super_speed_u_intensity = shader_get_uniform(sh_color,"u_intensity");

attack_jump_force = 2;
attack_count = 0;
attacking = false;
attack_x_force = 0;
attack_y_force = -2;
attack_type = ATTACK_TYPES.ATTACK;

attack_hit = false; //wether an attack actually hit anything

//after attacking there's a window where you can extend the combo
attack_combo_max = 12; 
attack_combo_t = 0;
attack_cooldown = 0;
attack_cooldown_max = 16;

//offset from origin where attack radius occurs
attack_x_punch = 16; //for regular punching attacks
attack_y_punch = -8;
attack_x_dunk = 12; //for dunking attacking downwards
attack_y_dunk = 0;
attack_x = attack_x_punch;
attack_y = attack_y_punch;

attack_radius_normal = 16;
attack_radius_meteor = 26;
attack_radius = attack_radius_normal;

//enemies/entities currently being attacked
attack_list = ds_list_create()

entity = noone;

on_land = false; //this is true on the frame you land again
on_ceiling = false; //this is true whenever you are touching the ceiling

t = 0; //used for some states as a timer
t2 = 0; //a secondary timer
image_to_ground_angle = true;

control_lock = 0; //When control lock is non-zero input is disabled, for when slipping down super steep slopes, or springs/speed ramps
set_controlled();
invulnerable = 0; //when over 0, pengu flashes and cannot take damage
invulnerable_duration = SECOND * 1.6;

//sounds
sound_slide = -1;

#endregion

///@function set_control_lock()
///@param duration
set_control_lock = function(_duration = SECOND*1){
	control_lock = _duration;
	input_h = 0;
}

///@function hurt()
hurt = function(_x_side = 0){
	//nothing happens if invulnerable
	if(invulnerable == 0 && !godmode){
		global.camera.shake_screen(4,SECOND*0.5);
		x_speed = hurt_x_force * _x_side;
		state.change("hurt");
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

#endregion

pick_move_state = function(_include_idle = true){
    if(airborne){
        state.change("fall");
    } else if (input_h != 0){
		if( input_h != facing ) state.change("turning");
		else if( !state.state_is("running") )state.change("running");
	} else if(_include_idle && !state.state_is("idle")){
		state.change("idle");
	}
}

#region states
// feather disable gm1065
state = new SnowState("idle");

state.event_set_default_function("draw",function(){
    default_draw();
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
		if(parent != noone){ //TODO is this safe?
			x_speed += parent.x_speed;	
			y_speed += parent.y_speed;
		}
		clear_parent();
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
        //controlled = false;
    }
})

state.add_child("airborne","spring_ball", {
    enter: function() {
        super_speed = false;
        state.inherit();
        sprite_index = spr_pengu_grab_on;
        //controlled = false;
    }
})

state.add_child("airborne","tube", {
    enter: function() {
        state.inherit();
        sprite_index = spr_pengu_spinning;
        //controlled = false;
		//TODO might be broken completely
        //active_layer = layers;
        
    },
    step: function(){
        image_angle = point_direction(xstart,ystart,x,y)-90;
        xstart = x;
        ystart = y;
		
        if(path_position == 1){
            x_speed = lengthdir_x(ground_spd,image_angle+90);
            y_speed = lengthdir_y(ground_spd,image_angle+90);
            
            collision_layer_switch(self,active_layer,true);
            set_controlled();	
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
        
        facing = -facing;
        
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
		anim_speed = 2.5;
        sprite_index = spr_pengu_idle;
    },
    step: function() {
        pick_move_state();
    }
})

state.add_child("tall","pushing", {
    enter: function() {
        state.inherit()
        facing = sign(ground_spd);
        sprite_index = spr_pengu_pushing;
    },
    
    step: function(){
        //need to find a better solution than this
        if(input_h != facing){
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
        var subimg_current_ = subimg;
        state.inherit()
        subimg = subimg_current_;
        sprite_index = spr_pengu_look_up;
        anim_speed = -1;
    },
    
    step: function(){
        if(subimg <= 0){
            state.change("idle");
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
            squish(1.4,0.8,SECOND);
            if(FORCE_SLIDE_FALSE) state.change("idle");
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
            squish(1.4,0.8,SECOND);
            if(FORCE_SLIDE_FALSE) state.change("idle");
            else state.change("sliding");	
        }
    }
})

state.add_child("airborne","jump", {
    enter: function() {
        state.inherit()
        sprite_index = spr_pengu_jump;
		
        var up_down_ = (ground_angle > 90 && ground_angle < 270) ? -1 : 1;
        
		//TODO set absolute jump force, so moving platforms don't let you jump into space
        y_speed += (-jump_force*up_down_) - gravity_force //subtracting gravity force cancels out gravity for one frame
		y_speed = max(-jump_absolute_force,y_speed);
        x_speed -= jump_force *dsin(ground_angle) * 0.5;
        
        if(x_speed != 0) facing = sign(x_speed);
        
        image_angle -= 90 * dsin(ground_angle);
        
        squish(0.4,1.4,SECOND*0.4);
        
        //when jumping from a slide you start rotated
        if(state.get_previous_state() == "sliding"){
            image_angle -= 90 * facing;
        }
        
        audio_play_sound_random(0,0,snd_jump1,snd_jump2)
    },
    step: function() {
        if((InputReleased(INPUT_VERB.JUMP) || on_ceiling) && y_speed < -jump_release_force){
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
        var spin_spd_ = point_distance(0,0,x_speed,y_speed);
        subimg+=spin_spd_/10;
        
        if (y_speed > 0) state.change("launch_end")
        if(!airborne){
            pick_move_state();
        }
    },
    leave: function(){
        if x_speed != 0{
            if x_speed > 0 facing = 1;
            else facing = -1;
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
        
        var up_down_ = (ground_angle > 90 && ground_angle < 270) ? -1 : 1;
        y_speed = (-enemy_jump_force*up_down_) - gravity_force //subtracting gravity force cancels out gravity for one frame
        x_speed -= enemy_jump_force *dsin(ground_angle) * 0.5;

    },
})

state.add_child("jump","hurt", {
    enter: function() {
        state.inherit()
        sprite_index = spr_pengu_hurt;
        var sound_ = audio_play_sound(snd_hurt,0,false);
        audio_sound_pitch(sound_,pitch_change(random_range(2,10)));			
        
        if (global.coins == 0){
            transition(function(){
                obj_game.state.change("level_checkpoint_start");
                state.change("idle");
            })
            
        }else{
            var points_ = min(global.coins,16);
            point_scatter(points_,false,false);
            global.coins = 0;
        }
        
        gravity_force = hurt_gravity_force;			
        invulnerable = invulnerable_duration;
        
        set_control_lock(SECOND*0.8);
        
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
		
        squish(0.4,1.4,SECOND*0.4);
        
        audio_play_sound_random(0,0,snd_wingflap1,snd_wingflap2);
    },
    step: function() {
        if(y_speed > 0) state.change("begin_fall");
        if(on_land) state.change("idle");
    },
})

state.add_child("airborne","attack_base", {
    enter: function() {
        state.inherit()
        
        ds_list_clear(attack_list);
        
        if(attack_count == 0 && input_h != 0){
            facing = input_h;
        }
        
        attack_combo_t = 0
        attacking = true;
		
		attack_radius = attack_radius_normal;
        
        attack_hit = false;
        
        //hits enemies/entities
        var attack_list_check_ = ds_list_create();
        var attack_x_ = x+(attack_x*facing)
        var attack_y_ = y+attack_y;
        
        var num_ = collision_circle_list(attack_x_,attack_y_,attack_radius,obj_enemy,true,true,attack_list_check_,true);
        
        for (var i_ = 0; i_ < num_; i_++) {
            //does not add entities that are already being hit to the attack list
            entity = attack_list_check_[|i_];
            if (ds_list_find_index(attack_list,entity) == -1 && !entity.invulnerable){
                ds_list_add(attack_list,entity)
                //runs on hit
                
                attack_hit = true;
                entity.hurt(attack_type,function(){
                        ///THIS SHOULD ALL BE ON THE ENEMY, NOT ON PENGU
                        entity.state.change("stunned")
                        entity.x_speed = (attack_launch_x + random_range(0,1))*facing;
                        entity.y_speed = (attack_launch_y);
                        entity.x = x+(attack_x*facing);
                        entity.y = y+attack_y;
                });
            }
        }
        ds_list_destroy(attack_list_check_)
        
    },
	step_nofreeze: function() {
		//animate subimg, despite a freeze frame
  		subimg += (sprite_get_speed(sprite_index)*anim_speed);
		subimg = min(subimg,sprite_get_number(sprite_index)-1);
	},
    step: function() {
        if(attack_combo_t < attack_combo_max){
            //combo can only be continued if your attack hit something
			if(attack_hit){
				if(!state.state_is("attack_dunk") && InputCheck(INPUT_VERB.DOWN) && InputBufferPressed(INPUT_VERB.ATTACK,10)){
					state.change("attack_dunk");
				}
	            else if(InputBufferPressed(INPUT_VERB.ATTACK,10)){
	                attack_next()
	            }
				else if(InputBufferPressed(INPUT_VERB.DASH,10)){
					state.change("dash_air_charge");
				}
			}
        } else {
            attacking = false;
            pick_move_state();
        }
        
        attack_combo_t++
        
    },
    leave: function(){
        attacking = false;
        attack_cooldown = attack_cooldown_max;
    }
})

state.add_child("attack_base","attack_1",{
    enter: function(){
		y_speed = attack_y_force;
        x_speed = max(attack_x_force,abs(x_speed))*facing;

        attack_launch_x = abs(x_speed) + 1;
        attack_launch_y = y_speed -3;
		attack_x = attack_x_punch
		attack_y = attack_y_punch
        attack_type = ATTACK_TYPES.ATTACK;
        
        sprite_index = spr_pengu_attack_1;
		subimg = 0;
		
        attack_next = function(){
            state.change("attack_2");
        }
        
        state.inherit()
		
		attack_count++;
    }
})

state.add_child("attack_base","attack_2",{
    enter: function(){ 
		y_speed = attack_y_force;
        x_speed = max(attack_x_force,abs(x_speed))*facing;
		
        sprite_index = spr_pengu_attack_2;
		subimg = 0;
		
        attack_next = function(){
            state.change("attack_3");
        }
        attack_launch_x = abs(x_speed) + 3;
        attack_launch_y = y_speed -3;
		attack_x = attack_x_punch
		attack_y = attack_y_punch
        attack_type = ATTACK_TYPES.ATTACK;
        
        state.inherit()
		
		attack_count++;
    }
})

state.add_child("attack_base","attack_3",{
    enter: function(){
		y_speed = attack_y_force;
        x_speed = max(attack_x_force,abs(x_speed))*facing;
		
        sprite_index = spr_pengu_attack_3;
		subimg = 0;
        attack_next = function(){
            state.change("attack_4");
        }
        attack_launch_x = abs(x_speed) + 4;
        attack_launch_y = y_speed -4;
		attack_x = attack_x_punch
		attack_y = attack_y_punch
        attack_type = ATTACK_TYPES.ATTACK;
        
        state.inherit()
		
		attack_count++;
    }
})

state.add_child("attack_base","attack_4",{
    enter: function(){
		y_speed = attack_y_force;
        x_speed = max(attack_x_force,abs(x_speed))*facing;
		
        sprite_index = spr_pengu_attack_4;
		subimg = 0;
        attack_next = function(){
            //state.change("attack_kick");
        }
        attack_launch_x = abs(x_speed) + 2;
        attack_launch_y = y_speed -6;
		attack_x = attack_x_punch
		attack_y = attack_y_punch
        attack_type = ATTACK_TYPES.ATTACK;
        
        state.inherit()
		
		attack_count++;
    }
})

state.add_child("attack_base","attack_kick", {
    enter: function() {
		y_speed = attack_y_force;
        x_speed = max(attack_x_force,abs(x_speed))*facing;
		
        sprite_index = spr_pengu_attack_kick;
		subimg = 0;
		
        attack_next = function(){ 
            //no more attacks
        }
        attack_launch_x = 6;
        attack_launch_y = -3;
		attack_x = attack_x_punch
		attack_y = attack_y_punch
        attack_type = ATTACK_TYPES.KICK;
        
        state.inherit()
		attack_count++;
        
    }, 
    step: function() {
        if(attack_combo_t >= attack_combo_max){
            attacking = false;
            pick_move_state();
        }
        
        attack_combo_t++
        
    },
})

state.add_child("airborne","attack_dunk_charge",{
    enter: function(){
		state.inherit()
        sprite_index = spr_pengu_attack_dunk;
		subimg = 0;
		anim_speed = 0;
		
		if(InputReleased(INPUT_VERB.ATTACK)){
			state.change("attack_dunk");
		}
    },
	step: function (){
		if(InputReleased(INPUT_VERB.ATTACK)){
			state.change("attack_dunk");
		}
	},
	leave: function(){
		anim_speed = 1;
	}
})

state.add_child("attack_base","attack_dunk",{
    enter: function(){ 
        sprite_index = spr_pengu_attack_dunk;
		subimg = 1;
        attack_next = function(){
            //no more attacks
        }
		attack_radius = attack_radius_meteor;
        attack_launch_x = abs(x_speed);
        attack_launch_y = 4;
		attack_x = attack_x_dunk;
		attack_y = attack_y_dunk;
        attack_type = ATTACK_TYPES.KICK;
        
        state.inherit();
		attack_count++;
		
		if(attack_hit){ //get upwards speed if you dunk
			y_speed = -6;
			double_jump_count = 0;
            dash_air_count = 0;
			attack_count = 0;
		}
    }
})
    
state.add_child("attack_base","dash_air_charge",{
    enter: function(){
		
		attack_radius = attack_radius_meteor;
        attack_launch_x = abs(x_speed) + 2;
        attack_launch_y = y_speed -6;
		attack_x = attack_x_dunk;
		attack_y = attack_y_dunk;
        attack_type = ATTACK_TYPES.KICK;
		
        state.inherit();
		
        sprite_index = spr_pengu_dash_charge_air;
        image_angle = 0;
        y_speed = -2;
        x_speed *= 0.8;
        
        t = 0;
		
        dash_air_count++;
        
        if(input_h != 0) facing = input_h;
        else if (x_speed != 0) facing = sign(x_speed);
        
        squish(1.4,1.4,dash_air_windup);
        
    },
    step: function(){
        
        var posx_ = (t/dash_air_windup);
        image_angle = animcurve_read(ac_dash_ball_rotate,0,posx_)*360 * -facing;
        t++
        if(t == dash_air_windup){
            if(InputCheck(INPUT_VERB.DOWN)) state.change("dash_air_down");
            else if(InputCheck(INPUT_VERB.UP)) state.change("dash_air_up");
            else state.change("dash_air");	
        }
    },	
})

state.add_child("prone","dash_air", {
    enter: function() {  
        state.inherit();
        airborne = true;
		clear_parent();
        image_to_ground_angle = false;
        
        sprite_index = spr_pengu_dash;
        
        if(input_h != 0) x_speed += dash_air_force * input_h;
        else x_speed += dash_air_force * facing;
        y_speed += -4;
        
        image_angle = (facing) ? 22 : 338;
        
        facing = sign(x_speed);
        
        squish(1.2,1.2,SECOND*0.2);
        
        super_speed = true;
        super_speed_fadeout = super_speed_fadeout_time;
        super_speed_trace_arr = [];
        
        var attack_list_check_ = ds_list_create();
        var num_ = instance_place_list(x,y,obj_enemy,attack_list_check_,false);
        for (var i_ = 0; i_ < num_; i_++) {
            var inst_ = attack_list_check_[|i_];
            if(inst_.invulnerable == 0){
                inst_.x_speed = 4*-facing;
                inst_.y_speed = -3;
                inst_.state.change("launched");
            }
            
        }
        ds_list_destroy(attack_list_check_)
        
        audio_play_sound(snd_dashing,0,false)
    },
    step: function() {
        if(on_land){
            state.change("sliding");
        }
    }
})

state.add_child("dash_air","dash_air_down", {
    enter: function() { 
        
        state.inherit();
        
        image_angle = (facing) ? 270 : 90;
        
        x_speed *= 0.5;
        y_speed = 3;
    }
})

state.add_child("dash_air","dash_air_up", {
    enter: function() { 
        
        state.inherit();
        
        image_angle = (facing) ? 45 : 315;
        
        x_speed *= 0.5;
        y_speed = -6;
    }
})

state.add_child("prone","dash_charge", {

    enter: function(){
        state.inherit();
        sprite_index = spr_pengu_dash_charge;
        
        if(input_h != 0) facing = input_h;
        
        dash_ground_force = dash_ground_force_min;
        t = 0;
        control_lock = 10;
        input_h = 0;
        
        squish(0.8,1.2,SECOND*0.5);
    },
    step: function(){
        
        control_lock = 10;
        input_h = 0;
        
        if(t < dash_ground_windup) t++; 
        if(!InputCheck(INPUT_VERB.DASH)){
            state.change("dash");
        }
        
        if(InputPressed(INPUT_VERB.LEFT)){
            facing = -1;
        }
        
        if(InputPressed(INPUT_VERB.RIGHT)){
            facing = 1;
        }
        
        var amount_ = t/dash_ground_windup;
        dash_ground_force = lerp(dash_ground_force_min,dash_ground_force_max,amount_);
        scale_x = lerp(1,1.2,amount_);
        scale_y = lerp(1,0.9,amount_);
        
    },
    draw_gui: function(){
        var offset_ = 18;
        var radius_ = 6;
        
        var x_ = global.camera.room_to_gui_x(x-(offset_*facing));
        var y_ = global.camera.room_to_gui_y(y-offset_);
        
        draw_percentage_donut((t/dash_ground_windup),radius_,x_,y_,PENGU_BLUE,PENGU_WHITE);
    }
})

state.add_child("prone","dash", {
    enter: function() {
        
        global.camera.shake_screen(2,SECOND*0.2);
        
        state.inherit()
        sprite_index = spr_pengu_dash;
        ground_spd = dash_ground_force * facing
        
        squish(1.2,1.2,SECOND*0.8);
        
        t = 0;
        
        super_speed = true;
        super_speed_fadeout = super_speed_fadeout_time;
        super_speed_trace_arr = [];
        
        audio_play_sound(snd_dashing,0,false)
    },
    step: function() {
        
        t++;
        if(t >= SECOND*1){
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

        if(facing == 1) sliding_subimg = 12; //decides wether to start pointing left or right
        else sliding_subimg = 0;
        
        subimg = sliding_subimg;
        facing = 1;
    },
    step: function() {
        sliding_subimg+=ground_spd/8;
        sliding_subimg = clamp(sliding_subimg,0,12);
        subimg = sliding_subimg;
    },
    leave: function() {			
        if(sliding_subimg<6) facing = -1;
    }
})

#endregion
// feather restore gm1065

/// @description
controlled = false;
debug_draw = false;

airborne = false;
on_land = false;

input_h = 0;
input_v = 0;
x_speed = 0;
y_speed = 0;

ground_spd = 0; //how fast it's moving on the ground
ground_angle = 0; //the grounds angle

w_radius = 49;
h_radius = 60;
w_foot_radius = 30;

//movement variables
acceleration_speed = 0.1;
deceleration_speed = 0.2;
friction_speed = 0.05;
top_speed = 4;
gravity_force = 0.21875;
air_acceleration_speed = 0.0937;
air_horizontal_top_speed = 4;
air_vertical_top_speed = 7;
jump_force = 6.5;
jump_release_force = 4;

sensor_length_base = 35;

//animation variables
mirror = 1;
mirror_component = 1;

rotation_speed = 0.0215; //when going airborne how fast you rotate to be back upright
min_flip_speed = 2; //x_speed has to be over this for the mech to change which side it's facing

//body
vec_body = new Vector2(0,0);
body = new Verlet(x,y,2);
body_stiffness = 0.2;
body_drag = 0.001;

body_angle = 0;
body_angle_base = 0;
body_angle_component = 0;

dome = new Verlet(x,y,1.2);
dome_radius = 24;
vec_dome = new Vector2(0,0);

normal_strength = 0.25;
roughness_strength = 0.6;
reflection_scale = 2;

//dice
vec_dice = new Vector2(0,-44);
die1 = verlet_rope(dome.x+vec_dice.x,dome.y+vec_dice.y,dome.x+vec_dice.x-8,dome.y+vec_dice.y+6,4,4);
die1.get_first_point().fixed = true;
die2 = verlet_rope(dome.x+vec_dice.x,dome.y+vec_dice.y,dome.x+vec_dice.x+8,dome.y+vec_dice.y+6,4,4);
die2.get_first_point().fixed = true;

vec_b = new Vector2(0,h_radius); //bottom
vec_bl = new Vector2(-w_foot_radius,h_radius); //bottom left_
vec_br = new Vector2(w_foot_radius,h_radius); //bottom right_
vec_l = new Vector2(-w_radius,20);  //left_
vec_r = new Vector2(w_radius ,20);  //right_

airborne_body_snap = 0;
airborne_body_snap_rate = 1 / (GAME_SPEED*2);

//legs
legs_height_standing = 65;
legs_height_crouching = 45;
legs_height_raised = 85;
legs_height = legs_height_crouching;
legs_height_change_spd = 0.08;

legs_length = 42;

//foot variables
foot_max_h_dist = 18;
foot_max_v_dist = 40;

foot_step_time = GAME_SPEED * 0.2;
foot_dist = 26; // distance between feet
foot_step_height = 20;

foot_left_right = false; //feet take turns moving

foot_center = {x,y};
foot_height = 12;

vec_leg_l = new Vector2(-26, 26); 
vec_leg_r = new Vector2( 26, 26);
vec_foot_l = new Vector2(-foot_dist,h_radius); 
vec_foot_r = new Vector2(foot_dist,h_radius);
foot_mass = 2;

function foot(_foot, _anchor) : Verlet(0,0,1,false) constructor{
	anchor = _anchor;
	foot_dest = _foot;
	mech = other;
	mass = mech.foot_mass;
	
	x = foot_dest.x + mech.x
	y = foot_dest.y + mech.y
	x_prev = x;
	y_prev = y;
	
	x_dest = x;
	y_dest = y;
	x_start = x;
	y_start = y;
	
	x_knee = 0;
	y_knee = 0;
	
	t = 0;
	
	stepping = false;
	
	static update_anchors = function(_foot, _anchor){
		anchor = _anchor;
		foot_dest = _foot;
	}
	
	static set_knee_pos = function(){
		with(mech){
			var len_ = point_distance( other.x,other.y-foot_height,body.x+other.anchor.x,body.y+other.anchor.y);
			var dir_ = point_direction(other.x,other.y-foot_height,body.x+other.anchor.x,body.y+other.anchor.y);
			
			var knee_offset_ = sqrt(  max(0,sqr(legs_length/2) - sqr(len_/2)) );
			
			other.x_knee = lerp(other.x,			  body.x + other.anchor.x ,0.5) + (knee_offset_ * dsin(dir_) * mirror_component);
			other.y_knee = lerp(other.y -foot_height, body.y + other.anchor.y ,0.5) + (knee_offset_ * dcos(dir_) * mirror_component);
		}
		
	}
	
	static set_pos = function(){
		with(mech){
			var trace_ = sensor(other.foot_dest,0,100);
		
			if(trace_ != noone){
				other.x = x + other.foot_dest.x + trace_.x;
				other.y = y + other.foot_dest.y + trace_.y;
			}
		}
		
		x_dest = x;
		y_dest = y;
		x_start = x;
		y_start = y;
		
		set_knee_pos();
	}
	
	static set_target = function(x_target_,y_target_){
		x_dest = x_target_;
		y_dest = y_target_;
		x_start = x;
		y_start = y;
		t = 0;
		stepping = true;
	}
	
	static set_target_to_ground = function(){
		with(mech){
			var trace_ = sensor(other.foot_dest,0,sensor_length_base);
			if(trace_ != noone){
				var x_target_ = x + other.foot_dest.x + trace_.x;
				var y_target_ = y + other.foot_dest.y + trace_.y;
				
				other.set_target(x_target_,y_target_);
			}
		}
	}
	
	static too_far = function(){
		var too_far = abs(mech.x+foot_dest.x-x) > mech.foot_max_h_dist || abs(mech.y+foot_dest.y-y) > mech.foot_max_v_dist
		return too_far;
	}
	

	static step = function(){
		//moves foot from prev to target
		if(stepping){
			if(t <= mech.foot_step_time){
				
				var val = animcurve_read(ac_basic,"linear",t / mech.foot_step_time);
				var val_raise = animcurve_read(ac_mech,"foot_step",t / mech.foot_step_time);
				
				x = lerp(x_start,x_dest,val);
				y = lerp(y_start,y_dest,val) - lerp(0,mech.foot_step_height,val_raise);
				
				t++;
			} else { // foot lands
				stepping = false;
				mech.foot_left_right = !mech.foot_left_right;
				
				global.camera.shake_screen(4,GAME_SPEED*0.1);
				var sound = audio_play_sound(snd_mech_stomp,0,false);
				audio_sound_pitch(sound,random_range(0.9,1.1));
			}
            
            //hitting enemies
            var attack_list_check = ds_list_create();
            var num = collision_circle_list(x,y,6,obj_enemy,false,true,attack_list_check,false)
            for (var i_ = 0; i_ < num; i_++) {
            	var inst = attack_list_check[|i_];
                if(!inst.invulnerable){
                    inst.invulnerable = true;
                    inst.x_speed = 8*mech.mirror_component + random_range(-1,1);
                    inst.y_speed = -6 + random_range(-1,1);
                    inst.state.change("launched");
                    inst.hurt();
                    
                    global.camera.shake_screen(8,GAME_SPEED*1);
                    part_particles_create(global.particles,inst.x,inst.y,global.part_stars,4);
                    set_freeze_frame();
                }
                
            }
            ds_list_destroy(attack_list_check)
		}
	}
}

foot_l = new foot(vec_foot_l,vec_leg_l);
foot_r = new foot(vec_foot_r,vec_leg_r);
 
 #region States
 
state = new SnowState("idle")
    .add("idle",{
        enter: function(){
            legs_height = legs_height_crouching;
            controlled = false;
        },
        step: function(){ 
            if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true) && InputPressed(INPUT_VERB.INTERACT)){
                instance_destroy(obj_pengu);
                state.change("walking");
            }
        },
        draw_gui: function(){
            if (collision_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,obj_pengu,false,true)){
                var x_ = global.camera.room_to_gui_x(x)
                var y_ = global.camera.room_to_gui_y(y) - 60
                draw_sprite(spr_gui_button_interact,using_gamepad(),x_,y_);
            }
        }
    })

	//parent states
	.add("walking",{
		enter: function(){
			airborne = false;
            legs_height = legs_height_standing;
            controlled = true;
            global.camera.follow = self;
            global.camera.move(x,y,30);
		},
		step: function(){
            if(InputCheck(INPUT_VERB.UP)){
			   	legs_height = lerp(legs_height,legs_height_raised,legs_height_change_spd);
			} else if(InputCheck(INPUT_VERB.DOWN)){ 
                legs_height = lerp(legs_height,legs_height_crouching,legs_height_change_spd);
            } else {
		        legs_height = lerp(legs_height,legs_height_standing,legs_height_change_spd);
			}
             
            if (InputPressed(INPUT_VERB.INTERACT)){
                instance_create_layer(x,y,"Instances",obj_pengu)
                state.change("idle");
            }
		}
	})
	
	.add("jump_charge",{
		step: function(){			
			legs_height = lerp(legs_height,legs_height_crouching,legs_height_change_spd);
			if(InputReleased(INPUT_VERB.JUMP)) state.change("jump")
		}
	})
	
	.add("airborne", {
	    enter: function() {
			airborne = true;

	    },
		step: function() {
			
			legs_height = lerp(legs_height,legs_height_standing,0.2);
			
			if(on_land){
				
				foot_l.set_pos();
				foot_r.set_pos();
				
				global.camera.shake_screen(10,GAME_SPEED*0.2);
				
				state.change("walking");
				
				ground_spd = x_speed;
				
				legs_height = legs_height_crouching;
			}
			
		}
	})
	
	.add_child("airborne","jump", {
	    enter: function() {
			state.inherit();
			
			y_speed = -jump_force - gravity_force //subtracting gravity force cancels out gravity for one frame
			x_speed -= jump_force *dsin(ground_angle) * 0.5;
			
			legs_height = legs_height_standing;
			
			vec_body.x = body.x - x;
			vec_body.y = body.y - y;
			
			foot_l.x_prev = foot_l.x;
			foot_r.x_prev = foot_r.x;
			foot_l.y_prev = foot_l.y;
			foot_r.y_prev = foot_r.y;
			
			if(x_speed != 0) mirror = sign(x_speed);
			
			
			//jump sfx			

	    }
	})
 
 #endregion
 
srf_gui = -1;
 
 //Inspectron()
  //.Section("player")
  //.Slider("body_stiffness",0,1)
  //.Slider("legs_length",0,90)
  //.Slider("normal_strength",0,1)
  //.Slider("roughness_strength",0,1)
  //.Slider("reflection_scale",1,2)
  //.Checkbox("debug_draw") 
  //.render()
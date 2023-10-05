/// @description

global.camera.follow = self;

#region variables
input_h = 0;

x_speed = 0;
y_speed = 0;

force_slide_angle = 46; //if you walk on an incline above this angle you're forced into sliding
#macro force_slide_false (ground_angle < force_slide_angle || ground_angle > 360-force_slide_angle)

normal_acceleration_speed = 0.3;
normal_deceleration_speed = 0.5;
normal_friction_speed = 0.24;
normal_top_speed = 2.4;

slide_acceleration_speed = 0.2;
slide_deceleration_speed = 0.4;
slide_friction_speed = 0.04;
slide_top_speed = 6;

gravity_force = 0.21875;

normal_slope_factor = 0.115;
slide_slope_factor = 0.425;
slope_factor = normal_slope_factor;

acceleration_speed = normal_acceleration_speed;
deceleration_speed = normal_deceleration_speed;
friction_speed = normal_friction_speed;
top_speed = normal_top_speed;


ground_spd = 0; //how fast it's moving on the ground
ground_angle = 0; //the grounds angle

w_radius = 6; //width radius
h_radius = 9; //height radius

grounded = true;
sliding = false;

mirror = 1; //+1 right | -1 left

//squishing
scale_x = 1;
scale_y = 1;
scale_x_squish = 1;
scale_y_squish = 1;
squishing = false;
squishing_t = 0;
squishing_duration = 0;

#endregion

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

#region sensors

vec_r = new Vector2(0,0); //right
vec_l = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom
vec_t = new Vector2(0,0); //top

vec_bl = new Vector2(0,0); //bottom left
vec_br = new Vector2(0,0); //bottom right

vec_tl = new Vector2(0,0); //top left
vec_tr = new Vector2(0,0); //top right

#endregion

#region states
state = new SnowState("idle");

state.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,image_index,x,y,scale_x*mirror,scale_y,image_angle,-1,1);
	
});

state.add("idle", {
    enter: function() {
		sprite_index = spr_pengu_idle;
		image_index = 0;
		
		w_radius = 6;
		h_radius = 9;
    },
	step: function() {
		if (input_h != 0){
			if( input_h != mirror ) state.change("turning");
			else state.change("running");
		}
	},
});

state.add("turning", {
    enter: function() {
		
		sprite_index = spr_pengu_idle;
		image_index = 0;
		
		mirror = -mirror;
		
		squish(1.2,0.8);
		
		state.change("idle");
    },
	step: function() {
		//if (animation_end(sprite_index,image_index)){
		//	state.change("idle");
		//}
	}
});

state.add("running", {
    enter: function() {
		sprite_index = spr_pengu_idle;
		image_index = 0;
    },
	step: function() {
		if (input_h == 0) state.change("idle");
		else if (input_h != mirror) state.change("turning");
	},
});

state.add("begin_slide", {
    enter: function() {
		sliding = true;
		sprite_index = spr_pengu_begin_slide;
		image_index = 0;
		//var sound = audio_play_sound(snd_down,100,false);
		//audio_sound_pitch(sound,pitch_change(random_range(-2,2)))
    },
	step: function() {
		if (animation_end()){
			state.change("sliding");
		}
	}
});

state.add("sliding", {
    enter: function() {
		
		sprite_index = spr_pengu_sliding;
		
		sliding = true;
		squish(1.4,0.8);
		// audio_play_sound(snd_slide_loop, 15, true); NEED TO FIX

		w_radius = 6;
		h_radius = 6;
		
		sliding_subimg = 0;
		if(mirror > 0) sliding_subimg = 12; //decides wether to start pointing left or right
		image_index = sliding_subimg;
		mirror = 1;
		
		
		acceleration_speed	= slide_acceleration_speed;
		deceleration_speed	= slide_deceleration_speed;
		friction_speed		= slide_friction_speed;
		top_speed			= slide_top_speed;
		
		slope_factor		= slide_slope_factor;
		
    },
	step: function() {
		sliding_subimg+=ground_spd/20;
		sliding_subimg = clamp(sliding_subimg,0,12);
		image_index = sliding_subimg;
		
		if(!grounded){
			//	state.change("falling_start")
			//	angle = sign(hspd)*-90;
		}
	},
	leave: function() {
		sliding = false;
		
		acceleration_speed	= normal_acceleration_speed;
		deceleration_speed	= normal_deceleration_speed;
		friction_speed		= normal_friction_speed;
		top_speed			= normal_top_speed;
		
		slope_factor		= normal_slope_factor;
		
		
		if(sliding_subimg<3) mirror = -1;	
	}
});

#endregion
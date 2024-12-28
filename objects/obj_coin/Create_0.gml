/// @description
// Inherit the parent event
event_inherited();

image_index = irandom(image_number-1);

trigger = function(){
	if(!touched){
		touched = true;
		array_push(obj_game.taken_points,id);
	}
	
	if(pickup_t == 0){
		state.change("collect");
	}
}

t_offset = irandom(60);

y_offset_max = 2;
rot_offset_max = 10;
anim_duration = game_speed * 1.2;

collect_duration = game_speed * 0.4;

collect_t = 0;

touched = false;
scoring = true; //points dropped by pengu shouldn't score

xspeed = 0;
yspeed = 0;
gravity_force = 0.2251;
falloff = 0.8;

radius = 8;
sensor_dist = 8;

vec_hor = new Vector2(sign(xspeed)*radius,0);
vec_ver = new Vector2(0,sign(yspeed)*radius);

pickup_t = 0;
pickup_t_max = game_speed * 1;

disappear = false;
disappear_duration = game_speed * 4;

start_time = 0;

state = new SnowState("idle");

state

.add("idle", {
	enter: function(){		
	},
	
	step: function(){
	}
})

.add("collect", {
	enter: function(){
		xstart = x;
		ystart = y;
		disappear = false;
	},
	
	step: function(){
		
		if(collect_t < collect_duration){
			
			var collect_val = animcurve_read(ac_coin,"collect",collect_t/collect_duration);
			
			x_speed = (obj_pengu.x - x) * collect_val;
			y_speed = (obj_pengu.y - y) * collect_val;
			
			x += x_speed;
			y += y_speed;
			
			image_xscale = lerp(1,0.2,collect_val);
			image_yscale = lerp(1,0.2,collect_val);
			
			collect_t++;
		} else {
			if scoring score_increase(1);
			global.coins+=1;
			var sound = audio_play_sound(snd_point,0,0);
			audio_sound_pitch(sound,pitch_change(random_range(2,10)));	
			
			instance_destroy();
		}
	}
	
})

.add("physics", {
	enter: function(){
		start_time = global.t;
		pickup_t = pickup_t_max;
		disappear = true;
	},
	step: function(){
		yspeed += gravity_force;
		
		x+=xspeed;
		y+=yspeed;
		
		vec_hor = new Vector2(sign(xspeed)*radius,0);
		vec_ver = new Vector2(0,sign(yspeed)*radius);
		
		var hor_sensor = sensor(vec_hor,90,sign(xspeed) * sensor_dist);
		var ver_sensor = sensor(vec_ver,0,sign(yspeed) * sensor_dist);
		
		if(hor_sensor != noone){
			xspeed = -xspeed * falloff;
			x+= hor_sensor.x;
			y+= hor_sensor.y;
		}
		
		if(ver_sensor != noone){
			yspeed = -yspeed * falloff;
			xspeed = xspeed * falloff;
			x+= ver_sensor.x;
			y+= ver_sensor.y;
		}
		
		if(pickup_t > 0) pickup_t--;
		else if(abs(xspeed) < 0.1 && abs(yspeed) < 0.1) {
			state.change("idle");
		}
		
	}
})
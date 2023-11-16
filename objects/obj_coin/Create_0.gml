/// @description
// Inherit the parent event
event_inherited();


image_index = irandom(image_number-1);


trigger = function(){
	if(pickup_t == 0){
		state.change("collect");
	}
}

y_offset_max = 2;
rot_offset_max = 10;
anim_duration = game_speed * 1.2;

collect_duration = game_speed * 0.4;

collect_t = 0;

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
disappear_t = 0;
disappear_duration = game_speed * 10;

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
		t = 0;
		disappear = false;
	},
	
	step: function(){
		
		if(collect_t < collect_duration){
			
			var collect_val = animcurve_read(ac_coin,"collect",collect_t/collect_duration);
			
			x = lerp(xstart,obj_pengu.x,collect_val);
			y = lerp(ystart,obj_pengu.y,collect_val);
			
			image_xscale = lerp(1,0.2,collect_val);
			image_yscale = lerp(1,0.2,collect_val);
			
			collect_t++;
		} else {		
			global.score++;
			var sound = audio_play_sound(snd_point,0,0);
			audio_sound_pitch(sound,pitch_change(random_range(2,10)));	
			instance_destroy();
		}
	}
	
})

.add("physics", {
	enter: function(){
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
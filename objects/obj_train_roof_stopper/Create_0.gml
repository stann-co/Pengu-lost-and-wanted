/// @description

// Inherit the parent event
event_inherited();

zone = instance_create_depth(x,y,depth,obj_stanncam_zone_1side);
with(zone){
	image_xscale = 20;
	image_yscale = 20;
	
	x-= sprite_width
	x+= 32;
	y-= sprite_height


}

hitpoint = instance_create_depth(x,y,depth,obj_train_roof_stopper_hitpoint);
hitpoint.trigger = function(_side,_object){	
	if(_object.super_speed){
		global.camera.shake_screen(2,GAME_SPEED*0.5);
		
		instance_destroy(zone)
		instance_destroy(hitpoint);
		instance_destroy();
		return false
	} else {
		
		with(_object){
			state.change("fall_up");
			double_jump_count = 0;
			dash_air_count = 0;
			x_speed = -2;
		}
		
		return true	
	}
}

//hurting laser
trigger = function(_side,_object){
	if(_object.object_index == obj_pengu){
		_object.hurt(sign(-_object.x_speed));
	}
	return true
}

y += sprite_height;

appeared = false;

trigger_dist = 180;

state = new SnowState("idle")

state.add("idle",{
	enter: function(){
		
	},
	step: function(){
		if(abs(obj_pengu.x - x) < trigger_dist){
			state.change("appear")
		}
	}
})

state.add("appear",{
	enter: function(){
		t = 0;
		duration = 15;
		
		ydest = ystart
		ystart = y;
		
	},
	step: function(){
		t++
		var val_ = animcurve_read(ac_basic,0,t / duration);
		y = lerp(ystart,ydest,val_);
		
		if(t >= duration){
			global.camera.shake_screen(2,GAME_SPEED*0.5);
			state.change("active")
		}
	}
})

state.add("active",{
	enter: function(){
		
		
	},
	step: function(){
		
	}
})
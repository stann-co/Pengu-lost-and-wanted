trigger = function(){
	if(!destroyed){
		state.change("destroy");
		global.camera.shake_screen(4,GAME_SPEED*0.5);
		with(obj_pengu){
			hurt(sign(x-other.x));
		}
	}
}

trigger_radius = 8;

gravity_force = 0.3215;
max_speed = 6;

h_radius = 10;
vec_b = new Vector2(0,h_radius)

destroyed = false;

state = new SnowState("idle");
state

.event_set_default_function("draw",function(){
	draw_sprite_cubemap(sprite_index,0,x,y,spr_crt,,,,,image_xscale,image_yscale,image_angle,1);
	draw_self();
})

.add("idle",{
	enter: function(){
		x = xstart;
		y = ystart;
		y_speed = 0;
		destroyed = false;
	},
	
	step: function(){
		if(obj_pengu.y > y && obj_pengu.y < y+trigger_height && obj_pengu.x > (x-trigger_radius) && obj_pengu.x < (x+trigger_radius)){
			state.change("fall");
		}
	}
})

.add("fall",{
	step: function(){
		y_speed += gravity_force;
		y_speed = clamp(y_speed,0,max_speed);
		
		y+=y_speed;
		
		var coll_sensor = sensor(vec_b,0,h_radius)
		
		if(coll_sensor != noone){
			state.change("destroy");
		}
	}
})

.add("destroy",{
	enter: function(){
		particle_burst(ps_ice_explode);
		destroyed = true;
	},
	
	draw: function(){}

})











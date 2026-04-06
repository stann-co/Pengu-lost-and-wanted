event_inherited();

/// @description
ps = part_system_create();

trigger = function(){
	if(obj_pengu.on_land){
		state.change("land")
	}
}

subimg = 0;
state = new SnowState("idle");
state
.event_set_default_function("draw",function(){
	draw_sprite(sprite_index,0,x,y);
})

.add("idle",{

})

.add("land",{
	enter: function(){
		//would be based if it bursted out some paper particles when you landed
		part_particles_burst(ps, x,y, ps_paper_explode);
		subimg = 0;
	},
	step: function(){
		subimg+=sprite_get_speed(sprite_index);
		
		if(animation_end(sprite_index,subimg)){
			state.change("idle");	
		}
	},
	draw: function(){		
		draw_sprite(sprite_index,subimg,x,y);
	}
})
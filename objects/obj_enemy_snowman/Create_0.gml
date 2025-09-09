/// @description
event_inherited();

t=0;
wait_duration = GAME_SPEED*2;
thrown = false;

snowball_throw_speed = 4;

h_radius = 12

hurt = function(){
	invulnerable = true;
	sprite_index = spr_snowman_hurt;
	
	state.change("die");
}

state
.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,image_angle,-1,1);
})

.add("idle",{
	enter:function(){	
		t = 0;
		subimg = 0;
		sprite_index = spr_snowman_idle;
	},
	step:function(){
		subimg+= sprite_get_speed(sprite_index);
		var side = sign(x - obj_pengu.x);
		if(side != 0){
			image_xscale = side;
		}
		
		if(t++ >= wait_duration){
			state.change("throw");
		}
	}
})

.add("throw",{
	enter:function(){	
		t = 0;
		subimg = 0;
		sprite_index = spr_snowman_throw;
		thrown = false;
	},
	step:function(){
		subimg+= sprite_get_speed(sprite_index);
		if(subimg == 3 && !thrown){
			thrown = true
			var snowball = instance_create_depth(x-(image_xscale*16),y,depth,obj_snowball_thrown);
			snowball.h_speed = -image_xscale * snowball_throw_speed;
		}
		
		if(animation_end(sprite_index,subimg)){
			state.change("idle");
		}
	}
})















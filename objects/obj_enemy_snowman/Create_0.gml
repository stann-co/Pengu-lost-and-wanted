/// @description
event_inherited();

t=0;
wait_duration = game_speed*2;
thrown = false;

snowball_throw_speed = 4;

hurt = function(){
	hurting = true;
	state.change("hurt");
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
		
		if(subimg == 3 && !thrown){
			thrown = true
			var snowball = instance_create_depth(x-(image_xscale*16),y-16,depth,obj_snowball_thrown);
			snowball.h_speed = -image_xscale * snowball_throw_speed;
		}
		
		if(animation_end(sprite_index,subimg)){
			state.change("idle");
		}
	}
})

.add("hurt",{
	enter:function(){
		y_speed = -10;
		x_speed = sign(x-obj_pengu.x) * 6;
		sprite_index = spr_snowman_hurt;
	},
	step:function(){
		y_speed += 0.5;
		image_angle-=sign(x_speed) * 6;
		
		x+= x_speed;
		y+= y_speed;
		
		if(global.camera.out_of_bounds(x,y,-30)){
			instance_destroy();	
		}
	}
})















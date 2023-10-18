/// @description
event_inherited();

vec_rt = new Vector2(0,0); //right
vec_lt = new Vector2(0,0); //left
vec_rb = new Vector2(0,0); //right
vec_lb = new Vector2(0,0); //left


vec_b = new Vector2(0,0); //bottom

t=0;
walk_duration = game_speed*0.2;
wait_duration = game_speed*0.4;

state = new SnowState("forward_1");

state
.event_set_default_function("draw",function(){
	draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,0,-1,1);
})

.add("forward_1",{
	enter:function(){	
		t = 0;
		subimg = 0;
		input_h = -image_xscale;
		sprite_index = spr_toybot_1;
		next_state = "forward_2";
	},
	step:function(){
		subimg+= sprite_get_speed(sprite_index);
		subimg = clamp(subimg,0,2);
		
		if(t++ >= walk_duration){
			state.change("wait");
		}
	}
})

.add_child("forward_1","forward_2",{
	enter:function(){	
		state.inherit();
		next_state = "forward_1";
		sprite_index = spr_toybot_2;
	}
})

.add("wait",{
	enter:function(){	
		input_h = 0;
		t = 0;
	},
	step:function(){
		if(t++ >= walk_duration){
			state.change(next_state);
		}	
	}
})

.add("turn",{
	enter:function(){	
		input_h = 0;
		image_xscale = -image_xscale;
		state.change("forward_1");
	}
})

















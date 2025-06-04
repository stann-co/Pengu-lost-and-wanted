/// @description

//variables
x_speed = 0;
y_speed = 0;
ground_angle = 0;
ground_spd = 0;
slope_factor = 0.123;
w_radius = 6;
h_radius = 9;
top_speed = 3;
input_h = -1;
subimg = 0;
airborne = false;
meteor = false;

//enable disable collision checking code, for dying state, or maybe flying
colliding = true;

hp = 1;
invulnerable = 0;

stagger = 0;

on_land = false; //gets true the frame enemy lands from being airborne
on_ceiling = false;
on_wall = false; //gets true the frame enemy hits wall
on_no_floor = false; //true the frame there is no floor underneath

#region sensors

vec_r = new Vector2(0,0); //right
vec_l = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom
vec_t = new Vector2(0,0); //top

sensor_angle = 0;
sensor_length_base = 8;

#endregion

hurt = function(){
    global.camera.shake_screen(4,game_speed*0.5);
    part_particles_create(global.particles,x,y,global.part_stars,4);
    freeze_frame();
    sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
}

default_draw = function(){
	draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,image_angle,-1,1);
}

state = new SnowState("idle");

state
.event_set_default_function("draw",function(){
    default_draw()
})

.add("idle",{
	enter:function(){	

	},
	step:function(){

	}
})

.add("die",{
	enter:function(){
		y_speed = -10;
		x_speed = sign(x-obj_pengu.x) * 6;
		point_scatter(5);
		score_increase(0,score_combo_t_max)
		part_particles_create(global.particles,x,y,global.part_stars,12);
	},
	step:function(){
		y_speed += 0.5;
		image_angle-=sign(x_speed) * 6;
		if(global.camera.out_of_bounds(x,y,-30)){
			instance_destroy();
		}
	}
})

.add("stunned",{
    enter:function(){
        airborne = true
    },
    step:function (){
        
    }
})

.add("launched",{
    enter:function(){
        airborne = true
        
    },
    step:function (){
        if(on_land){
            y_speed = 0;
            invulnerable = false;
            state.change("idle");
        }
        
        if(airborne){
            y_speed += gravity_force;
        }
    }    
})

.add("meteor",{
    enter: function(){
        airborne = true;
        invulnerable = game_speed * 1;
        meteor = true;
    },
    step:function (){
        if(invulnerable == 0){
            y_speed = 0;
            //state.change("idle");
        } else meteor--;
        
        if(airborne){
            y_speed += gravity_force*0.5;
        }
    },
    leave: function(){
        invulnerable = false;
        meteor = false;
    }
})

//.add("hurt",{
//	enter:function(){
//		y_speed = -2;
//		x_speed = sign(x-obj_pengu.x) * 2;
//		point_scatter(1);
//		score_increase(0,score_combo_t_max)
//		part_particles_create(global.particles,x,y,global.part_stars,2);
//		airborne = true;
//	},
//	step:function(){
//		y_speed += 0.5;
//		if (on_land){
//			state.change("idle");
//			invulnerable = false;
//		}
//	}
//})
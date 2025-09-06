/// @description

event_inherited();

//variables
slope_factor = 0.123;
w_radius = 6;
h_radius = 9;
top_speed = 3;
input_h = -1;

gravity_force = 0.2251;

//enable disable collision checking code, for dying state, or maybe flying
colliding = true;

hp_max = 10;
hp = hp_max;

invulnerable = 0;

stun_duration = 20;
stun_radius = 8;
stun_x = 0;
stun_y = 0;

meteor = false;
meteor_trace_array = [];
meteor_trace_offset = 1;
meteor_trace_count = 6;

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

hurt = function(_hurt_type = ATTACK_TYPES.ATTACK){
    switch (_hurt_type) {
    	case ATTACK_TYPES.ATTACK:
            global.camera.shake_screen(2,game_speed*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,4);
            set_freeze_frame(0.25);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
            break;
        case ATTACK_TYPES.KICK:
            global.camera.shake_screen(2,game_speed*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,6);
            set_freeze_frame(0.5);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
            break;
        case ATTACK_TYPES.COLLIDE:
            global.camera.shake_screen(2,game_speed*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,6);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
            break;
    }

    //hp--;
    if(hp <= 0){
        state.change("die");
    }
}



state = new SnowState("idle");


default_draw = function(){
    draw_sprite_ext(sprite_index,subimg,x,y,image_xscale,image_yscale,image_angle,-1,1);
}

state.event_set_default_function("draw",function(){
    default_draw()
})

.add("idle",{})

.add("die",{
	enter:function(){
		y_speed = -10;
		x_speed = sign(x-obj_pengu.x) * 6;
        
        colliding = false;
        invulnerable = true;
	},
	step:function(){
		y_speed += gravity_force;
		image_angle-=sign(x_speed) * 6;
		if(global.camera.out_of_bounds(x,y,-30)){
			instance_destroy();
		}
	}
})

state.add("stunned_base",{
    enter:function(){
        airborne = true
        
        stun_x = irandom_range(-stun_radius,stun_radius);
        stun_y = irandom_range(-stun_radius,stun_radius);
    },
    step:function (){
        if(meteor) state.change("meteor");
        else state.change("launched");
        
    },
    draw:function (){
        //every x frames a new stun pos is set
        if(global.freeze_duration mod 2 == 0){
            var val = stun_radius * ((global.freeze_duration) / 30)
            stun_x = irandom_range(-val,val);
            stun_y = irandom_range(-val,val);
        }
        
        if(sin(global.freeze_duration*0.5) > 0){
            shader_set(sh_stunned);
        }
    }
})
state.add_child("stunned_base","stunned",{
    draw:function (){
        state.inherit()
        //remember to call shader_reset() when overiding this
        shader_reset();
    }
})

.add("launched_base",{
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
.add_child("launched_base","launched")

.add("meteor_base",{
    enter: function(){
        airborne = true;
        invulnerable = true;

    },
    step:function (){ 
        if(airborne){
            //y_speed += gravity_force*0.5;
        }
        
        image_angle -= sign(x_speed) * 10;
        
        if(on_wall || x_speed == 0){
            //hitting wall after meteoring
            x_speed = -x_speed;
            y_speed = -3;
            state.change("launched");
            hurt(ATTACK_TYPES.COLLIDE);
        }
        
        var attack_list_check_ = ds_list_create();
        
        var num_ = instance_place_list(x,y,obj_enemy,attack_list_check_,true);
        for (var i = 0; i < num_; i++) {
            var inst = attack_list_check_[|i];
            if(!inst.invulnerable){
                inst.invulnerable = true;
                inst.x_speed = 8*sign(x_speed);
                inst.y_speed = -3;
                inst.state.change("launched");
                
                inst.hurt(ATTACK_TYPES.COLLIDE);
            }
        }
        ds_list_destroy(attack_list_check_)
        
    },
    leave: function(){
        invulnerable = false;
        meteor = false;
        image_angle = 0;
        meteor_trace_array = [];
    }
})
.add_child("meteor_base","meteor")
/// @description

event_inherited();

//variables
slope_factor = 0.123;
w_radius = 6;
h_radius = 9;
top_speed = 3;

gravity_force = 0.2251;

//enable disable collision checking code, for dying state, or maybe flying
colliding = true;

hp_max = 12;
hp = hp_max;

stamina_max = 4;
stamina = stamina_max;

stamina_regain_max = GAME_SPEED * 5;
stamina_regain_t = 0;

jump_attackable = true; //if player can jump on it to attack

invulnerable = 0;

stun_duration = 20;
stun_radius = 8;
stun_x = 0;
stun_y = 0;

meteor = false;
meteor_trace_array = [];
meteor_trace_offset = 1;
meteor_trace_count = 6;
meteor_min_speed = 2;

on_land = false;     //gets true the frame enemy lands from being airborne
on_ceiling = false;
on_wall = false;     //gets true the frame enemy hits wall
on_no_floor = false; //true the frame there is no floor underneath

#region sensors

vec_r = new Vector2(0,0); //right
vec_l = new Vector2(0,0); //left

vec_b = new Vector2(0,0); //bottom
vec_t = new Vector2(0,0); //top

sensor_angle = 0;
sensor_length_base = 8;

#endregion

///@function hurt()
hurt = function(_hurt_type = ATTACK_TYPES.ATTACK, _callback = function(){}){
    switch (_hurt_type) {
    	case ATTACK_TYPES.ATTACK:
            global.camera.shake_screen(2,GAME_SPEED*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,4);
            set_freeze_frame(0.3);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
        
            hurt_shake_start(4);
            
            hp--;
            stamina--;
            break;
        case ATTACK_TYPES.KICK:
            global.camera.shake_screen(2,GAME_SPEED*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,6);
            set_freeze_frame(0.45);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
            meteor = true;
        
            hurt_shake_start(8);
            
            hp--;
            stamina--;
            break;
		
        case ATTACK_TYPES.COLLIDE: //an enemy collides with another enemy
            global.camera.shake_screen(2,GAME_SPEED*0.2);
            part_particles_create(global.particles,x,y,global.part_stars,6);
            sound_play_random([snd_attack1,snd_attack2,snd_attack3],0.2)
            hurt_shake_start(2);
            hp-=0.5;
            stamina-=0.5;
            break;
    }
    
    //if stamina is down, executes the callback
    if(stamina <= 0){
        stamina_regain_t = stamina_regain_max; //if it keeps being attacked it stays stamina broken
        _callback();
    }
    
    if(hp <= 0){
        state.change("die");
    }
}

state = new SnowState("idle");

state.event_set_default_function("draw",function(){
    default_draw();
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
        anim_speed = 0;
    },
    step:function (){
        if(meteor) {
            state.change("meteor");
        }
        else state.change("launched");
        
    },
    leave:function (){
        anim_speed = 1;
    }
})
state.add_child("stunned_base","stunned",{

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
            squish(2,0.5,GAME_SPEED*1)
        }
        
        image_angle += angle_difference(ground_angle,image_angle)*0.1;
        
        if(airborne){
            y_speed += gravity_force;
        }
    },
    leave:function(){
        image_angle = ground_angle;
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
            y_speed += gravity_force*0.5;
        }
        
        image_angle -= sign(x_speed) * 16;
        
        if(on_wall){ // || x_speed == 0){
            //hitting wall after meteoring
            x_speed = -x_speed;
            y_speed = -3;
            state.change("launched");
            hurt(ATTACK_TYPES.COLLIDE);
        }
		
		if(on_land && y_speed > 3){ //hitting floor hard
			y_speed = -y_speed
			
		}
		
		//returns to launch state if meteor effect goes too slow
		if(point_distance(0,0,x_speed,y_speed) < meteor_min_speed){ 
			state.change("launched");
		}
        
        var attack_list_check_ = ds_list_create();
        
        var num_ = instance_place_list(x,y,obj_enemy,attack_list_check_,true);
        for (var i_ = 0; i_ < num_; i_++) {
            var inst_ = attack_list_check_[|i_];
            if(!inst_.invulnerable){
                inst_.invulnerable = true;
                inst_.x_speed = 8*sign(x_speed);
                inst_.y_speed = -3;
                inst_.state.change("launched");
                
                inst_.hurt(ATTACK_TYPES.COLLIDE);
            }
        }
        ds_list_destroy(attack_list_check_)
        
    },
    leave: function(){
        invulnerable = false;
        meteor = false;
        meteor_trace_array = [];
    }
})
.add_child("meteor_base","meteor")
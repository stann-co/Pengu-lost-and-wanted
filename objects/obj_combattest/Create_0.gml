/// @description

// Inherit the parent event
event_inherited();

w_radius = 12;
h_radius = 18;

floor_friction = 0.91;

//radius_spot = 200;
//radius_loose = 240;
radius_attack = 60;

facing = 1;

t = 0;

top_speed = 2;

squish_x = 1;
squish_y = 1;

windup_t = GAME_SPEED*0.5;
attack_pause = GAME_SPEED*0.5;
attack_cooldown = 0;
attack_cooldown_max = GAME_SPEED * 2;

punch_x = -28;
punch_y = -6;

attack_target = obj_pengu;

target_dist = function(){
    return point_distance(x,y,attack_target.x,attack_target.y);
    
}

choose_state = function(){
    if (player_dist() > radius_loose){
        state.change("idle");
    } else if (player_dist() > radius_attack){
        state.change("follow")
    } else {
        state.change("punch_windup");
    }
}

state.add_child("stunned_base","stunned",{
    draw:function (){
        state.inherit()
        
        default_draw();
        
        //remember to call shader_reset() when overiding this
        shader_reset();
    }
})

.add_child("meteor_base","meteor",{
    enter: function (){
        sprite_index = spr_combattest_hurt;    
    }    
})

state.add("idle",{
    enter: function (){
        x_speed = 0;
        sprite_index = spr_combattest_idle;
    },
    
    step: function (){
        
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
        
        if(target_dist() <= radius_attack){
            state.change("punch_windup");
        }
        
        if(attack_cooldown == 0) state.change("wander");
    }
})

state.add("wander",{
    enter: function (){
        sprite_index = spr_combattest_move;
        subimg = 0;
    },
    
    step: function (){
        
        if(on_wall || on_no_floor){
            facing = -facing;
        }
        
        ground_spd = top_speed * -facing
        ground_spd-=slope_factor * dsin(ground_angle);
        
		// Calculate x and y_speed from ground_speed
		x_speed = ground_spd * dcos(ground_angle)
		y_speed = ground_spd * -dsin(ground_angle)
        
        
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
        
        if(target_dist() <= radius_attack){
            state.change("punch_windup");
        }
    }
})

state.add("punch_windup",{
    enter: function (){
        sprite_index = spr_combattest_punch_windup;
        subimg = 0;
        
        facing = -sign(attack_target.x - x)
        
        x_speed = facing * 1;
        t = windup_t;
        
        squish(1.2,0.8,GAME_SPEED*0.4);
        
    },
    
    step: function (){
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
        
        if(t>0) t--;
        else{
            state.change("punch");
        }
    }
})

state.add("punch",{
    enter: function (){
        sprite_index = spr_combattest_punch;
        subimg = 0;
        x_speed = -facing * 8;
        
        t = attack_pause;
        attack_cooldown = attack_cooldown_max;
        squish(1.8,0.8,GAME_SPEED*1.5);
    },
    
    step: function (){
        subimg = clamp(subimg, 0, 1);
        
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
        
        if(t > 0) t--;
        else {
            state.change("wander");
        }
        
        // attack does damage
        var inst_ = collision_circle(x+(punch_x*facing),y+punch_y,8,attack_target,false,true);
        if (inst_ != noone){
            inst_.hurt(x_speed);
        }
    }
})

state.change("wander");
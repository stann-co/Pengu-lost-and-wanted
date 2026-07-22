/// @description

// Inherit the parent event
event_inherited();

facing = 1;
t = 0;
airborne = true;

w_radius = 8;
h_radius = 8;

hp_max = 12;
hp = hp_max;
stamina_max = 4;
stamina = stamina_max;

//position to try and be at
target_x = x;
target_y = y;

//TODO maybe this could be improved, or just removed outright, and refer to controlled directly in code
attack_target = function(){
	return global.controlled;
};

radius_spot = 250;
radius_loose = 360;

stalk_attack_wait = SECOND*0.3;
swoop_windup = SECOND*0.3;
swoop_duration = SECOND*0.65;

//when stalking how far away to position itself before swooping
stalk_dist_x = 145;
stalk_dist_y = -100;
stalk_threshold = 35; //how far away from the target pos to begin swooping down

stalk_speed = 1.6;
swoop_speed = 15;
swoop_angle = 57;

//Inspectron()
    //.Slider("swoop_duration",0,GAME_SPEED*2)
    //.Slider("swoop_speed",0,20)
    //.Slider("stalk_dist_x",0,200)
    //.Slider("radius_spot",0,400)
    //.Slider("radius_loose",0,400)
    //.Slider("swoop_angle",0,90)
//.render()

target_dist = function(){
    return point_distance(x,y,attack_target().x,attack_target().y);
}

choose_state = function(){
    if (player_dist() > radius_loose){
        state.change("idle");
    } else if (player_dist() > radius_spot){
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
        //sprite_index = spr_combattest_hurt;    
    }    
})

state.add("idle",{
    enter: function (){
        sprite_index = spr_flying_test_idle;
    },
    
    step: function (){
        x_speed = lerp(x_speed,0,0.05);
        y_speed = lerp(y_speed,0,0.05);
        
        if(target_dist() <= radius_spot){
            state.change("stalk");
        }
    }
})

state.add("stalk",{
    enter: function (){
        sprite_index = spr_flying_test_idle;
        t = 0;
    },
    
    step: function (){
        facing = sign(attack_target().x - x);
        target_x = attack_target().x + stalk_dist_x*-facing;
        target_y = attack_target().y + stalk_dist_y;
        
        var dist_x_ = (target_x - x);
        var dist_y_ = (target_y - y);
        
        if(point_distance(x,y,target_x,target_y) <= stalk_threshold){
            
            x_speed = lerp(x_speed,0,0.05);
            y_speed = lerp(y_speed,0,0.05);
            
            if(t >= stalk_attack_wait){
                state.change("swoop_windup");
            }
            t++;
            
        } else {
            x_speed = lerp(x_speed,sign(dist_x_) * stalk_speed,0.05);
            y_speed = lerp(y_speed,sign(dist_y_) * stalk_speed,0.05);
            t = 0;
        }
        
        if(target_dist() > radius_loose){
            state.change("idle");
        }
    }
})

state.add("swoop_windup",{
    enter: function (){
        sprite_index = spr_flying_test_swoop_windup;
        subimg = 0;
        
        facing = sign(attack_target().x - x)
        
        squish(1.2,0.8,SECOND*0.4);
        
        t = 0;
        
    },
    
    step: function (){
        if(t >= swoop_windup) state.change("swoop");
        t++;
    }
})

state.add("swoop",{
    enter: function (){
        sprite_index = spr_flying_test_swoop;
        subimg = 0;
        
        squish(2,0.5,swoop_duration);
        
        swoop_dir_start = facing ? -swoop_angle : 180+swoop_angle;
        swoop_dir_end = facing ? swoop_dir_start+swoop_angle*2 : swoop_dir_start-swoop_angle*2;
        
        swoop_dir = swoop_dir_start;
        
        t = 0;
        
    },
    
    step: function (){
        
        swoop_dir = lerp(swoop_dir_start,swoop_dir_end,t/swoop_duration);
        var swoop_speed_ = lerp(swoop_speed,swoop_speed*0.2,t/swoop_duration);
        
        
        x_speed =  dcos(swoop_dir) * swoop_speed_;
        y_speed = -dsin(swoop_dir) * swoop_speed_;
        
        image_angle = swoop_dir;
        if(!facing) image_angle+= 180;
        
        // attack does damage
        var inst_ = collision_circle(x,y,8,attack_target(),false,true);
        if (inst_ != noone){
            inst_.hurt(x_speed);
        }
        
        if(t >= swoop_duration) state.change("stalk");
        
        t++;
    },
    
    leave: function (){
        image_angle = 0;
    }
})

state.change("idle");
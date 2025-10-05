/// @description

// Inherit the parent event
event_inherited();
w_radius = 7;
h_radius = 6;
gravity_force = 0.2251;
floor_friction = 0.91;

jump_attackable = false;

hp_max = infinity;
hp = hp_max;

stamina_max = 0;
stamina = stamina_max;

state.add("idle",{

    enter:function(){

    },
    step:function(){
        if(on_land && abs(y_speed) > 1){
            y_speed = -y_speed * 0.8;
            x_speed = x_speed * 0.8;
            airborne = true;
        }
        
        if(on_wall && abs(x_speed) > 0.1){
            x_speed = -x_speed * 0.8;
        }
        
        if(airborne){
            y_speed += gravity_force;
        } else {
		    x_speed *= floor_friction;
        }
    }
})

state.add("launched",{

    step:function (){
        if(on_land){
            airborne = true;
            y_speed = -y_speed * 0.8;
            x_speed = x_speed * 0.8;
            invulnerable = false;
            state.change("idle");
        }
        
        if(on_wall){
            airborne = true;
            x_speed = -x_speed * 0.8;
            invulnerable = false;
            state.change("idle");
        }
        
        if(airborne){
            y_speed += gravity_force;
        }
    }    
})
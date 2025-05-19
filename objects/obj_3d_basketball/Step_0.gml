/// @description

// Inherit the parent event
event_inherited();

if(on_land || on_ceiling){
    if(on_land && y_speed < 4){
        y_speed = 0;
    } else {
        airborne = true;
        y_speed = -y_speed*0.2;
    }
}

if(on_wall){
    x_speed = -x_speed*0.5;
    rot_speed = -rot_speed;
}

rotation+=rot_speed;



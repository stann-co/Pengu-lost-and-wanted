/// @description
// Inherit the parent event
event_inherited();

spine.update(drag)

var base_ = spine.get_first_point();

base_.set_pos_fixed(x,y+h_radius-2);

if(on_land || on_ceiling){

    if(abs(y_speed)>2){
        airborne = true;
        y_speed = -y_speed*0.5;
    } else {
        y_speed = 0;
    }
}

if(on_wall){
    x_speed = -x_speed*0.5;
}
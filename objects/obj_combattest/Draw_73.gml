/// @description

// Inherit the parent event
event_inherited();

if(global.debug){
    if state.state_is("punch"){
        set_draw(RED,0.5)
        draw_circle(x+(punch_x*facing),y+punch_y,8,false);
        reset_draw();
    }
    
    //radius
    set_draw(RED,0.5)
    //draw_circle(x,y,radius_loose,true);
    //draw_circle(x,y,radius_spot,true);
    draw_circle(x,y,radius_attack,true);
    reset_draw();
}
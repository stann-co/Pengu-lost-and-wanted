/// @description

// Inherit the parent event
event_inherited();

if(global.debug){
    
    //radius
    set_draw(RED,0.5)
    draw_circle(x,y,radius_loose,true);
    draw_circle(x,y,radius_spot,true);
    
    //draw_circle(x,y,radius_attack,true);
    
    reset_draw();
}
/// @description

// Inherit the parent event
event_inherited();

var w_ = 8; //half width
var h_ = 1; //half height

var y_offset_ = -32;

draw_set_color(BLACK);
draw_rectangle(x-w_,y-y_offset_-h_,x+w_,y-y_offset_+h_,false);

draw_set_color(WHITE);

var percent_x_ = lerp(x-w_,x+w_,hp/hp_max)

draw_rectangle(x-w_,y-y_offset_-h_,percent_x_,y-y_offset_+h_,false);
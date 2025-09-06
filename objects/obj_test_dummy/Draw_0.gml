/// @description

// Inherit the parent event
event_inherited();

var w = 8; //half width
var h = 1; //half height

var y_offset = -32;

draw_set_color(black);
draw_rectangle(x-w,y-y_offset-h,x+w,y-y_offset+h,false);

draw_set_color(white);

var percent_x = lerp(x-w,x+w,hp/hp_max)

draw_rectangle(x-w,y-y_offset-h,percent_x,y-y_offset+h,false);
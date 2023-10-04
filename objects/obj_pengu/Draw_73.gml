/// @description





//draws vector lines
if(bl_collide()) draw_set_color(c_white);
else draw_set_color(c_red);

draw_line(x+vec_l.x,y+vec_l.y,x+vec_bl.x,y+vec_bl.y)

if(bl_collide()) draw_set_color(c_white);
else draw_set_color(c_green);

draw_line(x+vec_r.x,y+vec_r.y,x+vec_br.x,y+vec_br.y)

draw_set_color(c_white);
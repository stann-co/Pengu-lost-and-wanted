/// @description

//draws vector lines

//left
//draw_set_color(c_orange);
//draw_line(x,y,x+vec_l.x,y+vec_l.y)
//
////right
//draw_set_color(c_purple);
//draw_line(x,y,x+vec_r.x,y+vec_r.y)


#region bottom
//bottom left
draw_set_color(c_red);
draw_sensor(x,y,vec_bl,snap_to_90(ground_angle),h_radius);
draw_sensor(x,y,vec_bl,snap_to_90(ground_angle),-h_radius);


//bottom right
draw_set_color(c_green);
draw_sensor(x,y,vec_br,snap_to_90(ground_angle),h_radius);
draw_sensor(x,y,vec_br,snap_to_90(ground_angle),-h_radius);

draw_set_color(c_white);
draw_circle(x+vec_br.x,y+vec_br.y,1,0);
draw_circle(x+vec_bl.x,y+vec_bl.y,1,0);
#endregion



#region side
//left
if(ground_spd < 0){
	draw_set_color(c_yellow);
	draw_sensor(x,y,vec_l,snap_to_90(ground_angle)-90,w_radius);
	draw_sensor(x,y,vec_l,snap_to_90(ground_angle)-90,-w_radius);
	
	draw_set_color(c_white);
	draw_circle(x+vec_l.x,y+vec_l.y,1,0);
}


//right
if(ground_spd > 0){
	draw_set_color(c_orange);
	draw_sensor(x,y,vec_r,snap_to_90(ground_angle)+90,w_radius);
	draw_sensor(x,y,vec_r,snap_to_90(ground_angle)+90,-w_radius);
	
	draw_set_color(c_white);
	draw_circle(x+vec_r.x,y+vec_r.y,1,0);
}


#endregion



draw_text(x,y-40,ground_angle);
draw_text(x,y-60,snap_to_90(ground_angle));
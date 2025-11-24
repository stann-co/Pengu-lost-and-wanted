/// @description
//the main pole is in charge of drawing both poles, the other is just used as a reference point
if(main_pole){
	
	draw_set_color(BLACK);
	draw_line_width(point1.x,point1.y,point2.x,point2.y,2);
	draw_line_width(point3.x,point3.y,point4.x,point4.y,2);
	draw_set_color(WHITE);
	
	draw_self();
	draw_sprite(spr_skilift_pole,0,other_pole.x,other_pole.y);
	
}



















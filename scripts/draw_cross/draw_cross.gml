///@function draw_cross()
///@description draws a cross at position
function draw_cross(x,y,radius,color = white,angle = 0){
	
	var prev_color = draw_get_color();
	
	draw_set_color(color);
	
	var l1x = radius * dcos(angle);
	var l1y = radius * dsin(angle);
	
	var l2x = radius * dcos(angle+90);
	var l2y = radius * dsin(angle+90)

	//horizontal
	draw_line(x+l1x,y+l1y,x-l1x,y-l1y);
	//vertical
	draw_line(x+l2x,y+l2y,x-l2x,y-l2y);
	
	draw_set_color(prev_color);
}
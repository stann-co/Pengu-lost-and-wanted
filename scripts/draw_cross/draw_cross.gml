///@function draw_cross()
///@description draws a cross at position
function draw_cross(_x,_y,_radius,_color = WHITE,_angle = 0){
	
	var prev_color_ = draw_get_color();
	
	draw_set_color(_color);
	
	var l1x_ = _radius * dcos(_angle);
	var l1y_ = _radius * dsin(_angle);
	
	var l2x_ = _radius * dcos(_angle+90);
	var l2y_ = _radius * dsin(_angle+90)

	//horizontal
	draw_line(_x+l1x_,_y+l1y_,_x-l1x_,_y-l1y_);
	//vertical
	draw_line(_x+l2x_,_y+l2y_,_x-l2x_,_y-l2y_);
	
	draw_set_color(prev_color_);
}
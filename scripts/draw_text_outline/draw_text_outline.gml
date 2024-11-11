///@function draw_text_outline()
///@description draws text with outline
function draw_text_outline(x,y,text,width=1,color = white,outline_color = black,detail = 9){
	
	var prev_color = draw_get_color();
	
	var dir = 0;
	
	draw_set_color(outline_color);
	for (var i = 0; i < detail; ++i) {
		var x_offset = lengthdir_x(width,dir);
		var y_offset = lengthdir_y(width,dir);
		
	    draw_text(x+x_offset,y+y_offset,text);
		
		dir += 360 / detail;		
	}
	
	
	draw_set_color(color);
	draw_text(x,y,text);
	draw_set_color(prev_color);
}
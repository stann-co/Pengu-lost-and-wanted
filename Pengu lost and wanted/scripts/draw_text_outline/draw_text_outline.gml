///@function draw_text_outline()
///@description draws _text with outline
function draw_text_outline(_x,_y,_text,_width=1,_color = WHITE,_outline_color = BLACK){
	var prev_color_ = draw_get_color();
	
	draw_set_color(_outline_color);
	for (var x_ = -1; x_ <= 1; ++x_) {
		for (var y_ = -1; y_ <= 1; ++y_) {
			if(x_ == 0 && y_ == 0) continue;
		    draw_text(_x+x_,_y+y_,_text);
		}
	}
	
	draw_set_color(_color);
	draw_text(_x,_y,_text);
	draw_set_color(prev_color_);
}
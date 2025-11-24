///@function draw_text_outline()
///@description draws _text with outline
function draw_text_outline(_x,_y,_text,_width=1,_color = WHITE,_outline_color = BLACK,_detail = 9){
	
	var prev_color_ = draw_get_color();
	
	var dir_ = 0;
	
	draw_set_color(_outline_color);
	for (var i_ = 0; i_ < _detail; ++i_) {
		var x_offset_ = lengthdir_x(_width,dir_);
		var y_offset_ = lengthdir_y(_width,dir_);
		
	    draw_text(_x+x_offset_,_y+y_offset_,_text);
		
		dir_ += 360 / _detail;		
	}
	
	
	draw_set_color(_color);
	draw_text(_x,_y,_text);
	draw_set_color(prev_color_);
}
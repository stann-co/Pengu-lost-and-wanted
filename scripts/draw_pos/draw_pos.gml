///@function draw_pos()
///@description draws the position as text for debugging
function draw_pos(_x,_y){
	
	var prev_font_ = draw_get_font();
	draw_set_font(f_debug);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text_outline(_x,_y-5,string(_x));
	draw_text_outline(_x,_y+5,string(_y));
	draw_set_font(prev_font_);
	
	draw_set_valign(fa_top);
}
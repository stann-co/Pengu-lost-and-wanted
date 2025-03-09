///@function draw_pos()
///@description draws the position as text for debugging
function draw_pos(x,y){
	
	var prev_font = draw_get_font();
	draw_set_font(f_debug);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text_outline(x,y-5,string(x));
	draw_text_outline(x,y+5,string(y));
	draw_set_font(prev_font);
	
	draw_set_valign(fa_top);
}
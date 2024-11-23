/// @description
state.draw();

draw_set_halign(fa_left)

if(save_text) draw_text(50,50,"saved position"); 


draw_set_font(global.gui_font);

draw_set_halign(fa_right);

var text = [
	score,
	$"combo:{score_combo}",
	score_combo_t,
]
for (var i = 0; i < array_length(text); ++i) {
    draw_text(global.gui_w-5,5+(14*i),text[i]);
}



draw_set_halign(fa_left);

//draw_set_font(f_pixel);
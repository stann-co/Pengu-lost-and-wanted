/// @description
state.draw();

draw_set_halign(fa_left)

if(save_text) draw_text(50,50,"saved position"); 

draw_set_halign(fa_right);
draw_text(global.gui_w-10,10,score);
draw_text(global.gui_w-10,20,$"combo{score_combo}");

draw_text(global.gui_w-10,30,score_combo_t);

draw_set_halign(fa_left);
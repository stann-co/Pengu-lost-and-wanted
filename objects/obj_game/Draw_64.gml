/// @description

//if(obj_camera.transition_val != 0){
//	shader_set(sh_transition);
//	var u_transition = shader_get_uniform(sh_transition,"u_transition");
//	shader_set_uniform_f(u_transition,obj_camera.transition_val);
//}



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


draw_set_alpha(transition_val)
draw_rectangle(0,0,global.game_w,global.game_h,0);
draw_set_alpha(1)
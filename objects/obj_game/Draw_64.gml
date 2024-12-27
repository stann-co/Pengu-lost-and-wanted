/// @description

state.draw();

draw_set_halign(fa_left)

if(save_text) draw_text(50,50,"saved position"); 

draw_set_font(global.gui_font);

if(!main_menus){	
	//var score_text = string_format(global.score,6,0);
	score_text = global.score// string_replace_all(score_text," ","0");
	//if(global.score_combo_t > 0){
	//	score_text += "x2";
	//}
	
	var minutes = global.t div (game_speed * 60);
	var seconds = string_format(global.t div (game_speed) mod 60,2,0);
	var frames =  string_format(global.t mod game_speed,2,0);
	
	var time_text = string_replace_all($"{minutes}\"{seconds}'{frames}"," ","0");
	
	var coin_text = $"{global.coins}"
	
	var text = [
		"SCORE", 
		"TIME",  
		"SNACKS"
	]
	
	var text2 = [
		score_text,
		time_text,
		coin_text
	
	]
	
	draw_set_halign(fa_left);
	//shader_set(sh_color)
	//var u_color = shader_get_uniform(sh_color,"u_color")
	//var u_intensity = shader_get_uniform(sh_color,"u_intensity")
	//var color = yellow
	//shader_set_uniform_f(u_color,
	//	color_get_red(color)/255,
	//	color_get_green(color)/255,
	//	color_get_blue(color)/255)
	//shader_set_uniform_f(u_intensity,1);
	
	draw_set_color(yellow)
	
	for (var i = 0; i < array_length(text); ++i) {		
	    draw_text(5,5+16*i,text[i]);
	}
	draw_set_color(white)
	//shader_reset()
	
	draw_set_halign(fa_right);
	for (var i = 0; i < array_length(text2); ++i) {		
	    draw_text(135,5+16*i,text2[i]);
	}
	draw_set_halign(fa_left);
	
	var test = score_combo_t_max
	//combo counter
	if(global.score_combo_t > 0){
		
		draw_set_color(light_pink)
		
		var val = global.score_combo_t / score_combo_t_max
		var x_ = dsin(global.t*10)   * 4 * val;
		var y_ = dsin(global.t*10*2) * 4 * val;
		x_ += stanncam_shake(score_combo_t_max - global.score_combo_t,4,game_speed*1)
		y_ += stanncam_shake(score_combo_t_max - global.score_combo_t,4,game_speed*1)
		
		draw_text(145+x_,5+y_,$"X{global.score_mult}");
		
		draw_set_color(white);
	}
	
}

draw_set_alpha(transition_val)
draw_rectangle(0,0,global.game_w,global.game_h,0);
draw_set_alpha(1)
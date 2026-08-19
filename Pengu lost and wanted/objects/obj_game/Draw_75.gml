/// @description
if(global.gui_draw){
	draw_set_font(global.gui_font);
    state.draw();
    
    draw_set_halign(fa_left)
    
    if(save_text) draw_text(50,50,"saved position"); 
    
    
    if(!MAIN_MENUS){	
    	var score_text_ = global.score	
    	var time_text_ = timer_text(timer);
    	
    	var coin_text_ = $"{global.coins}"
    	
    	var text_ = [
    		"SCORE", 
    		"TIME",  
    		"SNACKS"
    	]
    	
    	var text2_ = [
    		score_text_,
    		time_text_,
    		coin_text_
    	
    	]
    	
    	draw_set_halign(fa_left);
    	draw_set_color(YELLOW)
    	for (var i_ = 0; i_ < array_length(text_); ++i_) {		
    	    draw_text(5,5+16*i_,text_[i_]);
    	}
    	
    	draw_set_halign(fa_right);
    	draw_set_color(WHITE)
    	for (var i_ = 0; i_ < array_length(text2_); ++i_) {		
    	    draw_text(135,5+16*i_,text2_[i_]);
    	}
    	draw_set_halign(fa_left);
    	
    	//combo counter
    	if(global.score_combo_t > 0){
    		
    		draw_set_color(LIGHT_PINK)
    		
    		var val_ = global.score_combo_t / SCORE_COMBO_T_MAX
    		var x_ = dsin(global.t*10)   * 4 * val_;
    		var y_ = dsin(global.t*10*2) * 4 * val_;
    		x_ += stanncam_shake(SCORE_COMBO_T_MAX - global.score_combo_t,4,SECOND*1)
    		y_ += stanncam_shake(SCORE_COMBO_T_MAX - global.score_combo_t,4,SECOND*1)
    		
    		draw_text(5+x_,53+y_,$"X{global.score_mult}");
    		
    		draw_set_color(WHITE);
    	}
    	
    } else {
    	//Game version
    	draw_set_font(f_debug);
    	draw_set_halign(fa_right);
    	draw_text(global.game_w-1,1,VERSION);
    }
    
    draw_set_font(global.gui_font);
}

#region transition
if (transition_val > 0){
	draw_set_alpha(transition_val)
	draw_rectangle(0,0,global.game_w,global.game_h,0);
	draw_set_alpha(1)	
}
#endregion
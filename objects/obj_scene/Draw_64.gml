/// @description

var alpha_ = 1;
for(var i_=0;i_<array_length(debug_text);i_++){
    draw_set_alpha(alpha_);
    
    draw_set_font(f_debug)
    
    draw_text(0,i_*6,debug_text[i_]);
    draw_set_alpha(1);
    alpha_ -= 0.2;
}

if(array_length(debug_text) > 0){

    if(debug_text_t != 0) debug_text_t--;
    else {
        array_pop(debug_text);
        debug_text_t = GAME_SPEED * 4;
    }
}

state.draw();
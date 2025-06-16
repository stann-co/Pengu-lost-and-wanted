/// @description

var alpha = 1;
for(i=0;i<array_length(debug_text);i++){
    draw_set_alpha(alpha);
    
    draw_set_font(f_debug)
    
    draw_text(0,i*6,debug_text[i]);
    draw_set_alpha(1);
    alpha -= 0.2;
}

if(array_length(debug_text) > 0){

    if(debug_text_t != 0) debug_text_t--;
    else {
        array_pop(debug_text);
        debug_text_t = game_speed * 4;
    }
}

state.draw();
/// @desc set color and alpha
/// @param {constant.color} [_color]=c_white
/// @param {real} [_alpha]=1
function set_draw(_color = WHITE,_alpha = 1){
    draw_set_color(_color);
    draw_set_alpha(_alpha);
}

/// @desc sets color white and alpha 1
function reset_draw(){
    set_draw();
}


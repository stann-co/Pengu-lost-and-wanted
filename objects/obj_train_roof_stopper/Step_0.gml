/// @description

state.step()


var half_height = sprite_height/2 - 16;

var offset_ = sin(global.t * 0.05) * half_height;

hitpoint.y = y-(sprite_height/2)+offset_;
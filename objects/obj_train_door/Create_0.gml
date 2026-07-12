/// @description

// Inherit the parent event
event_inherited();

open_for_time = function(_time = 1){
	forced_active = true;
	forced_active_t = _time * GAME_SPEED;
}

y_closed = y;
y_open = y - 64;

if(active) y = y_open;

move_spd = 0.1;

forced_active_t = 0;

forced_active = false;
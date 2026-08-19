/// @description
if(active || forced_active) {
	y = lerp(y,y_open,move_spd);
} else {
	y = lerp(y,y_closed,move_spd);
}

if(forced_active_t > 0) forced_active_t--
else forced_active = false;
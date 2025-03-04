/// @description

if(keyboard_check(vk_shift)){ //if shift r, checkpoint is reset
	global.active_level.checkpoint = undefined;	
}

room_restart();

state.change("idle");
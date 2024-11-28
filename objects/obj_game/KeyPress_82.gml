/// @description

if(keyboard_check(vk_shift)){ //if shift r, checkpoint is reset
	global.level_var.checkpoint = noone;	
}

room_restart();
/// @description

rope.update(drag);


if(mouse_check_button(mb_right)){	
	target_x = global.camera.get_mouse_x();
	target_y = global.camera.get_mouse_y();
	
	//var p = rope.get_last_point()
	//p.x = target_x;
	//p.y = target_y;
	
	rope.move_relative(target_x,target_y,relative);
}


rope.gravity_force();
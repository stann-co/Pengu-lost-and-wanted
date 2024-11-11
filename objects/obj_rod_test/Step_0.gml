/// @description

rod.substeps = substeps;

rod.get_last_point().mass = mass;

rod.update(drag,stiffness);
cable.update(drag);


if(mouse_check_button(mb_right)){	
	target_x = mouse_x //global.camera.get_mouse_x();
	target_y = mouse_y //global.camera.get_mouse_y();
	
	rod.get_first_point().set_pos(target_x,target_y);

}

if(mouse_check_button(mb_middle)){	
	target_x = mouse_x //global.camera.get_mouse_x();
	target_y = mouse_y //global.camera.get_mouse_y();
	
	cable.get_last_point().set_pos(target_x,target_y);

}

rod.gravity_force();
cable.gravity_force();
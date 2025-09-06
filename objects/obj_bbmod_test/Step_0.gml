/// @description

var forward = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP)
var right	= InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT) 
var up		= keyboard_check(vk_shift) - keyboard_check(vk_control);

if(forward != 0 || right != 0){
	
	var right_relative = global.camera_3d.get_right();
	var forward_relative = right_relative.cross(global.camera_3d.cam_up);
	
	right_relative = right_relative.scale(right);
	forward_relative = forward_relative.scale(forward);
	
	var translation = right_relative.add(forward_relative);
	
	
	player.move(translation.x,translation.y,translation.z);
	player.target = translation.normalize();
	

	global.camera_3d.set_position(player.pos.x,player.pos.y,player.pos.z);
	
}
player.update_shape()


if(mouse_check_button(mb_left)){	
	var pitch = my - mouse_y
	var yaw   = mx - mouse_x

	global.camera_3d.rotate(pitch,yaw)
}
mx = mouse_x;
my = mouse_y;


animplayer.update(delta_time);

var arm_l = test.find_node_id("arm.L");
var arm_r = test.find_node_id("arm.R");
var node_l = animplayer.get_node_transform(arm_l);
var node_r = animplayer.get_node_transform(arm_r);

var pos_l = node_l.GetTranslation()
var pos_r = node_r.GetTranslation()

//sphere_l[@ CM_SPHERE.X] = pos_l.X;
//sphere_l[@ CM_SPHERE.Y] = pos_l.Y;
//sphere_l[@ CM_SPHERE.Z] = pos_l.Z;

//sphere_r[@ CM_SPHERE.X] = pos_r.X;
//sphere_r[@ CM_SPHERE.Y] = pos_r.Y;
//sphere_r[@ CM_SPHERE.Z] = pos_r.Z;


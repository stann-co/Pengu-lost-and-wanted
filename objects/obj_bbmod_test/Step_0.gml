/// @description

var forward_ = InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.DOWN)
var right_	= InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT) 
var up_		= keyboard_check(vk_shift) - keyboard_check(vk_control);

if(forward_ != 0 || right_ != 0){
	
	var right_relative_ = global.camera_3d.get_right();
	var forward_relative_ = right_relative_.cross(global.camera_3d.cam_up);
	
	right_relative_ = right_relative_.scale(right_);
	forward_relative_ = forward_relative_.scale(forward_);
	
	var translation_ = right_relative_.add(forward_relative_);
	
	
	player.move(translation_.x,translation_.y,translation_.z);
	player.target = translation_.normalize();
	

	global.camera_3d.set_position(player.pos.x,player.pos.y,player.pos.z);
	
}
player.update_shape()


if(mouse_check_button(mb_left)){	
	var pitch_ = my - mouse_y
	var yaw_   = mx - mouse_x

	global.camera_3d.rotate(pitch_,yaw_)
}
mx = mouse_x;
my = mouse_y;


animplayer.update(delta_time);

var arm_l_ = test.find_node_id("arm.L");
var arm_r_ = test.find_node_id("arm.R");
var node_l_ = animplayer.get_node_transform(arm_l_);
var node_r_ = animplayer.get_node_transform(arm_r_);

var pos_l_ = node_l_.GetTranslation()
var pos_r_ = node_r_.GetTranslation()

//sphere_l[@ CM_SPHERE.X] = pos_l_.X;
//sphere_l[@ CM_SPHERE.Y] = pos_l_.Y;
//sphere_l[@ CM_SPHERE.Z] = pos_l_.Z;

//sphere_r[@ CM_SPHERE.X] = pos_r_.X;
//sphere_r[@ CM_SPHERE.Y] = pos_r_.Y;
//sphere_r[@ CM_SPHERE.Z] = pos_r_.Z;


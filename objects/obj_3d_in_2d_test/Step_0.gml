/// @description

animplayer.update(delta_time);

//var arm_l = test.find_node_id("arm.L");
//var arm_r = test.find_node_id("arm.R");
//var node_l = animplayer.get_node_transform(arm_l);
//var node_r = animplayer.get_node_transform(arm_r);
//
//var pos_l = node_l.GetTranslation()
//var pos_r = node_r.GetTranslation()

var updown_ = keyboard_check(ord("N")) - keyboard_check(ord("M"))
depth+=updown_;


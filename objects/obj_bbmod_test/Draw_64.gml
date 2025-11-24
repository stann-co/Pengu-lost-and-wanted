/// @description
global.camera_3d.draw_gizmo(global.gui_w-45,5)

var screen_ = global.camera_3d.pos_to_screen(new stanncam_vec3(0,0,0));
var x_ = screen_.x
var y_ = screen_.y

draw_sprite(spr_points,0,x_,y_)
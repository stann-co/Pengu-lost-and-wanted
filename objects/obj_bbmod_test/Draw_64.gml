/// @description
global.camera_3d.draw_gizmo(global.gui_w-45,5)

var screen = global.camera_3d.pos_to_screen(new stanncam_vec3(0,0,0));
var x_ = screen.x
var y_ = screen.y

draw_sprite(spr_points,0,x_,y_)
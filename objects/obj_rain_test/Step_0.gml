/// @description

var cam_x_ = global.camera.get_x();
var cam_y_ = global.camera.get_y();
part_emitter_region(ps, emitter, cam_x_-global.camera.width, cam_x_+global.camera.width+100, cam_y_-100, cam_y_-100, ps_shape_line, ps_distr_linear);

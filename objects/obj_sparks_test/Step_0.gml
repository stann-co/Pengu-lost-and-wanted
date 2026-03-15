/// @description

event_inherited()

var spd_ = xprevious - x;
var side_ = sign(spd_);
spd_ = abs(spd_);

part_emitter_stream(ps,emitter,part,lerp(0,500,spd_));
var val_ =  (side_+1)/2;
var dir_ = lerp(135,45,val_);
var spread_ = 15;
part_type_direction(part,dir_-spread_,dir_+spread_,0,0);

var spd_min_ = lerp(0,2,spd_*0.3);
var spd_max_ = lerp(0,3,spd_*0.3);
part_type_speed(part,spd_min_,spd_max_,0,0);
part_emitter_region(ps,emitter,bbox_left,bbox_right,bbox_bottom-1,bbox_bottom,ps_shape_rectangle,ps_distr_linear);

//part_emitter_region(ps, emitter, cam_x_-global.camera.width, cam_x_+global.camera.width+100, cam_y_-100, cam_y_-100, ps_shape_line, ps_distr_linear);

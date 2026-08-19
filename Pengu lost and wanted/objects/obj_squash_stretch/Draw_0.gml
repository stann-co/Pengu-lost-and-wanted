draw_sprite_entity(spr_test_dummy,0,x,y+h_radius+3,1,1,0,-1,1);

var seg_ = spine.segments[0];
var x_ = seg_.p1.x;
var y_ = seg_.p1.y;
var dir_ = seg_.get_direction()-90;
draw_sprite_entity(spr_test_dummy,1,x_,y_,1,1,dir_,-1,1);

seg_ = spine.segments[1];
x_ = seg_.p1.x;
y_ = seg_.p1.y;
dir_ = seg_.get_direction()-90;
draw_sprite_entity(spr_test_dummy,2,x_,y_,1,1,dir_,-1,1);

seg_ = spine.segments[2];
x_ = seg_.p1.x;
y_ = seg_.p1.y;
dir_ = seg_.get_direction()-90;
draw_sprite_entity(spr_test_dummy,3,x_,y_,1,1,dir_,-1,1);
/// @description draws the ball and springs

var par_ = parralax_snapped(x,y,15,15);
var par_x_ = par_.x;
var par_y_ = par_.y;

var depth_ = gpu_get_depth();

gpu_set_depth(depth_+50);

draw_sprite(spr_spring_ball,0,par_x_,par_y_);

par_x_ = lerp(par_.x,x,0.333);
par_y_ = lerp(par_.y,y,0.333);

draw_sprite(spr_spring_ball,1,par_x_+(ball_vec.x*0.333),par_y_+(ball_vec.y*0.333));

par_x_ = lerp(par_.x,x,0.666);
par_y_ = lerp(par_.y,y,0.666);

draw_sprite(spr_spring_ball,2,par_x_+(ball_vec.x*0.666),par_y_+(ball_vec.y*0.666));

gpu_set_depth(depth_);

draw_sprite(spr_spring_ball,3,x+ball_vec.x,y+ball_vec.y);

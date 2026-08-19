/// @description

var disappearing_ = 1;

if(disappear){
	disappearing_ = round(animcurve_read(ac_disappear,0,(global.t-start_time)/disappear_duration));
}

var alpha_ = disappearing_ ? 1 : 0.5;

var anim_t_ = ((global.t + t_offset) mod anim_duration) / anim_duration

var y_offset_   = animcurve_read(ac_coin,"anim_y"  ,anim_t_) * y_offset_max;
var rot_offset_ = animcurve_read(ac_coin,"anim_rot",anim_t_) * rot_offset_max;

draw_sprite_ext(sprite_index,image_index,x,y+y_offset_,image_xscale,image_yscale,rot_offset_,-1,alpha_);

if(global.debug && state.state_is("physics")){
	draw_set_color(RED);
	draw_sensor(x,y,vec_hor,90 ,sign(xspeed) * sensor_dist);
	draw_set_color(GREEN);
	draw_sensor(x,y,vec_ver,0,sign(yspeed) * sensor_dist);
	draw_set_color(WHITE);
	
}
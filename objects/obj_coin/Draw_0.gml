/// @description

var disappearing = 1;

if(disappear){
	disappearing = round(animcurve_read(ac_disappear,0,(global.t-start_time)/disappear_duration));
}

var alpha = disappearing ? 1 : 0.5;

var anim_t = ((global.t + t_offset) mod anim_duration) / anim_duration

var y_offset   = animcurve_read(ac_coin,"anim_y"  ,anim_t) * y_offset_max;
var rot_offset = animcurve_read(ac_coin,"anim_rot",anim_t) * rot_offset_max;

draw_sprite_ext(sprite_index,image_index,x,y+y_offset,image_xscale,image_yscale,rot_offset,-1,alpha);

if(global.debug && state.state_is("physics")){
	draw_set_color(red);
	draw_sensor(x,y,vec_hor,90 ,sign(xspeed) * sensor_dist);
	draw_set_color(green);
	draw_sensor(x,y,vec_ver,0,sign(yspeed) * sensor_dist);
	draw_set_color(white);
	
}











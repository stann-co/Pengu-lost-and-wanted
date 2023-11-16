/// @description

var disappearing = 1;

if(disappear){
	disappearing = round(animcurve_read(ac_disappear,0,disappear_t/disappear_duration));
	disappear_t++;
	
	if(disappear_t == disappear_duration) instance_destroy();
}

if(disappearing == 1){

	var anim_t = (global.t mod anim_duration) / anim_duration
	
	var y_offset   = animcurve_read(ac_coin,"anim_y"  ,anim_t) * y_offset_max;
	var rot_offset = animcurve_read(ac_coin,"anim_rot",anim_t) * rot_offset_max;
	
	draw_sprite_ext(sprite_index,image_index,x,y+y_offset,image_xscale,image_yscale,rot_offset,-1,1);
}

if(global.debug && state.state_is("physics")){
	draw_set_color(red);
	draw_sensor(x,y,vec_hor,90 ,sign(xspeed) * sensor_dist);
	draw_set_color(green);
	draw_sensor(x,y,vec_ver,0,sign(yspeed) * sensor_dist);
	draw_set_color(white);
	
}











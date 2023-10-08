/// @description
if(animate){
	subimg+=sprite_get_speed(sprite_index);
	if(animation_end(sprite_index,subimg)){
		animate = false;
		subimg = 0;	
	}
}














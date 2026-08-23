/// @description
if(global.debug){
	debug_draw_self(true)
	draw_text(x,y,image_angle)
	draw_text(x,y+20,t);
} else {
	draw_self();
}
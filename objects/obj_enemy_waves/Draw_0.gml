/// @description
if(global.debug){
	draw_self();
	draw_text(x,y-16,$"WAVE: {string(wave)}");
	draw_text(x,y-32,$"ENEMIES: {string(array_length(enemies))}");
}

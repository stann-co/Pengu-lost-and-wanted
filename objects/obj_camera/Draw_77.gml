/// @description


//draw background
//global.background();

//draw game

if(obj_game.transition_val != 0){
	shader_set(sh_transition);
	u_transition = shader_get_uniform(sh_transition,"u_transition");
	shader_set_uniform_f(u_transition,obj_game.transition_val );
}



global.camera.draw(0,0);

shader_reset()

/// @description
if(obj_game.transition_val != 0){
	shader_set(sh_transition);
	var u_transition_ = shader_get_uniform(sh_transition,"u_transition");
	shader_set_uniform_f(u_transition_,obj_game.transition_val );
}

state.draw();

shader_reset()

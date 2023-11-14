//everything pengu falls off if he's sliding / walking
//for when you slide down slopes and end up sliding down a wall where you'd want him to fall off

trigger = function(){
	with(obj_pengu){
		if(!state.state_is("airborne")){
			state.change("begin_fall");	
		}
	}
}
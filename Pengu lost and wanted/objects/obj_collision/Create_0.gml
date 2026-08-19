event_inherited();

/// @description collision object, when triggered it returns true, letting collision functions now it counts as solid

//when a sensor collides with this object,
//return true if solid
//return false if non-solid
trigger = function(_side,_object){
	//_object.x+= x - xprevious; //if moving, the collided object will also move
	return true;
}
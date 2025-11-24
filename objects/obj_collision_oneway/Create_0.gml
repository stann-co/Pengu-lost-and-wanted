/// @description

trigger = function(_side,_object){
	//only solid from the top
	
	if (_side == SIDES.TOP) return true
	else return false
}
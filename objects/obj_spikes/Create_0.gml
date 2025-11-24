/// @description

trigger = function(_side,_object){
	
	//hurt
	if(_side == SIDES.TOP){
		if(_object.object_index == obj_pengu){
			_object.hurt(sign(_object.x - x));
		}
	}
	return true
}
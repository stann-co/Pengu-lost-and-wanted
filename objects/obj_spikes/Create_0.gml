/// @description

trigger = function(side_,object_){
	
	//hurt
	if(side_ == SIDES.Top){
		if(object_.object_index == obj_pengu){
			object_.hurt(sign(object_.x - x));
		}
	}
	return true
}
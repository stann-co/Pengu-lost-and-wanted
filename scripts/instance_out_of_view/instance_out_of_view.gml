///@function bounds_out_of_view()
///@description returns if instances bbox is out of the camera's view
function bounds_out_of_view(_b_left = bbox_left,_b_right = bbox_right,_b_top = bbox_top,_b_bottom = bbox_bottom){
	var cam_ = global.camera;
	
	return (_b_right < cam_.get_x() ||
			_b_left > cam_.get_x()+cam_.width ||
			_b_bottom < cam_.get_y() ||
			_b_top > cam_.get_y()+cam_.height
			)
}
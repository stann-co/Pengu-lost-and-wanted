///@function bounds_out_of_view()
///@description returns if instances bbox is out of the camera's view
function bounds_out_of_view(b_left = bbox_left,b_right = bbox_right,b_top = bbox_top,b_bottom = bbox_bottom){
	var cam = global.camera;
	
	return (b_right < cam.get_x() ||
			b_left > cam.get_x()+cam.width ||
			b_bottom < cam.get_y() ||
			b_top > cam.get_y()+cam.height
			)
}
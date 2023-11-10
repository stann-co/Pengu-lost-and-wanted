/// @description
global.t++;


/// @description deactivates objects out of view

var margin = camera_outer_margin;

var left = global.camera.get_x() -margin;
var top = global.camera.get_y() -margin;

var width = global.camera.width   +	(margin*2);
var height = global.camera.height +	(margin*2);

instance_deactivate_region(left, top, width, height, false,true);
instance_activate_region(left, top, width, height, true);

//these should always be active
instance_activate_object(obj_camera);
instance_activate_object(input_controller_object)
instance_activate_object(__obj_stanncam_manager);
instance_activate_object(obj_game);
instance_activate_object(obj_pengu);


//connected instances will all be active if just one of them is active
for (var i1 = 0; i1 < array_length(global.activation_list); ++i1) {
	var linked_array = global.activation_list[i1];
	
	var any_active = false;
	
	for (var i2 = 0; i2 < array_length(linked_array); ++i2) {
		   if (instance_exists(linked_array[i2])){
			   any_active = true;
			   break;
		   }
	}
	
	if(any_active){
		for (var i2 = 0; i2 < array_length(linked_array); ++i2) {
		   instance_activate_object(linked_array[i2]);
		}
	}
}
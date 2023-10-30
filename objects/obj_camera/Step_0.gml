/// @description

var margin = 100;

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


















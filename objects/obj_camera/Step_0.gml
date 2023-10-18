/// @description

var left = global.camera.get_x();
var top = global.camera.get_y();

var width = global.camera.width;
var height = global.camera.height;

instance_deactivate_region(left, top, width, height, false,true);
instance_activate_region(left, top, width, height, true);

//these should always be active
instance_activate_object(obj_camera);
instance_activate_object(input_controller_object)
instance_activate_object(__obj_stanncam_manager);
instance_activate_object(obj_game);
instance_activate_object(obj_pengu);


















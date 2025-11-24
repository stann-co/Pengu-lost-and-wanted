/// @description don't draw sprite, only transforms when selected
if(obj_level_editor.element_active == id){
	//draw selection box around corners
	var parralax_ = struct_get_chained(global.level_data,"layers",layer_name,"parralax") ?? 0;
	var offset_x_ = floor(global.camera.get_x() * parralax_);
	var offset_y_ = floor(global.camera.get_y() * parralax_);
	draw_instance_selection(id,offset_x_,offset_y_);
}
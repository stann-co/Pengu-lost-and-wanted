/// @description don't draw sprite, only transforms when selected
if(obj_level_editor.element_active == id){
	//draw selection box around corners
	var parralax_x_ = struct_get_chained(global.room_data,"layers",layer_name,"parralax_x") ?? 0;
    var parralax_y_ = struct_get_chained(global.room_data,"layers",layer_name,"parralax_y") ?? 0;
    var offset_x_ = struct_get_chained(global.room_data,"layers",layer_name,"offset_x") ?? 0;
    var offset_y_ = struct_get_chained(global.room_data,"layers",layer_name,"offset_y") ?? 0;
	var x_ = floor(global.camera.get_x() * parralax_x_) + offset_x_;
	var y_ = floor(global.camera.get_y() * parralax_y_) + offset_y_;
	draw_instance_selection(id,x_,y_);
}
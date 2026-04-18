/// @description
if(global.debug){
	draw_set_halign(fa_right)
	var text_ = [
		$"{airborne} : AIRBORNE",
		$"{ground_spd} : GROUND SPEED",
		$"{ground_angle} : GROUND ANGLE",
		$"{x_speed} : X SPEED",
		$"{y_speed} : Y SPEED",
		$"{control_lock} : CONTROL LOCK",
		$"{depth} : DEPTH",
		$"{parent} : PARENT",
	]
	
	for (var i_ = 0; i_ < array_length(text_); ++i_) {
	    draw_text(global.game_w-5,5+(14*i_),text_[i_]);
	}
	
	draw_set_halign(fa_left)
}

state.draw_gui();

for (var i_ = 0; i_ < ds_list_size(attack_list); i_++) {
	draw_text(0,10*i_,attack_list[|i_])
}


//test tile index
//
//var Mx_ = global.camera.get_mouse_x();
//var My_ = global.camera.get_mouse_y();
//
//sensor(new Vector2(Mx_-x,My_-y),0,1);
//
//var inst_ = _tile_collision(Mx_,My_);
//if(!instance_exists(inst_)){
	////Tiles	
	//var mx_ = tilemap_get_cell_x_at_pixel(inst_, round(Mx_), round(My_));
	//var my_ = tilemap_get_cell_y_at_pixel(inst_, round(Mx_), round(My_));
	//var tile_ = tilemap_get(inst_, mx_, my_);
	//var tile_index_ = tile_get_index(tile_);
	//
	//draw_text(global.camera.room_to_gui_x(Mx_),global.camera.room_to_gui_y(My_), tile_index_);
//}
/// @description
if(tileset != undefined && brush != -1){
    var brush_offset_x_ = ds_grid_width( brush)*grid_cell_w / 2;
    var brush_offset_y_ = ds_grid_height(brush)*grid_cell_h / 2;
    
	var mx_ = round((global.camera.get_mouse_x()-brush_offset_x_) / grid_cell_w) * grid_cell_w;
	var my_ = round((global.camera.get_mouse_y()-brush_offset_y_) / grid_cell_h) * grid_cell_h;
	
	if(ds_exists(brush,ds_type_grid)){ 
		draw_grid_tiles(brush,tileset,mx_,my_);
	}
}
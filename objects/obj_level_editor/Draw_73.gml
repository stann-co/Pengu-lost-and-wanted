/// @description
if(tileset != undefined && brush != -1){
	var cell_w_ = tileset_info.tile_width;
	var cell_h_ = tileset_info.tile_height;
	
	var mx_ = floor(global.camera.get_mouse_x() / cell_w_) * cell_w_;
	var my_ = floor(global.camera.get_mouse_y() / cell_h_) * cell_h_;
	
	if(ds_exists(brush,ds_type_grid)){ 
		draw_grid_tiles(brush,tileset,mx_,my_);
	} else { 
		draw_tile(tileset,brush,0,mx_,my_);
	}
}
#macro tile_blank -2147483648

function draw_grid_tiles(_ds_grid,_tileset,_x,_y){
	var width_ = ds_grid_width(_ds_grid);
	var height_ = ds_grid_height(_ds_grid);

	for (var y_ = 0; y_ < height_; y_++) {
		for (var x_ = 0; x_ < width_; x_++) {
			var tile_ = ds_grid_get(_ds_grid,x_,y_);
			if(tile_ == 0) continue;
			var tileset_info_ = tileset_get_info(_tileset);
			//draw tile at position
			draw_tile(_tileset,tile_,0,_x+x_*tileset_info_.tile_width,_y+y_*tileset_info_.tile_height);
		}
	}
}


function draw_grid(_x,_y,_cell_w,_cell_h,_width,_height,_scale){
	//collumns
    for (var w_ = 0; w_ <= _width; w_++) {
        var x_ =  _x + w_*_cell_w;
        var y1_ = _y;
        var y2_ = _y + _cell_h*_height;
    	draw_line(x_,y1_,x_,y2_);
    }
    
	//rows
    for (var h_ = 0; h_ <= _height; h_++) {
		var y_ =  _y + h_*_cell_h;
		var x1_ = _x;
		var x2_ = _x + _cell_w*_width;
		draw_line(x1_,y_,x2_,y_);
    }
}

/**
 * Function draws filled cell relative to a grid
 * @param {float*} _x position
 * @param {float*} _y
 * @param {int*} _cell_w cell size
 * @param {int*} _cell_h
 * @param {int*} _cell_x cell position
 * @param {int*} _cell_y
 */
function draw_cell(_x,_y,_cell_w,_cell_h,_cell_x,_cell_y){
	var x1_ = _x + (_cell_x*_cell_w);
	var x2_ = x1_+_cell_w;
	var y1_ = _y + (_cell_y*_cell_h);
	var y2_ = y1_+_cell_h;
	draw_rectangle(x1_,y1_,x2_,y2_,false);
}

function transfrom() constructor {
	
}
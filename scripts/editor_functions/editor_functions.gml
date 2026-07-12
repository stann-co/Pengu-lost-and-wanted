#macro IS_EDITOR false 
#macro Editor:IS_EDITOR true

#macro tile_blank -2147483648

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
 * Function draws tiles from ds_grid
 * @param {id.dsgrid} _ds_grid
 * @param {asset.gmtileset} _tileset
 * @param {real} _x
 * @param {real} _y
 * @returns {bool}
 */
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
	return true
}

/**
 * Function pastes dsgrid tilebrush
 * @param {id.tilemapelement} _tilemap tilemap
 * @param {id.dsgrid} _tilegrid tile grid
 * @param {int} _x tilemap pos
 * @param {int} _y
 */
function paste_tile_grid(_tilemap,_tilegrid,_x,_y){
    var width_ = ds_grid_width(_tilegrid);
    var height_ = ds_grid_height(_tilegrid);
    for (var w_ = 0; w_ < width_; w_++) {
        for (var h_ = 0; h_ < height_; h_++) {
            var tile_ = ds_grid_get(_tilegrid,w_,h_);
            
            if (tile_ == 0 || _x+w_ < 0 || _y+h_ < 0) continue;
                
            tilemap_set(_tilemap,tile_,_x+w_,_y+h_);
        }
    }
}

/**
 * Function erases using dsgrid tilebrush
 * @param {id.tilemapelement} _tilemap tilemap
 * @param {id.dsgrid} _tilegrid tile grid
 * @param {int} _x tilemap pos
 * @param {int} _y
 */
function erase_tile_grid(_tilemap,_tilegrid,_x,_y){
    var width_ = ds_grid_width(_tilegrid);
    var height_ = ds_grid_height(_tilegrid);
    for (var w_ = 0; w_ < width_; w_++) {
        for (var h_ = 0; h_ < height_; h_++) {
            var tile_ = ds_grid_get(_tilegrid,w_,h_);
            if (tile_ != 0) tilemap_set(_tilemap,0,_x+w_,_y+h_);
        }
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

/**
 * Function rotates tile and returns it
 * @param {tiledata} _tiledata
 * @param {bool} [_clockwise]=true rotate clockwise or anticlockwise
 * @returns {tiledata}
 */
function rotate_tile(_tiledata,_clockwise = true){
    var rotate_ = tile_get_rotate(_tiledata);
    var flip_   = tile_get_flip(_tiledata);
    var mirror_ = tile_get_mirror(_tiledata);
    
    if(rotate_ == _clockwise){
        _tiledata = tile_set_flip(_tiledata,!flip_);
        _tiledata = tile_set_mirror(_tiledata,!mirror_);
    }
    
    _tiledata = tile_set_rotate(_tiledata,!rotate_);
    
    return _tiledata;
}

/**
 * Function mirrors tile and returns it
 * @param {tiledata} _tiledata
 * @returns {real}
 */
function mirror_tile(_tiledata){
    var rotate_ = tile_get_rotate(_tiledata);
    var flip_   = tile_get_flip(_tiledata);
    var mirror_ = tile_get_mirror(_tiledata);
    
    if(rotate_){
        _tiledata = tile_set_flip(_tiledata,!flip_);
    } else {
        _tiledata = tile_set_mirror(_tiledata,!mirror_);
    }
    return _tiledata;
}

/**
 * Function flips tile and returns it
 * @param {tiledata} _tiledata
 * @returns {real}
 */
function flip_tile(_tiledata){
    var rotate_ = tile_get_rotate(_tiledata);
    var flip_   = tile_get_flip(_tiledata);
    var mirror_ = tile_get_mirror(_tiledata);
    
    if(rotate_){
        _tiledata = tile_set_mirror(_tiledata,!mirror_);
    } else {
        _tiledata = tile_set_flip(_tiledata,!flip_);
    }
    return _tiledata;
}

/**
 * Function Rotates brush with tiledata
 * @param {id.dsgrid<tiledata>} _tilegrid
 * @param {bool} [_clockwise]=true Description
 */
function brush_rotate(_tilegrid,_clockwise = true){
    var width_ = ds_grid_width(_tilegrid);
    var height_ = ds_grid_height(_tilegrid);
    
    var temp_grid_ = ds_grid_create(width_,height_);
    ds_grid_copy(temp_grid_,_tilegrid);
    
    ds_grid_resize(_tilegrid,height_,width_);
    
    for (var w_ = 0; w_ < width_; w_++) {
        for (var h_ = 0; h_ < height_; h_++) {
            var tile_ = ds_grid_get(temp_grid_,w_,h_);
            tile_ = rotate_tile(tile_,_clockwise);
            
            if(_clockwise){
                ds_grid_set(_tilegrid,(height_-1)-h_,w_,tile_);
            } else {
                ds_grid_set(_tilegrid,h_,(width_-1)-w_,tile_);
            }
        }
    }
    
    ds_grid_destroy(temp_grid_);
}

/**
 * Function mirrors tilebrush
 * @param {id.dsgrid<tiledata>} _tilegrid
 */
function brush_mirror(_tilegrid){
    var width_ = ds_grid_width(_tilegrid);
    var height_ = ds_grid_height(_tilegrid);
    
    var temp_grid_ = ds_grid_create(width_,height_);
    ds_grid_copy(temp_grid_,_tilegrid);
    
    for (var w_ = 0; w_ < width_; w_++) {
        for (var h_ = 0; h_ < height_; h_++) {
            var tile_ = ds_grid_get(temp_grid_,w_,h_);
            tile_ = mirror_tile(tile_);
            ds_grid_set(_tilegrid,(width_-1)-w_,h_,tile_);
        }
    }
    
    ds_grid_destroy(temp_grid_);
}

/**
 * Function flips tilebrush
 * @param {id.dsgrid<tiledata>} _tilegrid
 */
function brush_flip(_tilegrid){
    var width_ = ds_grid_width(_tilegrid);
    var height_ = ds_grid_height(_tilegrid);
    
    var temp_grid_ = ds_grid_create(width_,height_);
    ds_grid_copy(temp_grid_,_tilegrid);
    
    for (var w_ = 0; w_ < width_; w_++) {
        for (var h_ = 0; h_ < height_; h_++) {
            var tile_ = ds_grid_get(temp_grid_,w_,h_);
            tile_ = flip_tile(tile_);
            ds_grid_set(_tilegrid,w_,(height_-1)-h_,tile_);
        }
    }
    
    ds_grid_destroy(temp_grid_);
    
}

/// @desc Function draws line with moving checkerboard pattern
/// @param {float*} _x1
/// @param {float*} _y1
/// @param {float*} _x2
/// @param {float*} _y2
/// @param {float*} _width
function draw_line_selection(_x1,_y1,_x2,_y2,_width = 1){
	shader_set(sh_line_selection)
	shader_set_uniform_f(shader_get_uniform(sh_line_selection,"u_length"),point_distance(_x1,_y1,_x2,_y2));
	shader_set_uniform_f(shader_get_uniform(sh_line_selection,"u_time"),current_time);
	draw_line_width_colour(_x1,_y1,_x2,_y2,_width,c_white,c_black);
	shader_reset();
}

/**
 * Function Draw selection box around instance
 * @param {Instance.id*} _inst
 * @param {real} [_x] Offset
 * @param {real} [_y] 
 * @param {real} [_width] = 1 Description
 */
function draw_instance_selection(_inst,_x = 0,_y = 0,_width = 1){
	var c_ = instance_corners(_inst);
	draw_line_selection(c_.tl.x+_x,c_.tl.y+_y,c_.tr.x+_x,c_.tr.y+_y,_width);
	draw_line_selection(c_.tr.x+_x,c_.tr.y+_y,c_.br.x+_x,c_.br.y+_y,_width);
	draw_line_selection(c_.br.x+_x,c_.br.y+_y,c_.bl.x+_x,c_.bl.y+_y,_width);
	draw_line_selection(c_.bl.x+_x,c_.bl.y+_y,c_.tl.x+_x,c_.tl.y+_y,_width);
}

/**
 * Function returns struct with corner positons of rotated/scaled instance
 * @param {Instance.id*} _inst
 * @returns {Struct} tl, tr, bl, br each containing x,y
 */
function instance_corners(_inst){
	with(_inst){
		var c_ = dcos(image_angle);
		var s_ = dsin(image_angle);
		
		var ul_ = -sprite_get_xoffset(sprite_index); //U left
		var vt_ = -sprite_get_yoffset(sprite_index); //V top
		
		var ur_ = sprite_get_width(sprite_index) + ul_; //U right
		var vb_ = sprite_get_height(sprite_index) + vt_; //V bottom
		
		ul_*=image_xscale;
		ur_*=image_xscale;
		vt_*=image_yscale;
		vb_*=image_yscale;

		//Corners
		return {
			//top left
			tl: {
				x : x + c_*ul_ + s_*vt_,
				y : y + -s_*ul_ + c_*vt_,
			},
			//top right
			tr: {
				x: x + c_*ur_ + s_*vt_,
				y: y + -s_*ur_ + c_*vt_,
			},
			//bottom left
			bl: {
				x: x + c_*ul_ + s_*vb_,
				y: y + -s_*ul_ + c_*vb_,
			},
			//bottom right
			br: {
				x: x + c_*ur_ + s_*vb_,
				y: y + -s_*ur_ + c_*vb_,
			}
		}
	}
}

/**
 * Function returns if point is within box
 * @param {real} _x point
 * @param {real} _y
 * @param {real} _1x corners
 * @param {real} _1y 
 * @param {real} _2x 
 * @param {real} _2y 
 * @param {real} _3x 
 * @param {real} _3y 
 * @param {real} _4x 
 * @param {real} _4y 
 * @returns {bool} Description
 */
function point_in_box(_x,_y,_1x,_1y,_2x,_2y,_3x,_3y,_4x,_4y){
	return point_in_triangle(_x,_y,_1x,_1y,_2x,_2y,_3x,_3y) ||
	point_in_triangle(_x,_y,_2x,_2y,_3x,_3y,_4x,_4y)
}

/**
 * Function returns if point is close to a line within threshold
 * @param {real} _x point
 * @param {real} _y 
 * @param {real} _lx1 line start
 * @param {real} _ly1
 * @param {real} _lx2 line end
 * @param {real} _ly2 
 * @param {real} _threshold
 * @returns {bool}
 */
function point_in_line(_x,_y,_lx1,_ly1,_lx2,_ly2,_threshold){
	var d1_ = point_distance(_x,_y,_lx1,_ly1);
	var d2_ = point_distance(_x,_y,_lx2,_ly2);
	var line_len_ = point_distance(_lx1,_ly1,_lx2,_ly2);
	
	//check if within threshold of line length
	if (d1_ + d2_ >= line_len_ - _threshold && d1_ + d2_ <= line_len_ + _threshold){
		return true;
	}
	return false;
}
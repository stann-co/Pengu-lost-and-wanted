#macro IS_EDITOR false 
#macro Editor:IS_EDITOR true

#macro tile_blank -2147483648

//codepoints of the icons in datafiles/editor/icons.ttf
enum ICON{
    MAP              = 0x21,
    STAR             = 0x22,
    PLUS             = 0x23,
    MINUS            = 0x24,
    CLOSE            = 0x25,
    FILE             = 0x26, //blank folded-corner page
    LOCK             = 0x27,
    EDIT             = 0x28,
    EYE              = 0x29,
    EYE_OFF          = 0x30,
    TAG              = 0x31,
    TAGS             = 0x32,
    COMMENT          = 0x33,
    WARNING          = 0x34,
    FILE_ALT         = 0x35, //near-duplicate of FILE, double check if intentional
    FOLDER_OPEN      = 0x36,
    GEAR             = 0x37,
    WRENCH           = 0x38,
    EXPAND           = 0x39, //diagonal arrows pointing outward
    COMPRESS         = 0x40, //diagonal arrows pointing inward
    RESIZE_VERTICAL  = 0x41,
    RESIZE_HORIZONTAL= 0x42,
    ZOOM_IN          = 0x43,
    ZOOM_OUT         = 0x44,
    ARROW_UP         = 0x45,
    ARROW_RIGHT      = 0x46,
    ARROW_LEFT       = 0x47,
    ARROW_DOWN       = 0x48,
    REDO             = 0x49,
    UNDO             = 0x50,
    LEAF             = 0x51,
    TEXT             = 0x52, //"A" glyph
    BOLD             = 0x53, //"B" glyph
    ITALIC           = 0x54, //"I" glyph
    DROPLET          = 0x55,
    ADJUST           = 0x56, //half-filled circle
    KEY              = 0x57,
    MAGNET           = 0x58,
    TARGET           = 0x59,
    CHECK            = 0x60,
    SAVE             = 0x61,
    CLIPBOARD        = 0x62,
    MARQUEE          = 0x63, //dashed selection rectangle
    MOVE             = 0x64, //4-directional arrows from a center point
    EXPAND_ARROWS    = 0x65, //diagonal double-headed arrows on a square
    FLASK            = 0x66,
    COPY             = 0x67,
    MENU             = 0x68, //hamburger menu
    MAGIC_WAND       = 0x69,
    BELL             = 0x70,
    CODE             = 0x71,
    PUZZLE           = 0x72,
    UNLOCK           = 0x73,
    MORE_HORIZONTAL  = 0x74,
    MORE_VERTICAL    = 0x75,
    SHARE            = 0x76, //arrow hooking up-right
    REPLY            = 0x77, //arrow hooking down-right
    SORT_AZ          = 0x78,
    SORT_ZA          = 0x79,
    SORT_SIZE_ASC    = 0xA0, //bars grow longer going down
    SORT_SIZE_DESC   = 0xA1, //bars grow shorter going down
    BUG              = 0xA2,
    PARAGRAPH        = 0xA3,
    SLIDERS          = 0xA4,
    BELL_OFF         = 0xA5,
    TRASH            = 0xA6,
    EYEDROPPER       = 0xA7,
    PAINTBRUSH       = 0xA8,
    USER             = 0xA9, //person standing on a base/platform
    TEXT_CURSOR      = 0xB0,
    TRANSFORM        = 0xB1, //bounding box with rotated inner box, both w/ corner handles
    TRANSFORM_ALT    = 0xB2, //two overlapping boxes w/ corner handles
    FILE_FILLED      = 0xB3, //folded-corner page, solid
    FILE_OUTLINE     = 0xB4, //folded-corner page, outline - near-duplicate of FILE/FILE_ALT
    HELP             = 0xB5,
    SNOWFLAKE        = 0xB6,
    HOME             = 0xB7,
    SHAPES           = 0xB8, //overlapping circle+triangle
    FOLDER           = 0xB9, //near-duplicate of FOLDER_OPEN, double check if intentional
    SWIPE            = 0xC0, //bold diagonal arrow w/ motion trail - meaning unclear, verify
    FRAME            = 0xC1, //corner brackets, like a crop/focus frame
    TILEMAP          = 0xC2, //tilemap
    MAGIC_WAND_ALT   = 0xC3, //near-duplicate of MAGIC_WAND, extra sparkles
    GRID             = 0xC4,
    SIGNAL           = 0xC5, //concentric arcs + dot, could read as wifi/broadcast/rss
    BRIGHTNESS       = 0xC6, //two sun/spark bursts - verify intent
    BRACES           = 0xC7, //"{}" glyph
    FUNCTION         = 0xC8, //cursive "f" glyph
    HASH             = 0xC9, //"#" glyph
    FUNCTION_ALT     = 0xD0, //"f*" glyph - verify against FUNCTION
    LIGHTBULB        = 0xD1, //outline
    PAINT_ROLLER     = 0xD2,
    SWAP             = 0xD3, //opposing horizontal arrows
    ALARM            = 0xD4,
    STEPS            = 0xD5,
    LIGHTBULB_ALT    = 0xD6,
    MOUSE            = 0xD7, //computer mouse
    ANGLE            = 0xD8, //right-angle/protractor
    PENCIL           = 0xD9, //diagonal writing pencil, distinct from EDIT
    SCRIPT           = 0xE0, //scroll + pencil - verify intent
    SHADER           = 0xE1, //diagonal hatch fill
    AUTOFILL         = 0xE2, //near-duplicate of UNLOCK, different style
    ANGLE_90         = 0xE3, //ANGLE with an arrow - verify intent
    ERASER           = 0xE4,
    LINE             = 0xE5, //diagonal pen stroke
    FLIP_VERTICAL    = 0xE6, //dashed vertical line w/ up+down arrows
    PAINTBUCKET      = 0xE7, //tag w/ pencil/paint mark - verify intent
    FLIP_HORIZONTAL  = 0xE8, //"<|>" style glyph - verify intent
}

function draw_grid(_x,_y,_cell_w,_cell_h,_width,_height,_scale){
	//collumns
    for (var w_ = 0; w_ <= _width; w_++) {
        var x_ =  _x + w_*_cell_w*_scale;
        var y1_ = _y;
        var y2_ = _y + _cell_h*_height * _scale;
    	draw_line(x_,y1_,x_,y2_);
    }
    
	//rows
    for (var h_ = 0; h_ <= _height; h_++) {
		var y_ =  _y + h_*_cell_h*_scale;
		var x1_ = _x;
		var x2_ = _x + _cell_w*_width*_scale;
		draw_line(x1_,y_,x2_,y_);
    }
}

function draw_checkerboard(_x,_y,_cell_w,_cell_h,_width,_height,_scale,_col1,_col2){
	set_draw(_col1,1)
	draw_rectangle(_x,_y,_cell_w*_width,_cell_h*_height,false)
	reset_draw()
	
	set_draw(_col2,1)
	for (var w = 0; w < _width; ++w) {
	    for (var h = 0; h < _height; ++h) {
			if((h mod 2 == 0 && w mod 2 == 0) || (h mod 2 == 1 && w mod 2 == 1 )){
				draw_rectangle(
					w*_cell_w,
					h*_cell_h,
					w*_cell_w+_cell_w,
					h*_cell_h+_cell_h,
					false
				)
			}
		}
	}
	reset_draw()
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

//draws _tilemap via individual draw_tile calls instead of draw_tilemap -
//draw_tilemap breaks when combined with a scaling matrix_world on a surface
function draw_tilemap_tiles(_tilemap,_x,_y){
	var tileset_ = tilemap_get_tileset(_tilemap);
	var w_ = tilemap_get_width(_tilemap);
	var h_ = tilemap_get_height(_tilemap);
	var tw_ = tilemap_get_tile_width(_tilemap);
	var th_ = tilemap_get_tile_height(_tilemap);

	for (var yy_ = 0; yy_ < h_; yy_++) {
		for (var xx_ = 0; xx_ < w_; xx_++) {
			var tile_ = tilemap_get(_tilemap,xx_,yy_);
			if (tile_ == 0) continue;
			draw_tile(tileset_,tile_,0,_x+xx_*tw_,_y+yy_*th_);
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

/// @desc returns an array of [x,y] tile coordinate pairs along a straight
/// line from (_x1,_y1) to (_x2,_y2) - Bresenham's algorithm, used by the
/// Line tool
function tile_line_points(_x1,_y1,_x2,_y2){
	var points_ = [];
	var dx_ = abs(_x2-_x1), dy_ = -abs(_y2-_y1);
	var sx_ = _x1 < _x2 ? 1 : -1, sy_ = _y1 < _y2 ? 1 : -1;
	var err_ = dx_+dy_;
	var x_ = _x1, y_ = _y1;

	while (true) {
		array_push(points_, [x_,y_]);
		if (x_ == _x2 && y_ == _y2) break;
		var e2_ = 2*err_;
		if (e2_ >= dy_) { err_ += dy_; x_ += sx_; }
		if (e2_ <= dx_) { err_ += dx_; y_ += sy_; }
	}

	return points_;
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

/// @desc Function draws a selection marker around a rectangular area (eg a
/// single tile or a square of tiles), using draw_line_selection for each edge
/// @param {float*} _x
/// @param {float*} _y
/// @param {float*} _w
/// @param {float*} _h
/// @param {float*} _width line width
function draw_box_selection(_x,_y,_w,_h,_width = 1){
	draw_line_selection(_x,    _y,    _x+_w, _y,    _width);
	draw_line_selection(_x+_w, _y,    _x+_w, _y+_h, _width);
	draw_line_selection(_x+_w, _y+_h, _x,    _y+_h, _width);
	draw_line_selection(_x,    _y+_h, _x,    _y,    _width);
}

/// @desc draws a selection envelope that hugs _grid's actual non-empty cells
/// (not just its bounding rectangle) at tile position (_x,_y) - an edge is
/// drawn wherever a filled cell borders an empty one (or the grid's edge)
/// @param {id.dsgrid} _grid
/// @param {float*} _x tile position
/// @param {float*} _y
/// @param {float*} _cell_w
/// @param {float*} _cell_h
/// @param {float*} _width line width
function draw_grid_selection(_grid,_x,_y,_cell_w,_cell_h,_width = 1){
	var w_ = ds_grid_width(_grid);
	var h_ = ds_grid_height(_grid);

	for (var gx_ = 0; gx_ < w_; gx_++) {
		for (var gy_ = 0; gy_ < h_; gy_++) {
			if (ds_grid_get(_grid,gx_,gy_) == 0) continue;

			var px_ = _x*_cell_w + gx_*_cell_w;
			var py_ = _y*_cell_h + gy_*_cell_h;

			if (gy_ <= 0 || ds_grid_get(_grid,gx_,gy_-1) == 0)
				draw_line_selection(px_, py_, px_+_cell_w, py_, _width);
			if (gy_ >= h_-1 || ds_grid_get(_grid,gx_,gy_+1) == 0)
				draw_line_selection(px_, py_+_cell_h, px_+_cell_w, py_+_cell_h, _width);
			if (gx_ <= 0 || ds_grid_get(_grid,gx_-1,gy_) == 0)
				draw_line_selection(px_, py_, px_, py_+_cell_h, _width);
			if (gx_ >= w_-1 || ds_grid_get(_grid,gx_+1,gy_) == 0)
				draw_line_selection(px_+_cell_w, py_, px_+_cell_w, py_+_cell_h, _width);
		}
	}
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

///@desc combined render-space bounding box of every currently selected
///element (obj_level_editor.get_selected_elements) - each shifted by its
///own parralax offset first, matching where they're actually drawn.
///undefined if nothing's selected. Shared by the group move hit-test
///(obj_asset_transform/Step_0) and its matching visual (Draw_0)
function selection_bounds(){
	var targets_ = obj_level_editor.get_selected_elements();
	if (array_length(targets_) == 0) return undefined;

	var min_x_, min_y_, max_x_, max_y_;
	for (var i_ = 0; i_ < array_length(targets_); i_++) {
		var t_ = targets_[i_];
		var anchor_ = parralax_offset(t_.x, t_.y, parralax_effective(t_.parralax));
		var dx_ = anchor_.x - t_.x;
		var dy_ = anchor_.y - t_.y;
		var c_ = instance_corners(t_);
		var xs_ = [c_.tl.x+dx_, c_.tr.x+dx_, c_.bl.x+dx_, c_.br.x+dx_];
		var ys_ = [c_.tl.y+dy_, c_.tr.y+dy_, c_.bl.y+dy_, c_.br.y+dy_];
		for (var j_ = 0; j_ < 4; j_++) {
			if (i_ == 0 && j_ == 0) {
				min_x_ = xs_[j_]; max_x_ = xs_[j_];
				min_y_ = ys_[j_]; max_y_ = ys_[j_];
			} else {
				min_x_ = min(min_x_, xs_[j_]);
				max_x_ = max(max_x_, xs_[j_]);
				min_y_ = min(min_y_, ys_[j_]);
				max_y_ = max(max_y_, ys_[j_]);
			}
		}
	}
	return { min_x: min_x_, min_y: min_y_, max_x: max_x_, max_y: max_y_ };
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

/// @desc builds a plain-data struct describing a level from a live _layers
/// array, ready for json_save - read back by level_deserialize
/// @param _layers
/// @param {real} _room_width
/// @param {real} _room_height
function level_serialize(_layers, _room_width, _room_height){
	var layers_data_ = [];
	for (var i_ = 0; i_ < array_length(_layers); i_++) {
		var layer_ = _layers[i_];
		var ld_ = {
			name : layer_.name,
			depth : layer_get_depth(layer_.layer),
			type : layer_.type,
			always : layer_.always,
			visible : layer_.visible,
			locked : layer_.locked,
			color : layer_.color,
			parralax : layer_.parralax,
			collision : layer_.collision,
		};

		if (layer_.type == LAYER_TYPE.TILEMAP) {
			ld_.tileset = layer_.tileset != undefined ? tileset_get_name(layer_.tileset) : undefined;

			var w_ = tilemap_get_width(layer_.tilemap);
			var h_ = tilemap_get_height(layer_.tilemap);
			var tiles_ = array_create(h_);
			for (var yy_ = 0; yy_ < h_; yy_++) {
				var row_ = array_create(w_);
				for (var xx_ = 0; xx_ < w_; xx_++) {
					row_[xx_] = tilemap_get(layer_.tilemap, xx_, yy_);
				}
				tiles_[yy_] = row_;
			}
			ld_.tiles = tiles_;
		} else {
			//vars holds each INSTANCE element's custom variable values (see
			//editor_variable_float/instance_variables) - always empty on ASSET
			//layers, since sprite elements aren't tied to an object
			var elements_ = [];
			with (obj_asset_transform) {
				if (layer != layer_.layer) continue;
				if (editor_only) continue;
				var ed_ = {
					x : x, y : y,
					image_xscale : image_xscale, image_yscale : image_yscale, image_angle : image_angle,
					vars : {},
				};
				if (layer_.type == LAYER_TYPE.INSTANCE) {
					ed_.object_name = variable_instance_exists(id,"object_name") ? object_name : "";
					ed_.element_name = variable_instance_exists(id,"element_name") ? element_name : "";
					ed_.ref_vars = [];
					if (variable_instance_exists(id,"instance_variables")) {
						var var_names_ = variable_struct_get_names(instance_variables);
						for (var vi_ = 0; vi_ < array_length(var_names_); vi_++) {
							var var_name_ = var_names_[vi_];
							var var_def_ = instance_variables[$ var_name_];
							variable_struct_set(ed_.vars, var_name_, var_def_.value);
							if (var_def_.type == EDITOR_VARIABLE_TYPES.REFERENCE) array_push(ed_.ref_vars, var_name_);
						}
					}
				} else {
					ed_.sprite_name = variable_instance_exists(id,"sprite_name") ? sprite_name : "";
				}
				array_push(elements_, ed_);
			}
			ld_.elements = elements_;
		}

		array_push(layers_data_, ld_);
	}

	return {
		name : global.level,
		version : 1,
		room_width : _room_width,
		room_height : _room_height,
		layers : layers_data_,
	};
}
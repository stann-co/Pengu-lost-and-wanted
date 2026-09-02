/// @description
if(tileset != undefined && brush != -1 && layer_active != undefined && layer_active.type == LAYER_TYPE.TILEMAP){
    var tile_scale_x_ = parralax_effective(layer_active.parralax_x, grid_cell_w) / grid_cell_w;
    var tile_scale_y_ = parralax_effective(layer_active.parralax_y, grid_cell_w) / grid_cell_w;

    //undoes obj_tilemap's own scaling to find the raw tile cell under the
    //cursor, so the ghost/preview appears at the cursor and paints exactly
    //where it's shown (see Step_1.gml)
    var center_x_ = global.camera.get_x() + global.camera.width * 0.5;
    var center_y_ = global.camera.get_y() + global.camera.height * 0.5;
    var inv_ = parralax_offset(global.camera.get_mouse_x(), global.camera.get_mouse_y(), TILE_SIZE / tile_scale_x_, TILE_SIZE / tile_scale_y_);

    //everything below is drawn in raw tile space, then scaled through the
    //same transform obj_tilemap uses, so it lines up with the real tiles
    var world_ = matrix_get(matrix_world);
    matrix_set(matrix_world, matrix_build(center_x_*(1-tile_scale_x_), center_y_*(1-tile_scale_y_), 0, 0,0,0, tile_scale_x_,tile_scale_y_,1));

    if (tool_mode == TOOL_MODE.DRAW) {
        var brush_offset_x_ = ds_grid_width( brush)*grid_cell_w / 2;
        var brush_offset_y_ = ds_grid_height(brush)*grid_cell_h / 2;

    	var mx_ = round((inv_.x-brush_offset_x_) / grid_cell_w) * grid_cell_w;
    	var my_ = round((inv_.y-brush_offset_y_) / grid_cell_h) * grid_cell_h;

    	if(ds_exists(brush,ds_type_grid)){
    		draw_grid_tiles(brush,tileset,mx_,my_);
    	}
    } else if (layer_active.tilemap != undefined) {
        //Line/Square/Selection preview - drawn here (Draw End) rather than
        //Step_1.gml since drawing straight to room space (no surface
        //involved) only has an effect from a Draw event
        var hover_x_ = floor(inv_.x/grid_cell_w);
        var hover_y_ = floor(inv_.y/grid_cell_h);
        tool_draw_preview(layer_active.tilemap, hover_x_, hover_y_);
    }

    matrix_set(matrix_world, world_);
}

if (box_select_active && layer_active != undefined) {
    //box_select_start_x/y are already raw mouse/render space (see Step_1.gml),
    //same space the current mouse position is in - no parralax_offset needed
    var mx_ = global.camera.get_mouse_x();
    var my_ = global.camera.get_mouse_y();
    var box_x1_ = min(box_select_start_x, mx_);
    var box_y1_ = min(box_select_start_y, my_);
    var box_x2_ = max(box_select_start_x, mx_);
    var box_y2_ = max(box_select_start_y, my_);
    draw_box_selection(box_x1_, box_y1_, box_x2_-box_x1_, box_y2_-box_y1_);
}
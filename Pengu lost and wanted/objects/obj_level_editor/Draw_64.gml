/// @description

//Tile grid
if(show_grid){

    set_draw(WHITE,grid_opacity);

    var is_tilemap_layer_ = layer_active != undefined && layer_active.type == LAYER_TYPE.TILEMAP;

    //tilemap layers always show the tileset's own tile size; other layer
    //types use the configurable grid_size instead (see the grid settings dropdown)
    var gw_ = is_tilemap_layer_ ? grid_cell_w : grid_size;
    var gh_ = is_tilemap_layer_ ? grid_cell_h : grid_size;

    //cols_/rows_ below need the UNSCALED cell size - the room's actual
    //tile grid dimensions don't change with parralax, only how big/where
    //each cell then draws (gw_/gh_ get scaled further down for that)
    var raw_gw_ = gw_;
    var raw_gh_ = gh_;

    var offset_x_, offset_y_;
    if (is_tilemap_layer_) {
        //matches obj_tilemap's own view-matrix scaling exactly (scales
        //around the camera's view CENTER, using tile WIDTH for both axes,
        //same as obj_tilemap does)
        var tile_scale_x_ = parralax_effective(layer_active.parralax_x, grid_cell_w) / grid_cell_w;
        var tile_scale_y_ = parralax_effective(layer_active.parralax_y, grid_cell_w) / grid_cell_w;
        var origin_ = parralax_offset(0, 0, tile_scale_x_ * TILE_SIZE, tile_scale_y_ * TILE_SIZE);
        offset_x_ = round(origin_.x);
        offset_y_ = round(origin_.y);
        gw_ *= tile_scale_x_;
        gh_ *= tile_scale_y_;
    } else {
        //ASSET/INSTANCE elements offset (not scale) away from the camera
        //center instead - see parralax_offset
        var grid_parralax_x_ = (layer_active != undefined) ? parralax_effective(layer_active.parralax_x) : TILE_SIZE;
        var grid_parralax_y_ = (layer_active != undefined) ? parralax_effective(layer_active.parralax_y) : TILE_SIZE;
        var origin_ = parralax_offset(0, 0, grid_parralax_x_, grid_parralax_y_);
        offset_x_ = round(origin_.x);
        offset_y_ = round(origin_.y);
    }

    //room_to_gui_x/y is an affine (pan+zoom) transform, so the gui-space
    //origin and per-cell size only need computing once - draw_grid can then
    //do its own line math in that already-transformed space
    var origin_x_ = global.camera.room_to_gui_x(offset_x_);
    var origin_y_ = global.camera.room_to_gui_y(offset_y_);
    var cell_w_ = global.camera.room_to_gui_x(offset_x_ + gw_) - origin_x_;
    var cell_h_ = global.camera.room_to_gui_y(offset_y_ + gh_) - origin_y_;

    //room_to_gui_x/y's +/-1px nudge cancels out in cell_w_/cell_h_ (a
    //difference) but leaves a residual in origin_x_/origin_y_ when gui/room
    //resolutions differ - back it out using the scale already derived above
    origin_x_ -= (cell_w_ / gw_) - 1;
    origin_y_ -= (cell_h_ / gh_) - 1;

    //covers the whole room, not just whatever grid_w/grid_h happen to be
    //(those are the tile picker's dimensions, unrelated to the room size)
    var cols_ = ceil(room_width  / raw_gw_);
    var rows_ = ceil(room_height / raw_gh_);

    //camera zoom goes through draw_grid's own _scale instead of being
    //folded into cell_w_/cell_h_ - cell_w_*zoom_ * (1/zoom_) still equals
    //cell_w_, so this doesn't change what gets drawn
    var zoom_ = global.camera.zoom_amount;
    draw_grid(origin_x_-0.5, origin_y_-0.5, cell_w_*zoom_, cell_h_*zoom_, cols_, rows_, 1/zoom_);

    reset_draw();
}

if (initialized) ImGui.__Render();

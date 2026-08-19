/**
 * Function populates grid with array
 * @param {id.dsgrid} _ds_grid
 * @param {array} _array
 */
function ds_grid_populate(_ds_grid,_array){
    var width_ = ds_grid_width(_ds_grid);
    var height_ = ds_grid_height(_ds_grid);
    for (var i_ = 0; i_ < array_length(_array); i_++) {
        ds_grid_add(_ds_grid,i_ mod width_,i_ div width_,_array[i_]); 
    }
}

function ds_grid_pick(_ds_grid,_x,_y){
    // picks a cell from grid; if non-empty, returns {grid, x, y} - a minimal
    // ds_grid bounding the connected (8-directional, incl. corners) region it
    // belongs to, plus that region's top-left origin in _ds_grid
    var w_ = ds_grid_width(_ds_grid), h_ = ds_grid_height(_ds_grid);
    if (_x < 0 || _x >= w_ || _y < 0 || _y >= h_) return undefined;
    if (ds_grid_get(_ds_grid, _x, _y) == 0) return undefined;

    var visited_ = ds_grid_create(w_, h_);
    ds_grid_set(visited_, _x, _y, 1);

    //flood fill using flat arrays as a manual queue (avoids a small array
    //allocation per node and ds_queue overhead)
    var qx_ = [_x], qy_ = [_y];
    var dirs_x_ = [1,-1,0,0,1,1,-1,-1];
    var dirs_y_ = [0,0,1,-1,1,-1,1,-1];

    var minX_ = _x, minY_ = _y, maxX_ = _x, maxY_ = _y;

    var head_ = 0;
    while (head_ < array_length(qx_)) {
        var cx_ = qx_[head_], cy_ = qy_[head_];
        head_++;

        if (cx_ < minX_) minX_ = cx_; if (cy_ < minY_) minY_ = cy_;
        if (cx_ > maxX_) maxX_ = cx_; if (cy_ > maxY_) maxY_ = cy_;

        for (var d_ = 0; d_ < 8; d_++) {
            var nx_ = cx_ + dirs_x_[d_], ny_ = cy_ + dirs_y_[d_];
            if (nx_ < 0 || nx_ >= w_ || ny_ < 0 || ny_ >= h_) continue;
            if (ds_grid_get(visited_, nx_, ny_) == 1) continue;
            if (ds_grid_get(_ds_grid, nx_, ny_) != 0) {
                ds_grid_set(visited_, nx_, ny_, 1);
                array_push(qx_, nx_);
                array_push(qy_, ny_);
            }
        }
    }
    ds_grid_destroy(visited_);

    // build minimal bounding grid in one native call instead of a per-cell copy loop
    var out_ = ds_grid_create(maxX_ - minX_ + 1, maxY_ - minY_ + 1);
    ds_grid_set_grid_region(out_, _ds_grid, minX_, minY_, maxX_, maxY_, 0, 0);

    return {grid: out_, x: minX_, y: minY_};
}
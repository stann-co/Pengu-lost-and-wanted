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
    // picks a cell from grid; if non-empty, returns a minimal ds_grid
    var w_ = ds_grid_width(_ds_grid), h_ = ds_grid_height(_ds_grid);
    if (_x < 0 || _x >= w_ || _y < 0 || _y >= h_) return undefined;
    if (ds_grid_get(_ds_grid, _x, _y) == 0) return undefined;

    var visited_ = ds_grid_create(w_, h_);
    var q_ = ds_queue_create();
    ds_queue_enqueue(q_, [_x, _y]);
    ds_grid_add(visited_, _x, _y, 1);

    var minX_ = _x, minY_ = _y, maxX_ = _x, maxY_ = _y;
    var dirs_ = [[1,0],[-1,0],[0,1],[0,-1]];

    while (ds_queue_size(q_) > 0) {
        var p_ = ds_queue_dequeue(q_), cx_ = p_[0], cy_ = p_[1];
        if (cx_ < minX_) minX_ = cx_; if (cy_ < minY_) minY_ = cy_;
        if (cx_ > maxX_) maxX_ = cx_; if (cy_ > maxY_) maxY_ = cy_;

        for (var d_ = 0; d_ < 4; d_++) {
            var nx_ = cx_ + dirs_[d_][0], ny_ = cy_ + dirs_[d_][1];
            if (nx_ < 0 || nx_ >= w_ || ny_ < 0 || ny_ >= h_) continue;
            if (ds_grid_get(visited_, nx_, ny_) == 1) continue;
            if (ds_grid_get(_ds_grid, nx_, ny_) != 0) {
                ds_grid_add(visited_, nx_, ny_, 1);
                ds_queue_enqueue(q_, [nx_, ny_]);
            }
        }
    }

    // build minimal bounding grid
    var outW_ = maxX_ - minX_ + 1;
    var outH_ = maxY_ - minY_ + 1;
    var out_ = ds_grid_create(outW_, outH_);

    for (var ix_ = 0; ix_ < outW_; ix_++) {
        for (var iy_ = 0; iy_ < outH_; iy_++) {
            var sx_ = minX_ + ix_;
            var sy_ = minY_ + iy_;
            var val_ = ds_grid_get(_ds_grid, sx_, sy_);
            ds_grid_add(out_, ix_, iy_, val_);
        }
    }

    // cleanup visited and queue
    ds_grid_destroy(visited_);
    ds_queue_destroy(q_);

    return out_;
}
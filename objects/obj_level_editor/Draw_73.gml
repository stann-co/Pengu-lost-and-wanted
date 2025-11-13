/// @description
if(tileset != undefined){
    
    var info_ = tileset_get_info(tileset);
    var cell_w_ = info_.tile_width;
    var cell_h_ = info_.tile_height;
    
    var mx_ = floor(global.camera.get_mouse_x() / cell_w_) * cell_w_;
    var my_ = floor(global.camera.get_mouse_y() / cell_h_) * cell_h_;
    
    draw_tile(tileset,tile,0,mx_,my_);
}
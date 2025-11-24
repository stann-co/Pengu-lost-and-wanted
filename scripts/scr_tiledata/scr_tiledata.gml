/// @desc 32bit tile data
/// @param {Id.TileMapElement} _tilemap_element Description
/// @param {Real} _x_cell Description
/// @param {Real} _y_cell Description
/// @returns {real} 32bit tile data
function tile_bits(_tilemap_element,_x,_y){
    var data_ = tilemap_get(_tilemap_element,_x,_y);
    
    var tile_ = tile_get_index(data_);
    
    //transform flags
    if(tile_get_mirror(data_)) tile_ |= tile_mirror;
    if(tile_get_flip(data_)  ) tile_ |= tile_flip;
    if(tile_get_rotate(data_)) tile_ |= tile_rotate;
    
    return tile_;
}
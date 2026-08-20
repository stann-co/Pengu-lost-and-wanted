var tilemap_ = layer_tilemap_get_id(global.collision_layers[? COLLISION_LAYERS.A] )

var tile_cell_check_ = tilemap_get(tilemap_,3,1);

var tile_pos_check_ = tilemap_get_at_pixel(tilemap_,48,16);

show_debug_message(tile_cell_check_);
show_debug_message(tile_pos_check_);

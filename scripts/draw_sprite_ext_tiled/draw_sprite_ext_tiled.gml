///@description does draw_sprite_ext tiled x times on the horizontal and vertical axis
///@function draw_sprite_tiled_ext2(_sprite,_subimg,_x,_y,_tile_h=1,_tile_v=1,_xscale=1,_yscale=1,_col=-1,_alpha=1)
function draw_sprite_tiled_ext2(_sprite,_subimg,_x,_y,_tile_h=1,_tile_v=1,_xscale=1,_yscale=1,_col=-1,_alpha=1){
	
	//horizontal
	for (var h_ = 0; h_ < _tile_h; ++h_) {
	    // vertical
		for (var v_ = 0; v_ < _tile_v; ++v_) {
			var x_offset_ = sprite_get_width(_sprite)*_xscale;
			var y_offset_ = sprite_get_height(_sprite)*_yscale;
			draw_sprite_ext(_sprite,_subimg,_x+(x_offset_*h_),_y+(y_offset_*v_),_xscale,_yscale,0,_col,_alpha);
		}
	}
	
}
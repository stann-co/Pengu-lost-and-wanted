event_inherited();

/// @description
var collision_layers_ = [];

if(collision_a){
	array_push(collision_layers_,global.collision_layers[? COLLISION_LAYERS.A]);
}

if(collision_b){
	array_push(collision_layers_,global.collision_layers[? COLLISION_LAYERS.B]);
}

if(collision_c){
	array_push(collision_layers_,global.collision_layers[? COLLISION_LAYERS.C]);
}

for (var i_ = 0; i_ < count; i_++) {
	var tilemap_ = global.collision_layers[? collision_layer];
	
	var tile_w_ = tilemap_get_tile_width(tilemap_);
	var tile_h_ = tilemap_get_tile_height(tilemap_);
	
	move_snap(tile_w_,tile_h_);
	
	for (var row_ = 0; row_ < sprite_width/tile_w_; row_++) {
		for (var col_ = 0; col_ < sprite_height/tile_h_; col_++) {
			//removes tile at this position
			var x_ = x+(row_*tile_w_);
			var y_ = y+(col_*tile_h_);
			var data_ = tilemap_get_at_pixel(tilemap_,x_,y_);
			
			if(!tile_get_empty(data_)){
				//creates collision tile objects in place of each tile
				var tile_ = instance_create_depth(x_,y_,depth,obj_collision_tile,{
					parent : id,
					depth_layer : depth_layer,
				})
				tile_.image_index = tile_get_index(data_);
				
				if(tile_get_rotate(data_)){
					tile_.image_angle-=90;
				}
				if(tile_get_mirror(data_)){
					tile_.image_xscale = -1;
				}
				if(tile_get_flip(data_)){
					tile_.image_yscale = -1;
				}
				tile_.x += x_ - tile_.bbox_left;
				tile_.y += y_ - tile_.bbox_top;
			}
			
			data_ = tile_set_empty(data_);
			tilemap_set_at_pixel(tilemap_,data_,x_,y_);
		}
	}
}


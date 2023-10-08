/// @description

/// feather ignore all in /Extensions/*

#region collision tiles
//function collision_tile(id,angle_,height_arr,width_arr) constructor{
//	self.id 		= id;
//	self.angle_		= angle_;
//	self.height_arr	= height_arr;
//	self.width_arr  = width_arr;
//}

//var tile_count = tilemap_get_width(ts_collisions) * tilemap_get_height(ts_collisions);

//The angles from each collision tile
//360 is for filled blocks, which top angle could be any direction
global.tile_angles = [
0,360,22,22,
45,45,22,22,
45,45,31,12,
12,31,45,0
];

//global.collision_tiles = array_create(tile_count,NaN);

////saves a struct of every collision tile with it's angle, id,
////and array of pixel height left to right
////and pixel width from top to bottom
//for (var tile = 0; tile < tile_count; ++tile) {
//	var height_arr = [];
//	for (var x_ = 0; x_ < 16; ++x_) {
		
//	}
	
//    global.collision_tiles[i] = new collision_tile(
//	i,
//	tile_angles[i],
//	[],
//	[]
//	)
//}

#endregion
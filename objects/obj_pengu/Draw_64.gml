/// @description

//var x_ = global.camera.get_mouse_x();
//var y_ = global.camera.get_mouse_y();

//var tile_id = layer_tilemap_get_id("collisions");
//var mx = tilemap_get_cell_x_at_pixel(tile_id, x_,y_);
//var my = tilemap_get_cell_y_at_pixel(tile_id, x_,y_);
//
//var data = tilemap_get(tile_id, mx, my);
//var ind = tile_get_index(data);
//if(ind <=15){
//	draw_text(4,30,tile_rotation(x_,y_));
//	draw_text(4,40,$"rotated : {tile_get_rotate(data)}");
//	draw_text(4,50,$"mirrored : {tile_get_mirror(data)}");
//	draw_text(4,60,$"flipped : {tile_get_flip(data)}");
//}
//draw_text(4,4,ind);


draw_text(20,20,$"Airborne: {airborne}");

draw_text(20,30,$"ground speed: {ground_spd}");
draw_text(20,40,$"ground angle: {ground_angle}");
draw_text(20,50,$"x speed: {x_speed}");
draw_text(20,60,$"y speed: {y_speed}");
draw_text(20,70,$"control lock: {control_lock}");
/// @description

level = room;

global.show_collisions = true;
show_collisions(true);

//room_directory = "D:\\projects\\Game Dev\\Pengu Lost and Wanted\\Pengu lost and wanted\\rooms\\";
//room_name = room_get_name(room);
//room_file = room_directory + room_name + "\\" + room_name + ".yy";
//
//room_data = json_load(room_file);

//show_debug_message("check")

layer_active = "collision_A";

tilemap_active = layer_tilemap_get_id(layer_active);

var width_ = 100;
var margin_ = 10;
view_layers = dbg_view("Layers",  true,margin_,margin_,width_,global.res_h - margin_*2)

width_ = 300;
view_tilemaps = dbg_view("Tilemaps",true,global.res_w-width_-margin_,margin_,width_,global.res_h - margin_*2);
dbg_set_view(view_tilemaps)
dbg_sprite()
/// @description

enum LAYER_TYPE {
    COLLISION,
    DECOR,
    ASSET,
    INSTANCE
}

if(variable_global_exists("editor_data")){
    //when stopping level editor the tile data and stuff is still present
    global.editor_data = {}
}

//close button intercept
window_command_hook(window_command_close);

ImGui.__Initialize();
font = ImGui.AddFontFromFile("fonts/AtkinsonHyperlegible.ttf",24);

global.show_collisions = true;
show_collisions(true);

initialized = false
call_later(1,time_source_units_frames,function (){ 
    //needs 1 frame delay before it can draw for some reason
    initialized = true;
})

last_camera_follow = global.camera.follow;
global.camera.follow = noone;
global.gui_draw = false;

move_spd = 2;
drag_x = 0;
drag_y = 0;
dragging = false;

quit = function(){ //stops level editor
    //maybe make a warning or popup or something
    
    global.camera.follow = last_camera_follow;
    global.gui_draw = true;
    
    global.camera.zoom(1,0);
    
    instance_destroy();
}

tileset_surface = -1;
tilebrush_surface = -1;

//room_directory = "D:\\projects\\Game Dev\\Pengu Lost and Wanted\\Pengu lost and wanted\\rooms\\";
//room_name = room_get_name(room);
//room_file = room_directory + room_name + "\\" + room_name + ".yy";
//
//room_data = json_load(room_file);

room_data = room_get_info(room,false,false,true,true,true);
level_data = {}
level_data = json_load("level_data");

show_debug_message(room_data);

layers = [];
layer_index = 0;
layer_active = 0;

element_active = undefined;

tilemap = undefined;
tileset = undefined;
tilemap_w = 0;
tilemap_h = 0;
tile = 0;
tile_w = 16;
tile_h = 16;
tile_flipped = false;
tile_mirrored = false;
tile_rotated = false;

//gets relevant layers, and adds a type for ease of use
for (var i_ = 0; i_ < array_length(room_data.layers); i_++) {
    //only show tile and decor layers, and store a type on them for ease
    var layer_ = room_data.layers[i_];
    var name_ = string_lower(layer_.name);
    
    if(string_starts_with(name_,"collision")){
        layer_.type = LAYER_TYPE.COLLISION
        array_push(layers,layer_);
    } else
    
    if(string_starts_with(name_,"decor")){
        layer_.type = LAYER_TYPE.DECOR
        array_push(layers,layer_);
    } else
    
    if(string_starts_with(name_,"asset")){
        layer_.type = LAYER_TYPE.ASSET
        array_push(layers,layer_);
    }
}

set_layer = function(_layer_index){
    layer_index = _layer_index;
    layer_active = layers[_layer_index];
    
    if(layer_active.type == LAYER_TYPE.COLLISION || layer_active.type == LAYER_TYPE.DECOR){
        if(is_array(layer_active.elements)){
            element_active = layer_active.elements[0];
            tilemap_w = element_active.width;
            tilemap_h = element_active.height;
        } else {
            element_active = undefined
            tilemap = undefined;
            tileset = undefined;
        }
        tilemap = layer_tilemap_get_id(layer_active.id);
        tileset = tilemap_get_tileset(tilemap);
    } else {
        tilemap = undefined;
        tileset = undefined;
    }
}

set_layer(layer_index); //sets first layer active

//var menu_size_ = 100;
//var margin_ = 10;
//view_layers = dbg_view("Layers",  true,margin_,margin_,menu_size_,global.res_h - margin_*2)
//
//menu_size_ = 300;
//view_tilemaps = dbg_view("Tilemaps",true,global.res_w-menu_size_-margin_,margin_,menu_size_,global.res_h - margin_*2);
//dbg_set_view(view_tilemaps)
//dbg_sprite()
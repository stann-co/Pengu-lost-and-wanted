/// @description

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
});

last_camera_follow = global.camera.follow;
global.camera.follow = noone;
global.gui_draw = false;

move_spd = 2;

quit = function(){ //stops level editor
    //maybe make a warning or popup or something
    
    global.camera.follow = last_camera_follow;
    global.gui_draw = true;
    
    global.camera.zoom(1,0);
    
    instance_destroy();
}

save = function(){
    show_debug_message(GM_project_filename)
    
    var path_ = string_replace(GM_project_filename,"Pengu-lost-and-wanted.yyp","extensions/editor_data/");
    
    var room_data_ = {
        width : room_width,
        height : room_height,
        layers : []
    }
    
    var layers_ = layer_get_all();
    show_debug_message(layers_);
    //saves all layers, but only goes on detail with tiles and sprites
    //starts at one because there's a layer made from code
    for (var i_ = 1; i_ < array_length(layers_); i_++) {
        var layer_id_ = layers_[i_];
        
        var element_ids_ = layer_get_all_elements(layer_id_);
        var layer_ = {}
        show_debug_message(element_ids_)
        if(array_length(element_ids_) > 0){
            //sprite
            if(layer_get_element_type(element_ids_[0]) == layerelementtype_sprite ){
                layer_.elements = [];
                
                for (var e_ = 0; e_ < array_length(element_ids_); e_++) {
                    var element_id_ = element_ids_[e_];
                    var element_ = {
                        name : $"graphic_{element_id_}",
                        image_speed : layer_sprite_get_speed(element_id_),
                        image_blend : layer_sprite_get_blend(element_id_),
                        image_alpha : layer_sprite_get_alpha(element_id_),
                        image_index : layer_sprite_get_index(element_id_),
                        image_angle : layer_sprite_get_angle(element_id_),
                        image_xscale : layer_sprite_get_xscale(element_id_),
                        image_yscale : layer_sprite_get_yscale(element_id_),
                        sprite_index : sprite_get_name(layer_sprite_get_sprite(element_id_)),
                        x : layer_sprite_get_x(element_id_),
                        y : layer_sprite_get_y(element_id_)
                    }
                    array_push(layer_.elements,element_);
                }
            }
            //tilemap
            else if(layer_get_element_type(element_ids_[0]) == layerelementtype_tilemap ){
                var tilemap_ = layer_tilemap_get_id(layer_id_);
                var width_ = tilemap_get_width(tilemap_);
                var height_ = tilemap_get_height(tilemap_);
                layer_.tiles = {
                    SerialiseWidth : width_,
                    SerialiseHeight : height_,
                    TileCompressedData : [] 
                } 
                for (var t_ = 0; t_ < width_*height_; t_++) {
                    show_debug_message($"x:{t_ mod width_} y: {t_ div width_}");
                    var tile_ = tilemap_get(tilemap_,t_ mod width_,t_ div width_) 
                    array_push(layer_.tiles.TileCompressedData,tile_);
                }
                show_debug_message(layer_.tiles.TileCompressedData);
            }
        }
        array_push(room_data_.layers,layer_);
    }
    
    show_debug_message("Saving tile and sprite data");
    json_save(path_+"temp_room_data.json",room_data_);
    execute_shell_simple("RoomSaveData.bat",room_get_name(room),"open",1,path_);
}

tileset_surface = -1;
tileset_data_surface = -1;
tilebrush_surface = -1;
tilebrush_data_surface = -1;

//flips on when data changes, so they can be redrawn and instanced
tileset_data_update = false;
tilebrush_data_update = false;

room_data = room_get_info(room,false,false,true,true,true);
room_name = room_get_name(room);

editor_data = json_load("editor_data.json");

layers = [];
layer_index = 0;
parralax = 0; //parralax value for specific layer

element_active = noone;

tilemap = undefined;
tileset = undefined;
tilemap_w = 0;
tilemap_h = 0;

tile_w = 16; //tile cell size
tile_h = 16;

//is either a tileindex, or a ds_grid 
brush = -1; //-1 is none selected

tile_flipped = false;
tile_mirrored = false;
tile_rotated = false;

tileset_info = undefined;
tileset_brushes = undefined;

//tile picker offset and zoom
tiles_x = 0;
tiles_y = 0;
tiles_zoom = 1;

//tile brush pickers offset and zoom
brushes_x = 0;
brushes_y = 0;
brushes_size = 64;

//grid, either size of tilemap or a default value
show_grid = true;
grid_cell_w = 16;
grid_cell_h = 16;
grid_w = 4;
grid_h = 4;

//sprite asset list
sprite_assets = asset_get_ids(asset_sprite);

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
        layer_.transforms = [];
		//adds asset editor instance, so they can be manipulated
		for (var e_ = 0; e_ < array_length(layer_.elements); e_++) {
			var element_ = layer_.elements[e_];
			array_push(layer_.transforms,instance_create_depth(0,0,0,obj_asset_transform,{
				element_id : element_.id,
                name : sprite_get_name(element_.sprite_index),
				layer_id : layer_.id,
			}));
		}
		array_push(layers,layer_);
    }
}

set_layer = function(_layer_index){
    layer_index = _layer_index;
    layer_active = layers[_layer_index];
    
    if(layer_active.type == LAYER_TYPE.COLLISION || layer_active.type == LAYER_TYPE.DECOR){ 
        if(is_array(layer_active.elements)){
            element_active = layer_active.elements[0];
            
            tilemap = layer_tilemap_get_id(layer_active.id);
            tilemap_w = tilemap_get_width(tilemap)
            tilemap_h = tilemap_get_height(tilemap)
            tileset = tilemap_get_tileset(tilemap);
            tileset_info = tileset_get_info(tileset);
            
            //redraw tile data and instance
            tileset_data_update = true;
            tilebrush_data_update = true;
			
            //Grid overlay size
			grid_w = tilemap_w; 
			grid_h = tilemap_h;
			grid_cell_w = tileset_info.tile_width;
			grid_cell_h = tileset_info.tile_height;
            
            tileset_info.name = tileset_get_name(tileset);
            
            var brush_width_ = struct_get_chained(editor_data,tileset_info.name,"brush_width");
            var brush_height_ = struct_get_chained(editor_data,tileset_info.name,"brush_height");
            var brush_tiles_ = struct_get_chained(editor_data,tileset_info.name,"brush_tiles");
            
            tileset_brushes = ds_grid_create(brush_width_,brush_height_);
            ds_grid_populate(tileset_brushes,brush_tiles_);
            
            tileset_tiles = ds_grid_create(tileset_info.tile_columns,tileset_info.tile_count / tileset_info.tile_columns);
            //fils grid with indexes from
            ds_grid_populate(tileset_tiles,array_create_ext(tileset_info.tile_count,function(_i){
                return _i;
            }));
            
            //a brush is a ds_grid of tiledata
            brush = -1; //-1 is none selected
            
            tile_flipped = false;
            tile_mirrored = false;
            tile_rotated = false;
            
            //tile picker offset and zoom
            tiles_x = 0;
            tiles_y = 0;
            tiles_size = 512; //this should automatically be set to fit the window
            
            //tile brush pickers offset and zoom
            brushes_x = 0;
            brushes_y = 0;
            brushes_size = 512;
        } else {
            element_active = noone
            tilemap = undefined;
            tileset = undefined;
        }
    } 
else if(layer_active.type == LAYER_TYPE.ASSET) { //asset layer
		element_active = noone;
		grid_cell_w = 16;
		grid_cell_h = 16;
		grid_w = room_width / grid_cell_w;
		grid_h = room_height / grid_cell_h;
        
        brush = -1;
    }
    
    parralax = struct_get_chained(global.level_data,"layers",layer_active.name,"parralax") ?? 0;
}

add_sprite = function(_sprite){
    var x_ = global.camera.x;
    var y_ = global.camera.y;
    var element_ = layer_sprite_create(layer_active.id,x_,y_,_sprite);
    var transform_ = instance_create_depth(0,0,0,obj_asset_transform,{
        element_id : element_,
        name :  sprite_get_name(_sprite),
        layer_id : layer_active.id,
    });
    element_active = transform_;
    array_push(layer_active.transforms,transform_);
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
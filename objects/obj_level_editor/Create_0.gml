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
})

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

tileset_surface = -1;
tileset_data_surface = -1;
tilebrush_surface = -1;
tilebrush_data_surface = -1;

//flips on when data changes, so they can be redrawn and instanced
tileset_data_update = false;
tilebrush_data_update = false;


//room_directory = "D:\\projects\\Game Dev\\Pengu Lost and Wanted\\Pengu lost and wanted\\rooms\\";
//room_name = room_get_name(room);
//room_file = room_directory + room_name + "\\" + room_name + ".yy";
//
//room_data = json_load(room_file);

room_data = room_get_info(room,false,false,true,true,true);
room_name = room_get_name(room);

editor_data = json_load("editor_data.json");

RoomSaveData()

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
		//adds asset editor instance, so they can be manipulated
		for (var e_ = 0; e_ < array_length(layer_.elements); e_++) {
			var element_ = layer_.elements[e_];
			instance_create_depth(0,0,0,obj_asset_transform,{
				element_id : element_.id,
				layer_id : layer_.id,
			});
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
            
            //biggest dimension
            //tiles_zoom = (tileset_info.width > tileset_info.height) ? tileset_info.width : tileset_info.height;
            
            //tile brush pickers offset and zoom
            brushes_x = 0;
            brushes_y = 0;
            brushes_size = 512;
        } else {
            element_active = noone
            tilemap = undefined;
            tileset = undefined;
        }
    } else if(layer_active.type == LAYER_TYPE.ASSET) { //asset layer
		element_active = noone;
		grid_cell_w = 16;
		grid_cell_h = 16;
		grid_w = room_width / grid_cell_w;
		grid_h = room_height / grid_cell_h;
        
        brush = -1;
    }
    
    parralax = struct_get_chained(global.level_data,"layers",layer_active.name,"parralax") ?? 0;
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
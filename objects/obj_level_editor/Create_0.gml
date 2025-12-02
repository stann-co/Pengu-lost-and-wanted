/// @description

if(!variable_global_exists("editor_data")){
    //when stopping level editor the tile data and stuff is still present
    global.editor_data = {
        //initialized : false
    }
}

//close button intercept
window_command_hook(window_command_close);

ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);

font = ImGui.AddFontFromFile("fonts/AtkinsonHyperlegible.ttf",24);

global.show_collisions = true;
show_collisions(true);

dock_init = false;
initialized = false;
call_later(1,time_source_units_frames,function (){ 
    //needs 1 frame delay before it can draw for some reason
    initialized = true;
});

last_camera_follow = global.camera.follow;
global.camera.follow = noone;
global.camera.zone_constrain = false;
global.gui_draw = false;

move_spd = 2;

tileset_surface = -1;
tileset_data_surface = -1;
tilebrush_surface = -1;
tilebrush_data_surface = -1;

//flips on when data changes, so they can be redrawn and instanced
tileset_data_update = false;
tilebrush_data_update = false;

//room_data = room_get_info(room,false,false,true,true,true);
room_name = room_get_name(room);

editor_data = json_load("editor_data.json");
layers_hide_internal = false;

layers = [];
layer_index = 0;
layer_active = undefined;
parralax = 0; //parralax value for specific layer

//add layers
add_layer_types = ["tilemap","assets","instances"]
add_layer_type = 1;

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

#region prepares layers
//gets relevant layers, and adds a type for ease of use
var layers_ = layer_get_all();
for (var i_ = 0; i_ < array_length(layers_); i_++) {
    //only show tile and decor layers, and store a type on them for ease
    var layer_ = {
        id : layers_[i_],
        name: string_lower(layer_get_name(layers_[i_])),
    }
    
    var external_ = false;
    var data_layers_ = struct_get_names(global.room_data.layers);
    for (var l_ = 0; l_ < array_length(data_layers_); l_++) {
    	if(layer_.name ==  data_layers_[l_]){
            external_ = true;
            break;
        }
    }
    
    if(external_ == false){ //internal layers do not need to be edited, and will be disabled
        array_push(layers,layer_);
    }
    
    else if(string_starts_with(layer_.name,"decor")){
        layer_.type = LAYER_TYPE.TILEMAP
        array_push(layers,layer_);
    } else
    
    if(string_starts_with(layer_.name,"asset")){
        layer_.type = LAYER_TYPE.ASSET
        layer_.transforms = [];
		//adds asset editor instance, so they can be manipulated
        var elements_ = struct_get_chained(layer_,"elements");
		for (var e_ = 0; e_ < array_length(elements_); e_++) {
			var element_ = elements_[e_];
			array_push(layer_.transforms,instance_create_depth(0,0,0,obj_asset_transform,{
				element_id : element_.id,
                name : sprite_get_name(element_.sprite_index),
				layer_id : layer_.id,
			}));
		}
		array_push(layers,layer_);
    }
}
#endregion

//reorders layers based on their depth
layers_depth_order = function (){
    array_sort(layers,function(_current,_next){
        return layer_get_depth(_current.id) - layer_get_depth(_next.id);
    })
    //sets layer index after sorting
    for (var i_ = 0; i_ < array_length(layers); i_++) {
    	if(layer_active == layers[i_]){
            layer_index = i_;
            break;
        }
    }
}

add_layer = function(_type){
     var layer_ = {
        type : _type,
    }
    var name_ = "";
    switch (_type) {
        case LAYER_TYPE.INSTANCE:
            name_ = "inst_";
            layer_.transforms = [];
            break;
        case LAYER_TYPE.ASSET:
            name_ = "asset_";
            layer_.transforms = [];
            break;
        case LAYER_TYPE.TILEMAP:
            name_ = "decor_";
            break;
    }
    
    var count_ = 0;
    //layer number for the name
    for (var i_ = 0; i_ < array_length(layers); i_++) {
    	if(string_starts_with(layers[i_].name,name_)) count_++;
    }
    name_+=string(count_);
    
    //sets depth to be under the lowest layer
    var depth_ = layer_get_depth(layers[array_length(layers)-1].id) + 100;
    
    layer_.name = name_;
    layer_.id = layer_create(depth_,name_);
    
    struct_set_chained(global.room_data,{
        depth: depth_,
        parralax: 0,
    },"layers",name_)
    
    array_push(layers,layer_);
    set_layer(array_length(layers)-1);
}

delete_layer = function(_layer_index){
    struct_remove(global.room_data.layers,layers[_layer_index].name);
    array_delete(layers,_layer_index,1);
    layer_active = undefined;
    layer_index = 0;
}

set_layer = function(_layer_index){
    layer_index = _layer_index;
    layer_active = layers[_layer_index];
    
    if(layer_active.type == LAYER_TYPE.TILEMAP){ 
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
    
    parralax = struct_get_chained(global.room_data,"layers",layer_active.name,"parralax") ?? 0;
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

quit = function(){ //stops level editor
    //maybe make a warning or popup or something
    
    global.camera.follow = last_camera_follow;
    global.camera.zone_constrain = true;
    global.gui_draw = true;
    
    global.camera.zoom(1,0);
    
    instance_destroy();
}

save = function(){ 
    var path_ = string_replace(GM_project_filename,"Pengu-lost-and-wanted.yyp","datafiles/room_data/"+room_get_name(room)+".json");
    show_debug_message("saved to: "+path_);
    show_debug_message(global.room_data);
    json_save(path_,global.room_data);
}

//reorders layers
layers_depth_order();
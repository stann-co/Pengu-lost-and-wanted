/// @description

#region constants
imgui_ini_runtime_path = working_directory + "/imgui.ini";
imgui_ini_backup_path  = filename_path(GM_project_filename) + "datafiles/editor/imgui_layout.ini";
editor_settings_path   = filename_path(GM_project_filename) + "datafiles/editor/editor_settings.json";

//codepoints of the icons in datafiles/editor/icons.ttf
enum ICON{
    MAP              = 0x21,
    STAR             = 0x22,
    PLUS             = 0x23,
    MINUS            = 0x24,
    CLOSE            = 0x25,
    FILE             = 0x26, //blank folded-corner page
    LOCK             = 0x27,
    EDIT             = 0x28,
    EYE              = 0x29,
    EYE_OFF          = 0x30,
    TAG              = 0x31,
    TAGS             = 0x32,
    COMMENT          = 0x33,
    WARNING          = 0x34,
    FILE_ALT         = 0x35, //near-duplicate of FILE, double check if intentional
    FOLDER_OPEN      = 0x36,
    GEAR             = 0x37,
    WRENCH           = 0x38,
    EXPAND           = 0x39, //diagonal arrows pointing outward
    COMPRESS         = 0x40, //diagonal arrows pointing inward
    RESIZE_VERTICAL  = 0x41,
    RESIZE_HORIZONTAL= 0x42,
    ZOOM_IN          = 0x43,
    ZOOM_OUT         = 0x44,
    ARROW_UP         = 0x45,
    ARROW_RIGHT      = 0x46,
    ARROW_LEFT       = 0x47,
    ARROW_DOWN       = 0x48,
    REDO             = 0x49,
    UNDO             = 0x50,
    LEAF             = 0x51,
    TEXT             = 0x52, //"A" glyph
    BOLD             = 0x53, //"B" glyph
    ITALIC           = 0x54, //"I" glyph
    DROPLET          = 0x55,
    ADJUST           = 0x56, //half-filled circle
    KEY              = 0x57,
    MAGNET           = 0x58,
    TARGET           = 0x59,
    CHECK            = 0x60,
    SAVE             = 0x61,
    CLIPBOARD        = 0x62,
    MARQUEE          = 0x63, //dashed selection rectangle
    MOVE             = 0x64, //4-directional arrows from a center point
    EXPAND_ARROWS    = 0x65, //diagonal double-headed arrows on a square
    FLASK            = 0x66,
    COPY             = 0x67,
    MENU             = 0x68, //hamburger menu
    MAGIC_WAND       = 0x69,
    BELL             = 0x70,
    CODE             = 0x71,
    PUZZLE           = 0x72,
    UNLOCK           = 0x73,
    MORE_HORIZONTAL  = 0x74,
    MORE_VERTICAL    = 0x75,
    SHARE            = 0x76, //arrow hooking up-right
    REPLY            = 0x77, //arrow hooking down-right
    SORT_AZ          = 0x78,
    SORT_ZA          = 0x79,
    SORT_SIZE_ASC    = 0xA0, //bars grow longer going down
    SORT_SIZE_DESC   = 0xA1, //bars grow shorter going down
    BUG              = 0xA2,
    PARAGRAPH        = 0xA3,
    SLIDERS          = 0xA4,
    BELL_OFF         = 0xA5,
    TRASH            = 0xA6,
    EYEDROPPER       = 0xA7,
    PAINTBRUSH       = 0xA8,
    USER             = 0xA9, //person standing on a base/platform
    TEXT_CURSOR      = 0xB0,
    TRANSFORM        = 0xB1, //bounding box with rotated inner box, both w/ corner handles
    TRANSFORM_ALT    = 0xB2, //two overlapping boxes w/ corner handles
    FILE_FILLED      = 0xB3, //folded-corner page, solid
    FILE_OUTLINE     = 0xB4, //folded-corner page, outline - near-duplicate of FILE/FILE_ALT
    HELP             = 0xB5,
    SNOWFLAKE        = 0xB6,
    HOME             = 0xB7,
    SHAPES           = 0xB8, //overlapping circle+triangle
    FOLDER           = 0xB9, //near-duplicate of FOLDER_OPEN, double check if intentional
    SWIPE            = 0xC0, //bold diagonal arrow w/ motion trail - meaning unclear, verify
    FRAME            = 0xC1, //corner brackets, like a crop/focus frame
    TILEMAP          = 0xC2, //tilemap
    MAGIC_WAND_ALT   = 0xC3, //near-duplicate of MAGIC_WAND, extra sparkles
    GRID             = 0xC4,
    SIGNAL           = 0xC5, //concentric arcs + dot, could read as wifi/broadcast/rss
    BRIGHTNESS       = 0xC6, //two sun/spark bursts - verify intent
    BRACES           = 0xC7, //"{}" glyph
    FUNCTION         = 0xC8, //cursive "f" glyph
    HASH             = 0xC9, //"#" glyph
    FUNCTION_ALT     = 0xD0, //"f*" glyph - verify against FUNCTION
    LIGHTBULB        = 0xD1, //outline
    PAINT_ROLLER     = 0xD2,
    SWAP             = 0xD3, //opposing horizontal arrows
    ALARM            = 0xD4,
    STEPS            = 0xD5,
    LIGHTBULB_ALT    = 0xD6,
    MOUSE            = 0xD7, //computer mouse
    ANGLE            = 0xD8, //right-angle/protractor
    PENCIL           = 0xD9, //diagonal writing pencil, distinct from EDIT
    SCRIPT           = 0xE0, //scroll + pencil - verify intent
    SHADER           = 0xE1, //diagonal hatch fill
    AUTOFILL         = 0xE2, //near-duplicate of UNLOCK, different style
    ANGLE_90         = 0xE3, //ANGLE with an arrow - verify intent
    ERASER           = 0xE4,
    LINE             = 0xE5, //diagonal pen stroke
    FLIP_VERTICAL    = 0xE6, //dashed vertical line w/ up+down arrows
    PAINTBUCKET      = 0xE7, //tag w/ pencil/paint mark - verify intent
    FLIP_HORIZONTAL  = 0xE8, //"<|>" style glyph - verify intent
}

//all icons in one array, used by the icon reference debug window
icon_codes = [
    ICON.MAP, ICON.STAR, ICON.PLUS, ICON.MINUS, ICON.CLOSE, ICON.FILE, ICON.LOCK, ICON.EDIT,
    ICON.EYE, ICON.EYE_OFF, ICON.TAG, ICON.TAGS, ICON.COMMENT, ICON.WARNING, ICON.FILE_ALT, ICON.FOLDER_OPEN,
    ICON.GEAR, ICON.WRENCH, ICON.EXPAND, ICON.COMPRESS, ICON.RESIZE_VERTICAL, ICON.RESIZE_HORIZONTAL, ICON.ZOOM_IN, ICON.ZOOM_OUT,
    ICON.ARROW_UP, ICON.ARROW_RIGHT, ICON.ARROW_LEFT, ICON.ARROW_DOWN, ICON.REDO, ICON.UNDO, ICON.LEAF, ICON.TEXT,
    ICON.BOLD, ICON.ITALIC, ICON.DROPLET, ICON.ADJUST, ICON.KEY, ICON.MAGNET, ICON.TARGET, ICON.CHECK,
    ICON.SAVE, ICON.CLIPBOARD, ICON.MARQUEE, ICON.MOVE, ICON.EXPAND_ARROWS, ICON.FLASK, ICON.COPY, ICON.MENU,
    ICON.MAGIC_WAND, ICON.BELL, ICON.CODE, ICON.PUZZLE, ICON.UNLOCK, ICON.MORE_HORIZONTAL, ICON.MORE_VERTICAL, ICON.SHARE,
    ICON.REPLY, ICON.SORT_AZ, ICON.SORT_ZA, ICON.SORT_SIZE_ASC, ICON.SORT_SIZE_DESC, ICON.BUG, ICON.PARAGRAPH, ICON.SLIDERS,
    ICON.BELL_OFF, ICON.TRASH, ICON.EYEDROPPER, ICON.PAINTBRUSH, ICON.USER, ICON.TEXT_CURSOR, ICON.TRANSFORM, ICON.TRANSFORM_ALT,
    ICON.FILE_FILLED, ICON.FILE_OUTLINE, ICON.HELP, ICON.SNOWFLAKE, ICON.HOME, ICON.SHAPES, ICON.FOLDER, ICON.SWIPE,
    ICON.FRAME, ICON.TILEMAP, ICON.MAGIC_WAND_ALT, ICON.GRID, ICON.SIGNAL, ICON.BRIGHTNESS, ICON.BRACES, ICON.FUNCTION,
    ICON.HASH, ICON.FUNCTION_ALT, ICON.LIGHTBULB, ICON.PAINT_ROLLER, ICON.SWAP, ICON.ALARM, ICON.STEPS, ICON.LIGHTBULB_ALT,
    ICON.MOUSE, ICON.ANGLE, ICON.PENCIL, ICON.SCRIPT, ICON.SHADER, ICON.AUTOFILL, ICON.ANGLE_90, ICON.ERASER,
    ICON.LINE, ICON.FLIP_VERTICAL, ICON.PAINTBUCKET, ICON.FLIP_HORIZONTAL,
]

//indexed by LAYER_TYPE enum value
layer_type_icons = [ICON.TILEMAP, ICON.TRANSFORM, ICON.SHAPES];

//indexed by LAYER_TYPE enum value - which resource_tree "type" is relevant
//to each kind of layer (tileset layers show tilesets, asset layers show
//sprites, instance layers show objects)
layer_type_resource_types = ["tileset", "sprite", "object"];

//regenerates datafiles/editor/resource_tree.json
resource_tree_bat_path = filename_path(GM_project_filename) + "extensions/editor_data/pre_build_step.bat";

font_size = 20;

left_panel_width      = 300;
right_panel_width     = 300;
panel_toggle_width    = 20; //width of the slim show/hide strip next to each panel
toolbar_height        = 36;
viewport_toolbar_height = 36; //fixed strip of editor buttons over the viewport, between the side panels

//stable dockspace ids for the two side panels - fixed constants rather than
//ImGui.GetID(), since GetID needs an active ImGui frame/window and this runs
//in Create before ImGui.__Update() has executed for the first time
dock_id_left  = 0x100001;
dock_id_right = 0x100002;

move_spd = 2;

tile_w = 16; //tile cell size
tile_h = 16;

//when any action is performed an undo action is added to the undo stack
//if you undo, the action gets popped and a redo action is added to the redo stack
undo_steps = 64

#endregion

#region variables
//settings that don't belong in imgui.ini (it only stores window/dock geometry)
var editor_settings_ = json_load(editor_settings_path) ?? {};
dark_mode = editor_settings_[$ "dark_mode"] ?? false;

//side panels always start visible/expanded - just an in-session toggle, not persisted
left_panel_visible    = true;
right_panel_visible   = true;

//show/hide state for each dockable tool window, toggled from the "Windows" menu
window_layers_visible        = true;
window_resources_visible     = true;
window_icons_visible         = false; //debug: reference list of all ICON names/glyphs
window_resource_tree_visible = false; //debug: unfiltered resource_tree, all types

initialized = false;

last_camera_follow = global.camera.follow;

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

layers = []; //contains layer struct
layer_index = 0;
layer_active = undefined;

layer_rename_index  = -1; //index of the layer currently being renamed, -1 if none
layer_rename_buffer = "";
layer_click_index   = -1; //for detecting a double-click on a layer name to rename it
layer_click_time    = 0;
parralax_x = 0; //parralax value for specific layer
parralax_y = 0;

offset_x = 0; //layer offset, useful to move parralaxed layers back into view
offset_y = 0;

add_layer_type = LAYER_TYPE.ASSET;

element_active = noone;

tilemap = undefined;
tileset = undefined;
tileset_tiles = noone; //ds_grid of the active tileset's tiles, see refresh_tileset_tiles
tilemap_w = 0;
tilemap_h = 0;

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
tiles_size = 512; //display size (px) of the tile picker surface, zoomable
tile_picker_selected_x = -1; //selected cell in tileset_tiles, -1 = none
tile_picker_selected_y = -1;

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
//sprite_assets = asset_get_ids(asset_sprite);

undo_stack = []
redo_stack = []

//3D model viewer window - see scan_smf_files/smf_viewer_load in #region functions
window_3d_viewer_visible = false;
smf_files = []; //relative paths (eg "3D/SMF/Dragon.smf"), populated once in #region setup
smf_selected_index = -1;
smf = undefined;
smf_inst = undefined;
smf_error = undefined; //set when the last smf_viewer_load() attempt failed
smf_rotx = 0;
smf_roty = 0;
smf_rotz = 0;
smf_preview_surface = -1;
#endregion

#region functions
//copies the live layout back to the stable backup location, and saves any
//editor settings that don't belong in imgui.ini alongside it
sync_imgui_layout_backup = function(){
    if (file_exists(imgui_ini_runtime_path)) {
        file_copy(imgui_ini_runtime_path, imgui_ini_backup_path);
    }
    json_save(editor_settings_path, {dark_mode : dark_mode});
}

///@desc draws a button showing an icon from ICON - square, sized to match
///the current frame height (so it lines up with adjacent text/widgets)
///unless _size is given explicitly
icon_button = function(_icon, _id_suffix = "", _size = 0){
    if (_size <= 0) _size = ImGui.GetFrameHeight();

    var label_ = chr(_icon);
    if (_id_suffix != "") ImGui.PushID(_id_suffix);

    ImGui.PushFont(font_icons);
    var pressed_ = ImGui.Button(label_, _size, _size);
    ImGui.PopFont();
    if (_id_suffix != "") ImGui.PopID();

    return pressed_;
}

icon = function(_icon,_disabled = false){
    var label_ = chr(_icon);
    ImGui.PushFont(font_icons);
    if(!_disabled){
        ImGui.Text(label_)
    } else {
        ImGui.TextDisabled(label_)
    }
    ImGui.PopFont();
}

///@desc a button that fills the entire available content region of the
///current window
area_button = function(){
    var w_ = ImGui.GetContentRegionAvailX();
    var h_ = ImGui.GetContentRegionAvailY();
    var start_x_ = ImGui.GetCursorScreenPosX();
    var start_y_ = ImGui.GetCursorScreenPosY();

    var pressed_ = ImGui.InvisibleButton("##area", w_, h_);
    var hovered_ = ImGui.IsItemHovered();

    var draw_list_ = ImGui.GetWindowDrawList();
    var icon_color_ = dark_mode ? c_white : c_black;

    if (hovered_) {
        ImGui.DrawListAddRectFilled(draw_list_, start_x_, start_y_, start_x_ + w_, start_y_ + h_, icon_color_, 0.25);
    }
    return pressed_;
}

///@desc re-runs the pre-build step (reads the .yyp fresh and rewrites
///datafiles/editor/resource_tree.json), then reloads resource_tree from it
regenerate_resource_tree = function(){
    //execute_shell_simple (ShellExecuteW under the hood) launches async with no
    //way to wait for completion, so the reload is deferred a couple seconds to
    //give node time to finish rewriting resource_tree.json before we read it
    execute_shell_simple(resource_tree_bat_path);
    call_later(2, time_source_units_seconds, function(){
        resource_tree = json_load("editor/resource_tree.json").folders;
    });
}

///@desc true if _folder (or any folder nested inside it) contains a
///resource of _type - used to skip folders with nothing relevant to show
resource_folder_has_type = function(_folder, _type){
    for (var i_ = 0; i_ < array_length(_folder.resources); i_++) {
        if (_folder.resources[i_].type == _type) return true;
    }
    for (var i_ = 0; i_ < array_length(_folder.folders); i_++) {
        if (resource_folder_has_type(_folder.folders[i_], _type)) return true;
    }
    return false;
}

///@desc recursively draws _folders/_resources as a tree, showing only
///resources matching _type and folders that contain at least one (nested
///or not) - used for the Resources window, filtered by the active layer's
///type. _selected_name highlights a matching leaf (optional). _on_click, if
///given, is called with a resource's name when that leaf is clicked
resource_tree_draw = function(_folders, _resources, _type, _selected_name = undefined, _on_click = undefined){
    for (var i_ = 0; i_ < array_length(_folders); i_++) {
        var folder_ = _folders[i_];
        if (!resource_folder_has_type(folder_, _type)) continue;

        if (ImGui.TreeNode(folder_.name)) {
            resource_tree_draw(folder_.folders, folder_.resources, _type, _selected_name, _on_click);
            ImGui.TreePop();
        }
    }

    for (var i_ = 0; i_ < array_length(_resources); i_++) {
        var res_ = _resources[i_];
        if (res_.type != _type) continue;

        var flags_ = ImGuiTreeNodeFlags.Leaf | ImGuiTreeNodeFlags.NoTreePushOnOpen | ImGuiTreeNodeFlags.Bullet;
        if (_selected_name != undefined && res_.name == _selected_name) flags_ |= ImGuiTreeNodeFlags.Selected;

        ImGui.TreeNodeEx(res_.name, flags_);
        if (_on_click != undefined && ImGui.IsItemClicked()) {
            _on_click(res_.name);
        }
    }
}

///@desc recursively draws every folder/resource in _folders/_resources with
///no type filtering, labeling each resource with its type - debug window,
///for eyeballing that resource_tree matches the actual project
resource_tree_draw_debug = function(_folders, _resources){
    for (var i_ = 0; i_ < array_length(_folders); i_++) {
        var folder_ = _folders[i_];

        if (ImGui.TreeNode(folder_.name)) {
            resource_tree_draw_debug(folder_.folders, folder_.resources);
            ImGui.TreePop();
        }
    }

    for (var i_ = 0; i_ < array_length(_resources); i_++) {
        var res_ = _resources[i_];
        ImGui.TreeNodeEx(res_.name + " (" + res_.type + ")", ImGuiTreeNodeFlags.Leaf | ImGuiTreeNodeFlags.NoTreePushOnOpen | ImGuiTreeNodeFlags.Bullet);
    }
}

///@desc set active layer
set_layer = function(_index = layer_index){
    layer_index = _index
    layer_active = layers[_index]
}

///@desc rebuilds tileset/tileset_tiles/grid_cell_w/grid_cell_h for the active
///layer's tileset - lazy, does nothing if tileset_tiles is already built for
///the current layer_active.tile_map
///@desc rebuilds tileset/tileset_tiles/grid_cell_w/grid_cell_h for the active
///layer's tileset - lazy, does nothing if tileset_tiles is already built for
///the current layer_active.tile_map. returns true if it rebuilt (so the
///caller can re-center/reset its view), false if already current
refresh_tileset_tiles = function(){
    if (layer_active == undefined || layer_active.tile_map == undefined) return false;
    if (tileset == layer_active.tile_map && ds_exists(tileset_tiles, ds_type_grid)) return false;

    if (ds_exists(tileset_tiles, ds_type_grid)) ds_grid_destroy(tileset_tiles);

    tileset = layer_active.tile_map;

    var info_ = tileset_get_info(tileset);
    grid_cell_w = info_.tile_width;
    grid_cell_h = info_.tile_height;

    var columns_ = info_.tile_columns;
    var rows_ = ceil(info_.tile_count / columns_);
    tileset_tiles = ds_grid_create(columns_, rows_);
    ds_grid_populate(tileset_tiles, array_create_ext(columns_ * rows_, function(_i){
        return _i;
    }));

    brush = -1;
    tiles_size = 512;
    tile_picker_selected_x = -1;
    tile_picker_selected_y = -1;
    return true;
}

///@desc add a new layer
action_add_layer = function(_name,_depth,_type,_always = false, _color = BLACK){
    var layer_ = {
        name : _name,
        parralax : 0,
        type : _type,
        layer : layer_create(_depth, _name),
        always : _always,
        visible : true,
        locked : false,
        color : _color
    }
    
    if(_type == LAYER_TYPE.TILEMAP){
        layer_.tileset = ts_collisions
        layer_.tiles = [];
        layer_.tilemap = layer_tilemap_create(layer_.layer,0,0,layer_.tileset,16,16)
        
    }

    array_push(layers,layer_)

    layers_depth_order()

    array_push(undo_stack,function(){
        var index_ = array_get_index(layers,layer_)
        if (index_ == -1) return;

        layer_destroy(layer_.layer)
        array_delete(layers,index_,1)

        if (layer_active == layer_) {
            layer_active = undefined
            layer_index = 0
        }
    })
}

///@desc remove a layer - layers marked "always" can't be removed
action_remove_layer = function(_index){
    var layer_ = layers[_index]
    if (layer_.always) return;

    var depth_ = layer_get_depth(layer_.layer)
    layer_destroy(layer_.layer)
    array_delete(layers,_index,1)

    layer_index--

    set_layer()

    array_push(undo_stack,function(){
        //recreates the underlying room layer (the old one is gone for good) and
        //restores the same struct - visibility/lock/name/etc. all come back with it
        layer_.layer = layer_create(depth_,layer_.name)
        layer_set_visible(layer_.layer,layer_.visible)

        array_push(layers,layer_)
        layers_depth_order()
    })
}

///@desc change a layer's depth
action_set_depth = function(_index, _depth){
    var layer_ = layers[_index]
    var old_depth_ = layer_get_depth(layer_.layer)
    if (_depth == old_depth_) return;

    layer_depth(layer_.layer,_depth)
    layers_depth_order()

    array_push(undo_stack,function(){
        layer_depth(layer_.layer, old_depth_)
        layers_depth_order()
    })
}

///@desc change a tilemap layer's active tileset - _tileset_name is a
///resource_tree resource name, resolved to the real tileset asset here
action_set_tileset = function(_index, _tileset_name){
    var layer_ = layers[_index]
    var new_tile_map_ = asset_get_index(_tileset_name)
    var old_tile_map_ = layer_.tile_map
    if (new_tile_map_ == old_tile_map_) return;

    layer_.tile_map = new_tile_map_

    array_push(undo_stack,function(){
        layer_.tile_map = old_tile_map_
    })
}

//reorders layers based on their depth
layers_depth_order = function (){
    array_sort(layers,function(_current,_next){
        var depth_diff_ = layer_get_depth(_current.layer) - layer_get_depth(_next.layer);
        if (depth_diff_ != 0) return depth_diff_;
        //tie-break by name so array_sort (unstable) doesn't reorder same-depth layers randomly
        return _current.name == _next.name ? 0 : (_current.name > _next.name ? 1 : -1);
    })
    //sets layer index after sorting
    for (var i_ = 0; i_ < array_length(layers); i_++) {
    	if(layer_active == layers[i_]){
            layer_index = i_;
            break;
        }
    }
    //sets new layer depth
    //with(obj_layer_draw){
        //depth = layer_get_depth(layer_id);
    //}
}

//Clear everything and reset parameters
new_level = function(){
    layers = []
    layer_index = 0

    //clear everything
    //setup the basic layers
    var d_ = 10; //depth offset
    action_add_layer("instances",  0    , LAYER_TYPE.INSTANCE, true)
    action_add_layer("collision_A",0    , LAYER_TYPE.TILEMAP , true ,RED)
    action_add_layer("collision_B",0    , LAYER_TYPE.TILEMAP , true ,GREEN)
    action_add_layer("collision_C",0    , LAYER_TYPE.TILEMAP , true ,BLUE)
    action_add_layer("decor_A",    d_   , LAYER_TYPE.TILEMAP , true ,RED)
    action_add_layer("decor_B",    d_*2 , LAYER_TYPE.TILEMAP , true ,GREEN)
    action_add_layer("decor_C",    d_*3 , LAYER_TYPE.TILEMAP , true ,BLUE)

    undo_stack = []
    redo_stack = []
}

///@desc recursively finds every .smf file under _dir (relative to the game's
///data root, eg "3D"), returning paths in the same relative form
///smf_model_load expects (eg "3D/SMF/Dragon.smf"). file_find_first/next/close
///use a single global search handle, so subdirectory names are fully
///collected and the search closed *before* recursing into them - two
///overlapping find sessions would corrupt each other
scan_smf_files = function(_dir){
    var out_ = [];

    var file_ = file_find_first(_dir + "/*.smf", 0);
    while (file_ != "") {
        array_push(out_, _dir + "/" + file_);
        file_ = file_find_next();
    }
    file_find_close();

    var subdirs_ = [];
    var entry_ = file_find_first(_dir + "/*", fa_directory);
    while (entry_ != "") {
        if (entry_ != "." && entry_ != ".." && directory_exists(_dir + "/" + entry_)) {
            array_push(subdirs_, entry_);
        }
        entry_ = file_find_next();
    }
    file_find_close();

    for (var i_ = 0; i_ < array_length(subdirs_); i_++) {
        var nested_ = scan_smf_files(_dir + "/" + subdirs_[i_]);
        for (var j_ = 0; j_ < array_length(nested_); j_++) {
            array_push(out_, nested_[j_]);
        }
    }

    return out_;
}

///@desc swaps the 3D model viewer to a different .smf file, destroying
///whatever was previously loaded. some .smf files (eg static, non-rigged
///meshes) aren't compatible with smf_instance's animated-rig path and throw
///from inside the SMF extension itself - caught here so a bad pick just
///shows an error in the viewer instead of crashing the whole editor
smf_viewer_load = function(_path){
    if (smf != undefined) smf.destroy();
    smf = undefined;
    smf_inst = undefined;
    smf_error = undefined;

    try {
        smf = smf_model_load(_path);
        smf_inst = new smf_instance(smf);
    } catch (_err) {
        if (smf != undefined) smf.destroy();
        smf = undefined;
        smf_inst = undefined;
        smf_error = _err.message;
    }
}
#endregion

#region setup
if(!variable_global_exists("editor_data")){
    //when stopping level editor the tile data and stuff is still present
    global.editor_data = {
        //initialized : false
    }
}

//close button intercept
window_command_hook(window_command_close);

smf_files = scan_smf_files("3D");

//loads whatever resource_tree.json currently exists so it's immediately
//usable, then kicks off a regeneration in the background to catch any
//project changes since it was last built - see the "Regenerate Resource
//Tree" menu item for a manual re-run
resource_tree = json_load("editor/resource_tree.json").folders;
regenerate_resource_tree();

//restore last session's window positions/dock layout, if any - windows are
//otherwise just Begin()'d plain (see Step_1.gml) and pick this up automatically
if (file_exists(imgui_ini_backup_path)) {
    file_copy(imgui_ini_backup_path, imgui_ini_runtime_path);
}

ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);

font = ImGui.AddFontFromFile("editor/AtkinsonHyperlegible.ttf",font_size);
font_icons = ImGui.AddFontFromFile("editor/icons.ttf",font_size);

global.show_collisions = true;
show_collisions(true);

call_later(1,time_source_units_frames,function (){
    //needs 1 frame delay before it can draw for some reason
    initialized = true;
});

global.camera.follow = noone;
global.camera.zone_constrain = false;
global.gui_draw = false;

//if you're not already in a level, when going to editor
if(global.level == undefined){
    //TODO it should load up the most recent level worked on, or prepare a new empty level
    new_level()
} else {
    //TODO get the level data of the current level
    //probably by clearing everything and reloading the file contents but as editor specific objects
}
#endregion



//#region prepares layers
////gets relevant layers, and adds a type for ease of use
//var layers_ = layer_get_all();
//for (var i_ = 0; i_ < array_length(layers_); i_++) {
    ////only show tile and decor layers, and store a type on them for ease
    //var layer_ = {
        //id : layers_[i_],
        //name: string_lower(layer_get_name(layers_[i_])),
    //}
    //
    //var external_ = false;
    //var data_layers_ = struct_get_names(global.room_data.layers);
    //for (var l_ = 0; l_ < array_length(data_layers_); l_++) {
    	//if(layer_.name ==  data_layers_[l_]){
            //external_ = true;
            //break;
        //}
    //}
    //
    //if(external_ == false){ //internal layers do not need to be edited, and will be disabled
        //array_push(layers,layer_);
    //}
    //
    //else if(string_starts_with(layer_.name,"decor")){
        //layer_.type = LAYER_TYPE.TILEMAP
        //array_push(layers,layer_);
    //} else
    //
    //if(string_starts_with(layer_.name,"asset")){
        //layer_.type = LAYER_TYPE.ASSET
        //layer_.transforms = [];
        //array_push(layers,layer_);
        //
		////adds asset editor instance, so they can be manipulated
        //var elements_ = layer_get_all_elements(layer_.id);
		//for (var e_ = 0; e_ < array_length(elements_); e_++) {
			//var element_ = elements_[e_];
			//array_push(layer_.transforms,instance_create_depth(0,0,0,obj_asset_transform,{
				//element_id : element_,
                //name : sprite_get_name(layer_sprite_get_sprite(element_)),
				//layer_id : layer_.id,
			//}));
		//}
    //}
//}
//#endregion

///TODO this should be changed into an action system for undo & redo as soon as possible
//add_layer = function(_type){
    //var layer_ = {
        //type : _type,
    //}
    //var name_ = "";
    //switch (_type) {
        //case LAYER_TYPE.INSTANCE:
            //name_ = "inst_";
            //layer_.transforms = [];
            //break;
        //case LAYER_TYPE.ASSET:
            //name_ = "asset_";
            //layer_.transforms = [];
            //break;
        //case LAYER_TYPE.TILEMAP:
            //name_ = "decor_";
            //break;
    //}
    //
    //var count_ = 0;
    ////layer number for the name
    //for (var i_ = 0; i_ < array_length(layers); i_++) {
    	//if(string_starts_with(layers[i_].name,name_)) count_++;
    //}
    //name_+=string(count_);
    //
    ////sets depth to be under the lowest layer
    //var depth_ = layer_get_depth(layers[array_length(layers)-1].id) + 100;
    //
    //layer_.name = name_;
    //layer_.id = layer_create(depth_,name_);
    //
    //struct_set_chained(global.room_data,{
        //depth: depth_,
        //parralax_x: 0,
        //parralax_y: 0,
        //offset_x: 0,
        //offset_y: 0,
    //},"layers",name_);
    //
    //switch (_type) {
        //case LAYER_TYPE.TILEMAP:
            //
            //instance_create_depth(0,0,depth_,obj_layer_draw,{
                //layer_id : layer_.id,
                //type : LAYER_TYPE.TILEMAP,
                //name : name_
            //})
            //layer_set_visible(layer_.id,false);
            //break;
            //
        //case LAYER_TYPE.INSTANCE:
            //struct_set_chained(global.room_data,[],"layers",name_,"elements");
        //case LAYER_TYPE.ASSET:
            //struct_set_chained(global.room_data,[],"layers",name_,"elements");
            //
            //instance_create_depth(0,0,depth_,obj_layer_draw,{
                //layer_id : layer_.id,
                //type : LAYER_TYPE.ASSET,
                //name : name_
            //})
            //layer_set_visible(layer_.id,false);
            //break;
    //}
    //
    //array_push(layers,layer_);
    //set_layer(array_length(layers)-1);
//}
//
//delete_layer = function(_layer_index){
    //struct_remove(global.room_data.layers,layers[_layer_index].name);
    //array_delete(layers,_layer_index,1);
    //layer_active = undefined;
    //layer_index = 0;
//}
//
//set_layer = function(_layer_index){
    //layer_index = _layer_index;
    //layer_active = layers[_layer_index];
    //
    //if(layer_active.type == LAYER_TYPE.TILEMAP){
        //if(is_array(layer_active.elements)){
            //element_active = layer_active.elements[0];
            //
            //tilemap = layer_tilemap_get_id(layer_active.id);
            //tilemap_w = tilemap_get_width(tilemap)
            //tilemap_h = tilemap_get_height(tilemap)
            //tileset = tilemap_get_tileset(tilemap);
            //tileset_info = tileset_get_info(tileset);
            //
            ////redraw tile data and instance
            //tileset_data_update = true;
            //tilebrush_data_update = true;
			//
            ////Grid overlay size
			//grid_w = tilemap_w;
			//grid_h = tilemap_h;
			//grid_cell_w = tileset_info.tile_width;
			//grid_cell_h = tileset_info.tile_height;
            //
            //tileset_info.name = tileset_get_name(tileset);
            //
            //var brush_width_ = struct_get_chained(editor_data,tileset_info.name,"brush_width");
            //var brush_height_ = struct_get_chained(editor_data,tileset_info.name,"brush_height");
            //var brush_tiles_ = struct_get_chained(editor_data,tileset_info.name,"brush_tiles");
            //
            //tileset_brushes = ds_grid_create(brush_width_,brush_height_);
            //ds_grid_populate(tileset_brushes,brush_tiles_);
            //
            //tileset_tiles = ds_grid_create(tileset_info.tile_columns,tileset_info.tile_count / tileset_info.tile_columns);
            ////fils grid with indexes from
            //ds_grid_populate(tileset_tiles,array_create_ext(tileset_info.tile_count,function(_i){
                //return _i;
            //}));
            //
            ////a brush is a ds_grid of tiledata
            //brush = -1; //-1 is none selected
            //
            //tile_flipped = false;
            //tile_mirrored = false;
            //tile_rotated = false;
            //
            ////tile picker offset and zoom
            //tiles_x = 0;
            //tiles_y = 0;
            //tiles_size = 512; //this should automatically be set to fit the window
            //
            ////tile brush pickers offset and zoom
            //brushes_x = 0;
            //brushes_y = 0;
            //brushes_size = 512;
        //} else {
            //element_active = noone
            //tilemap = undefined;
            //tileset = undefined;
        //}
    //}
    //else if(layer_active.type == LAYER_TYPE.ASSET) { //asset layer
		//element_active = noone;
		//grid_cell_w = 16;
		//grid_cell_h = 16;
		//grid_w = room_width / grid_cell_w;
		//grid_h = room_height / grid_cell_h;
        //
        //brush = -1;
    //}
    //
    //parralax_x = struct_get_chained(global.room_data,"layers",layer_active.name,"parralax_x") ?? 0;
    //parralax_y = struct_get_chained(global.room_data,"layers",layer_active.name,"parralax_y") ?? 0;
    //offset_x = struct_get_chained(global.room_data,"layers",layer_active.name,"offset_x") ?? 0;
    //offset_y = struct_get_chained(global.room_data,"layers",layer_active.name,"offset_y") ?? 0;
//}
//
//add_sprite = function(_sprite){
    //var x_ = global.camera.x + offset_x - global.camera.get_x() * parralax_x;
    //var y_ = global.camera.y + offset_y - global.camera.get_y() * parralax_y;
    //
    //var element_ = layer_sprite_create(layer_active.id,x_,y_,_sprite);
    //var transform_ = instance_create_depth(0,0,0,obj_asset_transform,{
        //element_id : element_,
        //name :  sprite_get_name(_sprite),
        //layer_id : layer_active.id,
    //});
    //element_active = transform_;
    //array_push(layer_active.transforms,transform_);
//}
//
//quit = function(){ //stops level editor
    ////maybe make a warning or popup or something
    //
    //global.camera.follow = last_camera_follow;
    //global.camera.zone_constrain = true;
    //global.gui_draw = true;
    //
    //global.camera.zoom(1,0);
    //
    //instance_destroy();
//}

//save = function(){
    //var path_ = string_replace(GM_project_filename,"Pengu-lost-and-wanted.yyp","datafiles/room_data/"+room_get_name(room)+".json");
    //show_debug_message("saved to: "+path_);
    //show_debug_message(global.room_data);
    //json_save(path_,global.room_data);
//}

//reorders layers
//layers_depth_order();

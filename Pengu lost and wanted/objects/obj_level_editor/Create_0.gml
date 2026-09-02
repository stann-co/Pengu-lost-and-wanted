/// @description

enum TOOL_MODE {
    DRAW,
    LINE,
    SQUARE,
    SELECTION,
    FILL
}

#region constants
imgui_ini_runtime_path = working_directory + "/imgui.ini";

//when exported, datafiles/ flattens next to the exe (working_directory);
//GM_project_filename only points at the IDE's own source datafiles folder
root_path = (GM_build_type == "exe") ? working_directory : filename_path(GM_project_filename) + "datafiles/";

imgui_ini_backup_path  = root_path + "editor/imgui_layout.ini";
editor_settings_path   = root_path + "editor/editor_settings.json";

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
layer_type_icons = [ICON.TILEMAP, ICON.TRANSFORM, ICON.SHAPES, ICON.FRAME];

//indexed by LAYER_TYPE - which resource_tree "type" each layer kind shows
//(tileset layers show tilesets, asset layers sprites, instance layers objects)
layer_type_resource_types = ["tileset", "sprite", "object"];

//regenerates datafiles/editor/resource_tree.json
resource_tree_bat_path = filename_path(GM_project_filename) + "extensions/editor_data/pre_build_step.bat";

font_size = 20;

left_panel_width      = 300;
right_panel_width     = 300;
panel_toggle_width    = 20; //width of the slim show/hide strip next to each panel
toolbar_height        = 36;
viewport_toolbar_height = 36; //fixed strip of editor buttons over the viewport, between the side panels
status_bar_height = 24; //thin strip along the bottom showing the room-space mouse position

//stable dockspace ids for the side panels - fixed constants since GetID()
//needs an active ImGui frame, which Create runs before __Update() has
dock_id_left  = 0x100001;
dock_id_right = 0x100002;

move_spd = 2;

tile_w = 16; //tile cell size
tile_h = 16;

room_min_w = tile_w * 8; //in pixels
room_min_h = tile_h * 8;

//editor-only tile brush canvases - one per tileset, painted on brushes_layer
//(see #region setup), persisted as json here and loaded back by name
tileset_brushes_dir = root_path + "editor/tileset_brushes/";
brush_canvas_w = 16; //size, in tiles, of every tile brush canvas
brush_canvas_h = 16;

//where Save/Save As/Open default to - see #region persistence
levels_dir = root_path + "levels/";

//when any action is performed an undo action is added to the undo stack
//if you undo, the action gets popped and a redo action is added to the redo stack
undo_steps = 64

#endregion

#region variables
destroyed = false;

//settings that don't belong in imgui.ini (it only stores window/dock geometry)
var editor_settings_ = json_load(editor_settings_path) ?? {};
dark_mode = editor_settings_[$ "dark_mode"] ?? false;

//most-recent-first, see add_recent_level - normalized/deduplicated here since
//older saves may have the same file listed twice under different slash directions
recent_levels = [];
var loaded_recent_levels_ = editor_settings_[$ "recent_levels"] ?? [];
for (var i_ = 0; i_ < array_length(loaded_recent_levels_); i_++) {
    var normalized_ = string_replace_all(loaded_recent_levels_[i_], "\\", "/");
    if (array_get_index(recent_levels, normalized_) == -1) array_push(recent_levels, normalized_);
}

//the level currently open - Save writes straight back to this once set;
//Save As (or the very first Save with nothing open yet) prompts for it
current_level_path = undefined;

//dirty tracking for the "*" suffix - compares undo_stack depth against the
//last save/load; level_dirty covers edits that skip undo_stack entirely
level_dirty = false;
saved_undo_depth = 0;

//side panels always start visible/expanded - just an in-session toggle, not persisted
left_panel_visible    = true;
right_panel_visible   = true;

//show/hide state for each dockable tool window, toggled from the "Windows" menu
window_layers_visible        = true;
window_resources_visible     = true;
window_icons_visible         = false; //debug: reference list of all ICON names/glyphs
window_resource_tree_visible = false; //debug: unfiltered resource_tree, all types

initialized = false;

//forces Layers/Resources back into their dockspaces once, the first frame
//after this ImGui context exists - a fresh __Initialize() won't reapply it
global.editor_docked_default_windows = false;

last_camera_follow = global.camera.follow;

tileset_surface = -1;
tilebrush_surface = -1;

room_width = room_min_w;
room_height = room_min_h;

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

collision_layer = -1; //when one of the collision layers are active, this value reflects that, and it ensures the other 2 appear slightly transparent

camera_x = global.camera.x; //camera position for the level view
camera_y = global.camera.y;

//offset_x = 0; //layer offset, useful to move parralaxed layers back into view
//offset_y = 0;

add_layer_type = LAYER_TYPE.ASSET;

//Layer Properties' parallax X/Y sliders move together while this is on
parallax_linked = true;

element_active = noone; //the primary selection - drives move/rotate/scale (see obj_asset_transform)
elements_selected = []; //rest of the multi-selection - dragged/rotated/scaled together with element_active
clipboard = []; //captured by action_copy_selected, placed by action_paste_clipboard

//entity eyedropper (REFERENCE fields, Outputs window's Target Entity) -
//armed by clicking an eyedropper button, resolved/cancelled in Step_1
picking_reference_owner = noone; //element_uid of the instance the pick belongs to
picking_reference_accepted = []; //accepted_objects for the field, cached at arm time
picking_hover_uid = noone; //valid pick target under the mouse this frame, if any
picking_reference_on_pick = function(_target_name){}; //called with the picked element_name once a pick resolves
picking_reference_context = undefined; //arm-site-defined key, lets a field tell if IT is the one being picked

//Outputs window (Inspector's I/O section) - see the "inspector" region of Step_1.gml
io_window_uid = noone; //element_uid the window is currently open for
io_window_row_index = -1; //index into that element's io_connections loaded for editing, -1 = new row
io_window_edit_row = undefined; //working copy of the row being edited
io_window_clipboard = undefined; //last row copied via the window's Copy button
//bumped whenever io_window_edit_row is replaced wholesale (not a single field
//edit) - suffixed onto each field's widget id, since ImGui widgets otherwise
//keep showing their own cached text after the struct backing them is swapped
io_window_edit_generation = 0;
//My Output/Via this Input render as a plain toggled list rather than an
//ImGui combo - a combo's own popup closes the whole Outputs window when
//dismissed in this ImGui build, since it's nested inside another popup
io_output_dropdown_open = false;
io_input_dropdown_open = false;
io_window_hidden_for_pick = false; //true while the eyedropper temporarily hides the window

//click-drag on empty viewport space, see the "element placement" region of Step_1.gml
box_select_active = false;
box_select_start_x = 0;
box_select_start_y = 0;

//hands out a unique element_uid per obj_asset_transform - a raw instance id
//isn't stable across undo/redo, since action_restore_instance recreates it
next_element_uid = 0;

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
tiles_switched = false; //set on layer selection (and the center button), so the view re-fits/centers next time it's drawn
tile_picker_selected_x = -1; //selected cell in tileset_tiles, -1 = none
tile_picker_selected_y = -1;

//tracks in-progress paint/erase strokes so holding the mouse only re-applies
//the brush once it moves a brush-width away, not every frame (see Step_1.gml)
tile_paint_active = false;
tile_paint_last_x = 0;
tile_paint_last_y = 0;
tile_erase_active = false;
tile_erase_last_x = 0;
tile_erase_last_y = 0;

//tile brush canvas view offset and zoom (see refresh_tileset_brush)
brushes_x = 0;
brushes_y = 0;
brushes_size = 512;

//the tile brush canvas being edited - only one is alive at a time (see
//refresh_tileset_brush); tilemap_expand uses brush_tilemap to detect it
brush_tileset = undefined;
brush_tilemap = noone;
brush_switched = false; //set by refresh_tileset_brush when it rebuilds, so the view can re-fit next time it's drawn

//tracks in-progress paint/erase strokes on the tile brush canvas, same
//movement-throttle idea as tile_paint_active/tile_erase_active above
brush_paint_active = false;
brush_paint_last_x = 0;
brush_paint_last_y = 0;
brush_erase_active = false;
brush_erase_last_x = 0;
brush_erase_last_y = 0;

brush_pick_mode = true; //false = draw/erase into brush_tilemap, true = left-click picks a connected clump back into brush
brush_picked_x = -1; //tile position of the last ds_grid_pick result in brush_tilemap, -1 = none (for drawing its selection envelope)
brush_picked_y = -1;

//active viewport tool - governs how the level and tile brush canvas are
//drawn on/erased (see tool_interact and the viewport toolbar buttons)
tool_mode = TOOL_MODE.DRAW;
tool_drag_active = false; //line/square/selection: dragging out a shape, started on mb_left/mb_right press, committed on release
tool_drag_tilemap = noone; //which tilemap (level or brush_tilemap) the active drag belongs to - the level and tile brush canvas share this drag state, so both interact and preview need to ignore a drag that isn't theirs
tool_drag_erase = false; //line/square: which button started the current drag
tool_drag_start_x = 0;
tool_drag_start_y = 0;

//selection tool - mask is a boolean ds_grid the same size as
//selection_tilemap, or noone if there's no active selection
selection_mask = noone;
selection_tilemap = noone;

//grid, either size of tilemap or a default value
show_grid = editor_settings_[$ "show_grid"] ?? true;
grid_opacity = editor_settings_[$ "grid_opacity"] ?? 0.1;
grid_cell_w = 16;
grid_cell_h = 16;
grid_w = 4;
grid_h = 4;

//grid overlay toggles for the Resources window's own tileset picker/tile
//brush canvas - independent of show_grid, which is just the level's
tileset_grid_visible = true;
brush_grid_visible = true;

//grid size for asset/instance layers (tilemaps use grid_cell_w/h instead)
//and rotate-snap degrees - see the grid dropdown and obj_asset_transform Step
grid_size = editor_settings_[$ "grid_size"] ?? 32;
snap_degrees = editor_settings_[$ "snap_degrees"] ?? 15;
snap_enabled = false; //toggled by the magnet button - holding ctrl also enables it temporarily

//sprite asset list
//sprite_assets = asset_get_ids(asset_sprite);

undo_stack = []
redo_stack = []

//3D model viewer window - see scan_smf_files/smf_viewer_load in region functions
window_3d_viewer_visible = false;
smf_files = []; //relative paths (eg "3D/SMF/Dragon.smf"), populated once in region setup
smf_selected_index = -1;
smf = undefined;
smf_inst = undefined;
smf_error = undefined; //set when the last smf_viewer_load() attempt failed
smf_rotx = 0;
smf_roty = 0;
smf_rotz = 0;
smf_preview_surface = -1;

#endregion

#region functions ----------------------

    #region persistence
    //copies the live layout back to the stable backup location, and saves any
    //editor settings/data that don't belong in imgui.ini alongside it
    sync_imgui_layout_backup = function(){
        if (file_exists(imgui_ini_runtime_path)) {
            file_copy(imgui_ini_runtime_path, imgui_ini_backup_path);
        }
        save_editor_settings();
        save_brush_tilemap();
    }

    //writes every persisted editor setting (not window/dock geometry - that's
    //imgui.ini) to editor_settings_path - called whenever any of them change
    save_editor_settings = function(){
        json_save(editor_settings_path, {
            dark_mode : dark_mode,
            recent_levels : recent_levels,
            show_grid : show_grid,
            grid_opacity : grid_opacity,
            grid_size : grid_size,
            snap_degrees : snap_degrees,
        });
    }

    //destroys every current layer (and, via layer_destroy, everything placed on them)
    clear_level = function(){
        instance_activate_all();
        with(all){
            if(!persistent) instance_destroy();
        }
        var culled_objects_ = [obj_entity, obj_tilemap];
        for (var o_ = 0; o_ < array_length(culled_objects_); o_++) {
            var obj_ = culled_objects_[o_];
            for (var i_ = instance_number(obj_) - 1; i_ >= 0; i_--) {
                var inst_ = instance_find(obj_, i_);
                if (!inst_.persistent) instance_destroy(inst_);
            }
        }
        for (var i_ = 0; i_ < array_length(layers); i_++) {
            layer_destroy(layers[i_].layer);
        }
        layers = []
        layer_index = 0
        layer_active = undefined
        collision_layer = -1;

        element_active = noone;
        elements_selected = [];
        clipboard = [];

        undo_stack = []
        redo_stack = []
    }

    //Clear everything and reset parameters
    new_level = function(){
        clear_level();

        //setup the basic layers        
		action_add_layer("instances",  -10    , LAYER_TYPE.INSTANCE, true, WHITE,false,false)
        action_add_layer("collision_A",0    , LAYER_TYPE.TILEMAP , true ,RED  ,true, false)
        action_add_layer("collision_B",0    , LAYER_TYPE.TILEMAP , true ,GREEN,true, false)
        action_add_layer("collision_C",0    , LAYER_TYPE.TILEMAP , true ,BLUE ,true, false)
        action_add_layer("decor_A",    20   , LAYER_TYPE.TILEMAP , true ,RED,  false,false)
        action_add_layer("decor_B",    30 , LAYER_TYPE.TILEMAP , true ,GREEN,false,false)
        action_add_layer("decor_C",    40 , LAYER_TYPE.TILEMAP , true ,BLUE, false,false)

        undo_stack = []
        redo_stack = []

        current_level_path = undefined;
        global.level = undefined;
        level_dirty = false;
        saved_undo_depth = array_length(undo_stack);
    }
    #endregion

    #region level save/load
    //read/write logic lives in editor_functions.gml - this is the stateful half:
    //which file is open, undo/redo, and spawning elements to place them

    //writes to _path and makes it "the open level" - further Save calls go
    //back to this file until Save As (or Open/New Level) points elsewhere
    save_level = function(_path){
        if (global.level == undefined) global.level = filename_change_ext(filename_name(_path), "");
        json_save(_path, level_serialize(layers, room_width, room_height));
        current_level_path = _path;
        level_dirty = false;
        saved_undo_depth = array_length(undo_stack);
        add_recent_level(_path);
    }

    //prompts for a file (native save dialog) and saves there - unlike
    //save_level, always asks, even if a level is already open
    save_level_as = function(){
        if (!directory_exists(levels_dir)) directory_create(levels_dir);
        var default_name_ = current_level_path != undefined ? filename_name(current_level_path) : "level.json";
        var path_ = get_save_filename_ext("Level Files|*.json|All Files|*.*", default_name_, levels_dir, "Save Level");
        if (path_ == "") return;
        save_level(path_);
    }

    //replaces the current level with the one at _path (see level_serialize) -
    //clears undo/redo, since none of it applies to the newly loaded level
    open_level = function(_path){
        var data_ = json_load(_path);
        if (data_ == undefined) return false;

        clear_level();
        room_width = data_.room_width;
        room_height = data_.room_height;

        //temporarily points layer_active at the layer being loaded, since
        //that's what action_place_instance/_sprite always place onto
        var place_element_ = function(_layer, _name, _ed, _is_instance){
            var prev_layer_active_ = layer_active;
            layer_active = _layer;
            if (_is_instance) action_place_instance(_name, _ed.x, _ed.y, false, _ed.vars, _ed.element_name, _ed[$ "io_connections"] ?? []);
            else action_place_sprite(_name, _ed.x, _ed.y, false);
            layer_active = prev_layer_active_;

            element_active.image_xscale = _ed.image_xscale;
            element_active.image_yscale = _ed.image_yscale;
            element_active.image_angle = _ed.image_angle;

            //Other_10 already ran (via action_place_instance) and may have synced
            //a linked widget off the sprite-default scale/angle set above
            if (variable_instance_exists(element_active, "on_scaled")) element_active.on_scaled();
            if (variable_instance_exists(element_active, "on_rotated")) element_active.on_rotated();
            return element_active;
        }

        layers = level_deserialize(data_, place_element_);

        layers_depth_order();
        element_active = noone;
        if (array_length(layers) > 0) set_layer(0);

        current_level_path = _path;
        level_dirty = false;
        saved_undo_depth = array_length(undo_stack);
        add_recent_level(_path);
        return true;
    }

    //prompts for a file (native open dialog) and loads it
    open_level_from_dialog = function(){
        if (!directory_exists(levels_dir)) directory_create(levels_dir);
        var path_ = get_open_filename_ext("Level Files|*.json|All Files|*.*", "", levels_dir, "Open Level");
        if (path_ == "") return;
        open_level(path_);
    }

    //moves _path to the front of recent_levels (deduplicating), caps the list
    //at 10, and persists it - so it survives to the next editor session
    add_recent_level = function(_path){
        //normalized so the same file isn't listed twice just for using backslash
        //paths (eg the native dialog) vs forward-slash ones (eg levels_dir)
        _path = string_replace_all(_path, "\\", "/");

        var idx_ = array_get_index(recent_levels, _path);
        if (idx_ != -1) array_delete(recent_levels, idx_, 1);
        array_insert(recent_levels, 0, _path);
        if (array_length(recent_levels) > 10) array_resize(recent_levels, 10);

        save_editor_settings();
    }
    #endregion

    #region layers & tilesets
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

    ///@desc set active layer
    set_layer = function(_index = layer_index){
        layer_index = _index
        layer_active = layers[_index]

        //mirrors obj_tilemap's own layer_name check - lets non-collision
        //layers draw at full opacity while a collision layer is active
        if      (layer_active.name == "collision_A") collision_layer = COLLISION_LAYERS.A;
        else if (layer_active.name == "collision_B") collision_layer = COLLISION_LAYERS.B;
        else if (layer_active.name == "collision_C") collision_layer = COLLISION_LAYERS.C;
        else collision_layer = -1;

		if(layer_active.type == LAYER_TYPE.TILEMAP){
	        var tileset_changed_ = tileset != layer_active.tileset;

	        refresh_tileset_brush();
	        tiles_switched = true;
	        brush_switched = true;

	        if (tileset_changed_) {
		        brush = -1;
		        tile_picker_selected_x = -1;
		        tile_picker_selected_y = -1;
		        brush_picked_x = -1;
		        brush_picked_y = -1;
	        }
		}

        elements_selected = []; //the element list (ASSET/INSTANCE layers) is per-layer too
        element_active = noone;
    }

    ///@desc rebuilds tileset/tileset_tiles/grid_cell_w/grid_cell_h for the active layer's tileset
    refresh_tileset_tiles = function(){
        if (layer_active == undefined || layer_active.tileset == undefined) return false;
        if (tileset == layer_active.tileset && ds_exists(tileset_tiles, ds_type_grid)) return false;

        if (ds_exists(tileset_tiles, ds_type_grid)) ds_grid_destroy(tileset_tiles);

        tileset = layer_active.tileset;

        var info_ = tileset_get_info(tileset);
        grid_cell_w = info_.tile_width;
        grid_cell_h = info_.tile_height;

        var columns_ = info_.tile_columns;
        var count_ = info_.tile_count;
        var rows_ = ceil(count_ / columns_);
        tileset_tiles = ds_grid_create(columns_, rows_);
        ds_grid_populate(tileset_tiles, array_create_ext(count_, function(_i){
            return _i;
        }));

        brush = -1;
        tiles_size = 512;
        tile_picker_selected_x = -1;
        tile_picker_selected_y = -1;
        brush_picked_x = -1;
        brush_picked_y = -1;
        return true;
    }

    ///@desc rebuilds brush_tilemap for the active layer's tileset
    refresh_tileset_brush = function(){
        if (layer_active == undefined || layer_active.tileset == undefined) return false;
        if (brush_tileset == layer_active.tileset && brush_tilemap != noone) return false;

        if (brush_tilemap != noone) {
            save_brush_tilemap();
            layer_tilemap_destroy(brush_tilemap);
        }

        brush_tileset = layer_active.tileset;
        var name_ = tileset_get_name(brush_tileset);

        var path_ = tileset_brushes_dir + name_ + ".json";
        var data_ = file_exists(path_) ? json_load(path_) : undefined;

        //grows to fit a brush that was previously painted larger than the
        //default canvas size, instead of truncating it back down on reload
        var saved_h_ = data_ != undefined ? array_length(data_.tiles) : 0;
        var saved_w_ = saved_h_ > 0 ? array_length(data_.tiles[0]) : 0;
        var w_ = max(brush_canvas_w, saved_w_);
        var h_ = max(brush_canvas_h, saved_h_);

        brush_tilemap = layer_tilemap_create(brushes_layer, 0, 0, brush_tileset, w_, h_);

        if (data_ != undefined) {
            for (var yy_ = 0; yy_ < saved_h_; yy_++) {
                var row_ = data_.tiles[yy_];
                var row_w_ = array_length(row_);
                for (var xx_ = 0; xx_ < row_w_; xx_++) {
                    tilemap_set(brush_tilemap, row_[xx_], xx_, yy_);
                }
            }
        }

        brush_switched = true;
        return true;
    }

    ///@desc writes brush_tilemap to tileset_brushes/<name>.json, called
    ///whenever editor data is saved
    save_brush_tilemap = function(){
        if (brush_tilemap == noone || brush_tileset == undefined) return;

        if (!directory_exists(tileset_brushes_dir)) directory_create(tileset_brushes_dir);

        var w_ = tilemap_get_width(brush_tilemap);
        var h_ = tilemap_get_height(brush_tilemap);
        var tiles_ = array_create(h_);
        for (var yy_ = 0; yy_ < h_; yy_++) {
            var row_ = array_create(w_);
            for (var xx_ = 0; xx_ < w_; xx_++) {
                row_[xx_] = tilemap_get(brush_tilemap, xx_, yy_);
            }
            tiles_[yy_] = row_;
        }

        json_save(tileset_brushes_dir + tileset_get_name(brush_tileset) + ".json", {width: w_, height: h_, tiles: tiles_});
    }

    ///@desc expands room bounds and every tile layer if a placed tile is out
    ///of bounds - just _tilemap alone if it's the brush canvas instead
    tilemap_expand = function(_tilemap,_x,_y){
        var w_ = tilemap_get_tile_width(_tilemap)
        var h_ = tilemap_get_tile_height(_tilemap)

        if (_tilemap == brush_tilemap){
            if (_x+1 > tilemap_get_width(_tilemap))  tilemap_set_width(_tilemap, _x+1);
            if (_y+1 > tilemap_get_height(_tilemap)) tilemap_set_height(_tilemap, _y+1);
            return;
        }

		var w_bigger_ = (_x+1) * w_ > room_width ;
		var h_bigger_ = (_y+1) * h_ > room_height;
        if (w_bigger_ || h_bigger_){
			if(w_bigger_){
				room_width = (_x+1) * w_;
			}

			if(h_bigger_){
				room_height = (_y+1) * h_;
			}
            for (var i = 0; i < array_length(layers); i++) {
                var layer_ = layers[i];
                if(layer_.type != LAYER_TYPE.TILEMAP) continue

                var tilemap = layer_tilemap_get_id(layer_.layer)

				if(w_bigger_){
					tilemap_set_width(tilemap, room_width div w_);
				}

				if(h_bigger_){
					tilemap_set_height(tilemap, room_height div h_);
				}
            }
        }
    }

    ///@desc shrinks room bounds (or just _tilemap if it's the brush canvas)
    ///to fit the tiles actually painted, across every tile layer together
    tilemap_shrink = function(_tilemap){
        if (_tilemap == brush_tilemap){
            var tile_w_ = tilemap_get_tile_width(_tilemap);
            var tile_h_ = tilemap_get_tile_height(_tilemap);
            var tiles_w_ = tilemap_get_width(_tilemap);
            var tiles_h_ = tilemap_get_height(_tilemap);

            //floor is the canvas's own full size, not the level's - otherwise
            //it shrinks toward room_min_w/h (often smaller) on every paint
            var biggest_w_ = brush_canvas_w * tile_w_; //in pixels
            var biggest_h_ = brush_canvas_h * tile_h_;

            for (var w = 0; w < tiles_w_; w++) {
            	for (var h = 0; h < tiles_h_; h++) {
                    if ( !tile_get_empty( tilemap_get(_tilemap,w,h)) ){
                        if ((w+1) * tile_w_ > biggest_w_) biggest_w_ = (w+1) * tile_w_;
                        if ((h+1) * tile_h_ > biggest_h_) biggest_h_ = (h+1) * tile_h_;
                    }
                }
            }

            tilemap_set_width(_tilemap, biggest_w_ div tile_w_);
            tilemap_set_height(_tilemap, biggest_h_ div tile_h_);
            return;
        }

        var biggest_w_ = room_min_w; //in pixels
        var biggest_h_ = room_min_h;

        for (var i = 0; i < array_length(layers); i++) {
            var layer_ = layers[i];
            if(layer_.type != LAYER_TYPE.TILEMAP) continue

            var tilemap_ = layer_tilemap_get_id(layer_.layer)

            var tile_w_ = tilemap_get_tile_width(tilemap_);
            var tile_h_ = tilemap_get_tile_height(tilemap_);

            var tiles_w_ = room_width div tile_w_;
            var tiles_h_ = room_height div tile_h_;

            for (var w = 0; w < tiles_w_; w++) {
            	for (var h = 0; h < tiles_h_; h++) {
                    if ( !tile_get_empty( tilemap_get(tilemap_,w,h)) ){
                        if ((w+1) * tile_w_ > biggest_w_) biggest_w_ = (w+1) * tile_w_;
                        if ((h+1) * tile_h_ > biggest_h_) biggest_h_ = (h+1) * tile_h_;
                    }
                }
            }
        }
        room_width = biggest_w_;
		room_height = biggest_h_;
    }
    #endregion

    #region tools
    ///@desc dispatches to the Line/Square/Selection/Fill handlers for a hovered
    ///paintable tilemap; Draw mode stays handled inline at each call site
    tool_interact = function(_tilemap,_hover_x,_hover_y){
        switch (tool_mode) {
            case TOOL_MODE.LINE:
            case TOOL_MODE.SQUARE:
                tool_interact_shape(_tilemap,_hover_x,_hover_y);
                break;
            case TOOL_MODE.SELECTION:
                tool_interact_selection(_tilemap,_hover_x,_hover_y);
                break;
            case TOOL_MODE.FILL:
                tool_interact_fill(_tilemap,_hover_x,_hover_y);
                break;
        }
    }

    ///@desc Line/Square tool: drag then release to stamp the current brush
    ///(right mouse erases instead); state-only, see tool_draw_preview for the drag
    tool_interact_shape = function(_tilemap,_hover_x,_hover_y){
        if (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) {
            tool_drag_active = true;
            tool_drag_tilemap = _tilemap;
            tool_drag_erase = mouse_check_button_pressed(mb_right);
            tool_drag_start_x = _hover_x;
            tool_drag_start_y = _hover_y;
        }
        if (!tool_drag_active || tool_drag_tilemap != _tilemap) return;

        var is_line_ = tool_mode == TOOL_MODE.LINE;
        var released_ = tool_drag_erase ? mouse_check_button_released(mb_right) : mouse_check_button_released(mb_left);
        if (!released_) return;
        tool_drag_active = false;

        var min_x_, min_y_, max_x_, max_y_, pts_;
        if (is_line_) {
            pts_ = tile_line_points(tool_drag_start_x,tool_drag_start_y,_hover_x,_hover_y);
            min_x_ = pts_[0][0]; max_x_ = min_x_; min_y_ = pts_[0][1]; max_y_ = min_y_;
            for (var i_ = 0; i_ < array_length(pts_); i_++) {
                var px_ = pts_[i_][0], py_ = pts_[i_][1];
                if (px_ < min_x_) min_x_ = px_; if (px_ > max_x_) max_x_ = px_;
                if (py_ < min_y_) min_y_ = py_; if (py_ > max_y_) max_y_ = py_;
            }
        } else {
            min_x_ = min(tool_drag_start_x,_hover_x); max_x_ = max(tool_drag_start_x,_hover_x);
            min_y_ = min(tool_drag_start_y,_hover_y); max_y_ = max(tool_drag_start_y,_hover_y);
        }

        var w_ = max_x_-min_x_+1, h_ = max_y_-min_y_+1;
        var stamp_ = ds_grid_create(w_,h_);
        var bw_ = ds_grid_width(brush), bh_ = ds_grid_height(brush);

        if (is_line_) {
            for (var i_ = 0; i_ < array_length(pts_); i_++) {
                var px_ = pts_[i_][0]-min_x_, py_ = pts_[i_][1]-min_y_;
                ds_grid_set(stamp_, px_, py_, tool_drag_erase ? 1 : ds_grid_get(brush, px_ mod bw_, py_ mod bh_));
            }
        } else {
            for (var xx_ = 0; xx_ < w_; xx_++) {
                for (var yy_ = 0; yy_ < h_; yy_++) {
                    ds_grid_set(stamp_, xx_, yy_, tool_drag_erase ? 1 : ds_grid_get(brush, xx_ mod bw_, yy_ mod bh_));
                }
            }
        }

        if (tool_drag_erase) {
            action_erase_tile_grid(_tilemap, stamp_, min_x_, min_y_);
        } else {
            action_paste_tile_grid(_tilemap, stamp_, min_x_, min_y_);
        }
        ds_grid_destroy(stamp_);
    }

    ///@desc Selection tool: drag marks cells in selection_mask (shift extends,
    ///ctrl erases); Ctrl+C copies them to a new brush, see tool_draw_preview
    tool_interact_selection = function(_tilemap,_hover_x,_hover_y){
        if (mouse_check_button_pressed(mb_left)) {
            tool_drag_active = true;
            tool_drag_tilemap = _tilemap;
            tool_drag_start_x = _hover_x;
            tool_drag_start_y = _hover_y;

            var extend_ = keyboard_check(vk_shift) || keyboard_check(vk_control);
            if (!extend_ || selection_mask == noone || selection_tilemap != _tilemap) {
                if (selection_mask != noone) ds_grid_destroy(selection_mask);
                selection_mask = ds_grid_create(tilemap_get_width(_tilemap), tilemap_get_height(_tilemap));
                selection_tilemap = _tilemap;
            }
        }

        if (tool_drag_active && tool_drag_tilemap == _tilemap && mouse_check_button_released(mb_left)) {
            var x1_ = min(tool_drag_start_x,_hover_x), x2_ = max(tool_drag_start_x,_hover_x);
            var y1_ = min(tool_drag_start_y,_hover_y), y2_ = max(tool_drag_start_y,_hover_y);

            var erase_ = keyboard_check(vk_control);
            var mw_ = ds_grid_width(selection_mask), mh_ = ds_grid_height(selection_mask);
            var cx1_ = clamp(x1_,0,mw_-1), cx2_ = clamp(x2_,0,mw_-1);
            var cy1_ = clamp(y1_,0,mh_-1), cy2_ = clamp(y2_,0,mh_-1);
            for (var xx_ = cx1_; xx_ <= cx2_; xx_++) {
                for (var yy_ = cy1_; yy_ <= cy2_; yy_++) {
                    ds_grid_set(selection_mask, xx_, yy_, erase_ ? 0 : 1);
                }
            }
            tool_drag_active = false;
        }
    }

    ///@desc Fill tool: click flood-fills the hovered region with the brush's
    ///top-left tile; right click clears it instead (see action_fill_tiles)
    tool_interact_fill = function(_tilemap,_hover_x,_hover_y){
        if (mouse_check_button_pressed(mb_left)) {
            if (!ds_exists(brush,ds_type_grid)) return;
            action_fill_tiles(_tilemap, _hover_x, _hover_y, ds_grid_get(brush,0,0));
        } else if (mouse_check_button_pressed(mb_right)) {
            action_fill_tiles(_tilemap, _hover_x, _hover_y, 0);
        }
    }

    ///@desc draws the active tool's drag preview/selection envelope for
    ///_tilemap - call every frame from wherever it's actually rendered
    tool_draw_preview = function(_tilemap,_hover_x,_hover_y){
        var dragging_here_ = tool_drag_active && tool_drag_tilemap == _tilemap;

        if (dragging_here_ && (tool_mode == TOOL_MODE.LINE || tool_mode == TOOL_MODE.SQUARE)) {
            if (tool_mode == TOOL_MODE.LINE) {
                var pts_ = tile_line_points(tool_drag_start_x,tool_drag_start_y,_hover_x,_hover_y);
                set_draw(WHITE,0.6);
                for (var i_ = 0; i_ < array_length(pts_); i_++) {
                    draw_cell(0,0,grid_cell_w,grid_cell_h,pts_[i_][0],pts_[i_][1]);
                }
                reset_draw();
            } else {
                var x1_ = min(tool_drag_start_x,_hover_x), x2_ = max(tool_drag_start_x,_hover_x);
                var y1_ = min(tool_drag_start_y,_hover_y), y2_ = max(tool_drag_start_y,_hover_y);
                set_draw(WHITE,0.6);
                draw_rectangle(x1_*grid_cell_w, y1_*grid_cell_h, (x2_+1)*grid_cell_w, (y2_+1)*grid_cell_h, false);
                reset_draw();
            }
        }

        if (tool_mode == TOOL_MODE.SELECTION) {
            if (dragging_here_) {
                var x1_ = min(tool_drag_start_x,_hover_x), x2_ = max(tool_drag_start_x,_hover_x);
                var y1_ = min(tool_drag_start_y,_hover_y), y2_ = max(tool_drag_start_y,_hover_y);
                draw_box_selection(x1_*grid_cell_w, y1_*grid_cell_h, (x2_-x1_+1)*grid_cell_w, (y2_-y1_+1)*grid_cell_h);
            }
            if (selection_mask != noone && selection_tilemap == _tilemap) {
                draw_grid_selection(selection_mask, 0, 0, grid_cell_w, grid_cell_h);
            }
        }

        if (tool_mode == TOOL_MODE.FILL) {
            set_draw(WHITE,0.4);
            draw_cell(0,0,grid_cell_w,grid_cell_h,_hover_x,_hover_y);
            reset_draw();
        }
    }

    ///@desc copies selection_mask's cells into a new brush and switches back
    ///to Draw mode; _destroy_mask=false keeps the mask (see tool_cut_selection)
    tool_copy_selection = function(_destroy_mask = true){
        if (selection_mask == noone) return;

        var w_ = ds_grid_width(selection_mask), h_ = ds_grid_height(selection_mask);
        var min_x_ = -1, min_y_ = -1, max_x_ = -1, max_y_ = -1;
        for (var gx_ = 0; gx_ < w_; gx_++) {
            for (var gy_ = 0; gy_ < h_; gy_++) {
                if (ds_grid_get(selection_mask,gx_,gy_) == 0) continue;
                if (min_x_ == -1 || gx_ < min_x_) min_x_ = gx_;
                if (min_y_ == -1 || gy_ < min_y_) min_y_ = gy_;
                if (gx_ > max_x_) max_x_ = gx_;
                if (gy_ > max_y_) max_y_ = gy_;
            }
        }

        if (min_x_ != -1) {
            var out_ = ds_grid_create(max_x_-min_x_+1, max_y_-min_y_+1);
            for (var gx_ = min_x_; gx_ <= max_x_; gx_++) {
                for (var gy_ = min_y_; gy_ <= max_y_; gy_++) {
                    if (ds_grid_get(selection_mask,gx_,gy_) != 0) {
                        ds_grid_set(out_, gx_-min_x_, gy_-min_y_, tilemap_get(selection_tilemap,gx_,gy_));
                    }
                }
            }
            brush = out_;
            //unlike a ds_grid_pick, a copied/cut selection doesn't leave its envelope
            //showing - the selection outline itself already gave that feedback
            brush_picked_x = -1;
            brush_picked_y = -1;
            tile_picker_selected_x = -1;
            tile_picker_selected_y = -1;
        }

        if (_destroy_mask) {
            ds_grid_destroy(selection_mask);
            selection_mask = noone;
            selection_tilemap = noone;
        }
        tool_mode = TOOL_MODE.DRAW;
    }

    ///@desc like tool_copy_selection, but also erases the copied cells from
    ///the level/canvas afterward
    tool_cut_selection = function(){
        if (selection_mask == noone) return;

        var tilemap_ = selection_tilemap;
        var mask_ = selection_mask;
        tool_copy_selection(false);

        action_erase_tile_grid(tilemap_, mask_, 0, 0);
        ds_grid_destroy(mask_);
        selection_mask = noone;
        selection_tilemap = noone;
    }

    ///@desc erases the selected cells without copying them to the brush -
    ///stays in Selection mode, unlike copy/cut
    tool_delete_selection = function(){
        if (selection_mask == noone) return;

        action_erase_tile_grid(selection_tilemap, selection_mask, 0, 0);
        ds_grid_destroy(selection_mask);
        selection_mask = noone;
        selection_tilemap = noone;
    }
    #endregion

    #region instance actions
    ///@desc true if some other placed instance (any _exclude_uid) already
    ///uses _name as its element_name
    element_name_taken = function(_name, _exclude_uid = noone){
        var taken_ = false;
        with (obj_editor_instance) {
            if (element_uid != _exclude_uid && element_name == _name) taken_ = true;
        }
        return taken_;
    }

    ///@desc first free "_base_name_N" - the default element_name a freshly
    ///placed instance gets
    generate_element_name = function(_base_name){
        var n_ = 1;
        var name_ = _base_name + "_" + string(n_);
        while (element_name_taken(name_)) {
            n_ += 1;
            name_ = _base_name + "_" + string(n_);
        }
        return name_;
    }

    ///@desc spawns an obj_editor_instance for _object_name at (_x,_y) on
    ///layer_active; _custom_variables overrides its instance_variables defaults
    action_place_instance = function(_object_name,_x,_y,_record=true,_custom_variables=undefined,_element_name=undefined,_custom_connections=undefined){
		var obj_ = asset_get_index(_object_name)

		var obj_sprite_ = object_get_sprite(obj_);
		var obj_mask_ = object_get_mask(obj_);
		var has_sprite_ = obj_sprite_ != undefined && obj_sprite_ != -1;

        //object_name/element_name/pending_variable_values go through the
        //creation struct, so editor_variable_* sees a saved value right away
        var inst_ = instance_create_layer(_x, _y, layer_active.layer, obj_editor_instance, {
            object_name : _object_name,
            element_name : _element_name != undefined ? _element_name : generate_element_name(_object_name),
            parralax_x : layer_active.parralax_x,
            parralax_y : layer_active.parralax_y,
            sprite_index : has_sprite_ ? obj_sprite_ : spr_instance_sprite,
            mask_index : has_sprite_ ? obj_mask_ : spr_instance_sprite,
            pending_variable_values : _custom_variables != undefined ? _custom_variables : {},
            pending_io_connections : _custom_connections != undefined ? _custom_connections : [],
            sort_index : next_sort_index(layer_active.layer),
        });

        element_active = inst_; //selected immediately, so it can be repositioned right away

        var inverse_ = {fn: action_remove_instance, args: [inst_.element_uid, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc spawns an obj_editor_sprite for _sprite_name at (_x,_y) on
    ///layer_active; self-inverting via action_remove_instance
    action_place_sprite = function(_sprite_name,_x,_y,_record=true){
        var sprite_ = asset_get_index(_sprite_name)
        var inst_ = instance_create_layer(_x, _y, layer_active.layer, obj_editor_sprite);
        inst_.sprite_name = _sprite_name;
        inst_.sprite_index = sprite_;
        inst_.mask_index = sprite_;
        inst_.parralax_x = layer_active.parralax_x;
        inst_.parralax_y = layer_active.parralax_y;
        inst_.sort_index = next_sort_index(layer_active.layer);

        element_active = inst_; //selected immediately, so it can be repositioned right away

        var inverse_ = {fn: action_remove_instance, args: [inst_.element_uid, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc removes the element identified by _uid (element_uid, not a raw
    ///id - see action_transform_instance); inverse is action_restore_instance
    action_remove_instance = function(_uid,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;

        if (inst_.editor_only && variable_instance_exists(inst_,"linked_uid") && inst_.linked_uid != noone) {
            return action_remove_instance(inst_.linked_uid, _record);
        }

        var data_ = {
            object_index: inst_.object_index,
            object_name: variable_instance_exists(inst_,"object_name") ? inst_.object_name : "",
            sprite_name: variable_instance_exists(inst_,"sprite_name") ? inst_.sprite_name : "",
            element_name: variable_instance_exists(inst_,"element_name") ? inst_.element_name : "",
            element_uid: inst_.element_uid,
            layer: inst_.layer,
            x: inst_.x, y: inst_.y,
            image_xscale: inst_.image_xscale, image_yscale: inst_.image_yscale,
            image_angle: inst_.image_angle,
            sprite_index: inst_.sprite_index,
            mask_index: inst_.mask_index,
            parralax_x: inst_.parralax_x,
            parralax_y: inst_.parralax_y,
            sort_index: variable_instance_exists(inst_,"sort_index") ? inst_.sort_index : 0,
            instance_variables: {},
            io_connections: variable_instance_exists(inst_,"io_connections") ? inst_.io_connections : [],
        };
        if (variable_instance_exists(inst_,"instance_variables")) {
            var var_names_ = variable_struct_get_names(inst_.instance_variables);
            for (var i_ = 0; i_ < array_length(var_names_); i_++) {
                var var_name_ = var_names_[i_];
                variable_struct_set(data_.instance_variables, var_name_, inst_.instance_variables[$ var_name_].value);
            }
        }

        if (element_active == inst_) element_active = noone;
        var sel_index_ = array_get_index(elements_selected, inst_);
        if (sel_index_ != -1) array_delete(elements_selected, sel_index_, 1);

        instance_destroy(inst_);

        var inverse_ = {fn: action_restore_instance, args: [data_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc recreates an instance from _data (captured by
    ///action_remove_instance). Its inverse is action_remove_instance again
    action_restore_instance = function(_data,_record=true){
        //object_name/sprite_name/pending_variable_values go through the
        //creation struct, so editor_variable_* sees a restored value right away
        var vars_ = {
            sprite_index : _data.sprite_index,
            mask_index : _data.mask_index,
            image_xscale : _data.image_xscale,
            image_yscale : _data.image_yscale,
            image_angle : _data.image_angle,
            parralax_x : _data.parralax_x,
            parralax_y : _data.parralax_y,
            sort_index : _data.sort_index,
            pending_variable_values : _data.instance_variables,
            pending_io_connections : _data.io_connections,
        };
        if (_data.object_name != "") vars_.object_name = _data.object_name;
        if (_data.sprite_name != "") vars_.sprite_name = _data.sprite_name;
        if (_data.element_name != "") vars_.element_name = _data.element_name;

        var inst_ = instance_create_layer(_data.x, _data.y, _data.layer, _data.object_index, vars_);

        //restores the original element_uid over the fresh one Create_0 assigned,
        //so anything still referring to this element by uid still finds it
        inst_.element_uid = _data.element_uid;
        element_active = inst_;

        var inverse_ = {fn: action_remove_instance, args: [inst_.element_uid, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc finds the live obj_asset_transform-descendant with element_uid ==
    ///_uid, or noone if it doesn't currently exist (eg its placement was undone)
    find_element_by_uid = function(_uid){
        with (obj_asset_transform) {
            if (element_uid == _uid) return id;
        }
        return noone;
    }

    ///@desc finds the live obj_editor_instance with element_name == _name -
    ///noone if there isn't one. See editor_variable_ref/REFERENCE fields
    find_element_by_name = function(_name){
        with (obj_editor_instance) {
            if (element_name == _name) return id;
        }
        return noone;
    }

    ///@desc the layers[] entry whose raw layer id is _raw_layer - undefined
    ///if none matches
    find_layer_by_layer_id = function(_raw_layer){
        for (var i_ = 0; i_ < array_length(layers); i_++) {
            if (layers[i_].layer == _raw_layer) return layers[i_];
        }
        return undefined;
    }

    ///@desc a single comparable number for _inst's real-game placement order
    ///(layer index, then sort_index within it) - lower means placed earlier.
    ///REFERENCE fields only resolve against instances placed earlier than
    ///the one holding the reference (see load_level.gml)
    element_placement_rank = function(_inst){
        var layer_ = find_layer_by_layer_id(_inst.layer);
        var layer_index_ = layer_ != undefined ? array_get_index(layers, layer_) : 0;
        var sort_index_ = variable_instance_exists(_inst,"sort_index") ? _inst.sort_index : 0;
        return layer_index_ * 1000000 + sort_index_;
    }

    ///@desc every obj_asset_transform on _raw_layer, sorted by sort_index -
    ///the Elements list and level_serialize (real-game creation order) read this
    sorted_layer_elements = function(_raw_layer){
        var arr_ = [];
        with (obj_asset_transform) {
            if (layer == _raw_layer) array_push(arr_, id);
        }
        array_sort(arr_, function(_a, _b){ return _a.sort_index - _b.sort_index; });
        return arr_;
    }

    ///@desc one past the highest sort_index currently on _raw_layer (0 if
    ///none) - appends a freshly placed element to the end of its layer's order
    next_sort_index = function(_raw_layer){
        var max_ = -1;
        with (obj_asset_transform) {
            if (layer == _raw_layer && sort_index > max_) max_ = sort_index;
        }
        return max_ + 1;
    }

    ///@desc swaps sort_index between two elements (Elements list reordering) -
    ///self-inverting: calling it again with the same pair undoes it
    action_swap_sort_index = function(_uid_a, _uid_b, _record=true){
        var a_ = find_element_by_uid(_uid_a);
        var b_ = find_element_by_uid(_uid_b);
        if (a_ == noone || b_ == noone) return undefined;

        var tmp_ = a_.sort_index;
        a_.sort_index = b_.sort_index;
        b_.sort_index = tmp_;
        level_dirty = true;

        var inverse_ = {fn: action_swap_sort_index, args: [_uid_a, _uid_b, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc sets one element's sort_index directly (Elements list's "move to
    ///top"/"move to bottom") - self-inverting
    action_set_sort_index = function(_uid, _value, _record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;
        if (inst_.sort_index == _value) return undefined;

        var old_value_ = inst_.sort_index;
        inst_.sort_index = _value;
        level_dirty = true;

        var inverse_ = {fn: action_set_sort_index, args: [_uid, old_value_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc pans the camera to the current selection, no-op with nothing
    ///selected - updates camera_x/camera_y too, since Step_1's pan reads those
    goto_selected = function(){
        if (element_active == noone) return;
        camera_x = element_active.x;
        camera_y = element_active.y;
        global.camera.move(camera_x, camera_y, SECOND*0.5);
    }

    ///@desc true if _accepted_objects is empty (anything goes) or
    ///_object_index is/descends from one of them
    element_reference_object_accepted = function(_object_index, _accepted_objects){
        if (array_length(_accepted_objects) == 0) return true;
        for (var i_ = 0; i_ < array_length(_accepted_objects); i_++) {
            var accepted_ = _accepted_objects[i_];
            if (_object_index == accepted_ || object_is_ancestor(_object_index, accepted_)) return true;
        }
        return false;
    }

    ///@desc true if _name names a real, non-self element whose object type
    ///passes _accepted_objects (see editor_variable_ref)
    element_reference_valid = function(_name, _accepted_objects, _self_uid){
        var target_ = find_element_by_name(_name);
        if (target_ == noone || target_.element_uid == _self_uid) return false;
        return element_reference_object_accepted(asset_get_index(target_.object_name), _accepted_objects);
    }

    ///@desc applies _after's transform to the element identified by _uid -
    ///commits a completed move/rotate/scale drag; self-inverting via _before
    action_transform_instance = function(_uid,_before,_after,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;

        inst_.x = _after.x;
        inst_.y = _after.y;
        inst_.image_xscale = _after.image_xscale;
        inst_.image_yscale = _after.image_yscale;
        inst_.image_angle = _after.image_angle;

        var inverse_ = {fn: action_transform_instance, args: [_uid, _after, _before, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc sets one instance_variables entry's value (Inspector's Custom
    ///Variables section) on the element identified by _uid; self-inverting
    action_set_variable = function(_uid,_var_name,_value,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;
        if (!variable_struct_exists(inst_.instance_variables, _var_name)) return undefined;

        var old_value_ = inst_.instance_variables[$ _var_name].value;
        if (old_value_ == _value) return undefined;

        inst_.instance_variables[$ _var_name].value = _value;
        level_dirty = true;

        var inverse_ = {fn: action_set_variable, args: [_uid, _var_name, old_value_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc sets _var_name to _value on every currently selected element that
    ///has a matching instance_variables entry for it, as one combined undo
    ///step - degrades to a plain single-element action_set_variable when
    ///only one element is selected (see get_selected_elements)
    action_set_variable_selected = function(_var_name, _value){
        var targets_ = get_selected_elements();
        var entries_ = [];
        for (var i_ = 0; i_ < array_length(targets_); i_++) {
            var inst_ = targets_[i_];
            if (!variable_instance_exists(inst_,"instance_variables")) continue;
            if (!variable_struct_exists(inst_.instance_variables, _var_name)) continue;
            array_push(entries_, {fn: action_set_variable, args: [inst_.element_uid, _var_name, _value, false]});
        }

        var inverse_ = action_run_many(entries_);
        if (inverse_ != undefined) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc true if every element in _targets has an instance_variables entry
    ///named _var_name of the same _type - drives which fields the Inspector
    ///shows when multiple elements with different variables are selected
    variable_shared_across_selection = function(_var_name, _type, _targets){
        for (var i_ = 0; i_ < array_length(_targets); i_++) {
            var inst_ = _targets[i_];
            if (!variable_instance_exists(inst_,"instance_variables")) return false;
            if (!variable_struct_exists(inst_.instance_variables, _var_name)) return false;
            if (inst_.instance_variables[$ _var_name].type != _type) return false;
        }
        return true;
    }

    ///@desc appends one io_connections entry to the element identified by
    ///_uid (Outputs window's Add/Apply); self-inverting via action_remove_connection
    action_add_connection = function(_uid,_connection,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;

        array_push(inst_.io_connections, _connection);
        level_dirty = true;

        var inverse_ = {fn: action_remove_connection, args: [_uid, array_length(inst_.io_connections)-1, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc removes the io_connections entry at _index on the element
    ///identified by _uid; self-inverting via action_insert_connection
    action_remove_connection = function(_uid,_index,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;
        if (_index < 0 || _index >= array_length(inst_.io_connections)) return undefined;

        var removed_ = inst_.io_connections[_index];
        array_delete(inst_.io_connections, _index, 1);
        level_dirty = true;

        var inverse_ = {fn: action_insert_connection, args: [_uid, _index, removed_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc re-inserts _connection at _index - the undo half of
    ///action_remove_connection; self-inverting via action_remove_connection
    action_insert_connection = function(_uid,_index,_connection,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;

        array_insert(inst_.io_connections, _index, _connection);
        level_dirty = true;

        var inverse_ = {fn: action_remove_connection, args: [_uid, _index, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc replaces one io_connections row wholesale (Outputs window's
    ///Apply commits a whole edited row at once); self-inverting
    action_set_connection = function(_uid,_index,_connection,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;
        if (_index < 0 || _index >= array_length(inst_.io_connections)) return undefined;

        var old_connection_ = inst_.io_connections[_index];
        inst_.io_connections[_index] = _connection;
        level_dirty = true;

        var inverse_ = {fn: action_set_connection, args: [_uid, _index, old_connection_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc renames the element identified by _uid (Inspector's Name field) -
    ///rejects blank/unchanged/taken names rather than auto-suffixing
    action_set_element_name = function(_uid,_name,_record=true){
        var inst_ = find_element_by_uid(_uid);
        if (inst_ == noone) return undefined;

        var trimmed_ = string_trim(_name);
        if (trimmed_ == "" || trimmed_ == inst_.element_name) return undefined;
        if (element_name_taken(trimmed_, _uid)) return undefined;

        var old_name_ = inst_.element_name;
        inst_.element_name = trimmed_;
        level_dirty = true;

        var inverse_ = {fn: action_set_element_name, args: [_uid, old_name_, false]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc returns the currently selected elements (elements_selected plus
    ///element_active, deduplicated, filtered to those still existing)
    get_selected_elements = function(){
        var targets_ = [];
        for (var i_ = 0; i_ < array_length(elements_selected); i_++) {
            if (instance_exists(elements_selected[i_])) array_push(targets_, elements_selected[i_]);
        }
        if (element_active != noone && instance_exists(element_active) && array_get_index(targets_, element_active) == -1) {
            array_push(targets_, element_active);
        }
        return targets_;
    }

    ///@desc applies _mutate_fn(_inst) to every selected element (Mirror/Flip/
    ///Rotate 90 toolbar buttons), combined into one undo step via action_run_many
    action_transform_selected = function(_mutate_fn){
        var targets_ = get_selected_elements();

        var entries_ = [];
        for (var i_ = 0; i_ < array_length(targets_); i_++) {
            var inst_ = targets_[i_];
            var before_ = {x:inst_.x, y:inst_.y, image_xscale:inst_.image_xscale, image_yscale:inst_.image_yscale, image_angle:inst_.image_angle};
            _mutate_fn(inst_);
            var after_ = {x:inst_.x, y:inst_.y, image_xscale:inst_.image_xscale, image_yscale:inst_.image_yscale, image_angle:inst_.image_angle};
            array_push(entries_, {fn: action_transform_instance, args: [inst_.element_uid, before_, after_, false]});
        }

        //action_run_many only returns the combined inverse, it doesn't push it
        //itself (same as action_paste_tile_grid) - has to happen here to record it
        var inverse_ = action_run_many(entries_);
        if (inverse_ != undefined) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc deletes every selected element as a single undo step (DEL key) -
    ///same action_run_many pattern as action_transform_selected
    action_delete_selected = function(){
        var targets_ = get_selected_elements();
        if (array_length(targets_) == 0) return undefined;

        var entries_ = [];
        for (var i_ = 0; i_ < array_length(targets_); i_++) {
            array_push(entries_, {fn: action_remove_instance, args: [targets_[i_].element_uid, false]});
        }

        var inverse_ = action_run_many(entries_);
        if (inverse_ != undefined) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }

    ///@desc Ctrl+X: copies then deletes the selection - the delete is the
    ///undo step (see action_delete_selected), copying isn't tracked on its own
    action_cut_selected = function(){
        action_copy_selected();
        return action_delete_selected();
    }

    ///@desc captures the currently selected elements into clipboard for
    ///action_paste_clipboard (Ctrl+C) - not an undo step, copying changes nothing
    action_copy_selected = function(){
        var targets_ = get_selected_elements();
        if (array_length(targets_) == 0) return;

        //anchor is the group's average position, so pasting centers the whole
        //group on the mouse instead of whichever element was copied first
        var anchor_x_ = 0, anchor_y_ = 0;
        for (var i_ = 0; i_ < array_length(targets_); i_++) {
            anchor_x_ += targets_[i_].x;
            anchor_y_ += targets_[i_].y;
        }
        anchor_x_ /= array_length(targets_);
        anchor_y_ /= array_length(targets_);

        clipboard = [];
        for (var i_ = 0; i_ < array_length(targets_); i_++) {
            var inst_ = targets_[i_];

            //custom variable values, keyed by name - action_place_instance
            //feeds this straight into pending_variable_values on paste
            var vars_ = {};
            if (variable_instance_exists(inst_,"instance_variables")) {
                var var_names_ = variable_struct_get_names(inst_.instance_variables);
                for (var vi_ = 0; vi_ < array_length(var_names_); vi_++) {
                    var var_name_ = var_names_[vi_];
                    variable_struct_set(vars_, var_name_, inst_.instance_variables[$ var_name_].value);
                }
            }

            //each row cloned individually - inst_.io_connections stays live
            //on the original, so pasting must not end up sharing its structs
            var connections_ = [];
            if (variable_instance_exists(inst_,"io_connections")) {
                for (var ci_ = 0; ci_ < array_length(inst_.io_connections); ci_++) {
                    array_push(connections_, variable_clone(inst_.io_connections[ci_]));
                }
            }

            array_push(clipboard, {
                object_index: inst_.object_index,
                object_name: variable_instance_exists(inst_,"object_name") ? inst_.object_name : "",
                sprite_name: variable_instance_exists(inst_,"sprite_name") ? inst_.sprite_name : "",
                offset_x: inst_.x - anchor_x_,
                offset_y: inst_.y - anchor_y_,
                image_xscale: inst_.image_xscale,
                image_yscale: inst_.image_yscale,
                image_angle: inst_.image_angle,
                vars: vars_,
                io_connections: connections_,
            });
        }
    }

    ///@desc pastes clipboard as new elements centered on (_x,_y), matching
    ///layer_active's type, and selects them as a group (Ctrl+V)
    action_paste_clipboard = function(_x,_y,_record=true){
        if (array_length(clipboard) == 0 || layer_active == undefined) return undefined;
        if (layer_active.type != LAYER_TYPE.INSTANCE && layer_active.type != LAYER_TYPE.ASSET) return undefined;

        var entries_ = [];
        var pasted_ = [];
        for (var i_ = 0; i_ < array_length(clipboard); i_++) {
            var data_ = clipboard[i_];
            var is_instance_ = data_.object_index == obj_editor_instance;
            if (is_instance_ && layer_active.type != LAYER_TYPE.INSTANCE) continue;
            if (!is_instance_ && layer_active.type != LAYER_TYPE.ASSET) continue;

            var px_ = _x + data_.offset_x;
            var py_ = _y + data_.offset_y;
            var place_inverse_ = is_instance_
                ? action_place_instance(data_.object_name, px_, py_, false, data_.vars, undefined, data_.io_connections)
                : action_place_sprite(data_.sprite_name, px_, py_, false);

            //action_place_instance/_sprite's inverse carries an element_uid, not a
            //raw instance - grab it via element_active, already set before returning
            var inst_ = element_active;
            inst_.image_xscale = data_.image_xscale;
            inst_.image_yscale = data_.image_yscale;
            inst_.image_angle = data_.image_angle;

            array_push(entries_, place_inverse_);
            array_push(pasted_, inst_);
        }

        if (array_length(entries_) == 0) return undefined;

        elements_selected = pasted_;
        element_active = pasted_[array_length(pasted_) - 1];

        var inverse_ = {fn: action_run_many, args: [entries_]};
        if (_record) {
            array_push(undo_stack, inverse_)
            redo_stack = []
        }
        return inverse_;
    }
    #endregion

    #region resources
    ///@desc recursively finds every .smf file under _dir (relative to the game's data root)
    scan_smf_files = function(_dir){
        var out_ = [];
        
        var file_ = file_find_first(_dir + "/"+"*.smf", 0);
        
        while (file_ != "") {
            
            array_push(out_, _dir + "/" + file_);
            
            file_ = file_find_next();
            
        }
        file_find_close();
        
        var subdirs_ = [];
        var entry_ = file_find_first(_dir + "/"+"*", fa_directory);
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
    
    ///@desc swaps the 3D model viewer to a different .smf file, destroying whatever was previously loaded
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
    
    ///@desc re-runs the pre-build step (reads the .yyp fresh and rewrites
    ///datafiles/editor/resource_tree.json), then reloads resource_tree from it
    regenerate_resource_tree = function(){
        //execute_shell_simple launches async with no way to wait for completion,
        //so the reload is deferred to give node time to finish rewriting the file
        execute_shell_simple(resource_tree_bat_path);
        call_later(2, time_source_units_seconds, function(){
            resource_tree = json_load(root_path + "editor/resource_tree.json").folders;
        });
    }

    ///@desc finds a top-level folder in resource_tree by name (eg "Objects") -
    ///undefined if not found; jumps straight into it for single-folder layer types
    resource_tree_find_folder = function(_name){
        for (var i_ = 0; i_ < array_length(resource_tree); i_++) {
            if (resource_tree[i_].name == _name) return resource_tree[i_];
        }
        return undefined;
    }

    ///@desc true if _folder (or any folder nested inside it) contains a
    ///resource of _type - used to skip folders with nothing relevant to show
    resource_folder_has_type = function(_folder, _type){
        for (var i_ = 0; i_ < array_length(_folder.resources); i_++) {
            var res_ = _folder.resources[i_];
            if (res_.type == _type && !asset_has_tags(res_.name, "editor_exclude")) return true;
        }
        for (var i_ = 0; i_ < array_length(_folder.folders); i_++) {
            if (resource_folder_has_type(_folder.folders[i_], _type)) return true;
        }
        return false;
    }
    
    ///@desc recursively draws _folders/_resources as a tree, showing only
    ///resources matching _type; _on_click(name) fires when a leaf is clicked
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
            if (asset_has_tags(res_.name, "editor_exclude")) continue;
			var index_ = asset_get_index(res_.name);
			if(index_ == -1) continue;

            //objects/sprites show a tiny preview image instead of a bullet
            var flags_ = ImGuiTreeNodeFlags.Leaf | ImGuiTreeNodeFlags.NoTreePushOnOpen;
            var icon_size_, sprite_;
            if (_type == "object") {
                icon_size_ = ImGui.GetFrameHeight();
                sprite_ = object_get_sprite(index_);
                if (sprite_ == -1) sprite_ = spr_instance_sprite;
                ImGui.Image(sprite_, 0, c_white, 1, icon_size_, icon_size_);
                ImGui.SameLine();
            } else if (_type == "sprite") {
                icon_size_ = ImGui.GetFrameHeight();
                sprite_ = index_;
                ImGui.Image(sprite_, 0, c_white, 1, icon_size_, icon_size_);
                ImGui.SameLine();
            } else {
                flags_ |= ImGuiTreeNodeFlags.Bullet;
            }
            if (_selected_name != undefined && res_.name == _selected_name) flags_ |= ImGuiTreeNodeFlags.Selected;

            ImGui.TreeNodeEx(res_.name, flags_);
            if (_on_click != undefined && ImGui.IsItemClicked()) {
                _on_click(res_.name);
            }

            //objects/sprites can be dragged into the viewport to place one, via
            //action_place_instance/_sprite once dropped (see Step_1.gml)
            var payload_type_ = _type == "object" ? "object_drag" : (_type == "sprite" ? "sprite_drag" : "");
            if (payload_type_ != "" && ImGui.BeginDragDropSource()) {
                ImGui.SetDragDropPayload(payload_type_, res_.name);
                ImGui.Image(sprite_, 0, c_white, 1, icon_size_, icon_size_);
                ImGui.SameLine();
                ImGui.Text(res_.name);
                ImGui.EndDragDropSource();
            }
        }
    }
    
    ///@desc debug window: draws every folder/resource unfiltered, labeled with
    ///its type, for eyeballing that resource_tree matches the actual project
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
    
    #endregion

    #region imgui helpers
        ///@desc draws a square icon button from ICON, sized to the current frame
        ///height (matching adjacent widgets) unless _size is given explicitly
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

        ///@desc thin drag strip on the window's right (or left) edge - returns raw
        ///mouse dx while dragged, or 0; only sets the resize cursor, never resets it
        panel_resize_handle = function(_right_edge){
            var handle_w_ = 4;
            var x_ = ImGui.GetWindowPosX() + (_right_edge ? ImGui.GetWindowWidth()-handle_w_ : 0);
            ImGui.SetCursorScreenPos(x_, ImGui.GetWindowPosY());
            ImGui.InvisibleButton(_right_edge ? "##ResizeR" : "##ResizeL", handle_w_, ImGui.GetWindowHeight());

            if (ImGui.IsItemHovered() || ImGui.IsItemActive()) {
                window_set_cursor(cr_size_we);
            }
            return ImGui.IsItemActive() ? window_mouse_get_delta_x() : 0;
        }

        ///@desc a compact toggle switch - same call convention as ImGui.Checkbox:
        ///pass the current bool, get back the new one after handling a click
        toggle_switch = function(_value, _id_suffix = "", _height = 0){
            if (_height <= 0) _height = ImGui.GetFrameHeight();
            var width_ = _height * 1.75;
            var radius_ = _height * 0.5 - 2;

            if (_id_suffix != "") ImGui.PushID(_id_suffix);
            var start_x_ = ImGui.GetCursorScreenPosX();
            var start_y_ = ImGui.GetCursorScreenPosY();
            var clicked_ = ImGui.InvisibleButton("##toggle", width_, _height);
            var hovered_ = ImGui.IsItemHovered();
            if (_id_suffix != "") ImGui.PopID();

            if (clicked_) _value = !_value;

            var draw_list_ = ImGui.GetWindowDrawList();
            var track_col_ = _value ? c_dkgray : c_gray;
            var track_alpha_ = hovered_ ? 0.8 : 0.6;
            ImGui.DrawListAddRectFilled(draw_list_, start_x_, start_y_, start_x_ + width_, start_y_ + _height, track_col_, track_alpha_, _height * 0.5);

            var knob_x_ = _value ? start_x_ + width_ - _height * 0.5 : start_x_ + _height * 0.5;
            var knob_y_ = start_y_ + _height * 0.5;
            ImGui.DrawListAddCircleFilled(draw_list_, knob_x_, knob_y_, radius_, c_white, 1);

            return _value;
        }

        ///@desc draws the widget matching _type (FLOAT/BOOL/STRING/LIST) for
        ///_value and returns the edited value - shared by the Custom Variables
        ///switch and the Outputs window's parameter field, so both render a
        ///typed value the same way without duplicating each widget's code
        draw_typed_value_field = function(_id, _type, _value, _minimum=undefined, _maximum=undefined, _options=undefined){
            switch (_type) {
                case EDITOR_VARIABLE_TYPES.FLOAT:
                    var new_value_ = ImGui.InputFloat(_id, _value);
                    if (_minimum != undefined) new_value_ = max(new_value_, _minimum);
                    if (_maximum != undefined) new_value_ = min(new_value_, _maximum);
                    return new_value_;
                case EDITOR_VARIABLE_TYPES.INT:
                    var new_int_ = ImGui.InputInt(_id, _value);
                    if (_minimum != undefined) new_int_ = max(new_int_, _minimum);
                    if (_maximum != undefined) new_int_ = min(new_int_, _maximum);
                    return new_int_;
                case EDITOR_VARIABLE_TYPES.BOOL:
                    return ImGui.Checkbox(_id, _value);
                case EDITOR_VARIABLE_TYPES.STRING:
                    return ImGui.InputText(_id, _value);
                case EDITOR_VARIABLE_TYPES.LIST:
                    //_value is the selected option's index, not the string itself
                    var new_index_ = _value;
                    var preview_ = (_value >= 0 && _value < array_length(_options)) ? _options[_value] : "";
                    if (ImGui.BeginCombo(_id, preview_, ImGuiComboFlags.None)) {
                        for (var oi_ = 0; oi_ < array_length(_options); oi_++) {
                            if (ImGui.Selectable(_options[oi_], oi_ == _value)) new_index_ = oi_;
                        }
                        ImGui.EndCombo();
                    }
                    return new_index_;
            }
            return _value;
        }

    #endregion

    #region action funcs
        //Every action_* function performs its change and returns its own
        //inverse as a plain {fn, args} struct, for the undo redo stack

        ///@desc pops and performs the most recent action's inverse, then
        ///files ITS inverse (ie the original action) onto redo_stack
        action_undo = function(){
            if (array_length(undo_stack) <= 0) return;
            var entry_ = array_pop(undo_stack);
            var inverse_ = script_execute_ext(entry_.fn, entry_.args);
            if (inverse_ != undefined) array_push(redo_stack, inverse_);
        }

        ///@desc re-applies the most recently undone action, then files its
        ///inverse back onto undo_stack
        action_redo = function(){
            if (array_length(redo_stack) <= 0) return;
            var entry_ = array_pop(redo_stack);
            var inverse_ = script_execute_ext(entry_.fn, entry_.args);
            if (inverse_ != undefined) array_push(undo_stack, inverse_);
        }

        ///@desc returns _base, or _base with a number suffix if already taken -
        ///duplicate names break GameMaker's own by-name layer lookups
        unique_layer_name = function(_base){
            var name_ = _base;
            var n_ = 1;
            while (true) {
                var taken_ = false;
                for (var i_ = 0; i_ < array_length(layers); i_++) {
                    if (layers[i_].name == name_) { taken_ = true; break; }
                }
                if (!taken_) return name_;
                n_ += 1;
                name_ = _base + " " + string(n_);
            }
        }

        ///@desc add a new layer. Its inverse is removing it again
        //_collision marks a tileset-locked layer (collision_A/B/C) - only
        //those keep respecting _always for tileset editing
        action_add_layer = function(_name,_depth,_type,_always=false,_color=BLACK,_collision=false,_record=true){
            var layer_ = {
                name : _name,
                parralax_x : 16,
                parralax_y : 16,
                type : _type,
                layer : layer_create(_depth, _name),
                always : _always,
                visible : true,
                locked : false,
                color : _color,
                collision : _collision,
                fx_index : 0,
                fx_params : [],
            }

            if(_type == LAYER_TYPE.TILEMAP){
                layer_.tileset = ts_collisions
                var tileset_info_ = tileset_get_info(layer_.tileset)

                var w_ = room_width div tileset_info_.tile_width;
                var h_ = room_height div tileset_info_.tile_height;
                layer_.tilemap = layer_tilemap_create(layer_.layer,0,0,layer_.tileset,w_, h_);
				layer_.obj_tilemap = instance_create_depth(0,0,_depth,obj_tilemap,{
					layer_name: layer_.name,
					parralax_x: layer_.parralax_x,
					parralax_y: layer_.parralax_y,
				});
				layer_.obj_tilemap.visible = layer_.visible;
            }

            if(_type == LAYER_TYPE.BACKGROUND){
                layer_.obj_background = instance_create_layer(0,0,layer_.layer,obj_background,{
                    sprite_index: -1,
                    parralax_x: layer_.parralax_x,
                    parralax_y: layer_.parralax_y,
                });
            }

            array_push(layers,layer_)
            layers_depth_order()

            var inverse_ = {fn: action_remove_layer, args: [layer_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = [] //this is a new branch of history - the old redo path no longer applies
            }
            return inverse_;
        }

        ///@desc removes _layer (layers marked "always" can't be). Its
        ///inverse is recreating it (action_restore_layer)
        action_remove_layer = function(_layer,_record=true){
            if (_layer.always) return undefined;

            var index_ = array_get_index(layers,_layer)
            if (index_ == -1) return undefined;

            var depth_ = layer_get_depth(_layer.layer)

            //captures every placed element so restoring it (undo) can recreate them -
            //layer_destroy below also destroys any instances on an instance layer
            var elements_ = [];
            with (obj_asset_transform) {
                if (layer != _layer.layer) continue;
                array_push(elements_, {
                    object_index: object_index,
                    object_name: variable_instance_exists(id,"object_name") ? object_name : "",
                    x: x, y: y,
                    image_xscale: image_xscale, image_yscale: image_yscale,
                    image_angle: image_angle,
                });
            }
			var obj_tilemap_ = struct_get(_layer,"obj_tilemap");
			if(obj_tilemap_ != undefined){
				instance_destroy(obj_tilemap_);
			}

            //captured before layer_destroy - obj_background lives on _layer.layer
            //itself, so layer_destroy below takes it out along with the layer
            var background_data_ = undefined;
            if (_layer.type == LAYER_TYPE.BACKGROUND && instance_exists(_layer.obj_background)) {
                background_data_ = {
                    sprite_index: _layer.obj_background.sprite_index,
                    background_mode: _layer.obj_background.background_mode,
                    x: _layer.obj_background.x,
                    y: _layer.obj_background.y,
                };
            }

            layer_fx_clear(_layer.layer)

            layer_destroy(_layer.layer)
            array_delete(layers,index_,1)

            if (layer_active == _layer) {
                if (array_length(layers) > 0) {
                    layer_index = min(layer_index, array_length(layers)-1)
                    set_layer()
                } else {
                    layer_active = undefined
                    layer_index = 0
                    collision_layer = -1;
                }
            }

            var inverse_ = {fn: action_restore_layer, args: [_layer, depth_, elements_, background_data_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc re-creates a previously-removed _layer (fresh room layer/tilemap)
        ///plus its _elements (captured by action_remove_layer); inverse removes it
        action_restore_layer = function(_layer,_depth,_elements=[],_background_data=undefined,_record=true){
            _layer.layer = layer_create(_depth,_layer.name)
            layer_set_visible(_layer.layer,_layer.visible)

            if (_layer.type == LAYER_TYPE.TILEMAP) {
                var tileset_info_ = tileset_get_info(_layer.tileset)
                var w_ = room_width div tileset_info_.tile_width;
                var h_ = room_height div tileset_info_.tile_height;
                _layer.tilemap = layer_tilemap_create(_layer.layer,0,0,_layer.tileset,w_,h_);
				_layer.obj_tilemap = instance_create_depth(0,0,_depth,obj_tilemap,{
					layer_name: _layer.name,
					parralax_x: _layer.parralax_x,
					parralax_y: _layer.parralax_y,
				});
				_layer.obj_tilemap.visible = _layer.visible;
            }

            if (_layer.type == LAYER_TYPE.BACKGROUND) {
                _layer.obj_background = instance_create_layer(
                    _background_data != undefined ? _background_data.x : 0,
                    _background_data != undefined ? _background_data.y : 0,
                    _layer.layer, obj_background, {
                        sprite_index: _background_data != undefined ? _background_data.sprite_index : -1,
                        background_mode: _background_data != undefined ? _background_data.background_mode : BACKGROUND_MODE.NONE,
                        parralax_x: _layer.parralax_x,
                        parralax_y: _layer.parralax_y,
                    });
            }

            for (var i_ = 0; i_ < array_length(_elements); i_++) {
                var e_ = _elements[i_];
                var inst_ = instance_create_layer(e_.x, e_.y, _layer.layer, e_.object_index);
                inst_.image_xscale = e_.image_xscale;
                inst_.image_yscale = e_.image_yscale;
                inst_.image_angle = e_.image_angle;
                if (e_.object_name != "") inst_.object_name = e_.object_name;
            }

            if (_layer.fx_index != 0) layer_fx_apply(_layer.layer, _layer.fx_index, _layer.fx_params);

            array_push(layers,_layer)
            layers_depth_order()

            var inverse_ = {fn: action_remove_layer, args: [_layer, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc changes _layer's depth. Self-inverting: its own inverse is
        ///just action_set_depth again with the old value
        action_set_depth = function(_layer,_depth,_record=true){
            var old_depth_ = layer_get_depth(_layer.layer)
            if (_depth == old_depth_) return undefined;

            layer_depth(_layer.layer,_depth)

            _layer.depth = _depth
            if (_layer.type == LAYER_TYPE.TILEMAP){
                _layer.obj_tilemap.depth = _depth;
            }

            layers_depth_order()

            var inverse_ = {fn: action_set_depth, args: [_layer, old_depth_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc sets a layer's parallax X and Y together (always both, even
        ///when only one axis changed - callers pass the other axis's current
        ///value), so one slider edit is always one undo step. Self-inverting
        action_set_parralax = function(_layer,_parralax_x,_parralax_y,_record=true){
            var old_x_ = _layer.parralax_x
            var old_y_ = _layer.parralax_y
            if (_parralax_x == old_x_ && _parralax_y == old_y_) return undefined;

            _layer.parralax_x = _parralax_x
            _layer.parralax_y = _parralax_y
            if (_layer.type == LAYER_TYPE.TILEMAP){
                _layer.obj_tilemap.parralax_x = _parralax_x;
                _layer.obj_tilemap.parralax_y = _parralax_y;
            } else if (_layer.type == LAYER_TYPE.BACKGROUND){
                if (instance_exists(_layer.obj_background)) {
                    _layer.obj_background.parralax_x = _parralax_x;
                    _layer.obj_background.parralax_y = _parralax_y;
                }
            } else {
                //ASSET/INSTANCE layers - every obj_editor_instance/obj_editor_sprite already on it
                with (obj_asset_transform) {
                    if (layer == _layer.layer) { parralax_x = _parralax_x; parralax_y = _parralax_y; }
                }
            }

            var inverse_ = {fn: action_set_parralax, args: [_layer, old_x_, old_y_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc switches a layer's fx (index into global.LAYER_FX) and its
        ///param values together, re-registering the hook immediately. Self-inverting
        action_set_layer_fx = function(_layer,_fx_index,_params,_record=true){
            var old_fx_index_ = _layer.fx_index;
            var old_params_ = _layer.fx_params;

            _layer.fx_index = _fx_index;
            _layer.fx_params = _params;
            layer_fx_apply(_layer.layer, _fx_index, _params);

            var inverse_ = {fn: action_set_layer_fx, args: [_layer, old_fx_index_, old_params_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc updates a layer's fx param values in place - the already
        ///running hook reads them live, so no clear/setup cycle needed. Self-inverting
        action_set_layer_fx_params = function(_layer,_params,_record=true){
            var old_params_ = _layer.fx_params;
            _layer.fx_params = _params;

            var entry_ = layer_fx_find(_layer.layer);
            if (entry_ != noone) entry_.params = _params;

            var inverse_ = {fn: action_set_layer_fx_params, args: [_layer, old_params_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc sets a tilemap layer's tileset (by resource_tree name). Self-inverting
        action_set_tileset = function(_layer,_tileset_name,_record=true){
            var new_tileset_ = asset_get_index(_tileset_name)
            var old_tileset_ = _layer.tileset
            if (new_tileset_ == old_tileset_) return undefined;

            _layer.tileset = new_tileset_
            if (_layer.tilemap != undefined) tilemap_tileset(_layer.tilemap, new_tileset_);
            if (_layer == layer_active) refresh_tileset_brush();

            var inverse_ = {fn: action_set_tileset, args: [_layer, tileset_get_name(old_tileset_), false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc sets a background layer's sprite (by resource_tree name, "" for
        ///none). Self-inverting
        action_set_background_sprite = function(_layer,_sprite_name,_record=true){
            if (!instance_exists(_layer.obj_background)) return undefined;
            var new_sprite_ = _sprite_name != "" ? asset_get_index(_sprite_name) : -1;
            var old_sprite_ = _layer.obj_background.sprite_index;
            if (new_sprite_ == old_sprite_) return undefined;

            _layer.obj_background.sprite_index = new_sprite_;
            _layer.obj_background.mask_index = new_sprite_;

            var old_name_ = old_sprite_ != -1 ? sprite_get_name(old_sprite_) : "";
            var inverse_ = {fn: action_set_background_sprite, args: [_layer, old_name_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc sets a background layer's draw mode (None/Tiled/Fill - mutually
        ///exclusive, see BACKGROUND_MODE). Self-inverting
        action_set_background_mode = function(_layer,_mode,_record=true){
            if (!instance_exists(_layer.obj_background)) return undefined;
            var old_mode_ = _layer.obj_background.background_mode;
            if (_mode == old_mode_) return undefined;

            _layer.obj_background.background_mode = _mode;

            var inverse_ = {fn: action_set_background_mode, args: [_layer, old_mode_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc moves a background layer's sprite. Self-inverting
        action_set_background_position = function(_layer,_x,_y,_record=true){
            if (!instance_exists(_layer.obj_background)) return undefined;
            var old_x_ = _layer.obj_background.x;
            var old_y_ = _layer.obj_background.y;
            if (_x == old_x_ && _y == old_y_) return undefined;

            _layer.obj_background.x = _x;
            _layer.obj_background.y = _y;

            var inverse_ = {fn: action_set_background_position, args: [_layer, old_x_, old_y_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc writes a single tile (_tile:0 = empty) at (_x,_y) in _tilemap,
        ///without expanding/shrinking it (see action_run_many); self-inverting
        action_set_tiles = function(_tilemap,_x,_y,_tile,_record=true){
            var old_tile_ = tilemap_get(_tilemap,_x,_y);
            if (old_tile_ == _tile) return undefined;

            tilemap_set(_tilemap,_tile,_x,_y);

            var inverse_ = {fn: action_set_tiles, args: [_tilemap, _x, _y, old_tile_, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc replays each {fn,args} in _entries as one combined undo step;
        ///also expands/shrinks the tilemap once per batch instead of once per cell
        action_run_many = function(_entries){
            if (array_length(_entries) <= 0) return undefined;

            //tile edit batches are always action_set_tiles entries needing one batch
            //expand/shrink - other batches (eg mirror/flip/rotate) don't use tile coords
            var is_tile_batch_ = _entries[0].fn == action_set_tiles;
            var tilemap_;

            if (is_tile_batch_) {
                tilemap_ = _entries[0].args[0];
                var max_x_ = _entries[0].args[1];
                var max_y_ = _entries[0].args[2];
                for (var i_ = 1; i_ < array_length(_entries); i_++) {
                    if (_entries[i_].args[1] > max_x_) max_x_ = _entries[i_].args[1];
                    if (_entries[i_].args[2] > max_y_) max_y_ = _entries[i_].args[2];
                }
                tilemap_expand(tilemap_, max_x_, max_y_);
            }

            var inverses_ = [];
            for (var i_ = 0; i_ < array_length(_entries); i_++) {
                var inv_ = script_execute_ext(_entries[i_].fn, _entries[i_].args);
                if (inv_ != undefined) array_push(inverses_, inv_);
            }

            if (is_tile_batch_) tilemap_shrink(tilemap_);

            if (array_length(inverses_) <= 0) return undefined;
            return {fn: action_run_many, args: [inverses_]};
        }

        ///@desc shifts the whole level (tiles, elements, room bounds, camera) by
        ///(_shift_x,_shift_y) px; self-inverting via the negated shift
        action_shift_room = function(_shift_x, _shift_y, _record=true){
            if (_shift_x == 0 && _shift_y == 0) return undefined;

            for (var i_ = 0; i_ < array_length(layers); i_++) {
                var layer_ = layers[i_];
                if (layer_.type != LAYER_TYPE.TILEMAP) continue;
                var tilemap_ = layer_tilemap_get_id(layer_.layer);

                var tile_w_ = tilemap_get_tile_width(tilemap_);
                var tile_h_ = tilemap_get_tile_height(tilemap_);
                var sx_ = round(_shift_x / tile_w_);
                var sy_ = round(_shift_y / tile_h_);
                if (sx_ == 0 && sy_ == 0) continue;

                var old_w_ = tilemap_get_width(tilemap_);
                var old_h_ = tilemap_get_height(tilemap_);
                var new_w_ = old_w_ + sx_;
                var new_h_ = old_h_ + sy_;

                if (sx_ >= 0 && sy_ >= 0) {
                    //growing - extend first, then move data to the shifted position
                    //back-to-front so writes never clobber a cell before it's read
                    tilemap_set_width(tilemap_, new_w_);
                    tilemap_set_height(tilemap_, new_h_);
                    for (var x_ = new_w_-1; x_ >= 0; x_--) {
                        for (var y_ = new_h_-1; y_ >= 0; y_--) {
                            var src_x_ = x_-sx_, src_y_ = y_-sy_;
                            var value_ = (src_x_ >= 0 && src_y_ >= 0) ? tilemap_get(tilemap_,src_x_,src_y_) : 0;
                            tilemap_set(tilemap_, value_, x_, y_);
                        }
                    }
                } else {
                    //shrinking (undo of a grow) - move data back down
                    //front-to-back, then crop the now-empty margin off
                    var dx_ = -sx_, dy_ = -sy_;
                    for (var x_ = 0; x_ < new_w_; x_++) {
                        for (var y_ = 0; y_ < new_h_; y_++) {
                            tilemap_set(tilemap_, tilemap_get(tilemap_,x_+dx_,y_+dy_), x_, y_);
                        }
                    }
                    tilemap_set_width(tilemap_, new_w_);
                    tilemap_set_height(tilemap_, new_h_);
                }
            }

            with (obj_asset_transform) {
                x += _shift_x;
                y += _shift_y;
            }

            room_width += _shift_x;
            room_height += _shift_y;

            //keeps the viewport visually stable - otherwise the level jumps
            //under a stationary camera the instant it shifts
            camera_x += _shift_x;
            camera_y += _shift_y;
            global.camera.move(camera_x, camera_y);

            var inverse_ = {fn: action_shift_room, args: [-_shift_x, -_shift_y, false]};
            if (_record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        /**
         * Function pastes dsgrid tilebrush
         * @param {id.tilemapelement} _tilemap tilemap
         * @param {id.dsgrid} _tilegrid tile grid
         * @param {int} _x tilemap pos
         * @param {int} _y
         */
        action_paste_tile_grid = function(_tilemap,_tilegrid,_x,_y,_record=true){
            var width_ = ds_grid_width(_tilegrid);
            var height_ = ds_grid_height(_tilegrid);

            //a paste landing left/above the room shifts the whole level first (its
            //own undo step) so nothing goes negative - brush_tilemap never needs this
            if (_tilemap != brush_tilemap) {
                var min_x_ = 0, min_y_ = 0;
                for (var w_ = 0; w_ < width_; w_++) {
                    for (var h_ = 0; h_ < height_; h_++) {
                        if (ds_grid_get(_tilegrid,w_,h_) == 0) continue;
                        min_x_ = min(min_x_, _x+w_);
                        min_y_ = min(min_y_, _y+h_);
                    }
                }
                if (min_x_ < 0 || min_y_ < 0) {
                    //min_x_/min_y_ are tile-grid indices here, not pixels -
                    //the shift needed is exactly how far negative they went
                    var tile_w_ = tilemap_get_tile_width(_tilemap);
                    var tile_h_ = tilemap_get_tile_height(_tilemap);
                    var shift_x_tiles_ = max(0, -min_x_);
                    var shift_y_tiles_ = max(0, -min_y_);
                    action_shift_room(shift_x_tiles_ * tile_w_, shift_y_tiles_ * tile_h_, _record);
                    _x += shift_x_tiles_;
                    _y += shift_y_tiles_;
                }
            }

            var entries_ = [];
            for (var w_ = 0; w_ < width_; w_++) {
                for (var h_ = 0; h_ < height_; h_++) {
                    var tile_ = ds_grid_get(_tilegrid,w_,h_);
                    if (tile_ == 0 || _x+w_ < 0 || _y+h_ < 0) continue;
                    array_push(entries_, {fn: action_set_tiles, args: [_tilemap, _x+w_, _y+h_, tile_, false]});
                }
            }

            var inverse_ = action_run_many(entries_);
            if (inverse_ != undefined && _record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        /**
         * Function erases using dsgrid tilebrush
         * @param {id.tilemapelement} _tilemap tilemap
         * @param {id.dsgrid} _tilegrid tile grid
         * @param {int} _x tilemap pos
         * @param {int} _y
         */
        action_erase_tile_grid = function(_tilemap,_tilegrid,_x,_y,_record=true){
            var width_ = ds_grid_width(_tilegrid);
            var height_ = ds_grid_height(_tilegrid);
            var entries_ = [];
            for (var w_ = 0; w_ < width_; w_++) {
                for (var h_ = 0; h_ < height_; h_++) {
                    var tile_ = ds_grid_get(_tilegrid,w_,h_);
                    if (tile_ == 0) continue;
                    array_push(entries_, {fn: action_set_tiles, args: [_tilemap, _x+w_, _y+h_, 0, false]});
                }
            }

            var inverse_ = action_run_many(entries_);
            if (inverse_ != undefined && _record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }

        ///@desc flood-fills every tile 4-connected to (_x,_y) sharing its value
        ///with _fill_value (0 = erase); bundled through action_run_many
        action_fill_tiles = function(_tilemap,_x,_y,_fill_value,_record=true){
            var w_ = tilemap_get_width(_tilemap);
            var h_ = tilemap_get_height(_tilemap);
            if (_x < 0 || _y < 0 || _x >= w_ || _y >= h_) return undefined;

            var target_ = tilemap_get(_tilemap,_x,_y);
            if (target_ == _fill_value) return undefined;

            var entries_ = [];
            var visited_ = ds_grid_create(w_,h_);
            ds_grid_clear(visited_,0);

            var stack_x_ = [_x];
            var stack_y_ = [_y];
            ds_grid_set(visited_,_x,_y,1);

            while (array_length(stack_x_) > 0) {
                var cx_ = array_pop(stack_x_);
                var cy_ = array_pop(stack_y_);
                array_push(entries_, {fn: action_set_tiles, args: [_tilemap, cx_, cy_, _fill_value, false]});

                var dirs_ = [[cx_-1,cy_],[cx_+1,cy_],[cx_,cy_-1],[cx_,cy_+1]];
                for (var i_ = 0; i_ < 4; i_++) {
                    var nx_ = dirs_[i_][0], ny_ = dirs_[i_][1];
                    if (nx_ < 0 || ny_ < 0 || nx_ >= w_ || ny_ >= h_) continue;
                    if (ds_grid_get(visited_,nx_,ny_) != 0) continue;
                    if (tilemap_get(_tilemap,nx_,ny_) != target_) continue;
                    ds_grid_set(visited_,nx_,ny_,1);
                    array_push(stack_x_,nx_);
                    array_push(stack_y_,ny_);
                }
            }
            ds_grid_destroy(visited_);

            var inverse_ = action_run_many(entries_);
            if (inverse_ != undefined && _record) {
                array_push(undo_stack, inverse_)
                redo_stack = []
            }
            return inverse_;
        }
    #endregion

#endregion

#region setup

set_controlled(self);

var layers_ = layer_get_all();
for (var i = 0; i < array_length(layers_); ++i) {
	layer_destroy_instances(layers_[i]);
    layer_destroy(layers_[i]);
}


//close button intercept
window_command_hook(window_command_close);

smf_files = scan_smf_files("3D");

//loads whatever resource_tree.json currently exists - regenerating it is
//slow enough to leave to the "Regenerate Resource Tree" menu item instead
resource_tree = json_load(root_path + "editor/resource_tree.json").folders;

//restore last session's window positions/dock layout, if any - windows are
//otherwise just Begin()'d plain (see Step_1.gml) and pick this up automatically
if (file_exists(imgui_ini_backup_path)) {
    file_copy(imgui_ini_backup_path, imgui_ini_runtime_path);
}

font = ImGui.AddFontFromFile("editor/AtkinsonHyperlegible.ttf",font_size);
font_icons = ImGui.AddFontFromFile("editor/icons.ttf",font_size);

//hidden layer purely for storing the tile brush canvas - see
//refresh_tileset_brush, which creates/loads brush_tilemap on it
brushes_layer = layer_create(0,"editor_tilebrushes");
layer_set_visible(brushes_layer,false)

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
    //continue from wherever the last session left off (most recently saved or
    //opened), falling back to a fresh level if that file's gone missing
	
	var success_ = false;
	if (array_length(recent_levels) > 0) {
		success_ = open_level(recent_levels[0])
	}

	if(!success_){
		new_level()
	}
} else {
    open_level(levels_dir + global.level + ".json")
}
#endregion

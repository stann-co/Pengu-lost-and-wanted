/// @description
#region close button save reminder
if (window_command_check(window_command_close)) {
    if (show_question("Really quit?")){
        game_end();
    }
}
#endregion

#region input
//maybe do controller inputs later lol, not impossible
var arrows_h_ = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT);
var arrows_v_ = InputCheck(INPUT_VERB.DOWN)  - InputCheck(INPUT_VERB.UP);

 //mouse delta movement
var mouse_spd_h_ = -window_mouse_get_delta_x(); //display
var mouse_spd_v_ = -window_mouse_get_delta_y();
var mouse_spd_x_ = mouse_spd_h_ / stanncam_get_res_scale_x(); //room
var mouse_spd_y_ = mouse_spd_v_ / stanncam_get_res_scale_y();

var mx_ = window_mouse_get_x(); //display mouse
var my_ = window_mouse_get_y();
    
var rmx_ = global.camera.get_mouse_x(); //room mouse
var rmy_ = global.camera.get_mouse_y();

#endregion

#region camera

//Move camera
var hspd_ = arrows_h_ * move_spd;
var vspd_ = arrows_v_ * move_spd;

if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow)){
    if (mouse_check_button(mb_middle)){
        hspd_ = mouse_spd_x_ * global.camera.zoom_amount;
        vspd_ = mouse_spd_y_ * global.camera.zoom_amount;
    }
    
    //zoom
    var zoom_ = mouse_wheel_down() - mouse_wheel_up();
    if(zoom_ != 0){
        zoom_ = clamp(global.camera.zoom_amount - zoom_ / log2(global.camera.zoom_amount * 0.1),0.5,4);
        global.camera.zoom(zoom_,0);
    }
    
    if(hspd_ != 0 || vspd_ != 0){
        var x_ = global.camera.x + hspd_;
        var y_ = global.camera.y + vspd_;
        global.camera.move(x_, y_);
    }
}

#endregion

#region imgui
ImGui.__Update();

if (dark_mode) ImGui.StyleColorsDark() else ImGui.StyleColorsLight()

ImGui.PushFont(font);
ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding,2)
ImGui.PushStyleVar(ImGuiStyleVar.WindowBorderSize,1)
ImGui.PushStyleVar(ImGuiStyleVar.ChildBorderSize,1)
ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding,4,4)
ImGui.PushStyleVar(ImGuiStyleVar.FramePadding,4,3)
ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing,4,3)
ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing,3,3)

//subtle gray instead of the theme's default blue, for buttons/selectables/docking tabs
ImGui.PushStyleColor(ImGuiCol.Button, c_gray, 0.4)
ImGui.PushStyleColor(ImGuiCol.ButtonHovered, c_ltgray, 0.6)
ImGui.PushStyleColor(ImGuiCol.ButtonActive, c_dkgray, 0.8)
ImGui.PushStyleColor(ImGuiCol.Header, c_gray, 0.35)
ImGui.PushStyleColor(ImGuiCol.HeaderHovered, c_ltgray, 0.5)
ImGui.PushStyleColor(ImGuiCol.HeaderActive, c_dkgray, 0.7)
ImGui.PushStyleColor(ImGuiCol.Tab, c_gray, 0.3)
ImGui.PushStyleColor(ImGuiCol.TabHovered, c_ltgray, 0.6)
ImGui.PushStyleColor(ImGuiCol.TabSelected, c_gray, 0.6)
ImGui.PushStyleColor(ImGuiCol.TabSelectedOverline, c_dkgray, 1)
ImGui.PushStyleColor(ImGuiCol.TabDimmed, c_gray, 0.15)
ImGui.PushStyleColor(ImGuiCol.TabDimmedSelected, c_gray, 0.4)
ImGui.PushStyleColor(ImGuiCol.TabDimmedSelectedOverline, c_dkgray, 0.5)
ImGui.PushStyleColor(ImGuiCol.DockingPreview, c_dkgray, 0.4)
ImGui.PushStyleColor(ImGuiCol.TitleBg, c_gray, 0.3)
ImGui.PushStyleColor(ImGuiCol.TitleBgActive, c_gray, 0.6)
ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, c_gray, 0.2)
ImGui.PushStyleColor(ImGuiCol.FrameBg, c_ltgray, 0.3)
ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, c_ltgray, 0.5)
ImGui.PushStyleColor(ImGuiCol.FrameBgActive, c_gray, 0.6)
ImGui.PushStyleColor(ImGuiCol.CheckMark, c_dkgray, 1)
ImGui.PushStyleColor(ImGuiCol.CheckboxSelectedBg, c_gray, 0.4)
ImGui.PushStyleColor(ImGuiCol.SliderGrab, c_gray, 0.8)
ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, c_dkgray, 1)
ImGui.PushStyleColor(ImGuiCol.ResizeGrip, c_gray, 0.3)
ImGui.PushStyleColor(ImGuiCol.ResizeGripHovered, c_ltgray, 0.6)
ImGui.PushStyleColor(ImGuiCol.ResizeGripActive, c_dkgray, 0.8)
ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, c_gray, 0.6)
ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, c_ltgray, 0.7)
ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabActive, c_dkgray, 0.8)
ImGui.PushStyleColor(ImGuiCol.SeparatorHovered, c_ltgray, 0.6)
ImGui.PushStyleColor(ImGuiCol.SeparatorActive, c_dkgray, 0.8)
ImGui.PushStyleColor(ImGuiCol.TextSelectedBg, c_ltgray, 0.4)
ImGui.PushStyleColor(ImGuiCol.NavCursor, c_dkgray, 0.8)
ImGui.PushStyleColor(ImGuiCol.DragDropTarget, c_dkgray, 0.8)

#region Main menu bar
if (ImGui.BeginMainMenuBar()){

    #region file menu
    if (ImGui.BeginMenu("File")){

        if (ImGui.MenuItem("New Level")){
            //TODO ask to save changes before going to new room
            //New level really just clears everything
            new_level()
        }
        if (ImGui.MenuItem("Open Level")){

        }
        if (ImGui.MenuItem("Save Level")){

        }
        if (ImGui.MenuItem("Save as Level")){

        }

        ImGui.EndMenu()
    }
    #endregion

    #region windows menu
    if (ImGui.BeginMenu("Windows")){

        if (ImGui.MenuItem("Layers", "", window_layers_visible, true)) {
            window_layers_visible = !window_layers_visible;
        }
        if (ImGui.MenuItem("Resources", "", window_resources_visible, true)) {
            window_resources_visible = !window_resources_visible;
        }
        if (ImGui.MenuItem("Regenerate Resource Tree")) {
            regenerate_resource_tree();
        }

        ImGui.Separator();

        if (ImGui.MenuItem("Left Panel", "", left_panel_visible, true)) {
            left_panel_visible = !left_panel_visible;
        }
        if (ImGui.MenuItem("Right Panel", "", right_panel_visible, true)) {
            right_panel_visible = !right_panel_visible;
        }

        ImGui.Separator();

        if (ImGui.MenuItem("Icon Reference", "", window_icons_visible, true)) {
            window_icons_visible = !window_icons_visible;
        }
        if (ImGui.MenuItem("Resource Tree", "", window_resource_tree_visible, true)) {
            window_resource_tree_visible = !window_resource_tree_visible;
        }
        if (ImGui.MenuItem("3D Model Viewer", "", window_3d_viewer_visible, true)) {
            window_3d_viewer_visible = !window_3d_viewer_visible;
        }

        ImGui.Separator();

        if (ImGui.MenuItem("Dark Mode", "", dark_mode, true)) {
            dark_mode = !dark_mode;
        }

        ImGui.EndMenu()
    }
    #endregion

    ImGui.EndMainMenuBar()
}

#endregion

#region floating toolbar
if (ImGui.BeginViewportSideBar("##EditorToolbar", 0, ImGuiDir.Up, toolbar_height, ImGuiWindowFlags.NoScrollbar)) {
    if (ImGui.Button("Play")) {
        //TODO
    }
    ImGui.SameLine();
    if (ImGui.Button("Pause")) {
        //TODO
    }
    ImGui.SameLine();
    if (ImGui.Button("Stop")) {
        //TODO
    }
    ImGui.End();
}
#endregion

#region left side panel (dockspace)
//dockspace host: always hosted so docked windows stay associated with it even
//while hidden - when hidden it's hosted in an off-screen window instead of a
//0-width viewport sidebar, since ImGui enforces a minimum window size that
//left a visible sliver even at width 0
var left_dock_flags_ = left_panel_visible ? ImGuiDockNodeFlags.None : ImGuiDockNodeFlags.KeepAliveOnly;
if (left_panel_visible) {
    if (ImGui.BeginViewportSideBar("##EditorLeftDock", 0, ImGuiDir.Left, left_panel_width, ImGuiWindowFlags.NoScrollbar)) {
        ImGui.DockSpace(dock_id_left, 0, 0, left_dock_flags_);
        ImGui.End();
    }
} else {
    ImGui.SetNextWindowPos(-10000, -10000);
    ImGui.SetNextWindowSize(1, 1);
    if (ImGui.Begin("##EditorLeftDockHidden", undefined, ImGuiWindowFlags.NoDecoration | ImGuiWindowFlags.NoBackground | ImGuiWindowFlags.NoInputs | ImGuiWindowFlags.NoSavedSettings | ImGuiWindowFlags.NoFocusOnAppearing | ImGuiWindowFlags.NoNav | ImGuiWindowFlags.NoBringToFrontOnFocus)) {
        ImGui.DockSpace(dock_id_left, 0, 0, left_dock_flags_);
    }
    ImGui.End();
}

//slim show/hide strip, always in the same place on the inner edge of the panel (facing the viewport)
if (ImGui.BeginViewportSideBar("##EditorLeftToggle", 0, ImGuiDir.Left, panel_toggle_width, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoBackground)) {
    if (left_panel_visible) {
        if (area_button()) {
            left_panel_visible = false;
        }
    } else {
        if (area_button()) {
            left_panel_visible = true;
        }
    }
    ImGui.End();
}
#endregion

#region right side panel (dockspace)
var right_dock_flags_ = right_panel_visible ? ImGuiDockNodeFlags.None : ImGuiDockNodeFlags.KeepAliveOnly;
if (right_panel_visible) {
    if (ImGui.BeginViewportSideBar("##EditorRightDock", 0, ImGuiDir.Right, right_panel_width, ImGuiWindowFlags.NoScrollbar)) {
        ImGui.DockSpace(dock_id_right, 0, 0, right_dock_flags_);
        ImGui.End();
    }
} else {
    ImGui.SetNextWindowPos(-10000, -10000);
    ImGui.SetNextWindowSize(1, 1);
    if (ImGui.Begin("##EditorRightDockHidden", undefined, ImGuiWindowFlags.NoDecoration | ImGuiWindowFlags.NoBackground | ImGuiWindowFlags.NoInputs | ImGuiWindowFlags.NoSavedSettings | ImGuiWindowFlags.NoFocusOnAppearing | ImGuiWindowFlags.NoNav | ImGuiWindowFlags.NoBringToFrontOnFocus)) {
        ImGui.DockSpace(dock_id_right, 0, 0, right_dock_flags_);
    }
    ImGui.End();
}

//slim show/hide strip on the inner edge of the right panel (facing the viewport)
if (ImGui.BeginViewportSideBar("##EditorRightToggle", 0, ImGuiDir.Right, panel_toggle_width, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoBackground)) {
    if (right_panel_visible) {
        if (area_button()) {
            right_panel_visible = false;
        }
    } else {
        if (area_button()) {
            right_panel_visible = true;
        }
    }
    ImGui.End();
}
#endregion

#region viewport toolbar
//fixed strip of editor buttons over the viewport, between the two side
//panels - registered after both so it only claims the remaining central
//width rather than spanning edge to edge. always visible, no expand/collapse
if (ImGui.BeginViewportSideBar("##ViewportToolbar", 0, ImGuiDir.Up, viewport_toolbar_height, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoBackground)) {
    if (icon_button(ICON.FLIP_HORIZONTAL)) {
        if(brush != -1){
            brush_mirror(brush)
        }
    }
    if (ImGui.IsItemHovered()) ImGui.SetTooltip("Flip X");
    ImGui.SameLine();

    if (icon_button(ICON.FLIP_VERTICAL)) {
        if(brush != -1){
            brush_flip(brush)
        }
    }
    if (ImGui.IsItemHovered()) ImGui.SetTooltip("Flip Y");
    ImGui.SameLine();

    if (icon_button(ICON.REDO)) {
        if(brush != -1){
            brush_rotate(brush)
        }
    }
    if (ImGui.IsItemHovered()) ImGui.SetTooltip("Rotate 90°");

    ImGui.End();
}
#endregion

#region dockable tool windows

#region layers list
if (window_layers_visible) {
    if (ImGui.Begin("Layers", undefined, ImGuiWindowFlags.None)) {
        #region layers
        ImGui.Text("Layers:")
        ImGui.BeginChild("Layers",,200, ImGuiChildFlags.Borders | ImGuiChildFlags.ResizeY);
        for (var i_ = 0; i_ < array_length(layers); i_++) {
            var layer_ = layers[i_];
            var can_rename_ = !layer_.locked && !layer_.always;
            
            ImGui.PushID(i_);

            //visibility toggle
            var icon_ = layer_.visible ? ICON.EYE : ICON.EYE_OFF
            if (icon_button(icon_,"visibility")) {
                layer_.visible = !layer_.visible;
                layer_set_visible(layer_.layer, layer_.visible);
            }
            if (ImGui.IsItemHovered()) ImGui.SetTooltip(layer_.visible ? "Hide layer" : "Show layer");
            ImGui.SameLine();
            
            //lock toggle
            var icon_ = layer_.locked ? ICON.LOCK : ICON.UNLOCK
            if (icon_button(icon_)) {
                layer_.locked = !layer_.locked;
            }
            if (ImGui.IsItemHovered()) ImGui.SetTooltip(layer_.locked ? "Unlock layer" : "Lock layer");
            ImGui.SameLine();

            var disabled_ = layer_.locked || layer_.always;
            var flags_ = ImGuiSelectableFlags.None

            if (layer_rename_index == i_) {
                //renaming this layer - a text field replaces the selectable, commits on enter/click-away
                ImGui.SetNextItemWidth(-1);
                ImGui.SetKeyboardFocusHere();
                layer_rename_buffer = ImGui.InputText("##rename", layer_rename_buffer, ImGuiInputTextFlags.EnterReturnsTrue | ImGuiInputTextFlags.AutoSelectAll);
                if (ImGui.IsItemDeactivated()) {
                    var new_name_ = string_trim(layer_rename_buffer);
                    if (new_name_ != "") layer_.name = new_name_;
                    layer_rename_index = -1;
                }
            } else {
                //blended from a base matching the current theme (not GetStyleColor - its
                //return format isn't reliably compatible with merge_color/PushStyleColor)
                //so the tint stays visible in both light and dark mode - disabled layers
                //blend from GRAY instead of losing the tint entirely
                var text_base_ = disabled_ ? GRAY : (dark_mode ? c_white : c_black);
                var name_color_ = merge_color(text_base_, layer_.color, 0.25);
                ImGui.PushStyleColor(ImGuiCol.Text, name_color_, 1);
                if (ImGui.Selectable(layer_.name, layer_index == i_, flags_)) {
                    set_layer(i_)
                }
                ImGui.PopStyleColor();
                //double-click (within 400ms, same row) to rename - not for locked/always layers
                if (can_rename_ && ImGui.IsItemHovered() && mouse_check_button_pressed(mb_left)) {
                    if (layer_click_index == i_ && (current_time - layer_click_time) < 400) {
                        layer_rename_index = i_;
                        layer_rename_buffer = layer_.name;
                        layer_click_index = -1;
                    } else {
                        layer_click_index = i_;
                        layer_click_time = current_time;
                    }
                }
            }
            ImGui.SameLine();

            var depth_ = string(layer_get_depth(layer_.layer));

            //Layer type
            var type_ = layer_type_icons[layer_.type];

            var spacing_ = 4;
            ImGui.PushFont(font_icons);
            var type_width_ = ImGui.CalcTextWidth(chr(type_));
            ImGui.PopFont();
            var row_width_ = type_width_ + spacing_ + ImGui.CalcTextWidth(depth_);

            ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - row_width_));

            icon(type_,disabled_)
            ImGui.SameLine(0,spacing_);

            if (!disabled_) {
                ImGui.Text(depth_);
            } else {
                ImGui.TextDisabled(depth_);
            }

            ImGui.PopID();
        }
        ImGui.EndChild();
        if (icon_button(ICON.FILE)) {
            var depth_ = array_length(layers) > 0 ? layer_get_depth(layers[array_length(layers)-1].layer) + 10 : 0;
            action_add_layer("New Layer", depth_, add_layer_type);
        }
        ImGui.SameLine()
        var can_remove_ = layer_active != undefined && !layer_active.always;
        if (!can_remove_) ImGui.BeginDisabled();
        if (icon_button(ICON.TRASH)) {
            action_remove_layer(layer_index);
        }
        if (!can_remove_) ImGui.EndDisabled();

        ImGui.SameLine();
        ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX());
        if (ImGui.BeginCombo("##add_layer_type", global.LAYER_TYPES[add_layer_type], ImGuiComboFlags.None)) {
            for (var i_ = 0; i_ < array_length(global.LAYER_TYPES); ++i_) {
                var selected_ = add_layer_type == i_;
                icon(layer_type_icons[i_]);
                ImGui.SameLine();
                if (ImGui.Selectable(global.LAYER_TYPES[i_], selected_)) {
                    add_layer_type = i_;
                }
                if (selected_) ImGui.SetItemDefaultFocus();
            }
            ImGui.EndCombo();
        }
        #endregion

        #region layer properties
        ImGui.Separator();
        ImGui.Text("Layer Properties:");
        if (layer_active != undefined) {
            var can_edit_ = !layer_active.locked && !layer_active.always;
            if (!can_edit_) ImGui.BeginDisabled();

            var field_width_ = 140;

            ImGui.Text("Depth");
            ImGui.SameLine();
            ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
            var depth_ = layer_get_depth(layer_active.layer);
            ImGui.SetNextItemWidth(field_width_);
            var new_depth_ = ImGui.InputInt("##depth", depth_);
            //committed on every change rather than IsItemDeactivatedAfterEdit - the
            //InputInt +/- step buttons don't reliably trigger deactivation-after-edit
            if (new_depth_ != depth_) {
                action_set_depth(layer_index, new_depth_);
            }

            ImGui.Text("Parallax");
            ImGui.SameLine();
            ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
            ImGui.SetNextItemWidth(field_width_);
            var new_parralax_ = ImGui.SliderInt("##parallax", layer_active.parralax, -16, 16);
            if (new_parralax_ != layer_active.parralax) {
                layer_active.parralax = new_parralax_;
            }

            switch (layer_active.type) {
                case LAYER_TYPE.TILEMAP:
                    ImGui.Text("Tileset");
                    ImGui.SameLine();
                    var tileset_name_ = layer_active.tile_map != undefined ? tileset_get_name(layer_active.tile_map) : "(none)";
                    ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX());
                    if (ImGui.BeginCombo("##set_tileset", tileset_name_, ImGuiComboFlags.None)) {
                        resource_tree_draw(resource_tree, [], "tileset", tileset_name_, function(_name){
                            action_set_tileset(layer_index, _name);
                            ImGui.CloseCurrentPopup();
                        });
                        ImGui.EndCombo();
                    }
                    break;
                case LAYER_TYPE.ASSET:
                    //TODO: asset-specific layer options
                    break;
                case LAYER_TYPE.INSTANCE:
                    //TODO: instance-specific layer options
                    break;
            }

            if (!can_edit_) ImGui.EndDisabled();
        } else {
            ImGui.TextDisabled("No layer selected");
        }
        #endregion

    }
    ImGui.End();
}
#endregion

#region resources
if (window_resources_visible) {
    if (ImGui.Begin("Resources", undefined, ImGuiWindowFlags.None)) {
        if(layer_active != undefined){
            switch (layer_active.type) {
                case LAYER_TYPE.TILEMAP:
                    #region tileset
                    ImGui.Text("Tileset:");

                    var menu_size_ = 300;
                    var tileset_changed_ = refresh_tileset_tiles();

                    ImGui.BeginChild("Tileset",,menu_size_);

                    if(!surface_exists(tileset_surface)){
                        tileset_surface = surface_create(menu_size_,menu_size_);
                    }
                    surface_set_target(tileset_surface);
                    draw_clear(BLACK);

                    if(layer_active.tile_map != undefined){

                        var tiles_width_  = ds_grid_width( tileset_tiles);
                        var tiles_height_ = ds_grid_height(tileset_tiles);

                        //can't zoom out past the point where the whole tileset
                        //already fits in view - beyond that it's just empty space
                        var tiles_size_max_ = min(max(tiles_width_*grid_cell_w, tiles_height_*grid_cell_h) + 64, 1024);
                        tiles_size = min(tiles_size, tiles_size_max_); //catches a tileset switch too

                        if(ImGui.IsWindowHovered() ){
                            //zoom (centered on view)
                            var zoom_ = mouse_wheel_down() - mouse_wheel_up();
                            if(zoom_ != 0){
                                var tiles_size_prev_ = tiles_size;
                                tiles_size = clamp(tiles_size + zoom_*log2(tiles_size)*16, 64, tiles_size_max_);
                                if (tiles_size != tiles_size_prev_) {
                                    var factor_ = tiles_size_prev_ / tiles_size;
                                    var center_ = menu_size_ * 0.5;
                                    // adjust translation so the center point stays fixed when scaling
                                    tiles_x = center_ - (center_ - tiles_x) * factor_;
                                    tiles_y = center_ - (center_ - tiles_y) * factor_;
                                }
                            }
                            //dragging
                            if (mouse_check_button(mb_middle)){
                                tiles_x -= mouse_spd_h_;
                                tiles_y -= mouse_spd_v_;
                            }
                        }
                        
                        var scale_ = menu_size_ / tiles_size;
                        var content_w_ = tiles_width_  * grid_cell_w * scale_;
                        var content_h_ = tiles_height_ * grid_cell_h * scale_;
                        
                        if (tileset_changed_) {
                            //first time this tileset is shown - start centered
                            tiles_x = (menu_size_ - content_w_) * 0.5;
                            tiles_y = (menu_size_ - content_h_) * 0.5;
                        }
                        
                        //keep the tiles on screen - centered/locked if they fit within
                        //the view, otherwise clamped (with a little padding so the
                        //edge isn't flush against the window border) so they can't
                        //pan far away
                        var pan_padding_ = 32;
                        tiles_x = content_w_ <= menu_size_ ? (menu_size_ - content_w_) * 0.5 : clamp(tiles_x, menu_size_ - content_w_ - pan_padding_, pan_padding_);
                        tiles_y = content_h_ <= menu_size_ ? (menu_size_ - content_h_) * 0.5 : clamp(tiles_y, menu_size_ - content_h_ - pan_padding_, pan_padding_);
                        
                        //zooms and offsets view
                        matrix_set(matrix_world,matrix_build(tiles_x,tiles_y,0,0,0,0,scale_,scale_,0));
                        
                        draw_sprite_tiled(spr_bg_checker_grid_small,0,0,0);
                        
                        draw_grid_tiles(tileset_tiles,tileset,0,0);
                        set_draw(WHITE,0.5);
                        draw_grid(0,0,grid_cell_w,grid_cell_h,tiles_width_,tiles_height_,1);
                        reset_draw()
                        
                        if(ImGui.IsWindowHovered() ){
                            var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY();
                            var hover_x_ = ((mx_-xx_ - tiles_x) / scale_);
                            var hover_y_ = ((my_-yy_ - tiles_y) / scale_);
                            
                            hover_x_ = hover_x_ div grid_cell_w;
                            hover_y_ = hover_y_ div grid_cell_h;
                            
                            set_draw(WHITE,0.2);
                            draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
                            reset_draw();
                            
                            if(mouse_check_button_pressed(mb_left)){
                                var brush_ = ds_grid_get(tileset_tiles,hover_x_,hover_y_);
                                if(brush_ != undefined){
                                    brush = ds_grid_create(1,1);
                                    ds_grid_add(brush,0,0,brush_);
                                    tile_picker_selected_x = hover_x_;
                                    tile_picker_selected_y = hover_y_;
                                } else brush = -1;
                            }
                        }
                        
                        if (tile_picker_selected_x >= 0) {
                            draw_box_selection(tile_picker_selected_x*grid_cell_w, tile_picker_selected_y*grid_cell_h, grid_cell_w, grid_cell_h);
                        }
                        
                        matrix_set(matrix_world,matrix_build_identity());
                    }
                    
                    surface_reset_target();
                    ImGui.Surface(tileset_surface);
                    
                    ImGui.EndChild();
                    break;
                #endregion
                case LAYER_TYPE.ASSET:
                    //TODO: asset-specific layer options
                    break;
                case LAYER_TYPE.INSTANCE:
                    //TODO: instance-specific layer options
                    resource_tree_draw(resource_tree, [], layer_type_resource_types[layer_active.type]);
                    break;
                default:
                    ImGui.TextDisabled("No layer selected");
                    break
            }
        }
    }
    ImGui.End();
}
#endregion

#region icon grid
if (window_icons_visible) {
    if (ImGui.Begin("Icon Reference", undefined, ImGuiWindowFlags.None)) {
        var hex_chars_ = "0123456789ABCDEF";
        var per_row_ = max(1, ImGui.GetContentRegionAvailX() div 36);
        for (var i_ = 0; i_ < array_length(icon_codes); i_++) {
            var cp_ = icon_codes[i_];
            if (i_ != 0 && i_ mod per_row_ != 0) ImGui.SameLine();
            icon_button(cp_, string(cp_));
            if (ImGui.IsItemHovered()) {
                var hex_ = string_char_at(hex_chars_, (cp_ div 16) + 1) + string_char_at(hex_chars_, (cp_ mod 16) + 1);
                ImGui.SetTooltip("0x" + hex_);
            }
        }
    }
    ImGui.End();
}
#endregion

#region resource tree debug
if (window_resource_tree_visible) {
    if (ImGui.Begin("Resource Tree (Debug)", undefined, ImGuiWindowFlags.None)) {
        resource_tree_draw_debug(resource_tree, []);
    }
    ImGui.End();
}
#endregion

#region 3d model viewer
if (window_3d_viewer_visible) {
    if (ImGui.Begin("3D Model Viewer", undefined, ImGuiWindowFlags.None)) {
        var smf_preview_name_ = smf_selected_index >= 0 ? filename_name(smf_files[smf_selected_index]) : "(select a model)";
        ImGui.SetNextItemWidth(-1);
        if (ImGui.BeginCombo("##smf_select", smf_preview_name_, ImGuiComboFlags.None)) {
            for (var i_ = 0; i_ < array_length(smf_files); i_++) {
                var smf_selected_ = smf_selected_index == i_;
                if (ImGui.Selectable(smf_files[i_], smf_selected_)) {
                    smf_selected_index = i_;
                    smf_viewer_load(smf_files[i_]);
                }
                if (smf_selected_) ImGui.SetItemDefaultFocus();
            }
            ImGui.EndCombo();
        }

        if (smf_inst != undefined) {
            ImGui.Text("Rotation");
            smf_rotx = ImGui.SliderInt("X##smf_rotx", smf_rotx, -180, 180);
            smf_roty = ImGui.SliderInt("Y##smf_roty", smf_roty, -180, 180);
            smf_rotz = ImGui.SliderInt("Z##smf_rotz", smf_rotz, -180, 180);

            var smf_preview_size_ = 300;
            if (!surface_exists(smf_preview_surface)) {
                smf_preview_surface = surface_create(smf_preview_size_, smf_preview_size_);
            }

            smf_inst.step(TIMESTEP);

            surface_set_target(smf_preview_surface);
            draw_clear(BLACK);

            //draws to a surface the same way obj_3d_smf draws into the room -
            //same shader/z-test toggle/scale, just parked at the surface's
            //center instead of an instance's room x/y
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);

            shader_set(sh_3d_animated);
            matrix_set(matrix_world, matrix_build(smf_preview_size_*0.5, smf_preview_size_*0.5, -100, smf_rotx, smf_roty, smf_rotz, SCALE_3D, SCALE_3D, SCALE_3D));
            smf_inst.draw();
            matrix_set(matrix_world, matrix_build_identity());
            shader_reset();

            gpu_set_ztestenable(false);
            gpu_set_zwriteenable(false);

            surface_reset_target();

            ImGui.Surface(smf_preview_surface);
        } else if (smf_error != undefined) {
            ImGui.TextDisabled("Failed to load model:");
            ImGui.TextWrapped(smf_error);
        } else {
            ImGui.TextDisabled("No model loaded");
        }
    }
    ImGui.End();
}
#endregion



#endregion

#endregion

ImGui.PopFont()
ImGui.PopStyleVar(7)
ImGui.PopStyleColor(35)

//if(ImGui.Begin("Center")){
    //ImGui.End()
//}
//if(ImGui.Begin("Hitboxes")){
    //ImGui.End()
//}
//if(ImGui.Begin("Timeline")){
    //ImGui.End()
//}


//var menu_size_ = 300;
//
//#region left panel
//ImGui.SetNextWindowPos(0,0);
//ImGui.SetNextWindowSize(menu_size_,window_get_height());
//if (ImGui.Begin("Left",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)){
    //if(ImGui.Button("Save")){
        //ImGui.OpenPopup("Save Changes?")
    //}
        //
    //if (ImGui.BeginPopupModal("Save Changes?",, ImGuiWindowFlags.AlwaysAutoResize)) {
        //ImGui.Text("Save Changes?");
        //ImGui.Separator();
        //
        //if (ImGui.Button("Save")){
            //save()
            //ImGui.CloseCurrentPopup()
        //} 
        //ImGui.SetItemDefaultFocus();
        //ImGui.SameLine();
        //if (ImGui.Button("Cancel")){
            //ImGui.CloseCurrentPopup()  
        //} 
        //ImGui.EndPopup();
    //}
    //
    //if(ImGui.Button("Add Layer")){
        //add_layer(add_layer_type);
    //}
    //
    //ImGui.SameLine();
    //var preview_val_ = add_layer_types[add_layer_type];
    //ImGui.SetNextItemWidth(180);
    //if (ImGui.BeginCombo("##combo",preview_val_,ImGuiComboFlags.None)){
        //for (var i_ = 0; i_ < array_length(add_layer_types); ++i_) {
            //var selected_ = add_layer_type == i_;
            //if(ImGui.Selectable(add_layer_types[i_],selected_)){
                //add_layer_type = i_;	
            //}
            //if(selected_) ImGui.SetItemDefaultFocus(); 
        //}
        //ImGui.EndCombo();
    //}
    //
    //ImGui.Separator();
	//ImGui.Spacing();
    //
    
    //
    //if(layer_active != undefined){
        //#region move layer
        //
        //var depth_ = layer_get_depth(layer_active.id);
        //var depth_top_ = layer_get_depth(layers[0].id);
        //var depth_bottom_ = layer_get_depth(layers[array_length(layers)-1].id);
        //
        //var depth_new_ = depth_;
        //
        //if(ImGui.Button("Up")){
            //if(layer_index > 1){
                //var depth_1_ = layer_get_depth(layers[layer_index-1].id);
                //var depth_2_ = layer_get_depth(layers[layer_index-2].id);
                //depth_new_ = floor(lerp(depth_1_,depth_2_,0.5));
            //} else if(layer_index > 0){
                //depth_new_ = depth_top_ - 100;
            //}
        //}
        //ImGui.SameLine()
        //if(ImGui.Button("Down")){
            //if(layer_index < array_length(layers) - 2){
                //var depth_1_ = layer_get_depth(layers[layer_index+1].id);
                //var depth_2_ = layer_get_depth(layers[layer_index+2].id);
                //depth_new_= floor(lerp(depth_1_,depth_2_,0.5));
            //} else if(layer_index < array_length(layers) - 1){
                //depth_new_ = depth_bottom_ + 100;
            //}
        //}
        //ImGui.SameLine()
        //if(ImGui.Button("Top")){
            //if(layer_get_depth(layer_active.id) != depth_top_){
                //depth_new_= depth_top_ - 100;
            //}
        //}
        //ImGui.SameLine()
        //if(ImGui.Button("Bottom")){
            //if(layer_get_depth(layer_active.id) != depth_bottom_){
                //depth_new_ = depth_bottom_ + 100;
            //}
        //}
        //
        //var input_int_ = ImGui.InputInt("Depth",depth_,10,100);
        //if(input_int_ != depth_) depth_new_ = input_int_;
            //
        //if(depth_new_ != depth_){
            //struct_set_chained(global.room_data,depth_new_,"layers",layer_active.name,"depth");
            //layer_depth(layer_active.id,depth_new_);
            //layers_depth_order();
        //}
        //
        //#endregion
        //
        //#region offset
        //offset_x = ImGui.InputInt("offset X",offset_x,1,10);
        //offset_y = ImGui.InputInt("offset Y",offset_y,1,10);
        //struct_set_chained(global.room_data,offset_x,"layers",layer_active.name,"offset_x");
        //struct_set_chained(global.room_data,offset_y,"layers",layer_active.name,"offset_y");
        //#endregion
        //
        //#region parralax slider
        //parralax_x = ImGui.SliderFloat("Parralax X",parralax_x,-1,1,"%.2f");
        //parralax_y = ImGui.SliderFloat("Parralax Y",parralax_y,-1,1,"%.2f");
        //struct_set_chained(global.room_data,parralax_x,"layers",layer_active.name,"parralax_x");
        //struct_set_chained(global.room_data,parralax_y,"layers",layer_active.name,"parralax_y");
        //#endregion
    //}
    //
    //#region delete layer
    //if(layer_active != undefined){
        //
        //ImGui.SetCursorPosY(ImGui.GetCursorPosY() + max(0, ImGui.GetContentRegionAvailY() - (ImGui.GetTextLineHeightWithSpacing() + 5 )));
        //if(ImGui.Button("Delete layer")){
            //ImGui.OpenPopup("Delete Layer?")
        //}
        //
        //if (ImGui.BeginPopupModal("Delete Layer?",, ImGuiWindowFlags.AlwaysAutoResize)) {
            //ImGui.Text("Delete layer?");
            //ImGui.Separator();
            //
            //if (ImGui.Button("Delete")){
                //delete_layer(layer_index);
                //ImGui.CloseCurrentPopup();
            //} 
            //ImGui.SetItemDefaultFocus();
            //ImGui.SameLine();
            //if (ImGui.Button("Cancel")){
                //ImGui.CloseCurrentPopup()  
            //} 
            //ImGui.EndPopup();
        //}
    //}
    //#endregion
    //
    //ImGui.End()
//}
//#endregion
//
//#region right panel
//
//ImGui.SetNextWindowPos(window_get_width()-menu_size_,0);
//ImGui.SetNextWindowSize(menu_size_,window_get_height());
//ImGui.Begin("Right",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)
//if(layer_active != undefined){
    //ImGui.Text("Hiii");
    //#region selecting tiles
    //if(layer_active.type == LAYER_TYPE.TILEMAP){
        //
        //#region tileset
            //
        //ImGui.Text("Tileset:");
        //ImGui.BeginChild("Tileset",,menu_size_);
        //
        //if(element_active != noone){
            ////also instance tileset
            ////TODO consider making updating tiledata surfaces it's own function
        //}
        //
        //if(!surface_exists(tileset_surface)){
            //tileset_surface = surface_create(menu_size_,menu_size_);
        //}
        //surface_set_target(tileset_surface);
        //draw_clear(BLACK);
        //
        //if(element_active != noone){
            //draw_sprite_tiled(spr_bg_checker_grid,0,0,0);
    		//if(ImGui.IsWindowHovered() ){ 
    			////zoom (centered on view)
    			//var zoom_ = mouse_wheel_down() - mouse_wheel_up();
    			//if(zoom_ != 0){
    				//var tiles_size_prev_ = tiles_size;
    				//tiles_size = clamp(tiles_size + zoom_*log2(tiles_size)*10, 64, 1024);
    				//if (tiles_size != tiles_size_prev_) { 
    					//var factor_ = tiles_size_prev_ / tiles_size;
    					//var center_ = menu_size_ * 0.5;
    					//// adjust translation so the center point stays fixed when scaling
    					//tiles_x = center_ - (center_ - tiles_x) * factor_;
    					//tiles_y = center_ - (center_ - tiles_y) * factor_;
    				//}
    			//}
    			////dragging
    			//if (mouse_check_button(mb_middle)){
    				//tiles_x -= mouse_spd_h_;
    				//tiles_y -= mouse_spd_v_;
    			//}
    		//}
            //
            //var scale_ = menu_size_ / tiles_size;
            //
            ////zooms and offsets view
            //matrix_set(matrix_world,matrix_build(tiles_x,tiles_y,0,0,0,0,scale_,scale_,0));
    		//
    		//var tiles_width_  = ds_grid_width( tileset_tiles);
    		//var tiles_height_ = ds_grid_height(tileset_tiles);
    		//draw_grid_tiles(tileset_tiles,tileset,0,0);
    		//draw_grid(0,0,grid_cell_w,grid_cell_h,tiles_width_,tiles_height_,1);
            ////Here
    		//
    		//if(ImGui.IsWindowHovered() ){ 
    			//var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
    			//var hover_x_ = ((mx_-xx_ - tiles_x) / scale_);
    			//var hover_y_ = ((my_-yy_ - tiles_y) / scale_);
    			//
    			//hover_x_ = hover_x_ div grid_cell_w;
    			//hover_y_ = hover_y_ div grid_cell_h;
    				//
    			//set_draw(WHITE,0.5);
    			//draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
    			//reset_draw();
    			//
    			//if(mouse_check_button_pressed(mb_left)){
    				//var brush_ = ds_grid_get(tileset_tiles,hover_x_,hover_y_);
    				//if(brush_ != undefined){
                        //brush = ds_grid_create(1,1);
                        //ds_grid_add(brush,0,0,brush_);
    				//} else brush = -1;
    			//}
    		//}
            //matrix_set(matrix_world,matrix_build_identity());
        //}
        //
        //surface_reset_target();
        //
        //ImGui.Surface(tileset_surface);
        //
        //ImGui.EndChild();
        //
        //#endregion
        //
        //#region tile brushes
        //
        //ImGui.Text("Tile Brushes:");
        //
        //ImGui.BeginChild("Tilebrushes",,menu_size_);
        //
        ////Draws and instances tiledata
        //if(element_active != noone){ 
            //if(!surface_exists(tilebrush_data_surface) || tilebrush_data_update){
                //tilebrush_data_update = false;
                //
                //var brushes_width_ = ds_grid_width(tileset_brushes); 
                //var brushes_height_ = ds_grid_height(tileset_brushes);
                //tilebrush_data_surface = surface_create(brushes_width_*grid_cell_w,brushes_height_*grid_cell_h);
                //
                //surface_set_target(tilebrush_data_surface);    
                //draw_grid_tiles(tileset_brushes,tileset,0,0);
                //set_draw(BLACK,0.5);
                //draw_grid(0,0,grid_cell_w,grid_cell_h,brushes_width_,brushes_height_,1);
                //reset_draw();
                //surface_reset_target();
            //}
        //}
        //
        //if(!surface_exists(tilebrush_surface)){
            //tilebrush_surface = surface_create(menu_size_,menu_size_);
        //}
        //surface_set_target(tilebrush_surface);
        //draw_clear(BLACK);
        //
        //if(element_active != noone){ 
            //draw_sprite_tiled(spr_bg_checker_grid,0,0,0);
    		//if(ImGui.IsWindowHovered() ){ 
    			////zoom (centered on view)
    			//var zoom_ = mouse_wheel_down() - mouse_wheel_up();
    			//if(zoom_ != 0){
    				//var brushes_size_prev_ = brushes_size;
    				//brushes_size = clamp(brushes_size + zoom_*log2(brushes_size)*10, 64, 1024);
    				//if (brushes_size != brushes_size_prev_) { 
    					//var factor_ = brushes_size_prev_ / brushes_size;
    					//var center_ = menu_size_ * 0.5;
    					//// adjust translation so the center point stays fixed when scaling
    					//brushes_x = center_ - (center_ - brushes_x) * factor_;
    					//brushes_y = center_ - (center_ - brushes_y) * factor_;
    				//}
    			//}
    			////dragging
    			//if (mouse_check_button(mb_middle)){
    				//brushes_x -= mouse_spd_h_;
    				//brushes_y -= mouse_spd_v_;
    			//}
    		//}
            //
            //var scale_ = menu_size_ / brushes_size;
            //
            ////zooms and offsets view
            //matrix_set(matrix_world,matrix_build(brushes_x,brushes_y,0,0,0,0,scale_,scale_,0));
    		//
            ////draw instanced tiledata
            //draw_surface(tilebrush_data_surface,0,0);
    		//
    		//if(ImGui.IsWindowHovered(ImGuiHoveredFlags.ChildWindows) ){ 
    			//var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
    			//var hover_x_ = ((mx_-xx_ - brushes_x) / scale_);
    			//var hover_y_ = ((my_-yy_ - brushes_y) / scale_);
    			//
    			//hover_x_ = hover_x_ div grid_cell_w;
    			//hover_y_ = hover_y_ div grid_cell_h;
    				//
    			//set_draw(WHITE,0.5);
    			//draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
    			//reset_draw();
    			//
    			//if(mouse_check_button_pressed(mb_left)){
    				//var brush_ = ds_grid_pick(tileset_brushes,hover_x_,hover_y_);
    				//if(brush_ != undefined){
    					//brush = brush_;
    				//}
    			//}
    		//}
            //matrix_set(matrix_world,matrix_build_identity());
        //}
        //
        //surface_reset_target();
        //
        //ImGui.Surface(tilebrush_surface);
        //
        //ImGui.EndChild();
        //
        //#endregion
    //}
    //#endregion
    //
    //#region sprite assets
    //if(layer_active.type == LAYER_TYPE.ASSET){
        //ImGui.Text("Assets:")
        //ImGui.BeginChild("Assets",,300, ImGuiChildFlags.Borders);
        //for (var i_ = 0; i_ < array_length(layer_active.transforms); i_++) {
            //var transform_ = layer_active.transforms[i_];
            //if(ImGui.Selectable(transform_.name,element_active == transform_)){
                //element_active = transform_;
                //
            //}
        //}
        //ImGui.EndChild();
    //#endregion
    //
    //#region add sprite element
        //ImGui.Text("Add sprites:")
        //ImGui.BeginChild("Sprites",,300, ImGuiChildFlags.Borders);
        //var sprites_ = asset_get_ids(asset_sprite);
        //for (var i_ = 0; i_ < array_length(sprites_); i_++) {
            //var sprite_ = sprites_[i_];
            //var cursor_pos_ = ImGui.GetCursorPosX();
            //if(ImGui.Selectable("     "+sprite_get_name(sprite_),false)){
                //add_sprite(sprite_);
            //}
            //ImGui.SameLine();
            //ImGui.SetCursorPosX(cursor_pos_);
            //ImGui.Image(sprite_,0,WHITE,1,20,20);
        //}
        //ImGui.EndChild();
    //}
    //#endregion
    //
    //ImGui.End()
//}
    //
//#endregion
//#endregion
//
//#region tile placing / asset moving
//if(layer_active != undefined){   
    //if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !ImGui.IsAnyItemActive()){
    	//
    	//if(layer_active.type == LAYER_TYPE.TILEMAP){
    		////tile drawing
            ////TODO:
            ////Make it so it only pastes once, until the mouse has moved the brushes length away again
            ////floor snapping based on the width/height maybe
                //
            //if(tileset != undefined){
                //if(ds_exists(brush,ds_type_grid)){
                    ////rotate brush
                    //if(keyboard_check_pressed(ord("Z"))){
                        //var clockwise_ = !keyboard_check(vk_shift);
                        //brush_rotate(brush,clockwise_);
                    //}
                    //
                    ////mirror brush
                    //if(keyboard_check_pressed(ord("X"))){
                        //brush_mirror(brush);
                    //}
                    //
                    ////flip brush
                    //if(keyboard_check_pressed(ord("Y"))){
                        //brush_flip(brush);
                    //}
                    //
                    //if(InputMouseCheck(mb_left) || InputMouseCheck(mb_right)){
                        //var brush_offset_x_ = (ds_grid_width( brush)*grid_cell_w / 2)-grid_cell_w/2;
                        //var brush_offset_y_ = (ds_grid_height(brush)*grid_cell_h / 2)-grid_cell_h/2;
                        //
                        //var cx_ = floor((rmx_-brush_offset_x_)/grid_cell_w);
                        //var cy_ = floor((rmy_-brush_offset_y_)/grid_cell_h);
                        //
                        //if (InputMouseCheck(mb_left)){
                            //paste_tile_grid(tilemap,brush,cx_,cy_);
                        //}
                        //
                        //if (InputMouseCheck(mb_right)){ 
                            ////uses brush to erase tiles
                            //erase_tile_grid(tilemap,brush,cx_,cy_);
                        //}
                    //}
                //}
            //}
    	//}
    	//else if(layer_active.type == LAYER_TYPE.ASSET){
    		////asset manipulation
    		//var offset_x_ = floor(global.camera.get_x() * parralax_x) + offset_x;
    		//var offset_y_ = floor(global.camera.get_y() * parralax_y) + offset_y;
    		//
    		//var x_ = rmx_-offset_x_;
    		//var y_ = rmy_-offset_y_;
    		//
    		////transforms already selecteed asset
    		//if(element_active == noone){
    			////selects asset at position
    			//if(mouse_check_button_pressed(mb_left)){
    				//element_active = instance_position(x_,y_,obj_asset_transform);
    			//}
    		//}
    	//}
    //}
//}
//#endregion

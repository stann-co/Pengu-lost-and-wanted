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

//true while an ImGui text field (eg the script editor popup) has focus -
//silences single-key shortcuts/camera pan instead of guarding each by hand
var typing_in_imgui_ = ImGui.WantTextInput();
if (typing_in_imgui_) { arrows_h_ = 0; arrows_v_ = 0; }

 //mouse delta movement
var mouse_spd_h_ = -window_mouse_get_delta_x(); //display
var mouse_spd_v_ = -window_mouse_get_delta_y();
var mouse_spd_x_ = mouse_spd_h_ / stanncam_get_res_scale_x(); //room
var mouse_spd_y_ = mouse_spd_v_ / stanncam_get_res_scale_y();

var mx_ = window_mouse_get_x(); //display mouse
var my_ = window_mouse_get_y();
    
var rmx_ = global.camera.get_mouse_x(); //room mouse
var rmy_ = global.camera.get_mouse_y();

//captured before reference picking resolves below, so the same click that
//resolves/cancels a pick doesn't fall through to normal select handling
var was_picking_reference_ = picking_reference_owner != noone;

#endregion

#region reference picking
//eyedropper for a REFERENCE custom variable, armed by its field's button -
//left click accepts a valid target, right click/empty space cancels
picking_hover_uid = noone;
if (was_picking_reference_ && !ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow)) {
    with (obj_editor_instance) {
        if (element_uid == other.picking_reference_owner) continue;
        var pick_layer_ = other.find_layer_by_layer_id(layer);
        if (pick_layer_ == undefined || pick_layer_.locked) continue;
        if (!other.element_reference_object_accepted(asset_get_index(object_name), other.picking_reference_accepted)) continue;

        var pick_pm_ = parralax_offset(rmx_, rmy_, (TILE_SIZE*TILE_SIZE) / parralax_effective(parralax_x), (TILE_SIZE*TILE_SIZE) / parralax_effective(parralax_y));
        if (instance_position(pick_pm_.x, pick_pm_.y, id) == id) {
            other.picking_hover_uid = id;
            break;
        }
    }

    if (mouse_check_button_pressed(mb_right)) {
        picking_reference_owner = noone;
    } else if (mouse_check_button_pressed(mb_left)) {
        if (picking_hover_uid != noone) {
            picking_reference_on_pick(picking_hover_uid.element_name);
        }
        picking_reference_owner = noone; //also cancels on an empty/invalid click
    }
} else if (was_picking_reference_ && mouse_check_button_pressed(mb_right)) {
    picking_reference_owner = noone; //right click cancels even over an ImGui window
}
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
    
    //zoom - multiplicative (constant % per tick), not additive, so steps
    //feel the same size whether zoomed way in or way out
    var zoom_ = mouse_wheel_up() - mouse_wheel_down();
    if(zoom_ != 0){
        var zoom_step_ = 1.1;
        var new_zoom_ = (zoom_ > 0) ? (global.camera.zoom_amount / zoom_step_) : (global.camera.zoom_amount * zoom_step_);
        zoom_ = clamp(new_zoom_, 0.5, 16);
        global.camera.zoom(zoom_,0);
    }
}

if(hspd_ != 0 || vspd_ != 0){
    camera_x += hspd_;
    camera_y += vspd_;

    global.camera.move(camera_x, camera_y);
}


#endregion

#region tile placing / asset moving
//while held, re-applying is throttled to once per brush-width/height of
//movement rather than every frame
if (!mouse_check_button(mb_left)){
    tile_paint_active = false; 
    brush_paint_active = false; 
}  
if (!mouse_check_button(mb_right)){ 
    tile_erase_active = false;
    brush_erase_active = false;   
}

if(layer_active != undefined){
    if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !ImGui.IsAnyItemActive()){

    	if(layer_active.type == LAYER_TYPE.TILEMAP){
    		//tile drawing
            refresh_tileset_tiles();

            if(layer_active.tileset != undefined && layer_active.tilemap != undefined){
                //undoes obj_tilemap's own view-matrix scaling around the camera
                //center, so painting lands on whichever raw tile cell is under the cursor
                var tile_scale_x_ = parralax_effective(layer_active.parralax_x, grid_cell_w) / grid_cell_w;
                var tile_scale_y_ = parralax_effective(layer_active.parralax_y, grid_cell_w) / grid_cell_w;
                var inv_ = parralax_offset(rmx_, rmy_, TILE_SIZE / tile_scale_x_, TILE_SIZE / tile_scale_y_);
                var tmx_ = inv_.x;
                var tmy_ = inv_.y;

                if(ds_exists(brush,ds_type_grid)){
                    if (tool_mode == TOOL_MODE.DRAW) {
                        if(InputMouseCheck(mb_left) || InputMouseCheck(mb_right)){
                            var brush_w_ = ds_grid_width( brush);
                            var brush_h_ = ds_grid_height(brush);
                            var brush_offset_x_ = (brush_w_*grid_cell_w / 2)-grid_cell_w/2;
                            var brush_offset_y_ = (brush_h_*grid_cell_h / 2)-grid_cell_h/2;

                            var cx_ = floor((tmx_-brush_offset_x_)/grid_cell_w);
                            var cy_ = floor((tmy_-brush_offset_y_)/grid_cell_h);

                            if (InputMouseCheck(mb_left)){
                                var paint_due_ = !tile_paint_active || abs(cx_-tile_paint_last_x) >= brush_w_ || abs(cy_-tile_paint_last_y) >= brush_h_;
                                if (paint_due_) {
                                    action_paste_tile_grid(layer_active.tilemap,brush,cx_,cy_);
                                    tile_paint_active = true;
                                    tile_paint_last_x = cx_;
                                    tile_paint_last_y = cy_;
                                }
                            }

                            if (InputMouseCheck(mb_right)){
                                //uses brush to erase tiles
                                var erase_due_ = !tile_erase_active || abs(cx_-tile_erase_last_x) >= brush_w_ || abs(cy_-tile_erase_last_y) >= brush_h_;
                                if (erase_due_) {
                                    action_erase_tile_grid(layer_active.tilemap,brush,cx_,cy_);
                                    tile_erase_active = true;
                                    tile_erase_last_x = cx_;
                                    tile_erase_last_y = cy_;
                                }
                            }
                        }
                    } else {
                        //Line/Square/Selection need to keep tracking the mouse even
                        //after release (to detect it and commit), unlike Draw above
                        var tool_hover_x_ = floor(tmx_/grid_cell_w);
                        var tool_hover_y_ = floor(tmy_/grid_cell_h);
                        tool_interact(layer_active.tilemap, tool_hover_x_, tool_hover_y_);
                    }
                }
            }
    	}
    }
}
#endregion

#region element placement
//dragging an object/sprite from the Resources window (see resource_tree_draw)
//and dropping it on the viewport places an obj_editor_instance/obj_editor_sprite there
if (layer_active != undefined && (layer_active.type == LAYER_TYPE.INSTANCE || layer_active.type == LAYER_TYPE.ASSET)) {
    //elements on this layer render shifted by parralax_offset, so mouse
    //interaction goes through its inverse to land on their actual world position
    var pm_ = parralax_offset(rmx_, rmy_, (TILE_SIZE*TILE_SIZE) / parralax_effective(layer_active.parralax_x), (TILE_SIZE*TILE_SIZE) / parralax_effective(layer_active.parralax_y));
    var pmx_ = pm_.x;
    var pmy_ = pm_.y;

    //clicking a placed element selects it (shift adds, ctrl removes) so its
    //own Step event can drag/rotate/scale it; empty space starts a box-select
    if (mouse_check_button_pressed(mb_left) && !ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !was_picking_reference_) {
        //each element only shifts its render anchor by parralax_offset, its own
        //size never scales (see Draw_0) - so hit-testing has to forward-transform
        //each candidate to its rendered position and test the raw mouse there,
        //not inverse-transform the mouse once and test raw (unshifted) masks.
        //instance_corners (rotation-aware) + point_in_box instead of a mask-based
        //check - GameMaker's rectangle collision masks ignore image_angle entirely
        var clicked_inst_ = noone;
        var click_layer_ = layer_active.layer;
        with (obj_asset_transform) {
            if (layer != click_layer_) continue;
            var anchor_ = parralax_offset(x, y, parralax_effective(parralax_x), parralax_effective(parralax_y));
            var dx_ = anchor_.x - x;
            var dy_ = anchor_.y - y;
            var c_ = instance_corners(id);
            var hit_ = point_in_box(rmx_, rmy_, c_.tl.x+dx_, c_.tl.y+dy_, c_.tr.x+dx_, c_.tr.y+dy_, c_.bl.x+dx_, c_.bl.y+dy_, c_.br.x+dx_, c_.br.y+dy_);
            if (hit_) {
                clicked_inst_ = id;
                break;
            }
        }

        if (clicked_inst_ != noone) {
            var in_selection_ = array_get_index(elements_selected, clicked_inst_) != -1;
            if (keyboard_check(vk_shift)) {
                if (!in_selection_) array_push(elements_selected, clicked_inst_);
                element_active = clicked_inst_;
            } else if (keyboard_check(vk_control)) {
                if (in_selection_) array_delete(elements_selected, array_get_index(elements_selected, clicked_inst_), 1);
                if (element_active == clicked_inst_) {
                    element_active = array_length(elements_selected) > 0 ? elements_selected[array_length(elements_selected)-1] : noone;
                }
            } else {
                //clicking a member of the current selection keeps the whole group
                //selected (draggable together) - only a new element replaces it
                var already_selected_ = in_selection_ || element_active == clicked_inst_;
                if (!already_selected_) elements_selected = [clicked_inst_];
                element_active = clicked_inst_;
            }
        } else {
            //missing the sprite mask isn't necessarily empty space - handles
            //reach past it, and gaps between grouped elements sit inside their bounds
            var bounds_ = selection_bounds();
            var handle_margin_ = 8;
            var within_selection_ = bounds_ != undefined
                && rmx_ >= bounds_.min_x-handle_margin_ && rmx_ <= bounds_.max_x+handle_margin_
                && rmy_ >= bounds_.min_y-handle_margin_ && rmy_ <= bounds_.max_y+handle_margin_;

            if (!within_selection_) {
                box_select_active = true;
                //raw mouse/render space, not the world-space pmx_/pmy_ - box-select
                //compares against each element's rendered (anchor-shifted) corners,
                //same reasoning as the click-select hit test above
                box_select_start_x = rmx_;
                box_select_start_y = rmy_;
                if (!keyboard_check(vk_shift) && !keyboard_check(vk_control)) {
                    elements_selected = [];
                    element_active = noone;
                }
            }
        }
    }

    if (box_select_active && mouse_check_button_released(mb_left)) {
        var box_x1_ = min(box_select_start_x, rmx_);
        var box_x2_ = max(box_select_start_x, rmx_);
        var box_y1_ = min(box_select_start_y, rmy_);
        var box_y2_ = max(box_select_start_y, rmy_);

        var box_remove_ = keyboard_check(vk_control);
        var box_layer_ = layer_active.layer;
        with (obj_asset_transform) {
            if (layer != box_layer_) continue;

            //shifted by the same anchor offset Draw_0 renders at - the element's
            //own size never scales with parralax, only its anchor position does
            var anchor_ = parralax_offset(x, y, parralax_effective(parralax_x), parralax_effective(parralax_y));
            var dx_ = anchor_.x - x;
            var dy_ = anchor_.y - y;
            var corners_ = instance_corners(id);
            var min_x_ = min(corners_.tl.x, corners_.tr.x, corners_.bl.x, corners_.br.x) + dx_;
            var max_x_ = max(corners_.tl.x, corners_.tr.x, corners_.bl.x, corners_.br.x) + dx_;
            var min_y_ = min(corners_.tl.y, corners_.tr.y, corners_.bl.y, corners_.br.y) + dy_;
            var max_y_ = max(corners_.tl.y, corners_.tr.y, corners_.bl.y, corners_.br.y) + dy_;
            if (max_x_ < box_x1_ || min_x_ > box_x2_ || max_y_ < box_y1_ || min_y_ > box_y2_) continue;

            var box_idx_ = array_get_index(other.elements_selected, id);
            if (box_remove_) {
                if (box_idx_ != -1) array_delete(other.elements_selected, box_idx_, 1);
                if (other.element_active == id) other.element_active = noone;
            } else {
                if (box_idx_ == -1) array_push(other.elements_selected, id);
                other.element_active = id;
            }
        }

        if (element_active == noone && array_length(elements_selected) > 0) {
            element_active = elements_selected[array_length(elements_selected)-1];
        }
        box_select_active = false;
    }

    if (mouse_check_button_released(mb_left) && !ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow)) {
        if (layer_active.type == LAYER_TYPE.INSTANCE && ImGui.GetDragDropPayloadType() == "object_drag") {
            action_place_instance(ImGui.GetDragDropPayload(), pmx_, pmy_);
        } else if (layer_active.type == LAYER_TYPE.ASSET && ImGui.GetDragDropPayloadType() == "sprite_drag") {
            action_place_sprite(ImGui.GetDragDropPayload(), pmx_, pmy_);
        }
    }

    //DEL deletes the current selection - Ctrl+X/Ctrl+C/Ctrl+V live in the
    //viewport toolbar instead, next to their buttons
    if (!ImGui.IsAnyItemActive()) {
        if (keyboard_check_pressed(vk_delete)) {
            action_delete_selected();
        }
        if (keyboard_check_pressed(ord("F"))) {
            goto_selected();
        }
    }
}
#endregion

#region imgui -----------------------------------------------------
     ImGui.__Update();

    #region reference picking cursor
    //window_set_cursor calls before ImGui.__Update() get overwritten by its own
    //cursor handling, so this runs after it - same for SetTooltip (needs a frame)
    if (was_picking_reference_) {
        window_set_cursor(picking_hover_uid != noone ? cr_handpoint : cr_cross);
        if (picking_hover_uid != noone) {
            ImGui.SetTooltip(picking_hover_uid.object_name + " [" + picking_hover_uid.element_name + "]");
        }
    }
    #endregion

    #region imgui styling
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
    ImGui.PushStyleColor(ImGuiCol.CheckMark, dark_mode ? c_white : c_dkgray, 1)
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
    
    #endregion
    
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
                open_level_from_dialog();
            }

            if (ImGui.BeginMenu("Open Recent", array_length(recent_levels) > 0)){
                for (var i_ = 0; i_ < array_length(recent_levels); i_++) {
                    if (ImGui.MenuItem(recent_levels[i_])){
                        //the file may have moved/been deleted since it was last opened -
                        //drop it from the list instead of silently doing nothing
                        if (!open_level(recent_levels[i_])) {
                            array_delete(recent_levels, i_, 1);
                            save_editor_settings();
                        }
                    }
                }
                ImGui.EndMenu()
            }

            ImGui.Separator();

            //no level open yet (current_level_path == undefined) - Save behaves
            //like Save As, since there's nowhere to save back to
            if (ImGui.MenuItem("Save Level")){
                if (current_level_path == undefined) save_level_as(); else save_level(current_level_path);
            }
            if (ImGui.MenuItem("Save Level as")){
                save_level_as();
            }

            ImGui.EndMenu()
        }
        #endregion

        #region tools menu
        if (ImGui.BeginMenu("Tools")){

            if (ImGui.MenuItem("Regenerate Resource Tree")) {
                regenerate_resource_tree();
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

        #region opened level name
        //right-aligned in the menu bar - no CalcTextSize in this build, so measure
        //by drawing invisibly first (alpha 0) via GetItemRectSizeX, then draw for real
        var level_label_ = global.level != undefined ? global.level : "(untitled)";
        //most edits go through undo_stack - comparing its depth to the last
        //save/load catches those; level_dirty covers the edits that don't
        var level_is_dirty_ = level_dirty || (array_length(undo_stack) != saved_undo_depth);
        if (level_is_dirty_) level_label_ += "*";

        ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0);
        ImGui.Text(level_label_);
        ImGui.PopStyleVar();
        var level_label_width_ = ImGui.GetItemRectSizeX();

        ImGui.SetCursorPosX(ImGui.GetWindowWidth() - level_label_width_ - 8);
        ImGui.TextDisabled(level_label_);
        if (ImGui.IsItemHovered() && current_level_path != undefined) ImGui.SetTooltip(current_level_path);
        #endregion

        ImGui.EndMainMenuBar()
    }
    
    #endregion
    
    #region floating toolbar
    if (ImGui.BeginViewportSideBar("##EditorToolbar", 0, ImGuiDir.Up, toolbar_height, ImGuiWindowFlags.NoScrollbar)) {
        //no level open yet (current_level_path == undefined) - Save behaves
        //like Save As, since there's nowhere to save back to
        if ( icon_button(ICON.SAVE) ) {
            if (current_level_path == undefined) save_level_as(); else save_level(current_level_path);
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Save Level");
        ImGui.SameLine();

        if ( icon_button(ICON.FOLDER_OPEN) ) {
            open_level_from_dialog();
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Open Level");
        ImGui.SameLine();

        if (icon_button(ICON.HOME) || (keyboard_check_pressed(vk_home) && !ImGui.IsAnyItemActive())) {
            //playtest: save, then swap the editor's placeholder layers
            //for the real game objects via load_level
            if (current_level_path == undefined){
				save_level_as();
			} else save_level(current_level_path);
			save_brush_tilemap();

            if (current_level_path != undefined) {
                destroyed = true;
				call_later(10,time_source_units_frames,function(){ //so pressing home doesn't immedietly start it up again
					obj_game.level_editor_active = false;
				})
            }
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Playtest (Home)");
        ImGui.SameLine();

        ImGui.SetNextItemWidth(120);
        global.parralax = round(ImGui.SliderFloat("Parralax Scale", global.parralax, 0, 2, "%.2f") * 10) / 10;
        ImGui.End();
    }
    #endregion
    
    #region left side panel (dockspace)
    //reset once per frame - each resize handle only ever sets cr_size_we, never
    //resets to default, so whichever ran last can't stomp on the other's cursor
    window_set_cursor(cr_default);

    //dockspace host: always hosted so docked windows stay associated with it even
    //while hidden - when hidden it's hosted in an off-screen window instead
    var left_dock_flags_ = left_panel_visible ? ImGuiDockNodeFlags.None : ImGuiDockNodeFlags.KeepAliveOnly;
    if (left_panel_visible) {
        if (ImGui.BeginViewportSideBar("##EditorLeftDock", 0, ImGuiDir.Left, left_panel_width, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoScrollWithMouse)) {
            ImGui.DockSpace(dock_id_left, 0, 0, left_dock_flags_);
            left_panel_width = clamp(left_panel_width + panel_resize_handle(true), 150, 800);
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
        if (ImGui.BeginViewportSideBar("##EditorRightDock", 0, ImGuiDir.Right, right_panel_width, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoScrollWithMouse)) {
            ImGui.DockSpace(dock_id_right, 0, 0, right_dock_flags_);
            right_panel_width = clamp(right_panel_width - panel_resize_handle(false), 150, 800);
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

    #region status bar
    //room-space mouse position, for figuring out coordinates to place things at
    if (ImGui.BeginViewportSideBar("##EditorStatusBar", 0, ImGuiDir.Down, status_bar_height, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoBackground)) {
        var mouse_text_ = $"Mouse: {round(rmx_)}, {round(rmy_)}";

        //backdrop so the text stays readable over busy level content -
        //the strip itself is NoBackground, so nothing else darkens it
        var text_x_ = ImGui.GetCursorScreenPosX();
        var text_y_ = ImGui.GetCursorScreenPosY();
        var text_w_ = ImGui.CalcTextWidth(mouse_text_);
        var text_h_ = ImGui.GetFrameHeight();
        var pad_ = 4;
        ImGui.DrawListAddRectFilled(ImGui.GetWindowDrawList(), text_x_-pad_, text_y_-pad_, text_x_+text_w_+pad_, text_y_+text_h_-pad_, BLACK, 0.5);

        ImGui.Text(mouse_text_);
        ImGui.End();
    }
    #endregion

    #region viewport toolbar
    if (ImGui.BeginViewportSideBar("##ViewportToolbar", 0, ImGuiDir.Up, viewport_toolbar_height, ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoBackground)) {

        //Undo
        ImGui.BeginDisabled(array_length(undo_stack) <= 0);
        var undo_clicked_ = icon_button(ICON.UNDO);
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Undo (Ctrl+Z)");
        ImGui.EndDisabled();
        if (undo_clicked_ || (keyboard_check(vk_control) && !keyboard_check(vk_shift) && keyboard_check_pressed(ord("Z")) && !ImGui.IsAnyItemActive())) {
            action_undo();
        }
        ImGui.SameLine();

        //Redo
        ImGui.BeginDisabled(array_length(redo_stack) <= 0);
        var redo_clicked_ = icon_button(ICON.REDO);
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Redo (Ctrl+Shift+Z)");
        ImGui.EndDisabled();
        if (redo_clicked_ || (keyboard_check(vk_control) && keyboard_check(vk_shift) && keyboard_check_pressed(ord("Z")) && !ImGui.IsAnyItemActive())) {
            action_redo();
        }
        ImGui.SameLine();

        //room-space mouse position, parralax-corrected same as element
        //placement - redone locally since that pmx_/pmy_ only exists there
        var clip_x_ = rmx_;
        var clip_y_ = rmy_;
        if (layer_active != undefined) {
            var clip_pm_ = parralax_offset(rmx_, rmy_, (TILE_SIZE*TILE_SIZE) / parralax_effective(layer_active.parralax_x), (TILE_SIZE*TILE_SIZE) / parralax_effective(layer_active.parralax_y));
            clip_x_ = clip_pm_.x;
            clip_y_ = clip_pm_.y;
        }

        //Cut
        ImGui.BeginDisabled(array_length(get_selected_elements()) <= 0);
        var cut_clicked_ = icon_button(ICON.ERASER);
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Cut (Ctrl+X)");
        ImGui.EndDisabled();
        if (cut_clicked_ || (keyboard_check(vk_control) && keyboard_check_pressed(ord("X")) && !ImGui.IsAnyItemActive())) {
            action_cut_selected();
        }
        ImGui.SameLine();

        //Copy
        ImGui.BeginDisabled(array_length(get_selected_elements()) <= 0);
        var copy_clicked_ = icon_button(ICON.COPY);
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Copy (Ctrl+C)");
        ImGui.EndDisabled();
        if (copy_clicked_ || (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")) && !ImGui.IsAnyItemActive())) {
            action_copy_selected();
        }
        ImGui.SameLine();

        //Paste
        ImGui.BeginDisabled(array_length(clipboard) <= 0);
        var paste_clicked_ = icon_button(ICON.CLIPBOARD);
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Paste (Ctrl+V)");
        ImGui.EndDisabled();
        if (paste_clicked_ || (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) && !ImGui.IsAnyItemActive())) {
            action_paste_clipboard(clip_x_, clip_y_);
        }
        ImGui.SameLine();

        //vertical separator - the wrapper's Separator() only draws full-width
        //horizontal outside menu-bar layouts, so a short line is drawn by hand
        var sep_height_ = ImGui.GetFrameHeight();
        var sep_x_ = ImGui.GetCursorScreenPosX() + 4;
        var sep_y_ = ImGui.GetCursorScreenPosY();
        ImGui.DrawListAddLine(ImGui.GetWindowDrawList(), sep_x_, sep_y_, sep_x_, sep_y_ + sep_height_, c_gray, 0.8, 1);
        ImGui.Dummy(9, sep_height_);
        ImGui.SameLine();

        //Mirror
        if (icon_button(ICON.FLIP_HORIZONTAL) || (keyboard_check_pressed(ord("X")) && !keyboard_check(vk_control) && !typing_in_imgui_)) {
            if(brush != -1){
                brush_mirror(brush)
            }
            action_transform_selected(function(_inst){ _inst.image_xscale *= -1; });
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Flip X");
        ImGui.SameLine();

        //Flip
        if (icon_button(ICON.FLIP_VERTICAL) || (keyboard_check_pressed(ord("Y")) && !keyboard_check(vk_control) && !typing_in_imgui_)) {
            if(brush != -1){
                brush_flip(brush)
            }
            action_transform_selected(function(_inst){ _inst.image_yscale *= -1; });
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Flip Y");
        ImGui.SameLine();

        //Rotate 90
        if (icon_button(ICON.ANGLE_90) || (keyboard_check_pressed(ord("Z")) && !keyboard_check(vk_control) && !typing_in_imgui_)) {
            var clockwise_ = !keyboard_check(vk_shift);
            if(brush != -1){
                brush_rotate(brush, clockwise_)
            }
            action_transform_selected(method({clockwise_: clockwise_}, function(_inst){ _inst.image_angle += clockwise_ ? -90 : 90; }));
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Rotate 90°");
        ImGui.SameLine();

        //Tool mode (Draw/Line/Square/Selection) only makes sense on a tilemap
        //layer - hidden entirely otherwise
        var on_tilemap_layer_ = layer_active != undefined && layer_active.type == LAYER_TYPE.TILEMAP;
        var on_element_layer_ = layer_active != undefined && (layer_active.type == LAYER_TYPE.ASSET || layer_active.type == LAYER_TYPE.INSTANCE);

        if (on_tilemap_layer_) {
            //vertical separator, same as above
            var sep_height_ = ImGui.GetFrameHeight();
            var sep_x_ = ImGui.GetCursorScreenPosX() + 4;
            var sep_y_ = ImGui.GetCursorScreenPosY();
            ImGui.DrawListAddLine(ImGui.GetWindowDrawList(), sep_x_, sep_y_, sep_x_, sep_y_ + sep_height_, c_gray, 0.8, 1);
            ImGui.Dummy(9, sep_height_);
            ImGui.SameLine();

            //Tool mode - clicking a button switches tool_mode, others dim to show
            //inactive; governs how the level/brush canvas respond (see tool_interact)
            var tool_icons_ = [ICON.PAINTBRUSH, ICON.LINE, ICON.EDIT, ICON.MARQUEE, ICON.PAINTBUCKET];
            var tool_names_ = ["Draw (D)", "Line (L)", "Square (R)", "Selection (S)", "Fill (F)"];
            var tool_keys_ = [ord("D"), ord("L"), ord("R"), ord("S"), ord("F")];
            for (var i_ = 0; i_ < array_length(tool_icons_); i_++) {
                var tool_active_ = tool_mode == i_;
                if (tool_active_) ImGui.PushStyleColor(ImGuiCol.Button, dark_mode ? c_dkgray : LIGHT_GRAY, 0.8);
                else ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0.7);

                var tool_shortcut_ = keyboard_check_pressed(tool_keys_[i_]) && !ImGui.IsAnyItemActive();
                if (icon_button(tool_icons_[i_], "tool"+string(i_)) || tool_shortcut_) {
                    tool_mode = i_;
                }

                if (tool_active_) ImGui.PopStyleColor();
                else ImGui.PopStyleVar();

                if (ImGui.IsItemHovered()) ImGui.SetTooltip(tool_names_[i_]);
                ImGui.SameLine();
            }

            //Ctrl+C/X copy/cut the selection into a new brush, Delete just erases it
            if (tool_mode == TOOL_MODE.SELECTION && !ImGui.IsAnyItemActive()) {
                if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
                    tool_copy_selection();
                }
                if (keyboard_check(vk_control) && keyboard_check_pressed(ord("X"))) {
                    tool_cut_selection();
                }
                if (keyboard_check_pressed(vk_delete)) {
                    tool_delete_selection();
                }
            }
        }

        //right-aligned: grid toggle, settings dropdown, and (on asset/instance
        //layers) a movement/rotation snap toggle
        var right_btn_size_ = ImGui.GetFrameHeight();
        var right_spacing_ = 4;
        var right_count_ = 2 + (on_element_layer_ ? 1 : 0);
        var right_width_ = right_count_ * right_btn_size_ + (right_count_-1) * right_spacing_;
        ImGui.SetCursorPosX(ImGui.GetWindowWidth() - right_width_ - 8);

        //Grid toggle
        if (show_grid) ImGui.PushStyleColor(ImGuiCol.Button, dark_mode ? c_dkgray : LIGHT_GRAY, 0.8);
        else ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0.7);
        if (icon_button(ICON.GRID, "levelgrid")) {
            show_grid = !show_grid;
        }
        if (show_grid) ImGui.PopStyleColor();
        else ImGui.PopStyleVar();
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Grid");

        //opacity applies to every layer; grid size/snap angle are disabled
        //(not hidden) outside asset/instance layers
        ImGui.SameLine();
        if (icon_button(ICON.MORE_VERTICAL, "gridsettings")) {
            ImGui.OpenPopup("GridSettings");
        }
        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Grid Settings");
        if (ImGui.BeginPopup("GridSettings")) {
            ImGui.Text("Grid Settings");
            ImGui.Separator();

            ImGui.SetNextItemWidth(120);
            var new_grid_opacity_ = ImGui.SliderFloat("Grid Opacity", grid_opacity, 0, 1);
            if (new_grid_opacity_ != grid_opacity) grid_opacity = clamp(new_grid_opacity_, 0, 1);

            if (!on_element_layer_) ImGui.BeginDisabled();

            ImGui.SetNextItemWidth(120);
            var new_grid_size_ = ImGui.InputInt("Grid Size", grid_size, 1, 8);
            if (new_grid_size_ != grid_size) grid_size = max(1, new_grid_size_);

            ImGui.SetNextItemWidth(120);
            var new_snap_degrees_ = ImGui.InputInt("Snap Degrees", snap_degrees, 1, 15);
            if (new_snap_degrees_ != snap_degrees) snap_degrees = clamp(new_snap_degrees_, 1, 180);

            if (!on_element_layer_) ImGui.EndDisabled();

            ImGui.EndPopup();
        }

        //Snap toggle - only meaningful for asset/instance layer elements' free
        //move/rotate (see obj_asset_transform Step); holding ctrl also enables it
        if (on_element_layer_) {
            ImGui.SameLine();
            if (snap_enabled) ImGui.PushStyleColor(ImGuiCol.Button, dark_mode ? c_dkgray : LIGHT_GRAY, 0.8);
            else ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0.7);
            if (icon_button(ICON.MAGNET, "snaptoggle")) {
                snap_enabled = !snap_enabled;
            }
            if (snap_enabled) ImGui.PopStyleColor();
            else ImGui.PopStyleVar();
            if (ImGui.IsItemHovered()) ImGui.SetTooltip("Snap to Grid (hold Ctrl)");
        }

        ImGui.End();

    }
    #endregion
    
    #region dockable tool windows ----------------------------------
        
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
                        if (layer_.type == LAYER_TYPE.TILEMAP) {
                            //the raw layer stays permanently hidden (obj_tilemap
                            //draws it manually) - toggle the instance instead
                            if (instance_exists(layer_.obj_tilemap)) layer_.obj_tilemap.visible = layer_.visible;
                        } else {
                            layer_set_visible(layer_.layer, layer_.visible);
                        }
                        level_dirty = true;
                    }
                    if (ImGui.IsItemHovered()) ImGui.SetTooltip(layer_.visible ? "Hide layer" : "Show layer");
                    ImGui.SameLine();
                    
                    //lock toggle
                    var icon_ = layer_.locked ? ICON.LOCK : ICON.UNLOCK
                    if (icon_button(icon_)) {
                        layer_.locked = !layer_.locked;
                        level_dirty = true;
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
                            if (new_name_ != "" && new_name_ != layer_.name) {
                                //rejects duplicate layer names outright
                                var name_taken_ = false;
                                for (var j_ = 0; j_ < array_length(layers); j_++) {
                                    if (layers[j_] != layer_ && layers[j_].name == new_name_) {
                                        name_taken_ = true;
                                        break;
                                    }
                                }
                                if (!name_taken_) {
                                    layer_.name = new_name_;
                                    level_dirty = true;
                                }
                            }
                            layer_rename_index = -1;
                        }
                    } else {
                        //tinted from the theme base color; disabled rows blend from GRAY
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
                    action_add_layer(unique_layer_name("New Layer"), depth_, add_layer_type);
                }
                ImGui.SameLine()
                var can_remove_ = layer_active != undefined && !layer_active.always;
                if (!can_remove_) ImGui.BeginDisabled();
                if (icon_button(ICON.TRASH)) {
                    action_remove_layer(layer_active);
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

                    //a filled background stretches to the room bounds - parallax/offset
                    //don't apply, so their fields are disabled rather than just ignored
                    var background_fill_ = layer_active.type == LAYER_TYPE.BACKGROUND
                        && instance_exists(layer_active.obj_background) && layer_active.obj_background.background_mode == BACKGROUND_MODE.FILL;

                    ImGui.Text("Depth");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    var depth_ = layer_get_depth(layer_active.layer);
                    ImGui.SetNextItemWidth(field_width_);
                    var new_depth_ = ImGui.InputInt("##depth", depth_);
                    //committed on every change rather than IsItemDeactivatedAfterEdit - the
                    //InputInt +/- step buttons don't reliably trigger deactivation-after-edit
                    if (new_depth_ != depth_) {
                        action_set_depth(layer_active, new_depth_);
                    }

                    if (background_fill_) ImGui.BeginDisabled();

                    ImGui.Text("Parallax X");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_parralax_x_ = ImGui.SliderInt("##parallax_x", layer_active.parralax_x, 0, 32);
                    if (new_parralax_x_ != layer_active.parralax_x) {
                        action_set_parralax(layer_active, new_parralax_x_, parallax_linked ? new_parralax_x_ : layer_active.parralax_y);
                    }

                    ImGui.Text("Parallax Y");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    if (parallax_linked) ImGui.BeginDisabled();
                    var new_parralax_y_ = ImGui.SliderInt("##parallax_y", layer_active.parralax_y, 0, 32);
                    if (!parallax_linked && new_parralax_y_ != layer_active.parralax_y) {
                        action_set_parralax(layer_active, layer_active.parralax_x, new_parralax_y_);
                    }
                    if (parallax_linked) ImGui.EndDisabled();

                    //keeps X/Y equal while dragging either slider - unchecking lets
                    //them diverge, without retroactively touching the other axis
                    var new_parallax_linked_ = ImGui.Checkbox("Link X/Y##parallax_linked", parallax_linked);
                    if (new_parallax_linked_ != parallax_linked) {
                        parallax_linked = new_parallax_linked_;
                        if (parallax_linked && layer_active.parralax_x != layer_active.parralax_y) {
                            action_set_parralax(layer_active, layer_active.parralax_x, layer_active.parralax_x);
                        }
                    }

                    if (background_fill_) ImGui.EndDisabled();

                    if (!can_edit_) ImGui.EndDisabled();

                    //fx is available even on "always" layers (decor/collision/
                    //instances) - only locked actually blocks editing it
                    var can_edit_fx_ = !layer_active.locked;
                    if (!can_edit_fx_) ImGui.BeginDisabled();

                    ImGui.Text("FX");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    if (ImGui.BeginCombo("##layer_fx", global.LAYER_FX[layer_active.fx_index].name, ImGuiComboFlags.None)) {
                        for (var fxi_ = 0; fxi_ < array_length(global.LAYER_FX); fxi_++) {
                            if (ImGui.Selectable(global.LAYER_FX[fxi_].name, fxi_ == layer_active.fx_index)) {
                                var fx_defaults_ = global.LAYER_FX[fxi_].params;
                                var new_fx_params_ = [];
                                for (var pi_ = 0; pi_ < array_length(fx_defaults_); pi_++) {
                                    array_push(new_fx_params_, fx_defaults_[pi_].default_value);
                                }
                                action_set_layer_fx(layer_active, fxi_, new_fx_params_);
                            }
                        }
                        ImGui.EndCombo();
                    }

                    var fx_param_defs_ = global.LAYER_FX[layer_active.fx_index].params;
                    for (var pi_ = 0; pi_ < array_length(fx_param_defs_); pi_++) {
                        var pdef_ = fx_param_defs_[pi_];
                        ImGui.Text(pdef_.name);
                        ImGui.SameLine();
                        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                        ImGui.SetNextItemWidth(field_width_);
                        var new_fx_val_ = ImGui.SliderFloat("##layer_fx_param" + string(pi_), layer_active.fx_params[pi_], pdef_.min, pdef_.max);
                        if (new_fx_val_ != layer_active.fx_params[pi_]) {
                            var new_params_ = variable_clone(layer_active.fx_params);
                            new_params_[pi_] = new_fx_val_;
                            action_set_layer_fx_params(layer_active, new_params_);
                        }
                    }

                    if (!can_edit_fx_) ImGui.EndDisabled();

                    if (layer_active.type == LAYER_TYPE.TILEMAP) {
                        //collision layers stay tileset-locked while always is
                        //on - every other tilemap layer only locks on locked
                        var can_edit_tileset_ = !layer_active.locked && (!layer_active.always || !layer_active.collision);
                        if (!can_edit_tileset_) ImGui.BeginDisabled();

                        ImGui.Text("Tileset");
                        ImGui.SameLine();
                        var tileset_name_ = layer_active.tileset != undefined ? tileset_get_name(layer_active.tileset) : "(none)";
                        ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX());
                        if (ImGui.BeginCombo("##set_tileset", tileset_name_, ImGuiComboFlags.None)) {
                            resource_tree_draw(resource_tree, [], "tileset", tileset_name_, function(_name){
                                action_set_tileset(layer_active, _name);
                                ImGui.CloseCurrentPopup();
                            });
                            ImGui.EndCombo();
                        }

                        if (!can_edit_tileset_) ImGui.EndDisabled();
                    }

                    if (layer_active.type == LAYER_TYPE.BACKGROUND) {
                        if (!can_edit_) ImGui.BeginDisabled();

                        var bg_inst_ = layer_active.obj_background;
                        var bg_valid_ = instance_exists(bg_inst_);

                        ImGui.Text("Sprite");
                        ImGui.SameLine();
                        var bg_sprite_name_ = (bg_valid_ && bg_inst_.sprite_index != -1) ? sprite_get_name(bg_inst_.sprite_index) : "(none)";
                        ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX());
                        if (ImGui.BeginCombo("##set_background_sprite", bg_sprite_name_, ImGuiComboFlags.None)) {
                            resource_tree_draw(resource_tree, [], "sprite", bg_sprite_name_, function(_name){
                                action_set_background_sprite(layer_active, _name);
                                ImGui.CloseCurrentPopup();
                            });
                            ImGui.EndCombo();
                        }

                        ImGui.Text("Mode");
                        ImGui.SameLine();
                        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                        ImGui.SetNextItemWidth(field_width_);
                        var bg_mode_ = bg_valid_ ? bg_inst_.background_mode : BACKGROUND_MODE.NONE;
                        if (ImGui.BeginCombo("##background_mode", global.BACKGROUND_MODES[bg_mode_], ImGuiComboFlags.None)) {
                            for (var bmi_ = 0; bmi_ < array_length(global.BACKGROUND_MODES); bmi_++) {
                                if (ImGui.Selectable(global.BACKGROUND_MODES[bmi_], bmi_ == bg_mode_) && bg_valid_) {
                                    action_set_background_mode(layer_active, bmi_);
                                }
                            }
                            ImGui.EndCombo();
                        }

                        //filling stretches to the room bounds, so position doesn't apply
                        if (bg_valid_ && bg_inst_.background_mode == BACKGROUND_MODE.FILL) ImGui.BeginDisabled();

                        ImGui.Text("X");
                        ImGui.SameLine();
                        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                        ImGui.SetNextItemWidth(field_width_);
                        var new_bg_x_ = ImGui.InputFloat("##background_x", bg_valid_ ? bg_inst_.x : 0, 1, 8);
                        if (bg_valid_ && new_bg_x_ != bg_inst_.x) {
                            action_set_background_position(layer_active, new_bg_x_, bg_inst_.y);
                        }

                        ImGui.Text("Y");
                        ImGui.SameLine();
                        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                        ImGui.SetNextItemWidth(field_width_);
                        var new_bg_y_ = ImGui.InputFloat("##background_y", bg_valid_ ? bg_inst_.y : 0, 1, 8);
                        if (bg_valid_ && new_bg_y_ != bg_inst_.y) {
                            action_set_background_position(layer_active, bg_inst_.x, new_bg_y_);
                        }

                        if (bg_valid_ && bg_inst_.background_mode == BACKGROUND_MODE.FILL) ImGui.EndDisabled();

                        if (!can_edit_) ImGui.EndDisabled();
                    }

                    if (layer_active.type == LAYER_TYPE.ASSET || layer_active.type == LAYER_TYPE.INSTANCE) {
                        //click-selects a placed element instead of hunting in viewport
                        //(shift/ctrl extend/erase, like tile Selection)
                        if (layer_active.locked) ImGui.BeginDisabled();

                        ImGui.Text("Elements:");
                        ImGui.BeginChild("Elements",,150, ImGuiChildFlags.Borders | ImGuiChildFlags.ResizeY);

                        //ordered by sort_index, not raw with() iteration - matches
                        //what level_serialize saves and real-game draw order
                        var elem_layer_ = layer_active.layer;
                        var sorted_elems_ = sorted_layer_elements(elem_layer_);
                        for (var ei_ = 0; ei_ < array_length(sorted_elems_); ei_++) {
                            var elem_ = sorted_elems_[ei_];
                            with (elem_) {
                                var label_;
                                if (variable_instance_exists(id,"element_name")) {
                                    label_ = element_name;
                                } else {
                                    label_ = variable_instance_exists(id,"object_name") ? object_name
                                        : (variable_instance_exists(id,"sprite_name") ? sprite_name : object_get_name(object_index));
                                    label_ += " (" + string(id) + ")";
                                }
                                var in_selection_ = array_get_index(other.elements_selected, id) != -1;
                                var selected_ = other.element_active == id || in_selection_;

                                if (ImGui.Selectable(label_, selected_)) {
                                    if (keyboard_check(vk_shift)) {
                                        if (!in_selection_) array_push(other.elements_selected, id);
                                        other.element_active = id;
                                    } else if (keyboard_check(vk_control)) {
                                        if (in_selection_) array_delete(other.elements_selected, array_get_index(other.elements_selected, id), 1);
                                        if (other.element_active == id) other.element_active = noone;
                                    } else {
                                        other.elements_selected = [id];
                                        other.element_active = id;
                                    }
                                }
                            }
                        }

                        ImGui.EndChild();

                        //reorders the active selection within sorted_elems_ -
                        //disabled with nothing selected or at an end already
                        var reorder_index_ = array_get_index(sorted_elems_, element_active);
                        if (reorder_index_ == -1) ImGui.BeginDisabled();

                        var at_top_ = reorder_index_ <= 0;
                        var at_bottom_ = reorder_index_ == array_length(sorted_elems_) - 1;

                        if (at_top_) ImGui.BeginDisabled();
                        if (icon_button(ICON.ARROW_UP, "reorder_up")) {
                            action_swap_sort_index(element_active.element_uid, sorted_elems_[reorder_index_-1].element_uid);
                        }
                        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Move Up");
                        if (at_top_) ImGui.EndDisabled();
                        ImGui.SameLine();

                        if (at_bottom_) ImGui.BeginDisabled();
                        if (icon_button(ICON.ARROW_DOWN, "reorder_down")) {
                            action_swap_sort_index(element_active.element_uid, sorted_elems_[reorder_index_+1].element_uid);
                        }
                        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Move Down");
                        if (at_bottom_) ImGui.EndDisabled();
                        ImGui.SameLine();

                        if (at_top_) ImGui.BeginDisabled();
                        if (ImGui.Button("Top")) {
                            action_set_sort_index(element_active.element_uid, sorted_elems_[0].sort_index - 1);
                        }
                        if (at_top_) ImGui.EndDisabled();
                        ImGui.SameLine();

                        if (at_bottom_) ImGui.BeginDisabled();
                        if (ImGui.Button("Bottom")) {
                            action_set_sort_index(element_active.element_uid, sorted_elems_[array_length(sorted_elems_)-1].sort_index + 1);
                        }
                        if (at_bottom_) ImGui.EndDisabled();
                        ImGui.SameLine();

                        if (icon_button(ICON.TARGET, "goto_selected")) {
                            goto_selected();
                        }
                        if (ImGui.IsItemHovered()) ImGui.SetTooltip("Go to Selected (F)");

                        if (reorder_index_ == -1) ImGui.EndDisabled();

                        if (layer_active.locked) ImGui.EndDisabled();
                    }
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
            //AlwaysVerticalScrollbar keeps menu_size_ from oscillating with its width;
            //NoScrollWithMouse stops the tile picker's zoom-on-wheel from also scrolling
            var resources_flags_ = ImGuiWindowFlags.AlwaysVerticalScrollbar;
            if (layer_active != undefined && layer_active.type == LAYER_TYPE.TILEMAP) {
                resources_flags_ |= ImGuiWindowFlags.NoScrollWithMouse;
            }
            if (ImGui.Begin("Resources", undefined, resources_flags_)) {
                if(layer_active != undefined){
                    switch (layer_active.type) {
                        case LAYER_TYPE.TILEMAP:
                            #region tileset
                            var menu_size_ = max(64, floor(ImGui.GetContentRegionAvailX()));
                            refresh_tileset_tiles();

                            ImGui.Text("Tileset:");

							ImGui.SameLine();
                            if (ImGui.Button("Center##tileset")) tiles_switched = true;

                            ImGui.SameLine();
                            if (tileset_grid_visible) ImGui.PushStyleColor(ImGuiCol.Button, dark_mode ? c_dkgray : LIGHT_GRAY, 0.8);
                            else ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0.7);
                            if (icon_button(ICON.GRID, "tilesetgrid")) tileset_grid_visible = !tileset_grid_visible;
                            if (tileset_grid_visible) ImGui.PopStyleColor();
                            else ImGui.PopStyleVar();
                            if (ImGui.IsItemHovered()) ImGui.SetTooltip("Grid");

                            ImGui.BeginChild("Tileset", 0, menu_size_, ImGuiChildFlags.None, ImGuiWindowFlags.NoScrollWithMouse);

                            var tileset_hovered_ = ImGui.IsWindowHovered();
                            var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY();

                            if(layer_active.tileset != undefined){

                                var tiles_width_  = ds_grid_width( tileset_tiles);
                                var tiles_height_ = ds_grid_height(tileset_tiles);

                                //the surface is sized to fit the tileset itself, not the menu -
                                //panning/zooming only affect where/how big it's drawn below
                                var native_w_ = max(1, tiles_width_  * grid_cell_w);
                                var native_h_ = max(1, tiles_height_ * grid_cell_h);
                                if(!surface_exists(tileset_surface)){
                                    tileset_surface = surface_create(native_w_,native_h_);
                                } else if (surface_get_width(tileset_surface) != native_w_ || surface_get_height(tileset_surface) != native_h_) {
                                    surface_resize(tileset_surface, native_w_, native_h_);
                                }

                                if(tileset_hovered_){
                                    //zoom (centered on view) - multiplicative, same feel as the
                                    //viewport camera's own zoom, instead of a fixed step per tick
                                    var zoom_ = mouse_wheel_down() - mouse_wheel_up();
                                    if(zoom_ != 0){
                                        var tiles_size_prev_ = tiles_size;
                                        var tiles_zoom_step_ = 1.1;
                                        var new_tiles_size_ = (zoom_ > 0) ? (tiles_size * tiles_zoom_step_) : (tiles_size / tiles_zoom_step_);
                                        tiles_size = clamp(new_tiles_size_, 64, 1024);
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

                                if (tiles_switched) {
                                    //layer/tileset selection or the center button - start centered
                                    tiles_x = (menu_size_ - content_w_) * 0.5;
                                    tiles_y = (menu_size_ - content_h_) * 0.5;
                                    tiles_switched = false;
                                }

                                var hover_x_ = -1, hover_y_ = -1, hover_in_bounds_ = false;
                                if(tileset_hovered_){
                                    hover_x_ = ((mx_-xx_ - tiles_x) / scale_);
                                    hover_y_ = ((my_-yy_ - tiles_y) / scale_);

                                    hover_x_ = hover_x_ div grid_cell_w;
                                    hover_y_ = hover_y_ div grid_cell_h;

                                    //the hovered child area is bigger than the tileset itself
                                    //(padding/zoom), so the cell under the cursor isn't always in bounds
                                    hover_in_bounds_ = hover_x_ >= 0 && hover_x_ < tiles_width_ && hover_y_ >= 0 && hover_y_ < tiles_height_;

                                    if(hover_in_bounds_ && mouse_check_button_pressed(mb_left)){
                                        var brush_ = ds_grid_get(tileset_tiles,hover_x_,hover_y_);
                                        if(brush_ != undefined){
                                            brush = ds_grid_create(1,1);
                                            ds_grid_add(brush,0,0,brush_);
                                            tile_picker_selected_x = hover_x_;
                                            tile_picker_selected_y = hover_y_;
                                            brush_picked_x = -1; //this brush came from the tileset picker, not a brush_tilemap pick
                                            brush_picked_y = -1;
                                            tool_mode = TOOL_MODE.DRAW;
                                        } else brush = -1;
                                    }
                                }

                                //everything below draws at the tileset's own native scale -
                                //panning/zooming happens when the surface itself is displayed
                                surface_set_target(tileset_surface);
                                draw_clear(dark_mode ? DARKER_GRAY : DARK_GRAY);

								draw_checkerboard(0,0,grid_cell_w,grid_cell_h,tiles_width_,tiles_height_,1,DARK_GRAY,DARKER_GRAY);

                                draw_grid_tiles(tileset_tiles,tileset,0,0);
                                if (tileset_grid_visible) {
                                    set_draw(WHITE,0.2);
                                    draw_grid(0,0,grid_cell_w,grid_cell_h,tiles_width_,tiles_height_,1);
                                    reset_draw()
                                }

                                if (hover_in_bounds_) {
                                    set_draw(WHITE,0.2);
                                    draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
                                    reset_draw();
                                }

                                if (tile_picker_selected_x >= 0) {
                                    draw_grid_selection(brush, tile_picker_selected_x, tile_picker_selected_y, grid_cell_w, grid_cell_h);
                                }

                                surface_reset_target();

                                ImGui.SetCursorPos(tiles_x, tiles_y);
                                ImGui.Surface(tileset_surface, c_white, 1, content_w_, content_h_);
                            }

                            ImGui.EndChild();
                            #endregion

                            #region tile brush
                            ImGui.Text("Tile Brush:");

                            if (layer_active.tileset != undefined) {
                                //refresh_tileset_brush runs on layer/tileset selection (set_layer/
                                //action_set_tileset), not every frame - just consume the flag it leaves behind
                                var brush_view_changed_ = brush_switched;
                                brush_switched = false;

								ImGui.SameLine();
                                if (ImGui.Button("Center##brush")) brush_view_changed_ = true;

                                ImGui.SameLine();
                                if (brush_grid_visible) ImGui.PushStyleColor(ImGuiCol.Button, dark_mode ? c_dkgray : LIGHT_GRAY, 0.8);
                                else ImGui.PushStyleVar(ImGuiStyleVar.Alpha, 0.7);
                                if (icon_button(ICON.GRID, "brushgrid")) brush_grid_visible = !brush_grid_visible;
                                if (brush_grid_visible) ImGui.PopStyleColor();
                                else ImGui.PopStyleVar();
                                if (ImGui.IsItemHovered()) ImGui.SetTooltip("Grid");

                                ImGui.SameLine();
                                brush_pick_mode = toggle_switch(brush_pick_mode, "brush_mode");
                                ImGui.SameLine();
                                ImGui.Text(brush_pick_mode ? "Pick" : "Draw");

                                ImGui.BeginChild("TileBrush", 0, menu_size_, ImGuiChildFlags.None, ImGuiWindowFlags.NoScrollWithMouse);

                                var brush_w_tiles_ = tilemap_get_width(brush_tilemap);
                                var brush_h_tiles_ = tilemap_get_height(brush_tilemap);

                                //the surface is sized to fit the brush itself, not the menu -
                                //panning/zooming only affect where/how big it's drawn below
                                var brush_native_w_ = max(1, brush_w_tiles_ * grid_cell_w);
                                var brush_native_h_ = max(1, brush_h_tiles_ * grid_cell_h);
                                if (!surface_exists(tilebrush_surface)) {
                                    tilebrush_surface = surface_create(brush_native_w_,brush_native_h_);
                                } else if (surface_get_width(tilebrush_surface) != brush_native_w_ || surface_get_height(tilebrush_surface) != brush_native_h_) {
                                    surface_resize(tilebrush_surface, brush_native_w_, brush_native_h_);
                                }
                                surface_set_target(tilebrush_surface);
                                draw_clear(dark_mode ? DARKER_GRAY : DARK_GRAY);

                                var tilebrush_hovered_ = ImGui.IsWindowHovered();

                                if (tilebrush_hovered_) {
                                    //zoom (centered on view) - multiplicative, same feel as the
                                    //viewport camera's own zoom, instead of a fixed step per tick
                                    var zoom_ = mouse_wheel_down() - mouse_wheel_up();
                                    if (zoom_ != 0) {
                                        var brushes_size_prev_ = brushes_size;
                                        var brushes_zoom_step_ = 1.1;
                                        var new_brushes_size_ = (zoom_ > 0) ? (brushes_size * brushes_zoom_step_) : (brushes_size / brushes_zoom_step_);
                                        brushes_size = clamp(new_brushes_size_, 64, 1024);
                                        if (brushes_size != brushes_size_prev_) {
                                            var factor_ = brushes_size_prev_ / brushes_size;
                                            var center_ = menu_size_ * 0.5;
                                            brushes_x = center_ - (center_ - brushes_x) * factor_;
                                            brushes_y = center_ - (center_ - brushes_y) * factor_;
                                        }
                                    }
                                    //dragging
                                    if (mouse_check_button(mb_middle)) {
                                        brushes_x -= mouse_spd_h_;
                                        brushes_y -= mouse_spd_v_;
                                    }
                                }

                                var brush_scale_ = menu_size_ / brushes_size;
                                var brush_content_w_ = brush_w_tiles_ * grid_cell_w * brush_scale_;
                                var brush_content_h_ = brush_h_tiles_ * grid_cell_h * brush_scale_;

                                if (brush_view_changed_) {
                                    //layer/tileset selection or the center button - start centered
                                    brushes_x = (menu_size_ - brush_content_w_) * 0.5;
                                    brushes_y = (menu_size_ - brush_content_h_) * 0.5;
                                }

                                draw_checkerboard(0,0,grid_cell_w,grid_cell_h,brush_w_tiles_,brush_h_tiles_,1,DARK_GRAY,DARKER_GRAY);

                                draw_tilemap_tiles(brush_tilemap,0,0);
                                if (brush_grid_visible) {
                                    set_draw(WHITE,0.2);
                                    draw_grid(0,0,grid_cell_w,grid_cell_h,brush_w_tiles_,brush_h_tiles_,1);
                                    reset_draw();
                                }

                                if (tilebrush_hovered_) {
                                    var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY();
                                    var hover_px_x_ = (mx_-xx_ - brushes_x) / brush_scale_;
                                    var hover_px_y_ = (my_-yy_ - brushes_y) / brush_scale_;
                                    var hover_x_ = hover_px_x_ div grid_cell_w;
                                    var hover_y_ = hover_px_y_ div grid_cell_h;

                                    set_draw(WHITE,0.2);
                                    draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
                                    reset_draw();

                                    if (brush_pick_mode) {
                                        //picks the connected clump of tiles under the cursor back into brush
                                        if (mouse_check_button_pressed(mb_left)) {
                                            var tiles_ = ds_grid_create(brush_w_tiles_, brush_h_tiles_);
                                            for (var py_ = 0; py_ < brush_h_tiles_; py_++) {
                                                for (var px_ = 0; px_ < brush_w_tiles_; px_++) {
                                                    ds_grid_set(tiles_, px_, py_, tilemap_get(brush_tilemap, px_, py_));
                                                }
                                            }
                                            var picked_ = ds_grid_pick(tiles_, hover_x_, hover_y_);
                                            ds_grid_destroy(tiles_);
                                            if (picked_ != undefined) {
                                                brush = picked_.grid;
                                                brush_picked_x = picked_.x;
                                                brush_picked_y = picked_.y;
                                                //this brush came from the tile brush canvas, not the tileset picker
                                                tile_picker_selected_x = -1;
                                                tile_picker_selected_y = -1;
                                                tool_mode = TOOL_MODE.DRAW;
                                            }
                                        }
                                    //same action funcs as a level tilemap paint
                                    //(same undo); only the coordinate space differs
                                    } else if (ds_exists(brush,ds_type_grid)) {
                                        if (tool_mode == TOOL_MODE.DRAW) {
                                            var bw_ = ds_grid_width(brush);
                                            var bh_ = ds_grid_height(brush);
                                            var boff_x_ = (bw_*grid_cell_w/2) - grid_cell_w/2;
                                            var boff_y_ = (bh_*grid_cell_h/2) - grid_cell_h/2;
                                            var cx_ = floor((hover_px_x_-boff_x_)/grid_cell_w);
                                            var cy_ = floor((hover_px_y_-boff_y_)/grid_cell_h);

                                            //ghost preview of what the brush would stamp down here
                                            set_draw(WHITE,0.5);
                                            draw_grid_tiles(brush,tileset,cx_*grid_cell_w,cy_*grid_cell_h);
                                            reset_draw();

                                            if (mouse_check_button(mb_left)) {
                                                var brush_paint_due_ = !brush_paint_active || abs(cx_-brush_paint_last_x) >= bw_ || abs(cy_-brush_paint_last_y) >= bh_;
                                                if (brush_paint_due_) {
                                                    action_paste_tile_grid(brush_tilemap,brush,cx_,cy_);
                                                    brush_paint_active = true;
                                                    brush_paint_last_x = cx_;
                                                    brush_paint_last_y = cy_;
                                                }
                                            }

                                            if (mouse_check_button(mb_right)) {
                                                var brush_erase_due_ = !brush_erase_active || abs(cx_-brush_erase_last_x) >= bw_ || abs(cy_-brush_erase_last_y) >= bh_;
                                                if (brush_erase_due_) {
                                                    action_erase_tile_grid(brush_tilemap,brush,cx_,cy_);
                                                    brush_erase_active = true;
                                                    brush_erase_last_x = cx_;
                                                    brush_erase_last_y = cy_;
                                                }
                                            }
                                        } else {
                                            tool_interact(brush_tilemap, hover_x_, hover_y_);
                                            tool_draw_preview(brush_tilemap, hover_x_, hover_y_);
                                        }
                                    }
                                }

                                if (brush_picked_x >= 0) {
                                    draw_grid_selection(brush, brush_picked_x, brush_picked_y, grid_cell_w, grid_cell_h);
                                }

                                surface_reset_target();

                                ImGui.SetCursorPos(brushes_x, brushes_y);
                                ImGui.Surface(tilebrush_surface, c_white, 1, brush_content_w_, brush_content_h_);

                                ImGui.EndChild();
                            }
                            #endregion

                            break;
                        case LAYER_TYPE.ASSET:
                            //jumps into "Sprites" instead of a click; dragging from here
                            //places an obj_editor_sprite (see "element placement" above)
                            var sprites_folder_ = resource_tree_find_folder("Sprites");
                            if (sprites_folder_ != undefined) {
                                resource_tree_draw(sprites_folder_.folders, sprites_folder_.resources, "sprite");
                            } else {
                                resource_tree_draw(resource_tree, [], "sprite");
                            }
                            break;
                        case LAYER_TYPE.INSTANCE:
                            //jumps into "Objects" - the only folder for instance layers
                            var objects_folder_ = resource_tree_find_folder("Objects");
                            if (objects_folder_ != undefined) {
                                resource_tree_draw(objects_folder_.folders, objects_folder_.resources, "object");
                            } else {
                                resource_tree_draw(resource_tree, [], "object");
                            }
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

        #region inspector
        //x/y/scale/angle for the selected element - only meaningful on
        //ASSET/INSTANCE layers, since tilemaps have no single selected element
        var inspector_active_ = layer_active != undefined && (layer_active.type == LAYER_TYPE.ASSET || layer_active.type == LAYER_TYPE.INSTANCE);
        if (inspector_active_) {
            if (ImGui.Begin("Inspector", undefined, ImGuiWindowFlags.None)) {
                if (element_active != noone && instance_exists(element_active)) {
                    var label_ = variable_instance_exists(element_active, "object_name") ? element_active.object_name
                        : (variable_instance_exists(element_active, "sprite_name") ? element_active.sprite_name : object_get_name(element_active.object_index));
                    ImGui.Text(label_);
                    ImGui.Separator();

                    var can_edit_ = !layer_active.locked;
                    if (!can_edit_) ImGui.BeginDisabled();

                    var field_width_ = 140;

                    if (layer_active.type == LAYER_TYPE.INSTANCE && variable_instance_exists(element_active,"element_name")) {
                        ImGui.Text("Name");
                        ImGui.SameLine();
                        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                        ImGui.SetNextItemWidth(field_width_);
                        var new_name_ = ImGui.InputText("##inspector_name", element_active.element_name, ImGuiInputTextFlags.EnterReturnsTrue | ImGuiInputTextFlags.AutoSelectAll);
                        if (ImGui.IsItemDeactivated()) {
                            action_set_element_name(element_active.element_uid, new_name_);
                        }
                    }

                    //commits x/y/scale/angle as one undo step (same as a completed drag)
                    //via action_transform_instance - re-reads element_active, not a local
                    var apply_transform_ = function(_x, _y, _xscale, _yscale, _angle){
                        var before_ = {
                            x : element_active.x, y : element_active.y,
                            image_xscale : element_active.image_xscale,
                            image_yscale : element_active.image_yscale,
                            image_angle : element_active.image_angle,
                        };
                        var after_ = {x : _x, y : _y, image_xscale : _xscale, image_yscale : _yscale, image_angle : _angle};
                        action_transform_instance(element_active.element_uid, before_, after_);
                    }

                    ImGui.Text("X");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_x_ = ImGui.InputFloat("##inspector_x", element_active.x, 1, 8);
                    if (new_x_ != element_active.x) {
                        apply_transform_(new_x_, element_active.y, element_active.image_xscale, element_active.image_yscale, element_active.image_angle);
                    }

                    ImGui.Text("Y");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_y_ = ImGui.InputFloat("##inspector_y", element_active.y, 1, 8);
                    if (new_y_ != element_active.y) {
                        apply_transform_(element_active.x, new_y_, element_active.image_xscale, element_active.image_yscale, element_active.image_angle);
                    }

                    ImGui.Text("Angle");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_angle_ = ImGui.InputFloat("##inspector_angle", element_active.image_angle, 1, 15);
                    if (new_angle_ != element_active.image_angle) {
                        apply_transform_(element_active.x, element_active.y, element_active.image_xscale, element_active.image_yscale, new_angle_);
                    }

                    ImGui.Text("Scale X");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_xscale_ = ImGui.InputFloat("##inspector_xscale", element_active.image_xscale, 0.05, 0.25);
                    if (new_xscale_ != element_active.image_xscale) {
                        apply_transform_(element_active.x, element_active.y, new_xscale_, element_active.image_yscale, element_active.image_angle);
                    }

                    ImGui.Text("Scale Y");
                    ImGui.SameLine();
                    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                    ImGui.SetNextItemWidth(field_width_);
                    var new_yscale_ = ImGui.InputFloat("##inspector_yscale", element_active.image_yscale, 0.05, 0.25);
                    if (new_yscale_ != element_active.image_yscale) {
                        apply_transform_(element_active.x, element_active.y, element_active.image_xscale, new_yscale_, element_active.image_angle);
                    }

                    if (layer_active.type == LAYER_TYPE.INSTANCE && variable_instance_exists(element_active,"instance_variables")) {
                        ImGui.Separator();
                        var multi_targets_ = get_selected_elements();
                        var multi_editing_ = array_length(multi_targets_) > 1;
                        ImGui.Text(multi_editing_ ? "Instance variables (shared)" : "Instance variables");

                        var var_names_ = element_active.instance_variable_order;
                        for (var i_ = 0; i_ < array_length(var_names_); i_++) {
                            var def_ = element_active.instance_variables[$ var_names_[i_]];
                            if (def_.hidden) continue;
                            //only fields every selected element shares (same name and type)
                            //are shown once multiple elements are selected together
                            if (multi_editing_ && !variable_shared_across_selection(def_.var_name, def_.type, multi_targets_)) continue;

                            ImGui.Text(variable_string_name(def_.var_name));
                            ImGui.SameLine();
                            ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - field_width_));
                            ImGui.SetNextItemWidth(field_width_);

                            switch (def_.type) {
                                case EDITOR_VARIABLE_TYPES.FLOAT:
                                case EDITOR_VARIABLE_TYPES.INT:
                                case EDITOR_VARIABLE_TYPES.BOOL:
                                case EDITOR_VARIABLE_TYPES.STRING:
                                case EDITOR_VARIABLE_TYPES.LIST:
                                    var new_value_ = draw_typed_value_field("##var_" + def_.var_name, def_.type, def_.value, def_[$ "minimum"], def_[$ "maximum"], def_[$ "options"]);
                                    if (new_value_ != def_.value) {
                                        action_set_variable_selected(def_.var_name, new_value_);
                                    }
                                    break;
                                case EDITOR_VARIABLE_TYPES.REFERENCE:
                                    var ref_button_size_ = ImGui.GetFrameHeight();
                                    var ref_picking_ = picking_reference_owner == element_active.element_uid && picking_reference_context == def_.var_name;
                                    var ref_text_ = ref_picking_ ? "picking ref" : (is_string(def_.value) ? def_.value : "");

                                    //placed later than this element in the elements list -
                                    //resolves to noone in real gameplay (see load_level.gml)
                                    var ref_target_inst_ = (!ref_picking_ && is_string(def_.value) && def_.value != "") ? find_element_by_name(def_.value) : noone;
                                    var ref_order_warning_ = ref_target_inst_ != noone && element_placement_rank(ref_target_inst_) > element_placement_rank(element_active);

                                    ImGui.SetNextItemWidth(field_width_ - ref_button_size_ - 4);
                                    if (ref_picking_) ImGui.BeginDisabled();
                                    if (ref_order_warning_) ImGui.PushStyleColor(ImGuiCol.Text, YELLOW, 1);
                                    var new_ref_ = ImGui.InputText("##var_" + def_.var_name, ref_text_);
                                    if (ref_order_warning_) ImGui.PopStyleColor();
                                    if (ref_order_warning_ && ImGui.IsItemHovered()) {
                                        ImGui.SetTooltip("Placed later in the Elements list - won't resolve in real\ngameplay. Move the target above this element to fix it.");
                                    }
                                    if (!ref_picking_ && ImGui.IsItemDeactivated()) {
                                        var ref_trimmed_ = string_trim(new_ref_);
                                        if (ref_trimmed_ == "") {
                                            action_set_variable_selected(def_.var_name, noone);
                                        } else if (element_reference_valid(ref_trimmed_, def_.accepted_objects, element_active.element_uid)) {
                                            action_set_variable_selected(def_.var_name, ref_trimmed_);
                                        }
                                        //invalid: silently rejected, field reverts to the last accepted value
                                    }
                                    if (ref_picking_) ImGui.EndDisabled();
                                    ImGui.SameLine();
                                    if (icon_button(ICON.EYEDROPPER, "ref_pick_" + def_.var_name, ref_button_size_)) {
                                        picking_reference_owner = element_active.element_uid;
                                        picking_reference_context = def_.var_name;
                                        picking_reference_accepted = def_.accepted_objects;
                                        picking_reference_on_pick = method({var_name: def_.var_name}, function(_target_name){
                                            //self here is this bound struct, not obj_level_editor -
                                            //action_set_variable_selected has to be called on it explicitly
                                            obj_level_editor.action_set_variable_selected(var_name, _target_name);
                                        });
                                    }
                                    if (ImGui.IsItemHovered()) ImGui.SetTooltip("Pick a reference by clicking an instance");
                                    break;
                                case EDITOR_VARIABLE_TYPES.SCRIPT:
                                    var script_label_ = "Edit Script" + (def_.value == "" ? " - empty" : "") + "##" + def_.var_name;
                                    if (ImGui.Button(script_label_, field_width_)) {
                                        def_.script_buffer = def_.value;
                                        ImGui.OpenPopup("Edit Script##" + def_.var_name);
                                    }
                                    ImGui.SetNextWindowSize(500, 400, ImGuiCond.FirstUseEver);
                                    if (ImGui.BeginPopupModal("Edit Script##" + def_.var_name, undefined, ImGuiWindowFlags.None)) {
                                        def_.script_buffer = ImGui.InputTextMultiline("##script_" + def_.var_name, def_.script_buffer, 480, 300);
                                        if (ImGui.Button("Done")) {
                                            action_set_variable_selected(def_.var_name, def_.script_buffer);
                                            ImGui.CloseCurrentPopup();
                                        }
                                        ImGui.SameLine();
                                        if (ImGui.Button("Cancel")) ImGui.CloseCurrentPopup();
                                        ImGui.EndPopup();
                                    }
                                    break;
                                default:
                                    ImGui.TextDisabled("(unsupported type)");
                                    break;
                            }
                        }
                    }

                    if (layer_active.type == LAYER_TYPE.INSTANCE && variable_instance_exists(element_active,"button_order") && array_length(element_active.button_order) > 0) {
                        ImGui.Separator();
                        for (var bi_ = 0; bi_ < array_length(element_active.button_order); bi_++) {
                            var button_text_ = element_active.button_order[bi_];
                            if (ImGui.Button(button_text_, field_width_)) element_active.buttons[$ button_text_]();
                        }
                    }

                    if (!can_edit_) ImGui.EndDisabled();

                    if (layer_active.type == LAYER_TYPE.INSTANCE && variable_instance_exists(element_active,"io_connections")) {
                        ImGui.Separator();
                        ImGui.Text("Outputs");
                        ImGui.SameLine();
                        if (ImGui.Button("Edit Outputs")) {
                            io_window_uid = element_active.element_uid;
                            io_window_row_index = -1;
                            io_window_edit_row = {output:"", target_name:"", input:"", param:undefined, delay:0, fire_once:false};
                            io_window_edit_generation += 1;
                            io_output_dropdown_open = false;
                            io_input_dropdown_open = false;
                            ImGui.OpenPopup("Object Properties - Outputs");
                        }
                    }

                    //hidden entirely (no BeginPopupModal call) while its own eyedropper is
                    //picking, so the modal's dimmed backdrop doesn't block the viewport -
                    //reopened once the pick resolves/cancels
                    var io_picking_for_window_ = io_window_uid != noone && picking_reference_owner == io_window_uid;
                    if (io_picking_for_window_) {
                        io_window_hidden_for_pick = true;
                    } else if (io_window_hidden_for_pick) {
                        io_window_hidden_for_pick = false;
                        ImGui.OpenPopup("Object Properties - Outputs");
                    }

                    ImGui.SetNextWindowSize(640, 480, ImGuiCond.FirstUseEver);
                    if (!io_picking_for_window_ && ImGui.BeginPopupModal("Object Properties - Outputs", undefined, ImGuiWindowFlags.None)) {
                        var io_inst_ = find_element_by_uid(io_window_uid);
                        if (io_inst_ == noone) {
                            ImGui.CloseCurrentPopup();
                        } else {
                            ImGui.Text("Output connections for " + io_inst_.element_name);
                            ImGui.Separator();

                            if (ImGui.BeginTable("io_outgoing", 6, ImGuiTableFlags.Borders | ImGuiTableFlags.RowBg, 0, 200)) {
                                ImGui.TableSetupColumn("Outputs");
                                ImGui.TableSetupColumn("Target Entity");
                                ImGui.TableSetupColumn("Via this Input");
                                ImGui.TableSetupColumn("Parameter");
                                ImGui.TableSetupColumn("Delay");
                                ImGui.TableSetupColumn("Only Once");
                                ImGui.TableHeadersRow();

                                for (var io_i_ = 0; io_i_ < array_length(io_inst_.io_connections); io_i_++) {
                                    var io_row_ = io_inst_.io_connections[io_i_];
                                    ImGui.TableNextRow();
                                    ImGui.TableNextColumn();
                                    if (ImGui.Selectable(io_row_.output + "##io_row_" + string(io_i_), io_window_row_index == io_i_, ImGuiSelectableFlags.SpanAllColumns | ImGuiSelectableFlags.NoAutoClosePopups)) {
                                        io_window_row_index = io_i_;
                                        io_window_edit_row = variable_clone(io_row_);
                                        io_window_edit_generation += 1;
                                        io_output_dropdown_open = false;
                                        io_input_dropdown_open = false;
                                    }
                                    ImGui.TableNextColumn(); ImGui.Text(io_row_.target_name);
                                    ImGui.TableNextColumn(); ImGui.Text(io_row_.input);
                                    ImGui.TableNextColumn(); ImGui.Text(io_row_.param != undefined ? string(io_row_.param) : "");
                                    ImGui.TableNextColumn(); ImGui.Text(string(io_row_.delay));
                                    ImGui.TableNextColumn(); ImGui.Text(io_row_.fire_once ? "Yes" : "");
                                }
                                ImGui.EndTable();
                            }

                            ImGui.Separator();
                            var io_editing_ = io_window_edit_row != undefined;
                            if (io_editing_) {
                                var io_target_inst_ = find_element_by_name(io_window_edit_row.target_name);
                                var io_input_def_ = (io_target_inst_ != noone && variable_struct_exists(io_target_inst_.input_functions, io_window_edit_row.input))
                                    ? io_target_inst_.input_functions[$ io_window_edit_row.input]
                                    : undefined;
                                //suffixed onto each field id below - ImGui widgets otherwise keep
                                //showing their own cached content after a wholesale row swap
                                var io_gen_ = "_" + string(io_window_edit_generation);

                                if (ImGui.BeginTable("io_edit_fields", 2, ImGuiTableFlags.SizingFixedFit)) {
                                    ImGui.TableSetupColumn("label", ImGuiTableColumnFlags.WidthFixed);
                                    ImGui.TableSetupColumn("field", ImGuiTableColumnFlags.WidthStretch);

                                    ImGui.TableNextRow();
                                    ImGui.TableNextColumn(); ImGui.Text("My output named");
                                    ImGui.TableNextColumn();
                                    if (ImGui.Button((io_window_edit_row.output == "" ? "(select)" : io_window_edit_row.output) + "##io_output_btn", ImGui.GetContentRegionAvailX())) {
                                        io_output_dropdown_open = !io_output_dropdown_open;
                                        io_input_dropdown_open = false;
                                    }
                                    if (io_output_dropdown_open) {
                                        for (var oi_ = 0; oi_ < array_length(io_inst_.output_signal_order); oi_++) {
                                            var out_opt_ = io_inst_.output_signal_order[oi_];
                                            ImGui.TableNextRow();
                                            ImGui.TableNextColumn();
                                            ImGui.TableNextColumn();
                                            if (ImGui.Selectable(out_opt_ + "##io_output_opt_" + string(oi_), out_opt_ == io_window_edit_row.output, ImGuiSelectableFlags.NoAutoClosePopups)) {
                                                io_window_edit_row.output = out_opt_;
                                                io_window_edit_generation += 1;
                                                io_output_dropdown_open = false;
                                                if (io_window_row_index != -1) action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                            }
                                        }
                                    }

                                    ImGui.TableNextRow();
                                    ImGui.TableNextColumn(); ImGui.Text("Targets entities named");
                                    ImGui.TableNextColumn();
                                    var io_eyedrop_size_ = ImGui.GetFrameHeight();
                                    var io_target_picking_ = picking_reference_owner == io_window_uid && picking_reference_context == "io_target";
                                    ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX() - io_eyedrop_size_ - 4);
                                    if (io_target_picking_) ImGui.BeginDisabled();
                                    var io_new_target_ = ImGui.InputText("##io_target" + io_gen_, io_target_picking_ ? "picking..." : io_window_edit_row.target_name);
                                    if (!io_target_picking_ && ImGui.IsItemDeactivated()) {
                                        var io_target_trimmed_ = string_trim(io_new_target_);
                                        if (io_target_trimmed_ == "" || find_element_by_name(io_target_trimmed_) != noone) {
                                            io_window_edit_row.target_name = io_target_trimmed_;
                                            io_window_edit_row.input = ""; //target changed - old input choice may not apply
                                            if (io_window_row_index != -1) action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                        }
                                        //invalid: silently rejected, field reverts to the last accepted value
                                    }
                                    if (io_target_picking_) ImGui.EndDisabled();
                                    ImGui.SameLine();
                                    if (icon_button(ICON.EYEDROPPER, "io_target_pick", io_eyedrop_size_)) {
                                        picking_reference_owner = io_window_uid;
                                        picking_reference_context = "io_target";
                                        picking_reference_accepted = [];
                                        picking_reference_on_pick = method({row: io_window_edit_row}, function(_target_name){
                                            row.target_name = _target_name;
                                            row.input = "";
                                            obj_level_editor.io_window_edit_generation += 1;
                                            if (obj_level_editor.io_window_row_index != -1) {
                                                obj_level_editor.action_set_connection(obj_level_editor.io_window_uid, obj_level_editor.io_window_row_index, row);
                                            }
                                        });
                                    }

                                    ImGui.TableNextRow();
                                    ImGui.TableNextColumn(); ImGui.Text("Via this input");
                                    ImGui.TableNextColumn();
                                    if (ImGui.Button((io_window_edit_row.input == "" ? "(select)" : io_window_edit_row.input) + "##io_input_btn", ImGui.GetContentRegionAvailX())) {
                                        io_input_dropdown_open = !io_input_dropdown_open;
                                        io_output_dropdown_open = false;
                                    }
                                    if (io_input_dropdown_open && io_target_inst_ != noone) {
                                        for (var ii_ = 0; ii_ < array_length(io_target_inst_.input_function_order); ii_++) {
                                            var in_opt_ = io_target_inst_.input_function_order[ii_];
                                            ImGui.TableNextRow();
                                            ImGui.TableNextColumn();
                                            ImGui.TableNextColumn();
                                            if (ImGui.Selectable(in_opt_ + "##io_input_opt_" + string(ii_), in_opt_ == io_window_edit_row.input, ImGuiSelectableFlags.NoAutoClosePopups)) {
                                                io_window_edit_row.input = in_opt_;
                                                io_window_edit_generation += 1;
                                                io_input_dropdown_open = false;
                                                if (io_window_row_index != -1) action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                            }
                                        }
                                    }

                                    if (io_input_def_ != undefined && io_input_def_.param_type != undefined) {
                                        //a fresh row/newly-picked input has no param value yet - seed a
                                        //default matching the input's declared type before drawing its widget
                                        if (io_window_edit_row.param == undefined) {
                                            switch (io_input_def_.param_type) {
                                                case EDITOR_VARIABLE_TYPES.FLOAT: io_window_edit_row.param = 0; break;
                                                case EDITOR_VARIABLE_TYPES.BOOL: io_window_edit_row.param = false; break;
                                                case EDITOR_VARIABLE_TYPES.STRING: io_window_edit_row.param = ""; break;
                                                case EDITOR_VARIABLE_TYPES.LIST: io_window_edit_row.param = 0; break;
                                            }
                                        }
                                        ImGui.TableNextRow();
                                        ImGui.TableNextColumn(); ImGui.Text("With a parameter override of");
                                        ImGui.TableNextColumn();
                                        ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailX());
                                        var io_param_before_ = io_window_edit_row.param;
                                        io_window_edit_row.param = draw_typed_value_field("##io_param" + io_gen_, io_input_def_.param_type, io_window_edit_row.param, io_input_def_.minimum, io_input_def_.maximum, io_input_def_.options);
                                        if (io_window_row_index != -1 && io_window_edit_row.param != io_param_before_) {
                                            action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                        }
                                    } else {
                                        io_window_edit_row.param = undefined;
                                    }

                                    ImGui.TableNextRow();
                                    ImGui.TableNextColumn(); ImGui.Text("After a delay in seconds of");
                                    ImGui.TableNextColumn();
                                    ImGui.SetNextItemWidth(160);
                                    var io_delay_before_ = io_window_edit_row.delay;
                                    io_window_edit_row.delay = ImGui.InputFloat("##io_delay" + io_gen_, io_window_edit_row.delay);
                                    ImGui.SameLine(0, 40);
                                    var io_fire_once_before_ = io_window_edit_row.fire_once;
                                    io_window_edit_row.fire_once = ImGui.Checkbox("Fire once only##io_fire_once" + io_gen_, io_window_edit_row.fire_once);
                                    if (io_window_row_index != -1 && (io_window_edit_row.delay != io_delay_before_ || io_window_edit_row.fire_once != io_fire_once_before_)) {
                                        action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                    }

                                    ImGui.EndTable();
                                }

                                //editing a selected row's fields commits immediately (see each
                                //field's own action_set_connection call above) - Add is only for
                                //appending the fields as a brand new connection
                                if (ImGui.Button("Add")) {
                                    action_add_connection(io_window_uid, variable_clone(io_window_edit_row));
                                    io_window_edit_row = {output:"", target_name:"", input:"", param:undefined, delay:0, fire_once:false};
                                    io_window_row_index = -1;
                                    io_window_edit_generation += 1;
                                    io_output_dropdown_open = false;
                                    io_input_dropdown_open = false;
                                }
                                ImGui.SameLine();
                                if (ImGui.Button("Copy")) io_window_clipboard = variable_clone(io_window_edit_row);
                                ImGui.SameLine();
                                if (ImGui.Button("Paste") && io_window_clipboard != undefined) {
                                    io_window_edit_row = variable_clone(io_window_clipboard);
                                    io_window_edit_generation += 1;
                                    io_output_dropdown_open = false;
                                    io_input_dropdown_open = false;
                                    //edits of an existing row commit immediately everywhere else -
                                    //pasting into one needs to do the same, not just fill the fields
                                    if (io_window_row_index != -1) action_set_connection(io_window_uid, io_window_row_index, io_window_edit_row);
                                }
                                ImGui.SameLine();
                                if (ImGui.Button("Delete") && io_window_row_index != -1) {
                                    action_remove_connection(io_window_uid, io_window_row_index);
                                    io_window_edit_row = {output:"", target_name:"", input:"", param:undefined, delay:0, fire_once:false};
                                    io_window_row_index = -1;
                                    io_window_edit_generation += 1;
                                    io_output_dropdown_open = false;
                                    io_input_dropdown_open = false;
                                }
                            }

                            ImGui.Separator();
                            ImGui.Text("Called by:");
                            if (ImGui.BeginTable("io_incoming", 3, ImGuiTableFlags.Borders, 0, 120)) {
                                ImGui.TableSetupColumn("Source Entity");
                                ImGui.TableSetupColumn("Output");
                                ImGui.TableSetupColumn("Input");
                                ImGui.TableHeadersRow();
                                var io_inst_name_ = io_inst_.element_name;
                                var io_inst_uid_ = io_inst_.element_uid;
                                with (obj_editor_instance) {
                                    if (element_uid == io_inst_uid_) continue;
                                    if (!variable_instance_exists(id,"io_connections")) continue;
                                    for (var ci_ = 0; ci_ < array_length(io_connections); ci_++) {
                                        var call_ = io_connections[ci_];
                                        if (call_.target_name != io_inst_name_) continue;
                                        ImGui.TableNextRow();
                                        ImGui.TableNextColumn(); ImGui.Text(element_name);
                                        ImGui.TableNextColumn(); ImGui.Text(call_.output);
                                        ImGui.TableNextColumn(); ImGui.Text(call_.input);
                                    }
                                }
                                ImGui.EndTable();
                            }

                            ImGui.Separator();
                            if (ImGui.Button("Close")) {
                                io_window_uid = noone;
                                ImGui.CloseCurrentPopup();
                            }
                        }
                        ImGui.EndPopup();
                    }
                } else {
                    ImGui.TextDisabled("No element selected");
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
                    draw_clear(dark_mode ? DARKER_GRAY : DARK_GRAY);
        
                    //draws to a surface the same way obj_3d_smf draws into the room -
                    //same shader/z-test/scale, parked at the surface center not room x/y
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
    
    #endregion -----------------------------------------------------
    
    ImGui.PopFont()
    ImGui.PopStyleVar(7)
    ImGui.PopStyleColor(35)

#endregion ----------------------------------------------------------

if(destroyed){
	instance_activate_all();
	destroyed = false;
	call_later(1,time_source_units_frames,function(){
		instance_destroy();
		clear_level();
	    load_level(current_level_path);
	});
}
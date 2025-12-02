
//if (live_call()) return live_result;

/// @description
#region close button save reminder
if (window_command_check(window_command_close)) {
    if (show_question("Really quit?")) game_end();
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

ImGui.PushFont(font);
ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding,4)
ImGui.PushStyleVar(ImGuiStyleVar.WindowBorderSize,0)

var menu_size_ = 300;

#region left panel
ImGui.SetNextWindowPos(0,0);
ImGui.SetNextWindowSize(menu_size_,window_get_height());
if (ImGui.Begin("Left",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)){
    if(ImGui.Button("Save")){
        ImGui.OpenPopup("Save Changes?")
    }
        
    if (ImGui.BeginPopupModal("Save Changes?",, ImGuiWindowFlags.AlwaysAutoResize)) {
        ImGui.Text("Save Changes?");
        ImGui.Separator();
        
        if (ImGui.Button("Save")){
            save()
            ImGui.CloseCurrentPopup()
        } 
        ImGui.SetItemDefaultFocus();
        ImGui.SameLine();
        if (ImGui.Button("Cancel")){
            ImGui.CloseCurrentPopup()  
        } 
        ImGui.EndPopup();
    }
    
    if(ImGui.Button("Add Layer")){
        add_layer(add_layer_type);
    }
    
    ImGui.SameLine();
    var preview_val_ = add_layer_types[add_layer_type];
    ImGui.SetNextItemWidth(180);
    if (ImGui.BeginCombo("##combo",preview_val_,ImGuiComboFlags.None)){
        for (var i_ = 0; i_ < array_length(add_layer_types); ++i_) {
            var selected_ = add_layer_type == i_;
            if(ImGui.Selectable(add_layer_types[i_],selected_)){
                add_layer_type = i_;	
            }
            if(selected_) ImGui.SetItemDefaultFocus(); 
        }
        ImGui.EndCombo();
    }
    
    ImGui.Separator();
	ImGui.Spacing();
    
    #region layers list
    ImGui.Text("Layers:")
    ImGui.SameLine();
    layers_hide_internal = ImGui.Checkbox("Hide Internal", layers_hide_internal);
    ImGui.BeginChild("Layers",,300, ImGuiChildFlags.Border);
    for (var i_ = 0; i_ < array_length(layers); i_++) {
        var layer_ = layers[i_];
        
        var disabled_ = (!array_contains(struct_get_names(global.room_data.layers),layer_.name));
        
        //if layers_hide_internal is checked, don't display them in layer list
        if(layers_hide_internal && disabled_) continue;
            
        var flags_ = disabled_ ? ImGuiSelectableFlags.Disabled : ImGuiSelectableFlags.None
        if(ImGui.Selectable(layer_.name,layer_index == i_,flags_)){
            set_layer(i_)
        }
        ImGui.SameLine();
        
        var depth_ = string(layer_get_depth(layer_.id));
        ImGui.SetCursorPosX(ImGui.GetCursorPosX() + max(0, ImGui.GetContentRegionAvailX() - ImGui.CalcTextWidth(depth_)));
        
        if (!disabled_) {
            ImGui.Text(depth_); 
        } else {
            ImGui.TextDisabled(depth_);
        }
    }
    ImGui.EndChild();
    #endregion
    
    if(layer_active != undefined){
        #region move layer
        
        var depth_ = layer_get_depth(layer_active.id);
        var depth_top_ = layer_get_depth(layers[0].id);
        var depth_bottom_ = layer_get_depth(layers[array_length(layers)-1].id);
        
        var depth_new_ = depth_;
        
        if(ImGui.Button("Up")){
            if(layer_index > 1){
                var depth_1_ = layer_get_depth(layers[layer_index-1].id);
                var depth_2_ = layer_get_depth(layers[layer_index-2].id);
                depth_new_ = floor(lerp(depth_1_,depth_2_,0.5));
            } else if(layer_index > 0){
                depth_new_ = depth_top_ - 100;
            }
        }
        ImGui.SameLine()
        if(ImGui.Button("Down")){
            if(layer_index < array_length(layers) - 2){
                var depth_1_ = layer_get_depth(layers[layer_index+1].id);
                var depth_2_ = layer_get_depth(layers[layer_index+2].id);
                depth_new_= floor(lerp(depth_1_,depth_2_,0.5));
            } else if(layer_index < array_length(layers) - 1){
                depth_new_ = depth_bottom_ + 100;
            }
        }
        ImGui.SameLine()
        if(ImGui.Button("Top")){
            if(layer_get_depth(layer_active.id) != depth_top_){
                depth_new_= depth_top_ - 100;
            }
        }
        ImGui.SameLine()
        if(ImGui.Button("Bottom")){
            if(layer_get_depth(layer_active.id) != depth_bottom_){
                depth_new_ = depth_bottom_ + 100;
            }
        }
        
        var input_int_ = ImGui.InputInt("Depth",depth_,10,100);
        if(input_int_ != depth_) depth_new_ = input_int_;
            
        if(depth_new_ != depth_){
            struct_set_chained(global.room_data,depth_new_,"layers",layer_active.name,"depth");
            layer_depth(layer_active.id,depth_new_);
            layers_depth_order();
        }
        
        #endregion
        
        #region parralax slider
        parralax = ImGui.SliderFloat("Parralax",parralax,-1,1,"%.2f");
        struct_set_chained(global.room_data,parralax,"layers",layer_active.name,"parralax");
        #endregion
    }
    
    #region delete layer
    if(layer_active != undefined){
        
        ImGui.SetCursorPosY(ImGui.GetCursorPosY() + max(0, ImGui.GetContentRegionAvailY() - (ImGui.GetTextLineHeightWithSpacing() + 5 )));
        if(ImGui.Button("Delete layer")){
            ImGui.OpenPopup("Delete Layer?")
        }
        
        if (ImGui.BeginPopupModal("Delete Layer?",, ImGuiWindowFlags.AlwaysAutoResize)) {
            ImGui.Text("Delete layer?");
            ImGui.Separator();
            
            if (ImGui.Button("Delete")){
                delete_layer(layer_index);
                ImGui.CloseCurrentPopup();
            } 
            ImGui.SetItemDefaultFocus();
            ImGui.SameLine();
            if (ImGui.Button("Cancel")){
                ImGui.CloseCurrentPopup()  
            } 
            ImGui.EndPopup();
        }
    }
    #endregion
    
    ImGui.End()
}
#endregion

#region right panel

ImGui.SetNextWindowPos(window_get_width()-menu_size_,0);
ImGui.SetNextWindowSize(menu_size_,window_get_height());
ImGui.Begin("Right",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)
if(layer_active != undefined){
    ImGui.Text("Hiii");
    #region selecting tiles
    if(layer_active.type == LAYER_TYPE.TILEMAP){
        
        #region tileset
            
        ImGui.Text("Tileset:");
        ImGui.BeginChild("Tileset",,menu_size_);
        
        if(element_active != noone){
            //also instance tileset
            //TODO consider making updating tiledata surfaces it's own function
        }
        
        if(!surface_exists(tileset_surface)){
            tileset_surface = surface_create(menu_size_,menu_size_);
        }
        surface_set_target(tileset_surface);
        draw_clear(BLACK);
        
        if(element_active != noone){
            draw_sprite_tiled(spr_bg_checker_grid,0,0,0);
    		if(ImGui.IsWindowHovered() ){ 
    			//zoom (centered on view)
    			var zoom_ = mouse_wheel_down() - mouse_wheel_up();
    			if(zoom_ != 0){
    				var tiles_size_prev_ = tiles_size;
    				tiles_size = clamp(tiles_size + zoom_*log2(tiles_size)*10, 64, 1024);
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
            
            //zooms and offsets view
            matrix_set(matrix_world,matrix_build(tiles_x,tiles_y,0,0,0,0,scale_,scale_,0));
    		
    		var tiles_width_  = ds_grid_width( tileset_tiles);
    		var tiles_height_ = ds_grid_height(tileset_tiles);
    		draw_grid_tiles(tileset_tiles,tileset,0,0);
    		draw_grid(0,0,grid_cell_w,grid_cell_h,tiles_width_,tiles_height_,1);
            //Here
    		
    		if(ImGui.IsWindowHovered() ){ 
    			var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
    			var hover_x_ = ((mx_-xx_ - tiles_x) / scale_);
    			var hover_y_ = ((my_-yy_ - tiles_y) / scale_);
    			
    			hover_x_ = hover_x_ div grid_cell_w;
    			hover_y_ = hover_y_ div grid_cell_h;
    				
    			set_draw(WHITE,0.5);
    			draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
    			reset_draw();
    			
    			if(mouse_check_button_pressed(mb_left)){
    				var brush_ = ds_grid_get(tileset_tiles,hover_x_,hover_y_);
    				if(brush_ != undefined){
                        brush = ds_grid_create(1,1);
                        ds_grid_add(brush,0,0,brush_);
    				} else brush = -1;
    			}
    		}
            matrix_set(matrix_world,matrix_build_identity());
        }
        
        surface_reset_target();
        
        ImGui.Surface(tileset_surface);
        
        ImGui.EndChild();
        
        #endregion
        
        #region tile brushes
        
        ImGui.Text("Tile Brushes:");
        
        ImGui.BeginChild("Tilebrushes",,menu_size_);
        
        //Draws and instances tiledata
        if(element_active != noone){ 
            if(!surface_exists(tilebrush_data_surface) || tilebrush_data_update){
                tilebrush_data_update = false;
                
                var brushes_width_ = ds_grid_width(tileset_brushes); 
                var brushes_height_ = ds_grid_height(tileset_brushes);
                tilebrush_data_surface = surface_create(brushes_width_*grid_cell_w,brushes_height_*grid_cell_h);
                
                surface_set_target(tilebrush_data_surface);    
                draw_grid_tiles(tileset_brushes,tileset,0,0);
                set_draw(BLACK,0.5);
                draw_grid(0,0,grid_cell_w,grid_cell_h,brushes_width_,brushes_height_,1);
                reset_draw();
                surface_reset_target();
            }
        }
        
        if(!surface_exists(tilebrush_surface)){
            tilebrush_surface = surface_create(menu_size_,menu_size_);
        }
        surface_set_target(tilebrush_surface);
        draw_clear(BLACK);
        
        if(element_active != noone){ 
            draw_sprite_tiled(spr_bg_checker_grid,0,0,0);
    		if(ImGui.IsWindowHovered() ){ 
    			//zoom (centered on view)
    			var zoom_ = mouse_wheel_down() - mouse_wheel_up();
    			if(zoom_ != 0){
    				var brushes_size_prev_ = brushes_size;
    				brushes_size = clamp(brushes_size + zoom_*log2(brushes_size)*10, 64, 1024);
    				if (brushes_size != brushes_size_prev_) { 
    					var factor_ = brushes_size_prev_ / brushes_size;
    					var center_ = menu_size_ * 0.5;
    					// adjust translation so the center point stays fixed when scaling
    					brushes_x = center_ - (center_ - brushes_x) * factor_;
    					brushes_y = center_ - (center_ - brushes_y) * factor_;
    				}
    			}
    			//dragging
    			if (mouse_check_button(mb_middle)){
    				brushes_x -= mouse_spd_h_;
    				brushes_y -= mouse_spd_v_;
    			}
    		}
            
            var scale_ = menu_size_ / brushes_size;
            
            //zooms and offsets view
            matrix_set(matrix_world,matrix_build(brushes_x,brushes_y,0,0,0,0,scale_,scale_,0));
    		
            //draw instanced tiledata
            draw_surface(tilebrush_data_surface,0,0);
    		
    		if(ImGui.IsWindowHovered(ImGuiHoveredFlags.ChildWindows) ){ 
    			var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
    			var hover_x_ = ((mx_-xx_ - brushes_x) / scale_);
    			var hover_y_ = ((my_-yy_ - brushes_y) / scale_);
    			
    			hover_x_ = hover_x_ div grid_cell_w;
    			hover_y_ = hover_y_ div grid_cell_h;
    				
    			set_draw(WHITE,0.5);
    			draw_cell(0,0, grid_cell_w,grid_cell_h,hover_x_,hover_y_);
    			reset_draw();
    			
    			if(mouse_check_button_pressed(mb_left)){
    				var brush_ = ds_grid_pick(tileset_brushes,hover_x_,hover_y_);
    				if(brush_ != undefined){
    					brush = brush_;
    				}
    			}
    		}
            matrix_set(matrix_world,matrix_build_identity());
        }
        
        surface_reset_target();
        
        ImGui.Surface(tilebrush_surface);
        
        ImGui.EndChild();
        
        #endregion
    }
    #endregion
    
    #region sprite assets
    if(layer_active.type == LAYER_TYPE.ASSET){
        ImGui.Text("Assets:")
        ImGui.BeginChild("Assets",,300, ImGuiChildFlags.Border);
        for (var i_ = 0; i_ < array_length(layer_active.transforms); i_++) {
            var transform_ = layer_active.transforms[i_];
            if(ImGui.Selectable(transform_.name,element_active == transform_)){
                element_active = transform_;
                
            }
        }
        ImGui.EndChild();
    #endregion
    
    #region add sprite element
        ImGui.Text("Add sprites:")
        ImGui.BeginChild("Sprites",,300, ImGuiChildFlags.Border);
        var sprites_ = asset_get_ids(asset_sprite);
        for (var i_ = 0; i_ < array_length(sprites_); i_++) {
            var sprite_ = sprites_[i_];
            var cursor_pos_ = ImGui.GetCursorPosX();
            if(ImGui.Selectable("     "+sprite_get_name(sprite_),false)){
                add_sprite(sprite_);
            }
            ImGui.SameLine();
            ImGui.SetCursorPosX(cursor_pos_);
            ImGui.Image(sprite_,0,WHITE,1,20,20);
        }
        ImGui.EndChild();
    }
    #endregion
    
    ImGui.End()
}
    
#endregion
#endregion

#region tile placing / asset moving
if(layer_active != undefined){   
    if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !ImGui.IsAnyItemActive()){
    	
    	if(layer_active.type == LAYER_TYPE.TILEMAP){
    		//tile drawing
            //TODO:
            //Make it so it only pastes once, until the mouse has moved the brushes length away again
            //floor snapping based on the width/height maybe
                
            if(tileset != undefined){
                if(ds_exists(brush,ds_type_grid)){
                    //rotate brush
                    if(keyboard_check_pressed(ord("Z"))){
                        var clockwise_ = !keyboard_check(vk_shift);
                        brush_rotate(brush,clockwise_);
                    }
                    
                    //mirror brush
                    if(keyboard_check_pressed(ord("X"))){
                        brush_mirror(brush);
                    }
                    
                    //flip brush
                    if(keyboard_check_pressed(ord("Y"))){
                        brush_flip(brush);
                    }
                    
                    if(InputMouseCheck(mb_left) || InputMouseCheck(mb_right)){
                        var brush_offset_x_ = (ds_grid_width( brush)*grid_cell_w / 2)-grid_cell_w/2;
                        var brush_offset_y_ = (ds_grid_height(brush)*grid_cell_h / 2)-grid_cell_h/2;
                        
                        var cx_ = floor((rmx_-brush_offset_x_)/grid_cell_w);
                        var cy_ = floor((rmy_-brush_offset_y_)/grid_cell_h);
                        
                        if (InputMouseCheck(mb_left)){
                            paste_tile_grid(tilemap,brush,cx_,cy_);
                        }
                        
                        if (InputMouseCheck(mb_right)){ 
                            //uses brush to erase tiles
                            erase_tile_grid(tilemap,brush,cx_,cy_);
                        }
                    }
                }
            }
    	}
    	else if(layer_active.type == LAYER_TYPE.ASSET){
    		//asset manipulation
    		var offset_x_ = floor(global.camera.get_x() * parralax);
    		var offset_y_ = floor(global.camera.get_y() * parralax);
    		
    		var x_ = rmx_-offset_x_;
    		var y_ = rmy_-offset_y_;
    		
    		//transforms already selecteed asset
    		if(element_active == noone){
    			//selects asset at position
    			if(mouse_check_button_pressed(mb_left)){
    				element_active = instance_position(x_,y_,obj_asset_transform);
    			}
    		}
    	}
    }
}
#endregion

/// @description

#region close button save reminder
if (window_command_check(window_command_close)) {
    if (show_question("Really quit?")) game_end();
}
#endregion

#region input

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
        global.camera.move(x_, y_, 0);
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
ImGui.SetNextWindowPos(0,0)
ImGui.SetNextWindowSize(menu_size_,global.res_h);

ImGui.Begin("Left",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)

ImGui.Text("Layers:")
ImGui.BeginChild("Layers",,300, ImGuiChildFlags.Border);
for (var i_ = 0; i_ < array_length(layers); i_++) {
    var layer_ = layers[i_];
    if(ImGui.Selectable(layer_.name,layer_index == i_)){
        set_layer(i_)
    }
}
ImGui.EndChild();

#region parralax slider
    parralax = ImGui.SliderFloat("Parralax",parralax,-1,1,"%.2f");
    struct_set_chained(global.level_data,parralax,"layers",layer_active.name,"parralax");
#endregion

ImGui.End()
#endregion

#region right panel

ImGui.SetNextWindowPos(global.res_w-menu_size_,0)
ImGui.SetNextWindowSize(menu_size_,global.res_h);
ImGui.Begin("Right",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)

#region selecting tiles
if(layer_active.type == LAYER_TYPE.COLLISION || layer_active.type == LAYER_TYPE.DECOR){
    
    #region tile selection
    
    ImGui.Text("Tilemaps:");
    ImGui.SameLine();
    ImGui.Text(tileset_info.name);
    
    ImGui.BeginChild("Tilemaps",,menu_size_);
    if(!surface_exists(tileset_surface)){
        tileset_surface = surface_create(menu_size_,menu_size_);
    }
    surface_set_target(tileset_surface);
    draw_clear(BLACK);
    
    if(element_active != undefined){
        var hovered_ = -1;
        var scale_ = menu_size_ / tiles_zoom;
        if(ImGui.IsWindowHovered() ){ 
            //zoom
            var zoom_ = mouse_wheel_down() - mouse_wheel_up();
            if(zoom_ != 0){
                tiles_zoom = clamp(tiles_zoom + zoom_*10,64,1024);
                scale_ = menu_size_ / tiles_zoom;
            }
            
            if (mouse_check_button(mb_middle)){
                tiles_x -= mouse_spd_h_;
                tiles_y -= mouse_spd_v_;
            } 
            
            var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
            var hover_x_ = ((mx_-xx_ - tiles_x) / scale_);
            var hover_y_ = ((my_-yy_ - tiles_y) / scale_);
            
            if(hover_x_ < tileset_info.width && hover_y_ < tileset_info.height){
                
                hover_x_ = hover_x_ div tileset_info.tile_width
                hover_y_ = hover_y_ div tileset_info.tile_height
                
                hovered_ = hover_y_ * tileset_info.tile_columns + hover_x_;
            }
        }
        
        //zooms and offsets view
        matrix_set(matrix_world,matrix_build(tiles_x,tiles_y,0,0,0,0,scale_,scale_,0));
        
        for (var i_ = 0; i_ < tileset_info.tile_count; i_++) {
            //select hovered tile
            if (mouse_check_button_pressed(mb_left)){
                brush = i_;    
            }
            
            var x_ = (i_ mod tileset_info.tile_columns) * tileset_info.tile_width;
            var y_ = (i_ div tileset_info.tile_columns) * tileset_info.tile_height;
        	draw_tile(tileset,i_,0,x_,y_);
            
            //hovered tile
            if(i_ == hovered_){
                set_draw(WHITE,0.5);
                draw_rectangle(x_,y_,x_+tileset_info.tile_width,y_+tileset_info.tile_height,false);
            }
            
            //rectangle around selected tile
            if(is_numeric(i_) && i_ == brush){
                set_draw(WHITE,1);
                draw_rectangle(x_,y_,x_+tileset_info.tile_width,y_+tileset_info.tile_height,true);
            }
            reset_draw();
        }
    }
    
    matrix_set(matrix_world,matrix_build_identity());
    surface_reset_target();
    
    ImGui.Surface(tileset_surface);
    
    ImGui.EndChild();
    
    #endregion
    
    #region tile brushes
    
    ImGui.Text("Tile Brushes:");
    
    ImGui.BeginChild("Tilebrushes",,menu_size_);
    if(!surface_exists(tilebrush_surface)){
        tilebrush_surface = surface_create(menu_size_,menu_size_);
    }
    surface_set_target(tilebrush_surface);
    draw_clear(BLACK);
    
    if(element_active != undefined){
        
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
		
		var brushes_width_ = ds_grid_width(tileset_brushes);
		var brushes_height_ = ds_grid_height(tileset_brushes);
		draw_grid_tiles(tileset_brushes,tileset,0,0);
		draw_grid(0,0,tileset_info.tile_width,tileset_info.tile_height,brushes_width_,brushes_height_,1);
		
		if(ImGui.IsWindowHovered() ){ 
			var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
			var hover_x_ = ((mx_-xx_ - brushes_x) / scale_);
			var hover_y_ = ((my_-yy_ - brushes_y) / scale_);
			
			//if(hover_x_ < brushes_width_ && hover_y_ < brushes_height_){
			
			hover_x_ = hover_x_ div tileset_info.tile_width;
			hover_y_ = hover_y_ div tileset_info.tile_height;
				
			set_draw(WHITE,0.5);
			draw_cell(0,0, tileset_info.tile_width,tileset_info.tile_height,hover_x_,hover_y_);
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

ImGui.End()

#endregion
#endregion

#region tile placing
if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !ImGui.IsAnyItemActive()){
    if(tileset != undefined){
        
        if(!ds_exists(brush,ds_type_grid)){
            //single tile
            var cx_ = tilemap_get_cell_x_at_pixel(tilemap, rmx_, rmy_);
            var cy_ = tilemap_get_cell_y_at_pixel(tilemap, rmx_, rmy_);
            var data_ = tilemap_get(tilemap, cx_, cy_);
            
            if (InputMouseCheck(mb_left)){ 
               tilemap_set(tilemap,brush,cx_,cy_);
            }
            else if (InputMouseCheck(mb_right)){ 
				//sets tile to blank 
				tilemap_set(tilemap,tile_blank,cx_,cy_);
            }
        } else {
            //brush
            
        }
    }
}
#endregion
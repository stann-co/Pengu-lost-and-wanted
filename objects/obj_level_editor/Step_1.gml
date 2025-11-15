/// @description

#region close button save reminder
if (window_command_check(window_command_close)) {
    if (show_question("Really quit?")) game_end();
}
#endregion

#region camera

    //Move camera
    var hspd_ = (InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)) * move_spd;
    var vspd_ = (InputCheck(INPUT_VERB.DOWN)  - InputCheck(INPUT_VERB.UP))   * move_spd;

    //if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow)){
        //if (mouse_check_button(mb_middle)){
            //hspd_ = -window_mouse_get_delta_x() / stanncam_get_res_scale_x() * global.camera.zoom_amount;
            //vspd_ = -window_mouse_get_delta_y() / stanncam_get_res_scale_y() * global.camera.zoom_amount;
        //}
        //
        ////zoom
        //var zoom_ = mouse_wheel_down() - mouse_wheel_up();
        //if(zoom_ != 0){
            //zoom_ = clamp(global.camera.zoom_amount - zoom_ / log2(global.camera.zoom_amount * 0.1),0.5,4);
            //global.camera.zoom(zoom_,0);
        //}
    //}
//
    //if(hspd_ != 0 || vspd_ != 0){
    	//var x_ = global.camera.x + hspd_;
    	//var y_ = global.camera.y + vspd_;
    	//global.camera.move(x_, y_, 0);
    //}
    //
    //var mx_ = window_mouse_get_x();
    //var my_ = window_mouse_get_y();
    //
    //var rmx_ = global.camera.get_mouse_x();
    //var rmy_ = global.camera.get_mouse_y();
//
//#endregion
//
//#region imgui
//ImGui.__Update();
//
//ImGui.PushFont(font);
//ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding,4)
//ImGui.PushStyleVar(ImGuiStyleVar.WindowBorderSize,0)
//

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
parralax = ImGui.SliderFloat("Parralax",parralax,-10,10);
level_data[$ room_name] ??= {};
level_data[$ room_name][$ layer_active.name] ??= {};
level_data[$ room_name][$ layer_active.name].parallax = parralax;

ImGui.End()
#endregion

//
//#region right panel
//
//ImGui.SetNextWindowPos(global.res_w-menu_size_,0)
//ImGui.SetNextWindowSize(menu_size_,global.res_h);
//ImGui.Begin("Right",true,ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoDecoration)
//
//#region selecting tiles
//if(layer_active.type == LAYER_TYPE.COLLISION || layer_active.type == LAYER_TYPE.DECOR){
    //
    //#region tile selection
    //
    //ImGui.Text("Tilemaps:");
    //ImGui.SameLine();
    //ImGui.Text(tileset_get_name(tileset)); 
    //
    //ImGui.BeginChild("Tilemaps",,menu_size_);
    //if(!surface_exists(tileset_surface)){
        //tileset_surface = surface_create(menu_size_,menu_size_);
    //}
    //surface_set_target(tileset_surface);
    //draw_clear(BLACK);
    //
    //if(element_active != undefined){
        //var info_ = tileset_get_info(tileset);
        //
        //var offset_x_ = 0;
        //var offset_y_ = 0;
        //var tileset_size_ = (info_.width > info_.height) ? info_.width : info_.height;
        //var scale_ = menu_size_ / tileset_size_;
        //
        //var hovered_ = -1;
        //if(ImGui.IsWindowHovered() ){ //gets hovered tile
            //var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
            //var hover_x_ = (mx_-xx_) / scale_;
            //var hover_y_ = (my_-yy_) / scale_;
            //
            //if(hover_x_ < info_.width && hover_y_ < info_.height){
                //
                //hover_x_ = hover_x_ div info_.tile_width
                //hover_y_ = hover_y_ div info_.tile_height
                //
                //hovered_ = hover_y_ * info_.tile_columns + hover_x_;
            //}
        //}
        //
        ////zooms and offsets view
        //matrix_set(matrix_world,matrix_build(offset_x_,offset_y_,0,0,0,0,scale_,scale_,0));
        //
        //for (var i_ = 0; i_ < info_.tile_count; i_++) {
            //var x_ = (i_ mod info_.tile_columns) * info_.tile_width;
            //var y_ = (i_ div info_.tile_columns) * info_.tile_height;
        	//draw_tile(tileset,i_,0,x_,y_);
            //
            ////select tile
            //if(i_ == hovered_){
                //set_draw(WHITE,0.1);
                //draw_rectangle(x_,y_,x_+info_.tile_width,y_+info_.tile_height,false);
                //
                //if (mouse_check_button_pressed(mb_left)){
                    //tile = i_;    
                //}
            //}
            //
            ////rectangle around selected tile
            //if(!is_struct(tile) && i_ == tile){
                //set_draw(WHITE,1);
                //draw_rectangle(x_,y_,x_+info_.tile_width,y_+info_.tile_height,true);
            //}
            //reset_draw();
        //}
    //}
    //
    //matrix_set(matrix_world,matrix_build_identity());
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
    //if(!surface_exists(tilebrush_surface)){
        //tilebrush_surface = surface_create(menu_size_,menu_size_);
    //}
    //surface_set_target(tilebrush_surface);
    //draw_clear(BLACK);
    //
    //if(element_active != undefined){
        ////var info_ = tileset_get_info(tileset);
        ////
        ////var offset_x_ = 0;
        ////var offset_y_ = 0;
        ////var tileset_size_ = (info_.width > info_.height) ? info_.width : info_.height;
        ////var scale_ = menu_size_ / tileset_size_;
        ////
        ////var hovered_ = -1;
        ////if(ImGui.IsWindowHovered() ){ //gets hovered tile
            ////var xx_ = ImGui.GetCursorScreenPosX(), yy_ = ImGui.GetCursorScreenPosY(); 
            ////var hover_x_ = (mx_-xx_) / scale_;
            ////var hover_y_ = (my_-yy_) / scale_;
            ////
            ////if(hover_x_ < info_.width && hover_y_ < info_.height){
                ////
                ////hover_x_ = hover_x_ div info_.tile_width
                ////hover_y_ = hover_y_ div info_.tile_height
                ////
                ////hovered_ = hover_y_ * info_.tile_columns + hover_x_;
            ////}
        ////}
        ////
        //////zooms and offsets view
        ////matrix_set(matrix_world,matrix_build(offset_x_,offset_y_,0,0,0,0,scale_,scale_,0));
        ////
        ////for (var i_ = 0; i_ < info_.tile_count; i_++) {
            ////var x_ = (i_ mod info_.tile_columns) * info_.tile_width;
            ////var y_ = (i_ div info_.tile_columns) * info_.tile_height;
        	////draw_tile(tileset,i_,0,x_,y_);
            ////
            //////select tile
            ////if(i_ == hovered_){
                ////set_draw(WHITE,0.1);
                ////draw_rectangle(x_,y_,x_+info_.tile_width,y_+info_.tile_height,false);
                ////
                ////if (mouse_check_button_pressed(mb_left)){
                    ////tile = i_;    
                ////}
            ////}
            ////
            //////rectangle around selected tile
            ////if(!is_struct(tile) && i_ == tile){
                ////set_draw(WHITE,1);
                ////draw_rectangle(x_,y_,x_+info_.tile_width,y_+info_.tile_height,true);
            ////}
            ////reset_draw();
        ////}
    //}
    //
    //matrix_set(matrix_world,matrix_build_identity());
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
//ImGui.End()
//
//#endregion
//#endregion
//
//#region tile placing
//if (!ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow)){
    //if(tileset != undefined){
        //
        //var info_ = tileset_get_info(tileset);
            //
        //var cx_ = tilemap_get_cell_x_at_pixel(tilemap, rmx_, rmy_);
        //var cy_ = tilemap_get_cell_y_at_pixel(tilemap, rmx_, rmy_);
        //var data_ = tilemap_get(tilemap, cx_, cy_);
        //
        //if (InputMouseCheck(mb_left)){
            //
            //data_ = tile_set_index(data_,tile);
            //data_ = tile_set_flip(data_,tile_flipped);
            //data_ = tile_set_mirror(data_,tile_mirrored);
            //data_ = tile_set_rotate(data_,tile_rotated);
            //
            //tilemap_set(tilemap,data_,cx_,cy_);
        //}
        //
        //else if (InputMouseCheck(mb_right)){
            //data_ = tile_set_index(data_,0);
            //data_ = tile_set_flip(data_,0);
            //data_ = tile_set_mirror(data_,0);
            //data_ = tile_set_rotate(data_,0);
            //tilemap_set(tilemap,data_,cx_,cy_);
        //}
    //}
//}
//#endregion
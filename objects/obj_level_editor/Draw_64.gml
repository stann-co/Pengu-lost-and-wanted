/// @description

//Tile grid
if(show_grid){
    
    set_draw(WHITE,0.4);
    
	var offset_x_ = floor(global.camera.get_x() * parralax_x);
	var offset_y_ = floor(global.camera.get_y() * parralax_y);
    
    var cell_w_ = grid_cell_w;
    var cell_h_ = grid_cell_h;
    for (var w_ = 0; w_ <= grid_w; w_++) {
        var x_ =  global.camera.room_to_gui_x(w_ * cell_w_ + offset_x_);
        var y1_ = global.camera.room_to_gui_y(offset_y_);
        var y2_ = global.camera.room_to_gui_y(cell_h_*grid_h + offset_y_);
    	draw_line(x_,y1_,x_,y2_);
    }
    
    for (var h_ = 0; h_ <= grid_h; h_++) {
        var y_ =  global.camera.room_to_gui_y(h_ * cell_h_ + offset_y_);
        var x1_ = global.camera.room_to_gui_x(offset_x_);
        var x2_ = global.camera.room_to_gui_x(cell_w_*grid_w + offset_x_);
    	draw_line(x1_,y_,x2_,y_);
    }
    
    reset_draw();
}

if (initialized) ImGui.__Render();
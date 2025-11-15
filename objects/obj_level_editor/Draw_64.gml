/// @description

set_draw(WHITE,0.4);

draw_circle(30,30,30,false)

//Tile grid
if(tilemap != undefined){
    
    
    
    
    
    var info_ = tileset_get_info(tileset);
    var cell_w_ = 16//info_.tile_width;
    var cell_h_ = 16//info_.tile_height;
    for (var w_ = 0; w_ <= tilemap_w; w_++) {
        var x_ =  global.camera.room_to_gui_x(w_ * cell_w_);
        var y1_ = global.camera.room_to_gui_y(0);
        var y2_ = global.camera.room_to_gui_y(cell_h_*tilemap_h);
    	draw_line(x_,y1_,x_,y2_);
    }
    
    for (var h_ = 0; h_ <= tilemap_h; h_++) {
        var y_ =  global.camera.room_to_gui_y(h_ * cell_h_);
        var x1_ = global.camera.room_to_gui_x(0);
        var x2_ = global.camera.room_to_gui_x(cell_w_*tilemap_w);
    	draw_line(x1_,y_,x2_,y_);
    }
    
    reset_draw();
}

//if (initialized) ImGui.__Render();
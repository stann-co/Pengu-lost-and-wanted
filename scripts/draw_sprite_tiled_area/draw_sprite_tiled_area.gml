///@function draw_sprite_tiled_area_ext(_sprite,_subimg,_x,_y,_x1,_y1,_x2,_y2,_xscale,_yscale,_col,_alpha)
//
//  Draws a repeated _sprite image, tiled to fill a given region and with
//  a given offset. 
//
//      _sprite      _sprite to draw, real
//      _subimg      _sprite subimage to draw, real
//      x,y         origin offset, real
//      _x1,_y1       top_-left_ corner of tiled area, real
//      _x2,_y2       bottom-right corner of tiled area, real
//      _xscale,_yscale       scale, real
//      _col         color, real
//      _alpha		_alpha, real
//
function draw_sprite_tiled_area_ext(_sprite,_subimg,_x,_y,_x1,_y1,_x2,_y2,_xscale=1,_yscale=1,_col=-1,_alpha=1){ 
    var sw_,sh_,i_,j_,jj_,left_,top_,width_,height_,x_,y_;
    sw_ = sprite_get_width(_sprite);
    sh_ = sprite_get_height(_sprite);
 
    i_ = _x1-((_x1 mod sw_) - (_x mod sw_)) - sw_*((_x1 mod sw_)<(_x mod sw_));
    j_ = _y1-((_y1 mod sh_) - (_y mod sh_)) - sh_*((_y1 mod sh_)<(_y mod sh_)); 
    jj_ = j_;
 
    for(i_=i_; i_<=_x2; i_+=sw_) {
        for(j_=j_; j_<=_y2; j_+=sh_) {
 
            if(i_ <= _x1) left_ = _x1-i_;
            else left_ = 0;
            x_ = i_+left_;
 
            if(j_ <= _y1) top_ = _y1-j_;
            else top_ = 0;
            y_ = j_+top_;
 
            if(_x2 <= i_+sw_) width_ = ((sw_)-(i_+sw_-_x2)+1)-left_;
            else width_ = sw_-left_;
 
            if(_y2 <= j_+sh_) height_ = ((sh_)-(j_+sh_-_y2)+1)-top_;
            else height_ = sh_-top_;
 
            draw_sprite_part_ext(_sprite,_subimg,left_,top_,width_,height_,x_,y_,_xscale,_yscale,_col,_alpha);
        }
        j_ = jj_;
    }
    return 0;
}
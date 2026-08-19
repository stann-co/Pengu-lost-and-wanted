/// @desc return cloest side_ from instance
/// @param {real*} _x
/// @param {real*} _y
/// @param {object*} _inst instance to get side_ from
function find_side(_x,_y,_inst){
    var angle_ = _inst.image_angle;
    
    var vec_ = new Vector2(_x - _inst.x,_y - _inst.y)
    vec_ = vec_.rotated(angle_);
    
    _x = vec_.x + _inst.x;
    _y = vec_.y + _inst.y;

    with(_inst){
        
        var w_ = sprite_width  / 2; //half width
        var h_ = sprite_height / 2; //half height
        
        image_angle = 0
        var mid_x_ = (bbox_left + bbox_right ) / 2;
        var mid_y_ = (bbox_top  + bbox_bottom) / 2;
        image_angle = angle_
     
        var left_	= mid_x_ - w_;
        var right_	= mid_x_ + w_;
        var top_	= mid_y_ - h_;
        var bottom_ = mid_y_ + h_;
     
        var offset_x_ = _x - mid_x_;
        var offset_y_ = _y - mid_y_;
        
        var is_vertical_ = false;
        
        if(sprite_height < sprite_width){
            var offset_clamped_ = _x - clamp(_x,left_+h_,right_-h_);
            is_vertical_ = abs(offset_y_) > abs(offset_clamped_ );
        } else {
            var offset_clamped_ = _y - clamp(_y,top_+w_,bottom_-w_);
            is_vertical_ = abs(offset_clamped_) > abs(offset_x_ );
        }
  
        var side_ = noone
        if( is_vertical_){
            side_ = (offset_y_ > 0) ? SIDES.BOTTOM: SIDES.TOP;
        } else {
            side_ = (offset_x_ > 0) ? SIDES.RIGHT: SIDES.LEFT;
        }
        return side_
    }
}
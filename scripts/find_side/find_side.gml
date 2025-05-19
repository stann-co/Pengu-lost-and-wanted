/// @desc return cloest side from instance
/// @param {real*} _x
/// @param {real*} _y
/// @param {object*} _inst instance to get side from
function find_side(_x,_y,_inst){


    var angle = _inst.image_angle;
    
    var vec = new Vector2(_x - _inst.x,_y - _inst.y)
    vec = vec.rotated(angle);
    
    _x = vec.x + _inst.x;
    _y = vec.y + _inst.y;

    with(_inst){
        
        var w = sprite_width  / 2; //half width
        var h = sprite_height / 2; //half height
        
        image_angle = 0
        var mid_x = (bbox_left + bbox_right ) / 2;
        var mid_y = (bbox_top  + bbox_bottom) / 2;
        image_angle = angle
     
        var left	    = mid_x - w;
        var right	= mid_x + w;
        var top		= mid_y - h;
        var bottom  = mid_y + h;
     
        var offset_x = _x - mid_x;
        var offset_y = _y - mid_y;
        
        var is_vertical = false;
        
        if(sprite_height < sprite_width){
            var offset_clamped = _x - clamp(_x,left+h,right-h);
            is_vertical = abs(offset_y) > abs(offset_clamped );
        } else {
            var offset_clamped = _y - clamp(_y,top+w,bottom-w);
            is_vertical = abs(offset_clamped) > abs(offset_x );
        }
  
        var side = noone
        if( is_vertical){
            side = (offset_y > 0) ? SIDES.Bottom: SIDES.Top;
        } else {
            side = (offset_x > 0) ? SIDES.Right: SIDES.Left;
        }
        return side
    }
}
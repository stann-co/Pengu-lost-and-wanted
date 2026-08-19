/// @description
draw_self()

var mx_ = global.camera.get_mouse_x();
var my_ = global.camera.get_mouse_y();

var side_ = find_side(mx_,my_,self);
var text_ = ""

switch (side_) {
    case SIDES.BOTTOM:
        text_ = "BOTTOM"
        break
    case SIDES.LEFT:
        text_ = "LEFT"
        break
    case SIDES.RIGHT:
        text_ = "RIGHT"
        break
    case SIDES.TOP:
        text_ = "TOP"
        break
}
draw_text(x,y,text_)

image_angle++

//
//var cw = sprite_width/2; //camer width
//var ch = sprite_height/2; //camer width
//
//var mid_x = (bbox_left + bbox_right ) / 2;
//var mid_y = (bbox_top  + bbox_bottom) / 2;
//
//var w = sprite_width  / 2
//var h = sprite_height / 2
//
//var left	    = mid_x - w;
//var right	= mid_x + w;
//var top		= mid_y - h;
//var bottom  = mid_y + h;
//
//var offset_x = mx_ - mid_x;
//var offset_y = my_ - mid_y;
//
//var offset_x_clamped = offset_x;
//var offset_y_clamped = offset_y;
//
//var is_vertical = false;
//
//if(sprite_height < sprite_width){
    //var offset_clamped = mx_ - clamp(mx_,left+h,right-h);
    //is_vertical = abs(offset_y) > abs(offset_clamped );
//} else {
    //var offset_clamped = my_ - clamp(my_,top+w,bottom-w);
    //is_vertical = abs(offset_clamped) > abs(offset_x );
//}
//
//var x_ = mx_;
//var y_ = my_;
//
//if( is_vertical){
    //y_ = (offset_y > 0) ? bottom : top;
//} else {
    //x_ = (offset_x > 0) ? right : left;
//}
//
//draw_circle(x_,y_,10,false)
//
////block_x += x_ - mx_;
////block_y += y_ - my_;

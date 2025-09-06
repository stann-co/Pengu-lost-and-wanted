/// @description
draw_self()

var mx = global.camera.get_mouse_x();
var my = global.camera.get_mouse_y();

var side = find_side(mx,my,self);
var text = ""

switch (side) {
    case SIDES.Bottom:
        text = "BOTTOM"
        break
    case SIDES.Left:
        text = "LEFT"
        break
    case SIDES.Right:
        text = "RIGHT"
        break
    case SIDES.Top:
        text = "TOP"
        break
}
draw_text(x,y,text)

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
//var offset_x = mx - mid_x;
//var offset_y = my - mid_y;
//
//var offset_x_clamped = offset_x;
//var offset_y_clamped = offset_y;
//
//var is_vertical = false;
//
//if(sprite_height < sprite_width){
    //var offset_clamped = mx - clamp(mx,left+h,right-h);
    //is_vertical = abs(offset_y) > abs(offset_clamped );
//} else {
    //var offset_clamped = my - clamp(my,top+w,bottom-w);
    //is_vertical = abs(offset_clamped) > abs(offset_x );
//}
//
//var x_ = mx;
//var y_ = my;
//
//if( is_vertical){
    //y_ = (offset_y > 0) ? bottom : top;
//} else {
    //x_ = (offset_x > 0) ? right : left;
//}
//
//draw_circle(x_,y_,10,false)
//
////block_x += x_ - mx;
////block_y += y_ - my;

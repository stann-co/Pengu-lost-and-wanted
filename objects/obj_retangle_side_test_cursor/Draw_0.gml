/// @description
draw_self()

var radius = 80;

var mx = global.camera.get_mouse_x();
var my = global.camera.get_mouse_y();

var cw = sprite_width/2; //camer width
var ch = sprite_height/2; //camer width

x = mx - cw;
y = my - ch;

var block_x = 0;
var block_y = 0;

var block_list = ds_list_create()
instance_place_list(x,y,obj_retangle_side_test,block_list,false);

for (var i = 0; i < ds_list_size(block_list); ++i) {
    var block = block_list[| i]
	
	var mid_x = (block.bbox_left + block.bbox_right)  / 2;
	var mid_y = (block.bbox_top  + block.bbox_bottom) / 2;
	
	var w = block.sprite_width  / 2  + cw
	var h = block.sprite_height / 2  + ch
	
	var left	= mid_x - w;
	var right	= mid_x + w;
	var top		= mid_y - h;
	var bottom  = mid_y + h;
	
	var offset_x = mx - mid_x;
	var offset_y = my - mid_y;
	
	var offset_x_clamped = offset_x;
	var offset_y_clamped = offset_y;
	
	var is_vertical = false;
	
	if(block.sprite_height < block.sprite_width){
		var offset_clamped = mx - clamp(mx,left+h,right-h);
		is_vertical = abs(offset_y) > abs(offset_clamped );
	} else {
		var offset_clamped = my - clamp(my,top+w,bottom-w);
		is_vertical = abs(offset_clamped) > abs(offset_x );
	}
	
	var x_ = mx;
	var y_ = my;
	
	if( is_vertical){
		y_ = (offset_y > 0) ? bottom : top;
	} else {
		x_ = (offset_x > 0) ? right : left;
	}
	
	//rounded corner
	//if( (abs(offset_x) > w - radius) && (abs(offset_y) > h - radius)){
	//	var corner_x = mid_x + (w - radius) * sign(offset_x);
	//	var corner_y = mid_y + (h - radius) * sign(offset_y);
	//	var dir = point_direction(corner_x,corner_y,mx,my);
	//	var dist = point_distance(corner_x,corner_y,mx,my);
	//	if(dist < radius){
	//		x_ = corner_x + lengthdir_x(radius,dir);
	//		y_ = corner_y + lengthdir_y(radius,dir);
	//	} else {
	//		x_ = mx;
	//		y_ = my;
	//	}
	//}
	
	block_x += x_ - mx;
	block_y += y_ - my;
}

x += block_x;
y += block_y;

draw_self()


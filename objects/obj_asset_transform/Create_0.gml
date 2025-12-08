/// @description associated with sprite asset, so it can be moved and manipulated
enum TRANSFORM_OPTIONS {
	MOVE,
	ROTATE,
	SCALE,
	NONE
}

sprite_index = layer_sprite_get_sprite(element_id);
image_index = layer_sprite_get_index(element_id);
image_speed = layer_sprite_get_speed(element_id);
x = layer_sprite_get_x(element_id);
y = layer_sprite_get_y(element_id);
image_xscale = layer_sprite_get_xscale(element_id);
image_yscale = layer_sprite_get_yscale(element_id);
image_alpha = layer_sprite_get_alpha(element_id);
image_angle = layer_sprite_get_angle(element_id);
image_blend = layer_sprite_get_blend(element_id);
mask_index = sprite_index;

layer_name = layer_get_name(layer_id);
var elements_ = struct_get_chained(global.room_data,"layers",layer_name,"elements");

transform = function(){
	layer_sprite_change(element_id,sprite_index);
	layer_sprite_index(element_id,image_index);
	layer_sprite_speed(element_id,image_speed);
	layer_sprite_x(element_id,x);
	layer_sprite_y(element_id,y);
	layer_sprite_xscale(element_id,image_xscale);
	layer_sprite_yscale(element_id,image_yscale);
	layer_sprite_alpha(element_id,image_alpha);
	layer_sprite_angle(element_id,image_angle);
	layer_sprite_blend(element_id,image_blend);
    
    var layer_index_ = 0;
    for (var i_ = 0; i_ < array_length(obj_level_editor.layers); i_++) {
    	if(layer_name == obj_level_editor.layers[i_].name){
            layer_index_ = i_;
            break;
        }
    }
    
    //gets this elements index, within the global room data layer element array
    var transforms_ = obj_level_editor.layers[layer_index_].transforms;
    var index_ = 0;
    for (var i_ = 0; i_ < array_length(transforms_); i_++) {
    	if(transforms_[i_].element_id == element_id){
            index_ = i_;
            break;
        }
    }
    
    struct_get_chained(global.room_data,"layers",layer_name,"elements")[index_] = {
        sprite_index : sprite_index,
        image_index : image_index,
        image_speed : image_speed,
        x : x,
        y : y,
        image_xscale : image_xscale,
        image_yscale : image_yscale,
        image_alpha : image_alpha,
        image_angle : image_angle,
        image_blend : image_blend,
    }
}

transform();

dragging = TRANSFORM_OPTIONS.NONE; //what state it's in

x_last = 0;
y_last = 0;

x_drag = 0;
y_drag = 0;
x_drag_offset = 0;
y_drag_offset = 0;

scale_h = 0; // 1 = drag right , -1 = drag left
scale_v = 0; // 1 = drag bottom, -1 = drag top

//set cursor direction icon, based on dir, and image_angle
scale_icon = function(_dir = 0){
	var angle_ = (_dir - image_angle) mod 360;
	if(angle_ < 0) angle_ += 360;
	var sector_ = (round(angle_ / 45)) mod 4;
	if (sector_ == 0) window_set_cursor(cr_size_ns)
	else if (sector_ == 2) window_set_cursor(cr_size_we)
	else if (sector_ == 1) window_set_cursor(cr_size_nesw)
	else window_set_cursor(cr_size_nwse)
}
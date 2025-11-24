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
}

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
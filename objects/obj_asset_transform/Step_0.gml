/// @description
if(obj_level_editor.element_active == id){
	var parralax_ = struct_get_chained(global.level_data,"layers",layer_name,"parralax") ?? 0;
	
	var offset_x_ = floor(global.camera.get_x() * parralax_);
	var offset_y_ = floor(global.camera.get_y() * parralax_);
	
	var x_ = global.camera.get_mouse_x()-offset_x_;
	var y_ = global.camera.get_mouse_y()-offset_y_;
	
	var rad_ = 3;
	
	window_set_cursor(cr_default);
	cursor_sprite = -1;
	
	var pressed_ = false;
	if(mouse_check_button_pressed(mb_left)){
		pressed_ = true;
		x_drag = x_ - x;
		y_drag = y_ - y;
        
	};
	
	var snap_ = false;
	if(keyboard_check(vk_shift)){
		snap_ = true;
	}
	
	var c_ = instance_corners(id);
	
	var x_delta_ = x_ - x_last;
	var y_delta_ = y_ - y_last;
	
	switch (dragging) {
		case TRANSFORM_OPTIONS.NONE:
		//middle
		if(point_in_box(x_,y_,c_.tl.x,c_.tl.y,c_.tr.x,c_.tr.y,c_.bl.x,c_.bl.y,c_.br.x,c_.br.y)){
			window_set_cursor(cr_size_all);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.MOVE;
			}
		} 
		//top left corner
		else if(point_in_circle(x_,y_,c_.tl.x,c_.tl.y,rad_)){
			scale_icon(315);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
				scale_h = -1;
			}
		}
		//top right corner
		else if(point_in_circle(x_,y_,c_.tr.x,c_.tr.y,rad_)){
			scale_icon(45);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
				scale_h = 1;
			}
		}
		//bottom left corner
		else if(point_in_circle(x_,y_,c_.bl.x,c_.bl.y,rad_)){
			scale_icon(225);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
				scale_h = -1;
			}
		}
		//bottom right corner
		else if(point_in_circle(x_,y_,c_.br.x,c_.br.y,rad_)){
			scale_icon(135);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
				scale_h = 1;
			}
		}
		//top
		else if(point_in_line(x_,y_,c_.tl.x,c_.tl.y,c_.tr.x,c_.tr.y,rad_)){
			scale_icon(0);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
			}
		}
		//right
		else if(point_in_line(x_,y_,c_.tr.x,c_.tr.y,c_.br.x,c_.br.y,rad_)){
			scale_icon(90);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_h = 1;
			}
		}
		//bottom
		else if(point_in_line(x_,y_,c_.br.x,c_.br.y,c_.bl.x,c_.bl.y,rad_)){
			scale_icon(180);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
			}
		}
		//left
		else if(point_in_line(x_,y_,c_.bl.x,c_.bl.y,c_.tl.x,c_.tl.y,rad_)){
			scale_icon(270);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_h = -1;
			}
		}
		//rotate
		else if(
			point_in_circle(x_,y_,c_.tl.x,c_.tl.y,rad_*2) ||
			point_in_circle(x_,y_,c_.tr.x,c_.tr.y,rad_*2) ||
			point_in_circle(x_,y_,c_.bl.x,c_.bl.y,rad_*2) ||
			point_in_circle(x_,y_,c_.br.x,c_.br.y,rad_*2)
		){
			window_set_cursor(cr_none);
			cursor_sprite = spr_cursor_rotate;
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.ROTATE;
			}
		}
		//outside
		else if (mouse_check_button_pressed(mb_left)){
			window_set_cursor(cr_default);
			obj_level_editor.element_active = noone;
		}
		break
		
		//transforming
		case TRANSFORM_OPTIONS.MOVE:
		//x += x_delta_;
		//y += y_delta_;
            x = round(x_ - x_drag);
            y = round(y_ - y_drag);
            
            transform();
		break
		
		case TRANSFORM_OPTIONS.ROTATE:
		var rotate_ = point_direction(x,y,x_,y_) - point_direction(x,y,x_last,y_last);
		image_angle += rotate_;
		transform();
		break
		
		case TRANSFORM_OPTIONS.SCALE:
		
		if(scale_h != 0){
			var scale_x_ = dcos(image_angle)*x_delta_ + -dsin(image_angle)*y_delta_;
			var width_ = sprite_get_width(sprite_index);
			if(scale_h > 0){
				var ratio_ = 1-((width_ - sprite_get_xoffset(sprite_index)) / width_);
				var dx_ = dcos(image_angle) * (scale_x_ * ratio_);
				var dy_ = -dsin(image_angle) * (scale_x_ * ratio_);
				image_xscale = (sprite_width + (scale_x_)) / width_;
				x += dx_;
				y += dy_;
			} else if(scale_h < 0){
				var ratio_ = ((width_ - sprite_get_xoffset(sprite_index)) / width_);
				var dx_ = dcos(image_angle) * (scale_x_ * ratio_);
				var dy_ = -dsin(image_angle) * (scale_x_ * ratio_);
				image_xscale = (sprite_width - (scale_x_)) / width_;
				x += dx_;
				y += dy_;
			}
		}
		
		if(scale_v != 0){
			var scale_y_ = dsin(image_angle)*x_delta_ + dcos(image_angle)*y_delta_;
			var height_ = sprite_get_height(sprite_index);
			if(scale_v > 0){
				var ratio_ = 1-((height_ - sprite_get_yoffset(sprite_index)) / height_);
				var dx_ = dsin(image_angle) * (scale_y_ * ratio_);
				var dy_ = dcos(image_angle) * (scale_y_ * ratio_);
				
				image_yscale = (sprite_height + (scale_y_)) / height_;
				x += dx_;
				y += dy_;
			}
			else if(scale_v < 0){
				var ratio_ = ((height_ - sprite_get_yoffset(sprite_index)) / height_);
				var dx_ = dsin(image_angle) * (scale_y_ * ratio_);
				var dy_ = dcos(image_angle) * (scale_y_ * ratio_);
				image_yscale = (sprite_height - (scale_y_)) / height_;
				x += dx_;
				y += dy_;
			}
		}
		transform()
		break
	}
	
	if(dragging != TRANSFORM_OPTIONS.NONE && mouse_check_button_released(mb_left)){
		dragging = TRANSFORM_OPTIONS.NONE;
		scale_h = 0;
		scale_v = 0;
	}
	
	x_last = x_;
	y_last = y_;
}

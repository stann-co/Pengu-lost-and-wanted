/// @description draws its own sprite, plus a selection box when active

//offset-only parallax - unlike obj_tilemap, the sprite itself doesn't get
//scaled, just shifted away from screen center by the same amount obj_tilemap's
//view-matrix scale would move a point at this position
var p_ = parralax_offset(x, y, parralax_effective(parralax));
var x_ = p_.x;
var y_ = p_.y;

draw_sprite_ext(sprite_index,image_index,x_,y_,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

if(obj_level_editor.element_active == id || array_get_index(obj_level_editor.elements_selected, id) != -1){
	//shifted by the same offset as the sprite, so the selection box still lines up with it
	draw_instance_selection(id, x_-x, y_-y);

	//combined envelope around the whole selection - drawn once, from the
	//active element, matching the group's own move hit-test (see Step_0)
	if (id == obj_level_editor.element_active && array_length(obj_level_editor.get_selected_elements()) > 1) {
		var bounds_ = selection_bounds();
		if (bounds_ != undefined) {
			draw_box_selection(bounds_.min_x, bounds_.min_y, bounds_.max_x-bounds_.min_x, bounds_.max_y-bounds_.min_y);
		}
	}
}

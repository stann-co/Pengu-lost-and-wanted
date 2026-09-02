

if(obj_level_editor.element_active == id || array_get_index(obj_level_editor.elements_selected, id) != -1){
	//shifted by the same offset as the sprite, so the selection box still lines up with it
	draw_instance_selection(id, px-x, py-y);

	//combined envelope around the whole selection - drawn once, from the
	//active element, matching the group's own move hit-test (see Step_0)
	if (id == obj_level_editor.element_active && array_length(obj_level_editor.get_selected_elements()) > 1) {
		var bounds_ = selection_bounds();
		if (bounds_ != undefined) {
			draw_box_selection(bounds_.min_x, bounds_.min_y, bounds_.max_x-bounds_.min_x, bounds_.max_y-bounds_.min_y);
		}
	}
}

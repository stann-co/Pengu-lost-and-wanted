/// @description associated with a real instance, so it can be selected,
/// moved, rotated and scaled in the editor - x/y/image_xscale/image_yscale/
/// image_angle/etc. are the instance's own built-in variables, already set
/// at spawn; nothing needs fetching from elsewhere
enum TRANSFORM_OPTIONS {
	MOVE,
	ROTATE,
	SCALE,
	NONE
}

mask_index = sprite_index;

//base parralax depth is the same as base tile size
parralax = TILE_SIZE;

//stable identity that survives this instance being destroyed/recreated by
//undo/redo of its own placement (action_restore_instance overwrites this
//with the original value instead of leaving the freshly auto-assigned one) -
//see obj_level_editor.next_element_uid/find_element_by_uid
element_uid = obj_level_editor.next_element_uid;
obj_level_editor.next_element_uid += 1;

dragging = TRANSFORM_OPTIONS.NONE; //what state it's in

x_last = 0;
y_last = 0;

x_drag = 0;
y_drag = 0;
x_drag_offset = 0;
y_drag_offset = 0;

scale_h = 0; // 1 = drag right , -1 = drag left
scale_v = 0; // 1 = drag bottom, -1 = drag top

//snapshot of x/y/image_xscale/image_yscale/image_angle taken right as a
//move/rotate/scale drag starts, so the whole gesture can be committed as one
//undo step (action_transform_instance) once the mouse is released
transform_start = undefined;

//mouse direction (from the pivot) at the moment a rotate drag starts - image_angle
//is recomputed each frame as transform_start.image_angle plus the angle moved
//since then, rather than accumulating frame-to-frame deltas, so that snapping
//(which rounds image_angle) can't eat small mouse movements before they add up
rotate_start_dir = 0;

//room-space mouse position at the moment a scale drag starts - scaling is,
//like rotating, recomputed each frame from this fixed reference (total
//movement since the drag started) rather than accumulated frame-to-frame,
//for the same snapping reason
drag_start_mouse_x = 0;
drag_start_mouse_y = 0;

//rest of the current multi-selection (obj_level_editor.get_selected_elements,
//captured once as a drag starts) plus their own starting transforms, so a
//move/rotate/scale on this (the active) element carries the group along
group_targets = [];
group_starts = [];
is_group = false; //array_length(group_targets) > 1, cached at drag-start

//rotate/scale of a multi-selection pivots around the group's own envelope
//(selection_bounds) instead of this element's own position - captured at
//drag-start, since the live envelope shifts as the drag moves things
transform_pivot_x = 0;
transform_pivot_y = 0;
group_bounds_start = undefined;

//set cursor direction icon, based on dir and _angle (the envelope's own
//rotation when scaling/rotating a multi-selection, always 0, since it's
//axis-aligned - otherwise this element's own image_angle)
scale_icon = function(_dir = 0, _angle = image_angle){
	var angle_ = (_dir - _angle) mod 360;
	if(angle_ < 0) angle_ += 360;
	var sector_ = (round(angle_ / 45)) mod 4;
	if (sector_ == 0) window_set_cursor(cr_size_ns)
	else if (sector_ == 2) window_set_cursor(cr_size_we)
	else if (sector_ == 1) window_set_cursor(cr_size_nesw)
	else window_set_cursor(cr_size_nwse)
}

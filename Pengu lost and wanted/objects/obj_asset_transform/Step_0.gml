/// @description
if(obj_level_editor.element_active == id){
	//dragging moves x/y via the mouse's inverse parralax offset; hover/handle
	//detection forward-transforms corners the same way Draw_0 does
	var effective_parralax_x_ = parralax_effective(parralax_x);
	var effective_parralax_y_ = parralax_effective(parralax_y);
	var mouse_ = parralax_offset(global.camera.get_mouse_x(), global.camera.get_mouse_y(), (TILE_SIZE*TILE_SIZE) / effective_parralax_x_, (TILE_SIZE*TILE_SIZE) / effective_parralax_y_);
	var x_ = mouse_.x;
	var y_ = mouse_.y;

	var raw_mx_ = global.camera.get_mouse_x();
	var raw_my_ = global.camera.get_mouse_y();

	//room-space handle radius, divided by res_scale for real screen pixels,
	//floored to 1 game pixel since nothing renders at finer precision
	var rad_ = max(2, 2 / stanncam_get_res_scale_x());

	window_set_cursor(cr_default);
	cursor_sprite = -1;

	//ignore clicks on ImGui (eg toolbar buttons), otherwise they're misread as
	//a room click and deselect the element before the button's code even runs
	var room_click_ = mouse_check_button_pressed(mb_left) && !ImGui.IsWindowHovered(ImGuiHoveredFlags.AnyWindow) && !ImGui.IsAnyItemActive();

	var pressed_ = false;
	if(room_click_){
		pressed_ = true;
		x_drag = x_ - x;
		y_drag = y_ - y;

		if (dragging == TRANSFORM_OPTIONS.NONE) {
			//snapshot taken right as a drag might be starting, so the whole
			//gesture can be committed as one undo step on release
			transform_start = {x:x, y:y, image_xscale:image_xscale, image_yscale:image_yscale, image_angle:image_angle};

			//rest of the multi-selection, snapshotted the same way so this drag
			//carries them too (see MOVE/ROTATE/SCALE cases and the commit below)
			group_targets = obj_level_editor.get_selected_elements();
			group_starts = [];
			for (var gi_ = 0; gi_ < array_length(group_targets); gi_++) {
				var gt_ = group_targets[gi_];
				array_push(group_starts, {x:gt_.x, y:gt_.y, image_xscale:gt_.image_xscale, image_yscale:gt_.image_yscale, image_angle:gt_.image_angle});
			}
			is_group = array_length(group_targets) > 1;

			//rotate/scale of a group pivots around the envelope's own
			//center/corners instead of this element's own - frozen here too
			if (is_group) {
				group_bounds_start = selection_bounds();
				transform_pivot_x = (group_bounds_start.min_x + group_bounds_start.max_x) * 0.5;
				transform_pivot_y = (group_bounds_start.min_y + group_bounds_start.max_y) * 0.5;
			} else {
				group_bounds_start = undefined;
				transform_pivot_x = x;
				transform_pivot_y = y;
			}

			rotate_start_dir = point_direction(transform_pivot_x, transform_pivot_y, x_, y_);
			//raw (unconverted) mouse - see the SCALE case below for why
			drag_start_mouse_x = raw_mx_;
			drag_start_mouse_y = raw_my_;
		}
	};

	//holding shift while group-scaling repositions the selection without
	//touching anyone's own image_xscale/image_yscale (see the SCALE case)
	var keep_size_ = keyboard_check(vk_shift);

	//hover detection uses the selection's envelope when multiple are selected,
	//else this element's own rotated corners; bounds_ also feeds the move test
	var hover_is_group_ = array_length(obj_level_editor.get_selected_elements()) > 1;
	var bounds_ = selection_bounds();
	var c_;
	//nudged opposite draw_instance_selection's rasterization offset, so hit
	//corners line back up with what's actually drawn on screen
	if (hover_is_group_) {
		c_ = {
			tl: { x: bounds_.min_x-1, y: bounds_.min_y-1 },
			tr: { x: bounds_.max_x,   y: bounds_.min_y-1 },
			bl: { x: bounds_.min_x-1, y: bounds_.max_y },
			br: { x: bounds_.max_x,   y: bounds_.max_y },
		};
	} else {
		//Draw_0 shifts just the sprite anchor and draws it unscaled, so corners
		//need that same shared translation, not their own parralax_offset scale
		var anchor_ = parralax_offset(x, y, effective_parralax_x_, effective_parralax_y_);
		var dx_ = anchor_.x - x;
		var dy_ = anchor_.y - y;
		var c_raw_ = instance_corners(id);
		c_ = {
			tl: { x: c_raw_.tl.x + dx_ - 1, y: c_raw_.tl.y + dy_ - 1 },
			tr: { x: c_raw_.tr.x + dx_,     y: c_raw_.tr.y + dy_ - 1 },
			bl: { x: c_raw_.bl.x + dx_ - 1, y: c_raw_.bl.y + dy_ },
			br: { x: c_raw_.br.x + dx_,     y: c_raw_.br.y + dy_ },
		};
	}

	//snap_enabled (or holding ctrl) snaps movement to
	//obj_level_editor.grid_size and rotation to snap_degrees
	var snap_active_ = obj_level_editor.snap_enabled || keyboard_check(vk_control);

	switch (dragging) {
		case TRANSFORM_OPTIONS.NONE:
		//corner/edge/rotate handles take priority over the move drag below, so
		//they stay reachable inside a multi-selection's combined bounds
		//top left corner
		if(!disable_scaling && point_in_circle(raw_mx_,raw_my_,c_.tl.x,c_.tl.y,rad_)){
			scale_icon(315, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
				scale_h = -1;
			}
		}
		//top right corner
		else if(!disable_scaling && point_in_circle(raw_mx_,raw_my_,c_.tr.x,c_.tr.y,rad_)){
			scale_icon(45, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
				scale_h = 1;
			}
		}
		//bottom left corner
		else if(!disable_scaling && point_in_circle(raw_mx_,raw_my_,c_.bl.x,c_.bl.y,rad_)){
			scale_icon(225, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
				scale_h = -1;
			}
		}
		//bottom right corner
		else if(!disable_scaling && point_in_circle(raw_mx_,raw_my_,c_.br.x,c_.br.y,rad_)){
			scale_icon(135, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
				scale_h = 1;
			}
		}
		//top
		else if(!disable_scaling && point_in_line(raw_mx_,raw_my_,c_.tl.x,c_.tl.y,c_.tr.x,c_.tr.y,rad_)){
			scale_icon(0, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = -1;
			}
		}
		//right
		else if(!disable_scaling && point_in_line(raw_mx_,raw_my_,c_.tr.x,c_.tr.y,c_.br.x,c_.br.y,rad_)){
			scale_icon(90, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_h = 1;
			}
		}
		//bottom
		else if(!disable_scaling && point_in_line(raw_mx_,raw_my_,c_.br.x,c_.br.y,c_.bl.x,c_.bl.y,rad_)){
			scale_icon(180, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_v = 1;
			}
		}
		//left
		else if(!disable_scaling && point_in_line(raw_mx_,raw_my_,c_.bl.x,c_.bl.y,c_.tl.x,c_.tl.y,rad_)){
			scale_icon(270, hover_is_group_ ? 0 : image_angle);
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.SCALE;
				scale_h = -1;
			}
		}
		//rotate
		else if(
			!disable_rotation && (
				point_in_circle(raw_mx_,raw_my_,c_.tl.x,c_.tl.y,rad_*2) ||
				point_in_circle(raw_mx_,raw_my_,c_.tr.x,c_.tr.y,rad_*2) ||
				point_in_circle(raw_mx_,raw_my_,c_.bl.x,c_.bl.y,rad_*2) ||
				point_in_circle(raw_mx_,raw_my_,c_.br.x,c_.br.y,rad_*2)
			)
		){
			window_set_cursor(cr_none);
			cursor_sprite = spr_cursor_rotate;
			if(pressed_){
				dragging = TRANSFORM_OPTIONS.ROTATE;
			}
		}
		//middle - the combined bounds of the whole selection (not just this
		//element), so the group can be dragged from anywhere inside it
		else {
			if (!disable_moving && bounds_ != undefined && point_in_box(raw_mx_,raw_my_, bounds_.min_x,bounds_.min_y, bounds_.max_x,bounds_.min_y, bounds_.min_x,bounds_.max_y, bounds_.max_x,bounds_.max_y)) {
				window_set_cursor(cr_size_all);
				if(pressed_){
					dragging = TRANSFORM_OPTIONS.MOVE;
				}
			}
		}
		break

		//transforming
		case TRANSFORM_OPTIONS.MOVE:
            var new_x_ = x_ - x_drag;
            var new_y_ = y_ - y_drag;
            if (snap_active_) {
                var gs_ = obj_level_editor.grid_size;
                new_x_ = round(new_x_ / gs_) * gs_;
                new_y_ = round(new_y_ / gs_) * gs_;
            }
            x = round(new_x_);
            y = round(new_y_);

            //carries the rest of the selection along by the same delta
            var move_dx_ = x - transform_start.x;
            var move_dy_ = y - transform_start.y;
            for (var mi_ = 0; mi_ < array_length(group_targets); mi_++) {
                if (group_targets[mi_] == id) {
                    on_moved();
                    continue;
                }
                if (group_targets[mi_].disable_moving) continue;
                group_targets[mi_].x = group_starts[mi_].x + move_dx_;
                group_targets[mi_].y = group_starts[mi_].y + move_dy_;
                group_targets[mi_].on_moved();
            }
		break

		case TRANSFORM_OPTIONS.ROTATE:
		//recomputed from the drag's starting angle each frame, not accumulated,
		//so snapping can't round away small mouse movements before they add up
		var current_dir_ = point_direction(transform_pivot_x, transform_pivot_y, x_, y_);
		var rotated_angle_ = transform_start.image_angle + (current_dir_ - rotate_start_dir);
		if (snap_active_) {
			var sd_ = obj_level_editor.snap_degrees;
			rotated_angle_ = round(rotated_angle_ / sd_) * sd_;
		}

		//every selected element spins by the same delta around the shared pivot -
		//this element's own position alone, or the group's envelope center
		var rot_delta_ = rotated_angle_ - transform_start.image_angle;
		var rot_cos_ = dcos(rot_delta_);
		var rot_sin_ = dsin(rot_delta_);
		for (var ri_ = 0; ri_ < array_length(group_targets); ri_++) {
			if (group_targets[ri_].disable_rotation) continue;
			var rs_ = group_starts[ri_];
			var rox_ = rs_.x - transform_pivot_x;
			var roy_ = rs_.y - transform_pivot_y;
			group_targets[ri_].x = transform_pivot_x + (rox_*rot_cos_ + roy_*rot_sin_);
			group_targets[ri_].y = transform_pivot_y + (roy_*rot_cos_ - rox_*rot_sin_);
			group_targets[ri_].image_angle = rs_.image_angle + rot_delta_;
			group_targets[ri_].on_rotated();
		}
		break

		case TRANSFORM_OPTIONS.SCALE:
		//total movement since drag start, avoiding snap fighting small per-frame
		//deltas; raw mouse since size renders 1:1 regardless of parralax
		var total_dx_ = raw_mx_ - drag_start_mouse_x;
		var total_dy_ = raw_my_ - drag_start_mouse_y;

		if (is_group) {
			//envelope is axis-aligned, no rotation projection - each member scales
			//in its own local axes by the same ratio (exact only if rotations match)
			var scale_ratio_x_ = 1;
			var scale_ratio_y_ = 1;
			var scale_anchor_x_ = (scale_h > 0) ? group_bounds_start.min_x : group_bounds_start.max_x;
			var scale_anchor_y_ = (scale_v > 0) ? group_bounds_start.min_y : group_bounds_start.max_y;
			var envelope_w_ = group_bounds_start.max_x - group_bounds_start.min_x;
			var envelope_h_ = group_bounds_start.max_y - group_bounds_start.min_y;

			if (scale_h != 0 && envelope_w_ > 0) {
				var edge_x_ = (scale_h > 0) ? group_bounds_start.max_x : group_bounds_start.min_x;
				edge_x_ += total_dx_;
				if (snap_active_) {
					var gs_ = obj_level_editor.grid_size;
					edge_x_ = round(edge_x_ / gs_) * gs_;
				}
				var new_w_ = (scale_h > 0) ? (edge_x_ - scale_anchor_x_) : (scale_anchor_x_ - edge_x_);
				scale_ratio_x_ = max(8, new_w_) / envelope_w_;
			}
			if (scale_v != 0 && envelope_h_ > 0) {
				var edge_y_ = (scale_v > 0) ? group_bounds_start.max_y : group_bounds_start.min_y;
				edge_y_ += total_dy_;
				if (snap_active_) {
					var gs_ = obj_level_editor.grid_size;
					edge_y_ = round(edge_y_ / gs_) * gs_;
				}
				var new_h_ = (scale_v > 0) ? (edge_y_ - scale_anchor_y_) : (scale_anchor_y_ - edge_y_);
				scale_ratio_y_ = max(8, new_h_) / envelope_h_;
			}

			for (var si_ = 0; si_ < array_length(group_targets); si_++) {
				if (group_targets[si_].disable_scaling) continue;
				var ss_ = group_starts[si_];
				group_targets[si_].x = scale_anchor_x_ + (ss_.x - scale_anchor_x_) * scale_ratio_x_;
				group_targets[si_].y = scale_anchor_y_ + (ss_.y - scale_anchor_y_) * scale_ratio_y_;
				if (!keep_size_) {
					group_targets[si_].image_xscale = ss_.image_xscale * scale_ratio_x_;
					group_targets[si_].image_yscale = ss_.image_yscale * scale_ratio_y_;
				}
				group_targets[si_].on_scaled();
			}
		} else {
			//scale_h/scale_v can both be active (a corner drag) - their position
			//offsets are combined and applied once instead of overwriting each other
			var accum_dx_ = 0;
			var accum_dy_ = 0;

			if(scale_h != 0){
				var scale_x_ = dcos(image_angle)*total_dx_ + -dsin(image_angle)*total_dy_;
				var width_ = sprite_get_width(sprite_index);
				var start_w_ = transform_start.image_xscale * width_;

				if (snap_active_) {
					//snaps the dragged edge along the sprite's own local x axis from
					//the world origin, not the mouse, so snap ignores grab point
					var gs_ = obj_level_editor.grid_size;
					var xoff_ = sprite_get_xoffset(sprite_index);
					var pivot_axis_ = dcos(image_angle)*transform_start.x + -dsin(image_angle)*transform_start.y;
					var edge_start_axis_ = pivot_axis_ + ((scale_h > 0) ? (transform_start.image_xscale*(width_-xoff_)) : (-transform_start.image_xscale*xoff_));
					var edge_axis_snapped_ = round((edge_start_axis_ + scale_x_) / gs_) * gs_;
					scale_x_ = edge_axis_snapped_ - edge_start_axis_;
				}

				if(scale_h > 0){
					var ratio_ = 1-((width_ - sprite_get_xoffset(sprite_index)) / width_);
					accum_dx_ += dcos(image_angle) * (scale_x_ * ratio_);
					accum_dy_ += -dsin(image_angle) * (scale_x_ * ratio_);
					image_xscale = max(8/width_, (start_w_ + scale_x_) / width_);
				} else if(scale_h < 0){
					var ratio_ = ((width_ - sprite_get_xoffset(sprite_index)) / width_);
					accum_dx_ += dcos(image_angle) * (scale_x_ * ratio_);
					accum_dy_ += -dsin(image_angle) * (scale_x_ * ratio_);
					image_xscale = max(8/width_, (start_w_ - scale_x_) / width_);
				}
			}

			if(scale_v != 0){
				var scale_y_ = dsin(image_angle)*total_dx_ + dcos(image_angle)*total_dy_;
				var height_ = sprite_get_height(sprite_index);
				var start_h_ = transform_start.image_yscale * height_;

				if (snap_active_) {
					var gs_ = obj_level_editor.grid_size;
					var yoff_ = sprite_get_yoffset(sprite_index);
					var pivot_axis_y_ = dsin(image_angle)*transform_start.x + dcos(image_angle)*transform_start.y;
					var edge_start_axis_y_ = pivot_axis_y_ + ((scale_v > 0) ? (transform_start.image_yscale*(height_-yoff_)) : (-transform_start.image_yscale*yoff_));
					var edge_axis_y_snapped_ = round((edge_start_axis_y_ + scale_y_) / gs_) * gs_;
					scale_y_ = edge_axis_y_snapped_ - edge_start_axis_y_;
				}

				if(scale_v > 0){
					var ratio_ = 1-((height_ - sprite_get_yoffset(sprite_index)) / height_);
					accum_dx_ += dsin(image_angle) * (scale_y_ * ratio_);
					accum_dy_ += dcos(image_angle) * (scale_y_ * ratio_);
					image_yscale = max(8/height_, (start_h_ + scale_y_) / height_);
				}
				else if(scale_v < 0){
					var ratio_ = ((height_ - sprite_get_yoffset(sprite_index)) / height_);
					accum_dx_ += dsin(image_angle) * (scale_y_ * ratio_);
					accum_dy_ += dcos(image_angle) * (scale_y_ * ratio_);
					image_yscale = max(8/height_, (start_h_ - scale_y_) / height_);
				}
			}

			//accum_dx_/accum_dy_ are render-space; added to the anchor's render pos
			//(not raw, or the opposite corner drifts under parralax), then reconverted
			var anchor_start_ = parralax_offset(transform_start.x, transform_start.y, effective_parralax_x_, effective_parralax_y_);
			var anchor_new_ = parralax_offset(anchor_start_.x + accum_dx_, anchor_start_.y + accum_dy_, (TILE_SIZE*TILE_SIZE) / effective_parralax_x_, (TILE_SIZE*TILE_SIZE) / effective_parralax_y_);
			x = anchor_new_.x;
			y = anchor_new_.y;
			on_scaled();
		}
		break
	}

	if(dragging != TRANSFORM_OPTIONS.NONE && mouse_check_button_released(mb_left)){
		//every changed group member commits together as one undo step, via the
		//same action_run_many batching tile brush/Mirror/Flip/Rotate90 use
		var commit_entries_ = [];
		for (var comi_ = 0; comi_ < array_length(group_targets); comi_++) {
			var comt_ = group_targets[comi_];
			var coms_ = group_starts[comi_];
			if (coms_.x != comt_.x || coms_.y != comt_.y || coms_.image_xscale != comt_.image_xscale || coms_.image_yscale != comt_.image_yscale || coms_.image_angle != comt_.image_angle) {
				var comafter_ = {x:comt_.x, y:comt_.y, image_xscale:comt_.image_xscale, image_yscale:comt_.image_yscale, image_angle:comt_.image_angle};
				array_push(commit_entries_, {fn: obj_level_editor.action_transform_instance, args: [comt_.element_uid, coms_, comafter_, false]});
			}
		}

		var commit_inverse_ = obj_level_editor.action_run_many(commit_entries_);
		if (commit_inverse_ != undefined) {
			array_push(obj_level_editor.undo_stack, commit_inverse_);
			obj_level_editor.redo_stack = [];
		}

		dragging = TRANSFORM_OPTIONS.NONE;
		scale_h = 0;
		scale_v = 0;
	}

	x_last = x_;
	y_last = y_;
}

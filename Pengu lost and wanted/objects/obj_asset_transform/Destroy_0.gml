/// @description also destroys its linked partner (owner/widget pair) as a
/// side effect, untracked by undo/redo - either side respawns its own partner
if (linked_uid != noone) {
	var partner_ = obj_level_editor.find_element_by_uid(linked_uid);
	if (partner_ != noone) {
		partner_.linked_uid = noone; //stops its own Destroy from cascading back
		instance_destroy(partner_);
	}
}

on_delete();
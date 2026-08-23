/// @description marker placed on an instance layer, representing an object
/// that isn't actually spawned in the editor - object_name comes in via the
/// instance_create_layer struct (see action_place_instance/action_restore_instance)
event_inherited();

if (!variable_instance_exists(id, "object_name")) object_name = "";

//always non-blank so other instances can reference this one by name -
//action_place_instance/action_restore_instance normally supply it already
if (!variable_instance_exists(id, "element_name")) {
	element_name = obj_level_editor.generate_element_name(object_name != "" ? object_name : "element");
}

instance_variables = {};

//runs object_name's own User Event 0, which calls editor_variable_float
//etc. to populate instance_variables with this object's variable defaults
if (object_name != "") event_perform_object(asset_get_index(object_name), ev_other, ev_user0);
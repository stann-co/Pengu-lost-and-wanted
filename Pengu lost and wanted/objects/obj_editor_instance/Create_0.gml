/// @description marker for an object not actually spawned in the editor -
/// object_name arrives via the instance_create_layer struct (see action_place_instance)
event_inherited();

if (!variable_instance_exists(id, "object_name")) object_name = "";

//always non-blank so other instances can reference this one by name -
//action_place_instance/action_restore_instance normally supply it already
if (!variable_instance_exists(id, "element_name")) {
	element_name = obj_level_editor.generate_element_name(object_name != "" ? object_name : "element");
}

instance_variables = {};

//var_name order the editor_variable_* calls below defined them in (structs
//don't preserve insertion order) - the Inspector shows them in this order
instance_variable_order = [];

output_signal_order = [];
input_functions = {};
input_function_order = [];

button_order = [];
buttons = {};

//this instance's own outgoing wiring - restored the same way
//instance_variables is, via a dedicated creation-struct key (see
//action_restore_instance/action_place_instance)
io_connections = variable_instance_exists(id,"pending_io_connections") ? pending_io_connections : [];

//runs object_name's User Event 0 to populate instance_variables with its
//defaults; a parent's own event_inherited() run puts its vars first
if (object_name != "") event_perform_object(asset_get_index(object_name), ev_other, ev_user0);

//User Event 1 runs here too, same as it runs on the real instance's own
//Create - lets an object define variables/functions shared by both
if (object_name != "") event_perform_object(asset_get_index(object_name), ev_other, ev_user1);
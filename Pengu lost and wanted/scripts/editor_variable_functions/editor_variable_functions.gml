///these functions are called in objects user event 0, to define custom variables exposed in the editor

enum EDITOR_VARIABLE_TYPES{
	FLOAT,
	INT,
	STRING,
	REFERENCE,
	BOOL,
	LIST,
	SCRIPT,
}

//@desc returns the value of an instance variable, or undefined if it doesn't exist
function inst_var(_var){
	return instance_variables[$ _var].value
}

///@desc _default unless _var_name already has a saved/restored value staged
///in pending_variable_values (via the instance_create_layer struct)
function _editor_variable_initial_value(_var_name,_default){
	return (variable_instance_exists(id,"pending_variable_values") && variable_struct_exists(pending_variable_values,_var_name))
		? pending_variable_values[$ _var_name]
		: _default;
}

///@desc records _var_name in instance_variable_order the first time it's
///defined, so the Inspector can show variables in definition order
function _editor_variable_register(_var_name){
	if (array_get_index(instance_variable_order,_var_name) == -1) array_push(instance_variable_order,_var_name);
}

///@desc float option with optional range - _hidden keeps it out of the
///Inspector (eg a value your own code computes, not meant for direct editing)
function editor_variable_float(_var_name,_default = 0,_minimum = undefined, _maximum = undefined,_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.FLOAT,
		var_name : _var_name,
		default_value : _default,
		value : _editor_variable_initial_value(_var_name,_default),
		minimum : _minimum,
		maximum : _maximum,
		hidden : _hidden
	})
}

///@desc int option with optional range
function editor_variable_int(_var_name,_default = 0,_minimum = undefined, _maximum = undefined,_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.INT,
		var_name : _var_name,
		default_value : _default,
		value : _editor_variable_initial_value(_var_name,_default),
		minimum : _minimum,
		maximum : _maximum,
		hidden : _hidden
	})
}

///@desc bool option
function editor_variable_bool(_var_name,_default = false,_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.BOOL,
		var_name : _var_name,
		default_value : _default,
		value : _editor_variable_initial_value(_var_name,_default),
		hidden : _hidden
	})
}

///@desc string option
function editor_variable_string(_var_name,_default = "",_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.STRING,
		var_name : _var_name,
		default_value : _default,
		value : _editor_variable_initial_value(_var_name,_default),
		hidden : _hidden
	})
}

///@desc dropdown of strings - value is the selected option's index (0-based),
///not the string itself, so gameplay code can switch on a number
function editor_variable_list(_var_name,_default_index = 0,_options,_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.LIST,
		var_name : _var_name,
		default_index : _default_index,
		options : _options,
		value : _editor_variable_initial_value(_var_name,_default_index),
		hidden : _hidden
	})
}

///@desc reference to other instance, optionally can be made to only accept certain objects, empty array for any
function editor_variable_ref(_var_name,_accepted_objects = [],_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.REFERENCE,
		var_name : _var_name,
		value : _editor_variable_initial_value(_var_name,noone),
		accepted_objects : _accepted_objects,
		hidden : _hidden
	})
}

///@desc in callback script
function editor_variable_script(_var_name,_script,_hidden = false){
	_editor_variable_register(_var_name);
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.SCRIPT,
		var_name : _var_name,
		value : _editor_variable_initial_value(_var_name,""),
		hidden : _hidden
	})
}

///@desc adds a button to the Inspector for this instance - clicking it
///immediately calls _callback with no arguments, eg to reset a transform
///or snap a value to match another entity
function editor_button(_text,_callback){
	if (array_get_index(button_order,_text) == -1) array_push(button_order,_text);
	variable_struct_set(buttons,_text,_callback);
}

///@desc registers _name as an output this object type can fire - purely
///editor-side, drives the I/O window's "My Output" dropdown
function editor_output_signal(_name){
	if (array_get_index(output_signal_order,_name) == -1) array_push(output_signal_order,_name);
}

///@desc registers _name as a callable input with no parameter
function editor_input_function(_name){
	_editor_input_function_register(_name, undefined);
}

///@desc callable input taking one float parameter, optional range
function editor_input_function_float(_name,_minimum=undefined,_maximum=undefined){
	_editor_input_function_register(_name, EDITOR_VARIABLE_TYPES.FLOAT, {minimum:_minimum, maximum:_maximum});
}

///@desc callable input taking one bool parameter
function editor_input_function_bool(_name){
	_editor_input_function_register(_name, EDITOR_VARIABLE_TYPES.BOOL);
}

///@desc callable input taking one string parameter
function editor_input_function_string(_name){
	_editor_input_function_register(_name, EDITOR_VARIABLE_TYPES.STRING);
}

///@desc callable input taking one dropdown-of-strings parameter
function editor_input_function_list(_name,_options){
	_editor_input_function_register(_name, EDITOR_VARIABLE_TYPES.LIST, {options:_options});
}

///@desc shared registration for editor_input_function_* - stores the param's
///type/metadata so the I/O window can render the right widget once this
///input is picked, same way instance_variables drives Custom Variables
function _editor_input_function_register(_name,_param_type,_meta={}){
	if (array_get_index(input_function_order,_name) == -1) array_push(input_function_order,_name);
	variable_struct_set(input_functions,_name, {
		name : _name,
		param_type : _param_type,
		minimum : _meta[$ "minimum"],
		maximum : _meta[$ "maximum"],
		options : _meta[$ "options"],
	});
}

///@desc converts variable string into display string "test_option" -> "Test option"
function variable_string_name(_string){
	return string_replace_all(string_upper(string_char_at(_string, 1)) + string_copy(_string, 2, string_length(_string) - 1),"_"," ");
}


///these functions are called in objects user event 0, to define custom variables exposed in the editor

enum EDITOR_VARIABLE_TYPES{
	FLOAT,
	INT,
	STRING,
	REFERENCE,
	BOOL,
	LIST,
}

///@desc float option with optional range - _hidden keeps it out of the
///Inspector (eg a value your own code computes, not meant for direct editing)
function editor_variable_float(_var_name,_default = 0,_minimum = undefined, _maximum = undefined,_hidden = false){
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.FLOAT,
		var_name : _var_name,
		default_value : _default,
		value : _default,
		minimum : _minimum,
		maximum : _maximum,
		hidden : _hidden
	})
}

///@desc bool option
function editor_variable_bool(_var_name,_default = false,_hidden = false){
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.BOOL,
		var_name : _var_name,
		default_value : _default,
		value : _default,
		hidden : _hidden
	})
}

///@desc string option
function editor_variable_string(_var_name,_default = "",_hidden = false){
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.STRING,
		var_name : _var_name,
		default_value : _default,
		value : _default,
		hidden : _hidden
	})
}

///@desc dropdown of strings
function editor_variable_list(_var_name,_default_index = 0,_options,_hidden = false){
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.LIST,
		var_name : _var_name,
		default_index : _default_index,
		options : _options,
		value : _options[_default_index],
		hidden : _hidden
	})
}

///@desc reference to other instance, optionally can be made to only accept certain objects, empty array for any
function editor_variable_ref(_var_name,_accepted_objects = [],_hidden = false){
	variable_struct_set(instance_variables,_var_name,{
		type : EDITOR_VARIABLE_TYPES.REFERENCE,
		var_name : _var_name,
		value : noone,
		accepted_objects : _accepted_objects,
		hidden : _hidden
	})
}

///@desc converts variable string into display string "test_option" -> "Test option"
function variable_string_name(_string){
	return string_replace(string_upper(string_char_at(_string, 1)) + string_copy(_string, 2, string_length(_string) - 1),"_"," ");
}
///@function activation_link
///@description add linked instance.id's together
function activation_link(){
	
	var linked_array = [];
	
	for (var i = 0; i < argument_count; ++i) {
	    var inst = argument[i];
		linked_array[i] = inst;
	}
	
	array_push(global.activation_list,linked_array);
}
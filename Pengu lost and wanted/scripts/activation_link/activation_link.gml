///@function activation_link
///@description add linked instance.id's together
function activation_link(){
	
	var linked_array_ = [];
	
	for (var i_ = 0; i_ < argument_count; ++i_) {
	    var inst_ = argument[i_];
		linked_array_[i_] = inst_;
	}
	
	array_push(global.activation_list,linked_array_);
}

///@function activation_link_list
///@description add linked instance.id's together
function activation_link_list(_list){
	
	var linked_array_ = [];
	
	for (var i_ = 0; i_ < ds_list_size(_list); ++i_;)
	{
		linked_array_[i_] = _list[| i_];
	}
	
	array_push(global.activation_list,linked_array_);
}
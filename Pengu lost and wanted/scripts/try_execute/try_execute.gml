///@desc tries to execute a function, and catches if theres errors
function try_execute(_func){
	try{
		_func()
	} catch( _exception) {
	    show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
}
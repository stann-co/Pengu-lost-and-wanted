///@desc broadcasts _output_name from the calling instance to every matching
///resolved connection (see resolve_io_connections) - call this from real
///gameplay code the same way obj_trigger_enter_leave calls fire_output("enter")
///@param {string} _output_name
function fire_output(_output_name){
	if (!variable_instance_exists(id, "io_connections_resolved")) return;

	for (var i_ = 0; i_ < array_length(io_connections_resolved); i_++) {
		var conn_ = io_connections_resolved[i_];
		if (conn_.output != _output_name) continue;
		if (conn_.fire_once && conn_.fired) continue;
		if (conn_.target == noone || !instance_exists(conn_.target)) continue;

		conn_.fired = true;

		//local vars aren't captured by a nested function literal - bound via
		//method() instead, so this still works once call_later invokes it later
		var invoke_ = method({target: conn_.target, input: conn_.input, param: conn_.param, has_param: conn_.param != undefined}, function(){
			if (!instance_exists(target) || !variable_instance_exists(target, input)) return;
			try_execute(function(){
				var fn_ = variable_instance_get(target, input);
				if (has_param) fn_(param); else fn_();
			});
		});

		if (conn_.delay > 0) call_later(conn_.delay, time_source_units_seconds, invoke_);
		else invoke_();
	}
}

// Inherit the parent event
event_inherited();

editor_variable_float("duration_seconds", 2, 0, 16 );

editor_variable_float("pause_duration_seconds", 2, 0, 4 );

editor_variable_float("offset_duration_seconds", 0, 0, 8 );

editor_variable_float("end_rotation", 0);

editor_variable_bool("active", true);

editor_variable_list("cycle", 0, ["cycle","do once","ping pong","cycle rotation continue","powered"]);
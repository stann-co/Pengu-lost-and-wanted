///@desc Editor placement
event_inherited();

editor_variable_bool("active", true);
editor_variable_list("cycle", 1, ["cycle","ping pong","cycle rotation continue","powered"]);
editor_variable_list("interpolation", 1, ["linear","ease","ease_in","ease_out"]);
editor_variable_float("end_rotation", 0);

editor_variable_float("duration", 2, 0, 16 );
editor_variable_float("pause_duration", 2, 0, 4 );
editor_variable_float("offset_duration", 0, 0, 8 );

editor_input_function_bool("SetActive");
editor_input_function_bool("SetPowered");

editor_variable_float("target_x",x,undefined,undefined,true);
editor_variable_float("target_y",y-64,undefined,undefined,true);

//spawns the associated widget - targetx/targety are already correct at
//this point (see editor_variable_initial_value), and destroying either this
//or the widget destroys both together (see obj_asset_transform's Destroy
//event), so there's never a leftover one to find here
target = instance_create_layer(inst_var("target_x"), inst_var("target_y"), layer, obj_asset_transform);
target.linked_uid = element_uid;
target.editor_only = true;
target.disable_scaling = true;
target.disable_rotation = true;
target.element_name = element_name + "_target";
target.sprite_index = sprite_index;
target.image_alpha = 0.5;

linked_uid = target.element_uid;

on_scaled = function(){
	target.image_xscale = image_xscale;
	target.image_yscale = image_yscale;
}

on_rotated = function(){
	target.image_angle = image_angle;
}

on_scaled(); //applies the owner's current scale/angle to the widget right away
on_rotated();

target.on_moved = method(target, function(){
	obj_level_editor.action_set_variable(linked_uid, "target_x", x);
	obj_level_editor.action_set_variable(linked_uid, "target_y", y);
});

editor_draw = function(){
	draw_sprite_ext(sprite_index,image_index,px,py,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	draw_line_color(x,y,target.x,target.y,GREEN,RED);
}
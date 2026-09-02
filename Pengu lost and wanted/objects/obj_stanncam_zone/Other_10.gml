editor_variable_bool("active",true);
editor_variable_int("priority",0,0);

editor_variable_ref("included_zone1",obj_stanncam_zone);
editor_variable_ref("included_zone2",obj_stanncam_zone);
editor_variable_ref("included_zone3",obj_stanncam_zone);
editor_variable_ref("included_zone4",obj_stanncam_zone);

editor_button("Set to game size",function(){
	image_xscale = 	 global.game_w / sprite_get_width(sprite_index);
	image_yscale = 	 global.game_h / sprite_get_height(sprite_index);
})
/// @description
if(!is_debug_overlay_open()){
    
    debug = dbg_view("Debug",true);
    dbg_set_view(debug)
    
	#region levels
	//dbg_section("levels")
	
	//dbg_button("workshop",function(){
	//	room_goto(rm_workshop);	
	//})
	//dbg_same_line();
	//dbg_button("up_mountain",function(){
	//	room_goto(rm_up_mountain);	
	//})
	#endregion
	
	#region debug
	dbg_section("debug",false)	
	dbg_button("toggle debug drawing",function(){
		global.debug = !global.debug;
        global.show_collisions = !global.show_collisions
		show_collisions(global.show_collisions);
	})
	#endregion
	
	#region resolution
	dbg_section("resolution",false);
	dbg_button("windowed",function(){
		stanncam_set_windowed()
	})
	dbg_same_line()
	dbg_button("borderless",function(){
		stanncam_set_borderless()
	})
	dbg_same_line()
	dbg_button("fullscreen",function(){
		stanncam_set_fullscreen();
	})
	
	dbg_button("maintain aspect ratio",function(){
		stanncam_set_keep_aspect_ratio(!stanncam_get_keep_aspect_ratio());
	})
	
    //feather ignore once GM2017
	dbg_watch(ref_create(__obj_stanncam_manager, "keep_aspect_ratio"), "keep_aspect_ratio"); 
	#endregion
	
	#region variables
	dbg_section("variables")
		dbg_slider_int(ref_create(self,"SCORE_COMBO_T_MAX"),1,GAME_SPEED * 3,"Score cooldown frames");
	#endregion
    
} else {
    dbg_view_delete(debug);
	show_debug_overlay(false);
}
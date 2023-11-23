/// @description starts the game and inits globals
/// feather ignore all in /Extensions/*

//vars
saved_pengu = {
	x: -1,
	y: -1,
}
save_text = false;
taken_points = [];
active_collisions_A = true;
background_sprites = [];
foreground_sprites = [];

///@function sprite_layer_parralax_init()
sprite_layer_parralax_init = function(layer_name){
	if(!layer_exists(layer_name)) return [];
	
	var sprites = layer_get_all_elements(layer_name);
	var array = [];
	for (var i = 0; i < array_length(sprites); ++i) {
	    array[i] = {
			sprite: sprites[i],
			x: layer_sprite_get_x(sprites[i]),
			y: layer_sprite_get_y(sprites[i])
		}
	}
	return array;
}

///@function sprite_layer_parralax()
sprite_layer_parralax = function(sprite_array,parralax_amount = 1.1){
	for (var i = 0; i < array_length(sprite_array); ++i) {
		var element = sprite_array[i];
		
		var offset_x = element.x - global.camera.x;
		var offset_y = element.y - global.camera.y;
		
		layer_sprite_x(element.sprite, global.camera.x + offset_x * parralax_amount );
		layer_sprite_y(element.sprite, global.camera.y + offset_y * parralax_amount );
	}
}

//loads settings or initializes the default ones
settings_load();

#region lexicon / languages
if (file_exists("local_en.json")){
	lexicon_index_declare_from_json("local_en.json");
	//lexicon_index_declare_from_json("local_da.json");
	//lexicon_index_declare_from_json("local_ru.json");
} else show_error("no language file", true);

lexicon_index_fallback_language_set("English");

var lang_array = lexicon_languages_get_array();
lexicon_language_set(lang_array[global.settings.language][0]);

enum LANGUAGES {
	English,
	//Danish,
	//Russian,
	TOTAL
}

#endregion

#region menu states

//sets text
draw_set_font(f_pixel);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

enum MENU_SETTINGS {
	resolution,
	window_mode,
	keep_aspect_ratio,
	language,
	TOTAL
}

state = new SnowState("start_menu");
//state = new SnowState("start_menu");

#region menu off
state.add("idle", {
	enter: function(){
		
	},
	step: function(){
		if (can_move && input_check_pressed("pause")){
			//audio_play_sound(snd_ui_confirm,0,0);
			state.change("pause_menu");	
		}
	},
	draw: function(){
		draw_set_halign(fa_right);
		draw_text(global.gui_w-10,10,global.score);	
		draw_set_halign(fa_left);
	}
});
#endregion
#region quick start for debugging quickly
state.add("quick_start", {
	enter: function(){
		call_later(1,time_source_units_frames,function(){
			state.change("idle");	
			room_goto_next();
		});
	}
});
#endregion
#region start menu
state.add("start_menu", {
	enter: function(){
		selection = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			//audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,2);
		}
		
		if(input_check_pressed("accept")){
			//audio_play_sound(snd_ui_confirm,0,0);
			if(selection == 0){
				//state.change("level_select");
				state.change("idle");
				room_goto_next();
			}
			if(selection == 1){
				state.change("settings");
			}
			else if(selection == 2) game_end(); 
		}
	},
	draw: function(){		
		var middle = global.game_w/2;
		
		var w = 80;
		var h = text_height*5;
		var x_ = middle-(w/2);
		var y_ = (global.game_h/5)*3;
		
		//draw_box(x_,y_,w,h,0);
		
		draw_text(x_,y_				 ,lexicon_text("gui.menu.level_select_name"));
		draw_text(x_,y_+text_height*1,lexicon_text("gui.menu.settings_name"));
		draw_text(x_,y_+text_height*2,lexicon_text("gui.menu.quit"));
		
		draw_circle(x_-10,y_+6+(text_height*selection),4,false);
		
		//draw_selection(x_,y_+(text_height*selection),w);
	}

})
#endregion

#region level select
state.add("level_select", {
	enter: function(){
		
	},
	step: function(){
		
		if(input_check_pressed("accept")){
			//checks if selected slot has a save file
			//else if(save_files[selection] != ""){
			//	if(load_delete == 0){
			//		audio_play_sound(snd_ui_confirm,0,0);
			//		user_load("save"+string(selection));
			//		global.save_slot = selection;
			//		state.change("idle");
			//		room_goto_next();
			//	} else if(load_delete == 1){
			//		audio_play_sound(snd_ui_confirm,0,0);
			//		popup = true;
			//		popup_selection = 0;
			//	}
			//} else {
			//	audio_play_sound(snd_ui_decline,0,0);
			//}
		}

	},
	draw: function(){		
		state.inherit();
		//draws selection
		if(!popup){
			var y_select = y_+(text_height*selection);
			draw_selection(x_,y_select,w_);
			
			var load_delete_x = x_+(w_/3);
			var load_delete_w = ((w_/3)*2)/4;
			
			draw_set_halign(fa_center);
			
			if(load_delete == 1){
				var load_color1   = color1;
				var load_color2   = color2;
				var delete_color1 = yellow;
				var delete_color2 = yellow_light;
			} else {
				var load_color1   = yellow;
				var load_color2   = yellow_light;
				var delete_color1 = color1;
				var delete_color2 = color2;	
			}
			
			draw_text_style(load_delete_x+(load_delete_w*1)-8,y_select,lexicon_text("gui.menu.load_game.load"),	load_color1,load_color2);
			draw_text_style(load_delete_x+(load_delete_w*2)-8,y_select,"/",										color1,color2);
			draw_text_style(load_delete_x+(load_delete_w*3)-8,y_select,lexicon_text("gui.menu.load_game.delete"),delete_color1,delete_color2);

			
			draw_set_halign(fa_left);
		}
		//draw_selection(x_+(w*load_delete),y_+(text_height*selection),w);
	}
});
#endregion
#region pause menu
state.add("pause_menu",{
	enter: function(){
		selection = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			//audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selection++;
			else if(input_check_pressed("up")) selection--;
			selection = clamp(selection,0,2);
		}
		
		if(input_check_pressed("accept")){
			//audio_play_sound(snd_ui_confirm,0,0);
			if(selection == 0){
				state.change("idle");
			} else if(selection == 1){
				state.change("settings");
			} else if(selection == 2){
				game_restart();
			}
		}
		
		if(input_check_pressed("cancel")){
			//audio_play_sound(snd_ui_decline,0,0);
			state.change("idle");
		}
	},
	draw: function(){		
		//draw_set_color(black);
		//draw_set_alpha(0.5);
		//draw_rectangle(0,0,global.game_w,global.game_h,0);
		
		var col = global.game_w/3;
		
		//draw_box(0,0,col,text_height*4,0);
		//draw_box(0,global.game_h-(text_height*2),col,text_height*2,0);
		//
		//draw_box(col,0,col*2,global.game_h,0);
		
		var middle = global.game_w/2;
		
		var w = 80;
		var h = text_height*5;
		var x_ = middle-(w/2);
		var y_ = (global.game_h/5)*3;
		
		//draw_box(x_,y_,w,h,0);
		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.gui_w,global.gui_h,false);
		draw_set_color(white);
		draw_set_alpha(1);
		
		draw_text(x_,y_,lexicon_text("gui.menu.continue"));
		draw_text(x_,y_+text_height,lexicon_text("gui.menu.settings_name"));
		draw_text(x_,y_+text_height*2,lexicon_text("gui.menu.quit"));
		
		draw_circle(x_-10,y_+6+(text_height*selection),4,false);
		
	}
});
#endregion

#region settings menu
state.add("settings",{
	enter: function(){
		selection = 0;		
		resolution_new = global.settings.resolution;
		language_new = global.settings.language;
		languages = lexicon_languages_get_array();

	},
	step: function(){
		//can't leave until new settings are confirmed
		if(resolution_new == global.settings.resolution && language_new == global.settings.language){
			if(input_check_pressed("down") || input_check_pressed("up")){
				//audio_play_sound(snd_ui_hover,0,0);
				if(input_check_pressed("down")) selection++;
				else if(input_check_pressed("up")) selection--;
				selection = clamp(selection,0,MENU_SETTINGS.TOTAL-1);
			}
		}
		
		var side_input = 0;
		if(input_check_pressed("left") || input_check_pressed("right")){
			//audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("left")) side_input = -1;
			if(input_check_pressed("right")) side_input = 1;
		}
		
		var action = false;
		if(input_check_pressed("accept")){
			action = true
			//audio_play_sound(snd_ui_confirm,0,0);
		}
		
		switch (selection) {
		    case MENU_SETTINGS.resolution:
				if(global.settings.window_mode == STANNCAM_WINDOW_MODE.windowed){ //can only change res in windowed mode
				    resolution_new+= side_input;
					if (resolution_new < 0) resolution_new = RES_LIB.TOTAL-1;
					if (resolution_new >= RES_LIB.TOTAL) resolution_new = 0;
					
					if(action){
						var new_res = global.resLib[resolution_new];
						stanncam_set_resolution(new_res.width,new_res.height);
						global.settings.resolution = resolution_new;
						settings_save();
					}
				}
		        break;
		    case MENU_SETTINGS.window_mode:
		        if(action || side_input != 0){
					var new_mode = global.window_mode;
					if(action) new_mode++;
					else new_mode+= side_input;	
					if(new_mode == 3) new_mode = 0;
					else if (new_mode == -1) new_mode = 2;
					
					stanncam_set_window_mode(new_mode);
					global.settings.window_mode = global.window_mode;
					settings_save();
				}
		        break;
			case MENU_SETTINGS.keep_aspect_ratio:
		        if(action || side_input != 0){
					var keep_aspect_ratio = !stanncam_get_keep_aspect_ratio();
					stanncam_set_keep_aspect_ratio(keep_aspect_ratio);
					global.settings.keep_aspect_ratio = keep_aspect_ratio;
					settings_save();
				}
		        break;
			case MENU_SETTINGS.language:
				language_new+= side_input;
				if (language_new < 0) language_new = LANGUAGES.TOTAL-1;
				if (language_new >= LANGUAGES.TOTAL) language_new = 0;
				
				if(action){
					var new_lang = languages[language_new][0];
					lexicon_language_set(new_lang);
					global.settings.language = language_new;
					settings_save();
				}
		        break;
		}
		
		if(input_check_pressed("cancel")){
			//audio_play_sound(snd_ui_decline,0,0);
			if(resolution_new != global.settings.resolution || language_new != global.settings.language){
				//if new settings aren't confirmed "back" resets them
				resolution_new = global.settings.resolution;
				language_new = global.settings.language
			} else {
				state.change(state.get_previous_state());	
			}			
		}
	},
	draw: function(){		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.gui_w,global.gui_h,false);
		draw_set_color(white);
		draw_set_alpha(1);
		
		var col = global.game_w/2;
		
		//draws boxes
		//draw_box(0,0,global.game_w,text_height*2,0);
		//draw_box(0,text_height*2,global.game_w,global.game_h-text_height,0);
		
		//resolution
		//var res_color1 = color1;
		//var res_color2 = color2;
		//if(resolution_new != global.settings.resolution){
		//	var res_color1 = yellow;
		//	var res_color2 = yellow_light;
		//}
		//resolution is greyed out when not in windowed mode
		var alpha = (global.settings.window_mode == STANNCAM_WINDOW_MODE.windowed) ? 1 : 0.5;
		
		draw_text(0,text_height*2,lexicon_text("gui.menu.settings.resolution"));
		var res = string(global.resLib[resolution_new].width) + " / " + string(global.resLib[resolution_new].height);
		draw_text(col,text_height*2,res);
		
		//window mode
		draw_text(0,text_height*3,lexicon_text("gui.menu.settings.window_mode"));
		switch (global.settings.window_mode) {
		    case STANNCAM_WINDOW_MODE.windowed:
		        var window_mode = lexicon_text("gui.menu.settings.window_mode.windowed");
		        break;
		    case STANNCAM_WINDOW_MODE.fullscreen:
		        var window_mode = lexicon_text("gui.menu.settings.window_mode.fullscreen");
		        break;
			case STANNCAM_WINDOW_MODE.borderless:
		        var window_mode = lexicon_text("gui.menu.settings.window_mode.borderless");
		        break;
		}
		draw_text(col,text_height*3,window_mode);
		
		//keep_aspect_ratio
		draw_text(0,text_height*4,lexicon_text("gui.menu.settings.keep_aspect_ratio"));
		var keep_aspect_ratio = global.settings.keep_aspect_ratio ? lexicon_text("gui.on") : lexicon_text("gui.off");
		draw_text(col,text_height*4,keep_aspect_ratio);
		
		//language
		//var res_color1 = color1;
		//var res_color2 = color2;
		//if(language_new != global.settings.language){
		//	var res_color1 = yellow;
		//	var res_color2 = yellow_light;
		//}
		draw_text(0,text_height*5,lexicon_text("gui.menu.settings.language"));
		draw_text(col,text_height*5,languages[language_new][0]);
		
		//draws selection
		var y_ = (selection*text_height)+(text_height*2);
		//draw_selection(0,y_, global.game_w);
		
		draw_circle(0,y_,4,false);
		
		//draws description
		switch (selection) {
		    case MENU_SETTINGS.resolution:
				var description = lexicon_text("gui.menu.settings.resolution.description")
		        break;
		    case MENU_SETTINGS.window_mode:
				var description = lexicon_text("gui.menu.settings.window_mode.description")
		        break;
			case MENU_SETTINGS.keep_aspect_ratio:
				var description = lexicon_text("gui.menu.settings.keep_aspect_ratio.description")
		        break;
			case MENU_SETTINGS.language:
				var description = lexicon_text("gui.menu.settings.language.description")
		        break;
		}	
		draw_text(0,0,description);
		
	}
});
#endregion

#endregion

#region debugging

show_collisions = function(){
	layer_set_visible(collision_A,false);
	layer_set_visible(collision_B,false);	
	//layer_set_visible(collision_A_oneway,false);
	//layer_set_visible(collision_B_oneway,false);	
	layer_set_visible("backgrounds_1",false);
	
	if(global.debug){
		layer_set_visible("backgrounds_1",false);
		
		if(active_collisions_A){
			layer_set_visible(collision_A,true);
			//layer_set_visible(collision_A_oneway,true);
		}else{
			layer_set_visible(collision_B,true);
			//layer_set_visible(collision_B_oneway,true);	
		}
	}
}	

//debugging variables
dbg_section("levels")

dbg_button("workshop",function(){
	room_goto(rm_workshop);	
})
dbg_same_line();
dbg_button("up_mountain",function(){
	room_goto(rm_up_mountain);	
})

dbg_section("debug")	
dbg_button("toggle debug drawing",function(){
	global.debug = !global.debug;	
})

var camera = instance_find(obj_camera,0);

dbg_section("bloom controls")
dbg_slider(ref_create(camera,"blur_steps_D"),0,30);
dbg_slider(ref_create(camera,"sigma_D"),0,1);
dbg_slider(ref_create(camera,"bloom_threshold"),0,1);
dbg_slider(ref_create(camera,"bloom_range"),0,1);
dbg_slider(ref_create(camera,"bloom_intensity"),0,2);
dbg_slider(ref_create(camera,"bloom_darken"),0,1);
dbg_slider(ref_create(camera,"bloom_saturation"),0,2);

show_debug_overlay(false);
#endregion
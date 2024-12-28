/// @description starts the game
/// feather ignore all in /Extensions/*

//vars
saved_pengu = {
	x: -1,
	y: -1,
}
save_text = false;
taken_points = [];
active_collisions = -1;

transition_in = false;
transition_val = 0;
transition_t = 0;
transition_duration = 50;
transition_callback = function(){}

timer = 0;
tallying = false;

//loads settings or initializes the default ones
settings_load();

//particles
layer_create(-100,"particles");
global.particles = part_system_create_layer("particles", true);

#region lexicon / languages
//if (file_exists("local_en.json")){
//	lexicon_index_declare_from_json("local_en.json");
//	//lexicon_index_declare_from_json("local_da.json");
//	//lexicon_index_declare_from_json("local_ru.json");
//} else show_error("no language file", true);

//lexicon_index_fallback_language_set("English");

//var lang_array = lexicon_languages_get_array();
//lexicon_language_set(lang_array[global.settings.language][0]);

#endregion

#region menu states

//sets text
draw_set_font(global.gui_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

state = new SnowState("quick_start");
//state = new SnowState("ng_start");
//state = new SnowState("ng_select");

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

	}
});
#endregion
#region quick start for debugging quickly
state.add("quick_start", {
	enter: function(){
		call_later(1,time_source_units_frames,function(){
			state.change("idle");	
			
			for (var i = 0; i < array_length(global.levels); ++i) {
			    if (room_next(room) == global.levels[i].room_id) {
					global.active_level = global.levels[i]
					break;	
				}
			}
			
			room_goto_next();
			
		});
	}
});
#endregion

#region ng_start
state.add("ng_start", {
	enter: function(){
		
	},
	step: function(){
		if (keyboard_check_pressed(vk_anykey)){
			transition(function(){
				state.change("ng_select");
			})
		}
	},
	draw: function(){
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var text =
		"merry christmas, and happy new year.\n"+
		"this is a public demo and playtest\n"+
		"for a full pengu saves christmas game.\n"+
		"there is just 2 short levels,\n"+
		"but we still hope you enjoy\n\n"+
		"press any key to continue";
		
		draw_text(global.game_w/2,global.game_h/2,text);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
});
#endregion
#region ng_select
state.add("ng_select", {
	enter: function(){
		selected = 0;
	},
	step: function(){
		
		if(input_check_pressed("accept")){
			transition(function(){
				state.change("idle");
				global.active_level = global.levels[selected];
				var level = global.levels[selected];
				room_goto(level.room_id);	
			})
			
		}
		
		selected += input_check_pressed("right") - input_check_pressed("left");
		
		var lvl_max = array_length(global.levels)-1
		if(selected < 0) selected = lvl_max;
		if(selected > lvl_max) selected = 0;

	},
	draw: function(){		
		var levels = global.levels;
		
		var width = 60;
		var center_x = global.game_w/2;
		var center_y = global.game_h/2;
		var num = array_length(levels)
		
		draw_set_halign(fa_middle)
		draw_set_valign(fa_center)
		
		for (var i = 0; i < num; ++i) {
			
			var x_ = center_x + (i*width) - (width/2)
			var y_ = center_y;
			
			if(selected != i){
				shader_set(sh_color)
				var u_color = shader_get_uniform(sh_color,"u_color")
				var u_intensity = shader_get_uniform(sh_color,"u_intensity")
				var color = gray;
				shader_set_uniform_f(u_color,
				color_get_red(color)/255,
				color_get_green(color)/255,
				color_get_blue(color)/255,)
				shader_set_uniform_f(u_intensity,0.5);
			} else {
				
				y_ += dsin(global.t*5*2);
				x_ += dsin(global.t*5);
				
			}
			
			draw_text(x_,y_,i+1);
			draw_sprite(spr_level_frame,0,x_,y_);
			
			if(selected != i){
				shader_reset()
				
			}
		}
		
		draw_set_valign(fa_top)
		
		x_ = center_x;
		y_ = center_y +34;
		
		var level = global.levels[selected];
		draw_text(x_,y_,level.name)
		
		y_+=20
		var w_ = 100;		
		var text = ["LEVEL SCORE","LEVEL TIME"]
		var values = [level.level_score,timer_text(level.level_time)];		
		
		for (var i = 0; i < array_length(text); ++i) {
		    draw_set_halign(fa_left);
			draw_set_color(yellow)
			draw_text(x_-w_,y_+text_height*i,text[i]);
			
			draw_set_halign(fa_right);
			draw_set_color(white)
			
			draw_text(x_+w_,y_+text_height*i,values[i]);
		}
		
	}
});
#endregion
#region pause menu
state.add("pause_menu",{
	enter: function(){
		selected = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			//audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selected++;
			else if(input_check_pressed("up")) selected--;
			selected = clamp(selected,0,2);
		}
		
		if(input_check_pressed("accept")){
			//audio_play_sound(snd_ui_confirm,0,0);
			if(selected == 0){
				state.change("idle");
			} else if(selected == 1){
				state.change("settings");
			} else if(selected == 2){
				transition(function(){
					room_goto(rm_init)
					state.change("ng_select")
				})
			}
		}
		
		if(input_check_pressed("cancel")){
			state.change("idle");
		}
	},
	draw: function(){		
	
		var col = global.game_w/3;
		
		var h = 20;
		var x_ = global.game_w/2
		var y_ = (global.game_h/2) - (h * 3) / 2;
		
		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(0,0,global.gui_w,global.gui_h,false);
		draw_set_color(white);
		draw_set_alpha(1);
		
		draw_set_halign(fa_middle);

		draw_text(x_,10,"GAME PAUSED");
		
		var options = ["CONTINUE","SETTINGS","LEVEL SELECT"]
		
		for (var i = 0; i < array_length(options); ++i) {
			if(selected == i) text = "*"+options[i]+"*";
			else text = options[i];
			
		    draw_text(x_,y_ + h * i,text);
		}
		
		draw_set_halign(fa_left);
		
	}
});
#endregion

#region settings menu
state.add("settings",{
	enter: function(){
		selected = 0;		
		resolution_new = global.settings.resolution;
		language_new = global.settings.language;
		languages = lexicon_languages_get_array();

	},
	step: function(){
		//can't leave until new settings are confirmed
		if(resolution_new == global.settings.resolution && language_new == global.settings.language){
			if(input_check_pressed("down") || input_check_pressed("up")){
				//audio_play_sound(snd_ui_hover,0,0);
				if(input_check_pressed("down")) selected++;
				else if(input_check_pressed("up")) selected--;
				selected = clamp(selected,0,MENU_SETTINGS.TOTAL-1);
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
		
		switch (selected) {
		    case MENU_SETTINGS.resolution:
				if(global.settings.window_mode == STANNCAM_WINDOW_MODE.WINDOWED){ //can only change res in windowed mode
				    resolution_new+= side_input;
					if (resolution_new < 0) resolution_new = array_length(global.stanncam_res_presets);
					if (resolution_new >= array_length(global.stanncam_res_presets)) resolution_new = 0;
					
					if(action){
						var new_res = global.stanncam_res_presets[resolution_new];
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
		var alpha = (global.settings.window_mode == STANNCAM_WINDOW_MODE.WINDOWED) ? 1 : 0.5;
		
		draw_text(0,text_height*2,lexicon_text("gui.menu.settings.resolution"));
		var res = string(languages[resolution_new].width) + " / " + string(languages[resolution_new].height);
		draw_text(col,text_height*2,res);
		
		//window mode
		draw_text(0,text_height*3,lexicon_text("gui.menu.settings.window_mode"));
		switch (global.settings.window_mode) {
		    case STANNCAM_WINDOW_MODE.WINDOWED:
		        var window_mode = lexicon_text("gui.menu.settings.window_mode.windowed");
		        break;
		    case STANNCAM_WINDOW_MODE.FULLSCREEN:
		        var window_mode = lexicon_text("gui.menu.settings.window_mode.fullscreen");
		        break;
			case STANNCAM_WINDOW_MODE.BORDERLESS:
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
		
		//draws selected
		var y_ = (selected*text_height)+(text_height*2);
		//draw_selected(0,y_, global.game_w);
		
		draw_circle(0,y_,4,false);
		
		//draws description
		switch (selected) {
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

#region level_tally
state.add("level_tally_start", {
	enter: function(){
		tallying = true;
		tally_x = global.game_w;
		tally_duration = game_speed * 1;
		tally_t = 0;
		tally_pause = false;
		
		tally_score = global.score;
		tally_score_time = 18000 - timer;
		tally_score_snacks = global.coins * 100;
		tally_score_total = 0;
	},
	step: function(){
		if (tally_t < tally_duration) tally_t++
		else if(!tally_pause) {
			tally_pause = true;
			call_later(1,time_source_units_seconds,function(){
				state.change("level_tally_scores");
			})
		}
		var val = animcurve_read(ac_basic,"ease",tally_t/tally_duration)
		tally_x = lerp(global.game_w,0,val);
	},
	draw: function(){
		
		var tally_text   = ["SCORE","BONUS TIME","BONUS SNACKS","","LEVEL SCORE"];
		var tally_scores = [tally_score,tally_score_time, tally_score_snacks,"",tally_score_total];
		
		var w_ = 100;
		var h_ = array_length(tally_text)*text_height;
		
		var x_ = global.game_w/2+tally_x;
		var y_ = (global.game_h/2)-(h_/2);
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_-text_height*1.5,$"{global.active_level.name} COMPLETE!!!")
		
		for (var i = 0; i < array_length(tally_text); ++i) {
		    draw_set_halign(fa_left);
			draw_set_color(yellow)
			draw_text(x_-w_,y_+text_height*i,tally_text[i]);
			
			draw_set_halign(fa_right);
			draw_set_color(white)
			
			draw_text(x_+w_,y_+text_height*i,tally_scores[i]);
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

	}
});

state.add_child("level_tally_start","level_tally_scores", {
	enter: function(){
		tallying = true;
		tally_duration = game_speed * 0.5;
		tally_t = 0;
		tally_pause = false;
		
		tally_score_prev		= tally_score;
		tally_score_time_prev	= tally_score_time;
		tally_score_snacks_prev = tally_score_snacks;
		tally_score_total_new = tally_score + tally_score_time + tally_score_snacks;
	},
	step: function(){
		if (tally_t < tally_duration) tally_t++;
		else if(!tally_pause) {
			tally_pause = true;
			
			//should be best time and score
			global.active_level.level_score = tally_score_total;
			global.active_level.level_time = timer;
			
			call_later(1,time_source_units_seconds,function(){
				state.change("level_tally_anykey")
			})
		}
		
		var val = tally_t / tally_duration;
		tally_score			= floor(lerp(tally_score_prev,0,val))
		tally_score_time	= floor(lerp(tally_score_time_prev,0,val))
		tally_score_snacks	= floor(lerp(tally_score_snacks_prev,0,val))
		tally_score_total	= floor(lerp(0,tally_score_total_new,val));
	},
});

state.add_child("level_tally_start","level_tally_anykey", {
	enter: function(){
	},
	step: function(){
		if(!transition_in && input_check(all)){
			transition(function(){
				state.change("ng_select");
				room_goto(rm_init);
			})
		}
	},
	draw: function(){
		state.inherit()
		
		var x_ = global.game_w/2;
		var y_ = global.game_h/2;
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_+text_height*4,"*CONTINUE*")
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
});


#endregion

#region music

global.song = audio_play_sound(mus_pengus_theme,1,true);

#endregion

#region debugging

show_collisions = function(){	
	if(global.debug){
		layer_set_visible(collision_A,true);
		layer_set_visible(collision_B,true);
		layer_set_visible(collision_C,true);
		layer_set_visible("backgrounds_1",true);
		
		switch (active_collisions) {
		    case collision_A:
		        layer_shader(collision_A,sh_default)
				layer_shader(collision_B,sh_half_alpha)
				layer_shader(collision_C,sh_half_alpha)
		        break;
			case collision_B:
		        layer_shader(collision_A,sh_half_alpha)
				layer_shader(collision_B,sh_default)
				layer_shader(collision_C,sh_half_alpha)
		        break;
			case collision_C:
		        layer_shader(collision_A,sh_half_alpha)
				layer_shader(collision_B,sh_half_alpha)
				layer_shader(collision_C,sh_default)
		        break;
		}
		
	} else {
		layer_set_visible(collision_A,false);
		layer_set_visible(collision_B,false);
		layer_set_visible(collision_C,false);
		layer_set_visible("backgrounds_1",false);
	}
}	


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
		show_collisions();
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
	
	dbg_watch(ref_create(__obj_stanncam_manager, "keep_aspect_ratio"), "keep_aspect_ratio"); 
	#endregion
	
	#region variables
	dbg_section("variables")
		dbg_slider_int(ref_create(self,"score_combo_t_max"),1,game_speed * 3,"Score cooldown frames");
		
	#endregion
	
	show_debug_overlay(false);
#endregion


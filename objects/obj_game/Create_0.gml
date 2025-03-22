/// @description starts the game

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

#region music
audio_group_load(audiogroup_music);
#endregion

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
//state = new SnowState("demo_start");

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
		draw_sprite(spr_gui_button_pause,using_gamepad(),30,global.game_h-15);
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

#region demo_start
state.add("demo_start", {
	enter: function(){
		
	},
	step: function(){
		if (input_check_pressed("accept")){
			state.change("main_menu");
		}
	},
	draw: function(){
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var text =
		@"THIS IS AN EARLY PROTOTYPE OF
		
		PENGU: LOST & WANTED
		
		EVERYTHING IS SUBJECT TO CHANGE
		I APPRECIATE YOUR SUPPORT!!!
		-STANN"
		
		draw_text(global.game_w/2,global.game_h/2,text);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
	}
});
#endregion

#region credits
state.add("credits", {
	enter: function(){
		
	},
	step: function(){
		if (input_check_pressed("cancel")){
			state.change("main_menu");
		}
	},
	draw: function(){
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var text =
		@"GAME: STANN.CO
		LEVEL DESIGN: BOBBYBURT
		EXTRA ART & CONCEPTS: CHOCOHOLICMONKEY
		MUSIC: CONNORGRAIL"
		
		draw_text(global.game_w/2,global.game_h/2,text);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_back,using_gamepad(),30,global.game_h-15);
	}
	
});
#endregion

#region main_menu
state.add("main_menu", {
	enter: function(){
		selected = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selected++;
			else if(input_check_pressed("up")) selected--;
			
			var val = in_browser ? 3 : 4
			selected = clamp(selected,0,val);
		}
		
		if(input_check_pressed("accept")){
			audio_play_sound(snd_ui_hover,0,0);
			if(selected == 0){
				state.change("demo_select")
			} else if(selected == 1){
				state.change("settings");
			} else if(selected == 2){
				state.change("credits");
			} else if(selected == 3){
				try{
					if(in_browser){
						url_open("https://store.steampowered.com/app/3373920/Pengu_Lost_and_Wanted");
					} else {
						steam_activate_overlay_browser("https://store.steampowered.com/app/3373920/Pengu_Lost_and_Wanted");
					}
				}
			} else if(selected == 4){
				game_end();	
			}
		}
	},
	draw: function(){		
	
		var col = global.game_w/3;
		
		var h = 20;
		var x_ = global.game_w/2
		var y_ = (global.game_h/2) - (h * 3) / 2;
		
		draw_set_halign(fa_middle);
		
		var options = ["LEVEL SELECT","SETTINGS","CREDITS","WISHLIST ON STEAM"]
		
		if(!in_browser){
			array_push(options,"QUIT GAME")
		}
		
		for (var i = 0; i < array_length(options); ++i) {
			if(selected != i) shader_set(sh_deselected)
		    draw_text(x_,y_ + h * i,options[i]);
			
			shader_reset()
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
	}
});
#endregion

#region level_start

state.add("level_start",{
	enter: function(){
		
		global.coins = 0;
		global.score = 0;
		global.score_mult = 0;
		global.score_combo_t = 0;
		timer = 0;
		
		state.change("idle")	
	}
});

state.add("level_checkpoint_start",{
	enter: function(){
		//resets to active checkpoint if there is any
		if(global.active_level != undefined && global.active_level.checkpoint != undefined){
			obj_pengu.x = global.active_level.checkpoint.x;
			obj_pengu.y = global.active_level.checkpoint.y;
			
			global.coins = global.active_level.checkpoint_coins;
			global.score = global.active_level.checkpoint_score;
			global.score_mult = 0;
			global.score_combo_t = 0;
			
			state.change("idle")
		} else {
			room_restart()
			state.change("level_start")
		}
	}
});

#endregion

#region demo_select
state.add("demo_select", {
	enter: function(){
		selected = 0;
	},
	step: function(){
		if(!transition_in){
			if(input_check_pressed("accept")){
				transition(function(){
					state.change("level_start");
					global.active_level = global.levels[selected];
					var level = global.levels[selected];
					level.checkpoint = undefined; //reset checkpoint				
					room_goto(level.room_id);	
				})
			}
			
			if(input_check_pressed("cancel")){
				audio_play_sound(snd_ui_decline,0,0);
				state.change("main_menu");
			}
			
			var left_right = input_check_pressed("right") - input_check_pressed("left");
			if(left_right != 0){
				selected += left_right
				audio_play_sound(snd_ui_hover,1,false);
			}
			
			var lvl_max = array_length(global.levels)-1
			if(selected < 0) selected = lvl_max;
			if(selected > lvl_max) selected = 0;
		}

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
			
			var x_ = center_x - ((num-1)*width/2) + (i*width);
			var y_ = center_y;
			
			if(selected != i) shader_set(sh_deselected)
			else {
				y_ += dsin(global.t*5*2);
				x_ += dsin(global.t*5);
			}
			
			draw_text(x_,y_,i+1);
			draw_sprite(spr_level_frame,0,x_,y_);
			
			shader_reset()
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
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_back,using_gamepad(),30,global.game_h-15);
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
		
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
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selected++;
			else if(input_check_pressed("up")) selected--;
			selected = clamp(selected,0,4);
		}
		
		if(input_check_pressed("accept")){
			audio_play_sound(snd_ui_hover,0,0);
			if(selected == 0){
				state.change("idle");
			} else if(selected == 1){
				state.change("settings");
			} else if(selected == 2 && !transition_in){ //level select
				transition(function(){
					room_goto(rm_init)
					state.change("demo_select")
				});
			} else if(selected == 3 && !transition_in){ // restart level
				transition(function(){
					room_restart();
					state.change("level_start");
				});
			} else if(selected == 4 && !transition_in && global.active_level.checkpoint != undefined){ //restart to checkpoint
				transition(function(){
					state.change("level_checkpoint_start");
				});
			}
		}
		
		if(input_check_pressed("cancel")){
			audio_play_sound(snd_ui_decline,0,0);
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
		draw_rectangle(-10,-10,global.gui_w+10,global.gui_h+10,false);
		draw_set_color(white);
		draw_set_alpha(1);
		
		draw_set_halign(fa_middle);

		draw_text(x_,10,"GAME PAUSED");
		
		var options = ["CONTINUE","SETTINGS","LEVEL SELECT","RESTART LEVEL","CHECKPOINT"]
		
		for (var i = 0; i < array_length(options); ++i) {
			if(selected == 4 && global.active_level.checkpoint == undefined) shader_set(sh_greyed);
			if(selected != i) shader_set(sh_deselected)
		    draw_text(x_,y_ + h * i,options[i]);
			
			shader_reset()
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_back,using_gamepad(),30,global.game_h-15);
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
	}
});
#endregion

#region settings menu
state.add("settings",{
	enter: function(){
		selected = 0;
	},
	step: function(){
		if(input_check_pressed("down") || input_check_pressed("up")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("down")) selected++;
			else if(input_check_pressed("up")) selected--;
			if(selected < 0) selected = MENU_SETTINGS.TOTAL-1;
			if(selected = MENU_SETTINGS.TOTAL) selected = 0;
		}
		
		var side_input = 0;
		if(input_check_pressed("left") || input_check_pressed("right")){
			audio_play_sound(snd_ui_hover,0,0);
			if(input_check_pressed("left")) side_input = -1;
			if(input_check_pressed("right")) side_input = 1;
		}
		
		var action = false;
		if(input_check_pressed("accept")){
			action = true
			audio_play_sound(snd_ui_hover,0,0);
		}
		
		switch (selected) {
		    case MENU_SETTINGS.fullscreen:
		        if(action){
					var fullscreen = !window_get_fullscreen();
					if(fullscreen){
						stanncam_set_fullscreen();
					}
					else stanncam_set_windowed();
				}
		        break;
			case MENU_SETTINGS.music_volume:
				if(side_input != 0){
					global.music_volume += side_input;
					global.music_volume = clamp(global.music_volume,0,volume_max);
					audio_group_set_gain(audiogroup_music,global.music_volume / volume_max,0);
				}
		        break;
			case MENU_SETTINGS.sound_volume:
				if(side_input != 0){
					global.sound_volume += side_input;
					global.sound_volume = clamp(global.sound_volume,0,volume_max);
					audio_group_set_gain(audiogroup_default,global.sound_volume / volume_max,0);
				}
		        break;
			case MENU_SETTINGS.draw_shine:
		        if(action){
					global.draw_shine = !global.draw_shine
				}
		        break;
			case MENU_SETTINGS.draw_reflections:
		        if(action){
					global.draw_reflections = !global.draw_reflections
				}
		        break;
			case MENU_SETTINGS.debug_draw:
		        if(action){
					global.debug = !global.debug
					show_collisions()
				}
		        break;
		}
		
		if(input_check_pressed("cancel")){
			audio_play_sound(snd_ui_decline,0,0);
			state.change(state.get_previous_state());	
		}
	},
	draw: function(){		
		draw_set_color(black);
		draw_set_alpha(0.5);
		draw_rectangle(-10,-10,global.gui_w+10,global.gui_h+10,false);
		draw_set_color(white);
		draw_set_alpha(1);
		
		var w_ = 100;
		var h_ = MENU_SETTINGS.TOTAL * text_height;
		
		var x_ = global.game_w/2;
		var y_ = global.game_h/2 - h_/2;
		
		var setting_text =	["FULLSCREEN","MUSIC VOLUME", "SOUND VOLUME", "SHINY TILES", "SHADER FX", "DEBUG DRAWING"];
		var setting_value = [
			(window_get_fullscreen() ? "ON" : "OFF"),
			global.music_volume,
			global.sound_volume,
			(global.draw_shine ? "ON" : "OFF"),
			(global.draw_reflections ? "ON" : "OFF"),
			(global.debug ? "ON" : "OFF"),
		]
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_-text_height*1.5,"-SETTINGS-")
		
		for (var i = 0; i < MENU_SETTINGS.TOTAL; ++i) {
			if(selected != i) shader_set(sh_deselected);
		    draw_set_halign(fa_left);
			draw_set_color(yellow)
			draw_text(x_-w_,y_+text_height*i,setting_text[i]);
			
			draw_set_halign(fa_right);
			draw_set_color(white)
			
			draw_text(x_+w_,y_+text_height*i,setting_value[i]);
			shader_reset()
		}
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_set_alpha(0.5);
		draw_sprite(spr_gui_button_back,using_gamepad(),30,global.game_h-15);
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
		draw_set_alpha(1);
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
		if(!transition_in && input_check("accept")){
			transition(function(){
				state.change("demo_select");
				room_goto(rm_init);
				tallying = false;
			})
		}
	},
	draw: function(){
		state.inherit()
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-30);
	}
});


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


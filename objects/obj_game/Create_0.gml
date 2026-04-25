/// @description starts the game

//vars
saved_pengu = {
	x: -1,
	y: -1,
}
save_text = false;
taken_points = [];

transition_in = false;
transition_val = 0;
transition_t = 0;
transition_duration = 50;
transition_callback = function(){}

timer = 0;
tallying = false;

debug = noone  //for debug view

//loads settings or initializes the default ones
settings_load();

#region music
audio_group_load(audiogroup_music);
#endregion

//particles
layer_create(-100,"particles");
global.particles = part_system_create_layer("particles", true);

//sets text_
draw_set_font(global.gui_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


#region menu states

state = new SnowState("quick_start");
//state = new SnowState("demo_start");

#region Menu parent
state.add("menu_parent",{
	enter: function(){
		selected = 0;
		selected_max = 1;
		action = false;
	},
	step: function(){
		if(InputPressed(INPUT_VERB.DOWN) || InputPressed(INPUT_VERB.UP)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.DOWN)) selected++;
			else if(InputPressed(INPUT_VERB.UP)) selected--;
			if(selected < 0) selected = selected_max;
			if(selected > selected_max) selected = 0;
		}
		
		var side_input_ = 0;
		if(InputPressed(INPUT_VERB.LEFT) || InputPressed(INPUT_VERB.RIGHT)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.LEFT)) side_input_ = -1;
			if(InputPressed(INPUT_VERB.RIGHT)) side_input_ = 1;
		}
		
		if(InputPressed(INPUT_VERB.ACCEPT)){
			action = true
			audio_play_sound(snd_ui_hover,0,0);
		}
		
		if(InputPressed(INPUT_VERB.CANCEL)){
			audio_play_sound(snd_ui_decline,0,0);
			state.change(state.get_previous_state());	
		}
	},
	draw: function(){		
		draw_set_color(BLACK);
		draw_set_alpha(0.5);
		draw_rectangle(-10,-10,global.gui_w+10,global.gui_h+10,false);
		draw_set_color(WHITE);
		draw_set_alpha(1);
	}
});
#endregion

#region menu off
state.add("idle", {
	enter: function(){
		
	},
	step: function(){
		if (CAN_MOVE_NOFREEZE && InputPressed(INPUT_VERB.PAUSE)){
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
			
			//for (var i_ = 0; i_ < array_length(global.levels); ++i_) {
			    //if (room_next(room) == global.levels[i_].room_id) {
					//global.active_level = global.levels[i_]
					//break;	
				//}
			//}
			
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
		if (InputPressed(INPUT_VERB.ACCEPT)){
			state.change("main_menu");
		}
	},
	draw: function(){
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var text_ =
		@"THIS IS AN EARLY PROTOTYPE OF
		
		PENGU: LOST & WANTED
		
		EVERYTHING IS SUBJECT TO CHANGE
		i_ APPRECIATE YOUR SUPPORT!!!
		-STANN"
		
		draw_text(global.game_w/2,global.game_h/2,text_);
		
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
		if (InputPressed(INPUT_VERB.CANCEL)){
			state.change("main_menu");
		}
	},
	draw: function(){
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var text_ =
		@"GAME: STANN.CO
		LEVEL DESIGN: BOBBYBURT
		EXTRA ART & CONCEPTS: CHOCOHOLICMONKEY
		MUSIC: CONNORGRAIL"
		
		draw_text(global.game_w/2,global.game_h/2,text_);
		
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
		if(InputPressed(INPUT_VERB.DOWN) || InputPressed(INPUT_VERB.UP)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.DOWN)) selected++;
			else if(InputPressed(INPUT_VERB.UP)) selected--;
			
			var val_ = IN_BROWSER ? 3 : 4
			selected = clamp(selected,0,val_);
		}
		
		if(InputPressed(INPUT_VERB.ACCEPT)){
			audio_play_sound(snd_ui_hover,0,0);
			if(selected == 0){
				state.change("demo_select")
			} else if(selected == 1){
				state.change("settings");
			} else if(selected == 2){
				state.change("credits");
			} else if(selected == 3){
				try{
					if(IN_BROWSER){
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
		
		var h_ = 20;
		var x_ = global.game_w/2
		var y_ = (global.game_h/2) - (h_ * 3) / 2;
		
		draw_set_halign(fa_middle);
		
		var options = ["LEVEL SELECT","SETTINGS","CREDITS","WISHLIST ON STEAM"]
		
		if(!IN_BROWSER){
			array_push(options,"QUIT GAME")
		}
		
		for (var i_ = 0; i_ < array_length(options); ++i_) {
			if(selected != i_) shader_set(sh_deselected)
		    draw_text(x_,y_ + h_ * i_,options[i_]);
			
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
        global.in_control = true;
		timer = 0;
		
		state.change("idle")	
	}
});

//state.add("level_checkpoint_start",{
	//enter: function(){
		////resets to active checkpoint if there is any
		//if(global.active_level != undefined && global.active_level.checkpoint != undefined){
			//obj_pengu.x = global.active_level.checkpoint.x;
			//obj_pengu.y = global.active_level.checkpoint.y;
			//
			//global.coins = global.active_level.checkpoint_coins;
			//global.score = global.active_level.checkpoint_score;
			//global.score_mult = 0;
			//global.score_combo_t = 0;
			//
			//state.change("idle")
		//} else {
			//room_restart()
			//state.change("level_start")
		//}
	//}
//});

//checkpoint system broken rn, just restarts level
state.add("level_checkpoint_start",{
	enter: function(){
		room_restart()
		state.change("level_start")
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
			if(InputPressed(INPUT_VERB.ACCEPT)){
				transition(function(){
					state.change("level_start");
					global.active_level = global.levels[selected];
					var level = global.levels[selected];
					level.checkpoint = undefined; //reset checkpoint				
					room_goto(level.room_id);	
				})
			}
			
			if(InputPressed(INPUT_VERB.CANCEL)){
				audio_play_sound(snd_ui_decline,0,0);
				state.change("main_menu");
			}
			
			var left_right_ = InputPressed(INPUT_VERB.RIGHT) - InputPressed(INPUT_VERB.LEFT);
			if(left_right_ != 0){
				selected += left_right_
				audio_play_sound(snd_ui_hover,1,false);
			}
			
			var lvl_max = array_length(global.levels)-1
			if(selected < 0) selected = lvl_max;
			if(selected > lvl_max) selected = 0;
		}

	},
	draw: function(){		
		var levels = global.levels;
		
		var width_ = 60;
		var center_x = global.game_w/2;
		var center_y = global.game_h/2;
		var num = array_length(levels)
		
		draw_set_halign(fa_middle)
		draw_set_valign(fa_center)
		
		for (var i_ = 0; i_ < num; ++i_) {
			
			var x_ = center_x - ((num-1)*width_/2) + (i_*width_);
			var y_ = center_y;
			
			if(selected != i_) shader_set(sh_deselected)
			else {
				y_ += dsin(global.t*5*2);
				x_ += dsin(global.t*5);
			}
			
			draw_text(x_,y_,i_+1);
			draw_sprite(spr_level_frame,0,x_,y_);
			
			shader_reset()
		}
		
		draw_set_valign(fa_top)
		
		x_ = center_x;
		y_ = center_y +34;
		
		var level = global.levels[selected];
		draw_text(x_,y_,level.name_)
		
		y_+=20
		var w_ = 100;		
		var text_ = ["LEVEL SCORE","LEVEL TIME"]
		var values = [level.level_score,timer_text(level.level_time)];		
		
		for (var i_ = 0; i_ < array_length(text_); ++i_) {
		    draw_set_halign(fa_left);
			draw_set_color(YELLOW)
			draw_text(x_-w_,y_+TEXT_HEIGHT*i_,text_[i_]);
			
			draw_set_halign(fa_right);
			draw_set_color(WHITE)
			
			draw_text(x_+w_,y_+TEXT_HEIGHT*i_,values[i_]);
		}
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_sprite(spr_gui_button_back,using_gamepad(),30,global.game_h-15);
		draw_sprite(spr_gui_button_ok,using_gamepad(),global.game_w-30,global.game_h-15);
		
	}
});
#endregion

#region level select
state.add_child("menu_parent","level_select",{
	enter: function(){
		selected_max = array_length(global.levels)-1;
	},
	
	step: function(){
		state.inherit();
		if(action){
			room_goto(global.levels[selected]);
		}
	},
	draw: function(){		
		state.inherit();
		
		var h_ = selected_max * TEXT_HEIGHT;
		
		var x_ = global.game_w/2;
		var y_ = global.game_h/2 - h_/2;
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_-TEXT_HEIGHT*1.5,"-LEVELS-")
		
		for (var i_ = 0; i_ < selected_max; i_++) {
			if(selected != i_) shader_set(sh_deselected);
			
			draw_set_halign(fa_middle);
			draw_set_color(WHITE)
			draw_text(x_,y_+TEXT_HEIGHT*i_,room_get_name(global.levels[i_]));
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

#region pause menu
state.add("pause_menu",{
	enter: function(){
		selected = 0;
	},
	step: function(){
		
		if(InputPressed(INPUT_VERB.PAUSE)){ //unpause
			state.change("idle");
		}
		
		if(InputPressed(INPUT_VERB.DOWN) || InputPressed(INPUT_VERB.UP)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.DOWN)) selected++;
			else if(InputPressed(INPUT_VERB.UP)) selected--;
			selected = clamp(selected,0,3);
		}
		
		if(InputPressed(INPUT_VERB.ACCEPT)){
			audio_play_sound(snd_ui_hover,0,0);
			if(selected == 0){
				state.change("idle");
			} else if(selected == 1){
				state.change("settings");
			} else if(selected == 2 && !transition_in){ //level select
				state.change("level_select");
			} else if(selected == 3 && !transition_in){ // restart level
				transition(function(){
					room_restart();
					state.change("level_start");
				});
			}
                
            //else if(selected == 4 && !transition_in && global.active_level.checkpoint != undefined){ //restart to checkpoint
				//transition(function(){
					//state.change("level_checkpoint_start");
				//});
			//}
		}
		
		if(InputPressed(INPUT_VERB.CANCEL)){
			audio_play_sound(snd_ui_decline,0,0);
			state.change("idle");
		}
	},
	draw: function(){		
		
		var h_ = 20;
		var x_ = global.game_w/2
		var y_ = (global.game_h/2) - (h_ * 3) / 2;
		
		
		draw_set_color(BLACK);
		draw_set_alpha(0.5);
		draw_rectangle(-10,-10,global.gui_w+10,global.gui_h+10,false);
		draw_set_color(WHITE);
		draw_set_alpha(1);
		
		draw_set_halign(fa_middle);

		draw_text(x_,10,"GAME PAUSED");
		
        //var options = ["CONTINUE","SETTINGS","LEVEL SELECT","RESTART LEVEL","CHECKPOINT"]
		var options = ["CONTINUE","SETTINGS","LEVEL SELECT","RESTART LEVEL"];
		
		for (var i_ = 0; i_ < array_length(options); ++i_) {
			//if(selected == 4 && global.active_level.checkpoint == undefined) shader_set(sh_greyed);
			if(selected != i_) shader_set(sh_deselected)
            
            //level select is off until we actually have levels
            if(selected == i_ && i_ == 2) shader_set(sh_greyed);
            
		    draw_text(x_,y_ + h_ * i_,options[i_]);
			
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
		if(InputPressed(INPUT_VERB.DOWN) || InputPressed(INPUT_VERB.UP)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.DOWN)) selected++;
			else if(InputPressed(INPUT_VERB.UP)) selected--;
			if(selected < 0) selected = MENU_SETTINGS.TOTAL-1;
			if(selected = MENU_SETTINGS.TOTAL) selected = 0;
		}
		
		var side_input = 0;
		if(InputPressed(INPUT_VERB.LEFT) || InputPressed(INPUT_VERB.RIGHT)){
			audio_play_sound(snd_ui_hover,0,0);
			if(InputPressed(INPUT_VERB.LEFT)) side_input = -1;
			if(InputPressed(INPUT_VERB.RIGHT)) side_input = 1;
		}
		
		var action = false;
		if(InputPressed(INPUT_VERB.ACCEPT)){
			action = true
			audio_play_sound(snd_ui_hover,0,0);
		}
		
		switch (selected) {
		    case MENU_SETTINGS.FULLSCREEN:
		        if(action){
					var fullscreen = !window_get_fullscreen();
					if(fullscreen){
						stanncam_set_fullscreen();
					}
					else stanncam_set_windowed();
				}
		        break;
			case MENU_SETTINGS.MUSIC_VOLUME:
				if(side_input != 0){
					global.music_volume += side_input;
					global.music_volume = clamp(global.music_volume,0,VOLUME_MAX);
					audio_group_set_gain(audiogroup_music,global.music_volume / VOLUME_MAX,0);
				}
		        break;
			case MENU_SETTINGS.SOUND_VOLUME:
				if(side_input != 0){
					global.sound_volume += side_input;
					global.sound_volume = clamp(global.sound_volume,0,VOLUME_MAX);
					audio_group_set_gain(audiogroup_default,global.sound_volume / VOLUME_MAX,0);
				}
		        break;
			case MENU_SETTINGS.DRAW_SHINE:
		        if(action){
					global.draw_shine = !global.draw_shine
				}
		        break;
			case MENU_SETTINGS.DRAW_REFLECTIONS:
		        if(action){
					global.draw_reflections = !global.draw_reflections
				}
		        break;
			case MENU_SETTINGS.DEBUG_DRAW:
		        if(action){
					global.debug = !global.debug
				}
            case MENU_SETTINGS.SHOW_COLLISIONS:
		        if(action){
                    global.show_collisions = !global.show_collisions;
                    show_collisions(global.show_collisions);
				}
		        break;
		}
		
		if(InputPressed(INPUT_VERB.CANCEL)){
			audio_play_sound(snd_ui_decline,0,0);
			state.change(state.get_previous_state());	
		}
	},
	draw: function(){		
		draw_set_color(BLACK);
		draw_set_alpha(0.5);
		draw_rectangle(-10,-10,global.gui_w+10,global.gui_h+10,false);
		draw_set_color(WHITE);
		draw_set_alpha(1);
		
		var w_ = 100;
		var h_ = MENU_SETTINGS.TOTAL * TEXT_HEIGHT;
		
		var x_ = global.game_w/2;
		var y_ = global.game_h/2 - h_/2;
		
		var setting_text =	["FULLSCREEN","MUSIC VOLUME",
        "SOUND VOLUME", "SHINY TILES", "SHADER FX", "DEBUG DRAWING", "SHOW COLLISIONS"];
		var setting_value = [
			(window_get_fullscreen() ? "ON" : "OFF"),
			global.music_volume,
			global.sound_volume,
			(global.draw_shine ? "ON" : "OFF"),
			(global.draw_reflections ? "ON" : "OFF"),
			(global.debug ? "ON" : "OFF"),
            (global.show_collisions ? "ON" : "OFF"),
		]
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_-TEXT_HEIGHT*1.5,"-SETTINGS-")
		
		for (var i_ = 0; i_ < MENU_SETTINGS.TOTAL; ++i_) {
			if(selected != i_) shader_set(sh_deselected);
		    draw_set_halign(fa_left);
			draw_set_color(YELLOW)
			draw_text(x_-w_,y_+TEXT_HEIGHT*i_,setting_text[i_]);
			
			draw_set_halign(fa_right);
			draw_set_color(WHITE)
			
			draw_text(x_+w_,y_+TEXT_HEIGHT*i_,setting_value[i_]);
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

#region demo level_tally
state.add("level_tally_start", {
	enter: function(){
		tallying = true;
		tally_x = global.game_w;
		tally_duration = GAME_SPEED * 1;
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
		var val_ = animcurve_read(ac_basic,"ease",tally_t/tally_duration)
		tally_x = lerp(global.game_w,0,val_);
	},
	draw: function(){
		
		var tally_text   = ["SCORE","BONUS TIME","BONUS SNACKS","","LEVEL SCORE"];
		var tally_scores = [tally_score,tally_score_time, tally_score_snacks,"",tally_score_total];
		
		var w_ = 100;
		var h_ = array_length(tally_text)*TEXT_HEIGHT;
		
		var x_ = global.game_w/2+tally_x;
		var y_ = (global.game_h/2)-(h_/2);
		
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		draw_text(x_,y_-TEXT_HEIGHT*1.5,$"{global.active_level.name_} COMPLETE!!!")
		
		for (var i_ = 0; i_ < array_length(tally_text); ++i_) {
		    draw_set_halign(fa_left);
			draw_set_color(YELLOW)
			draw_text(x_-w_,y_+TEXT_HEIGHT*i_,tally_text[i_]);
			
			draw_set_halign(fa_right);
			draw_set_color(WHITE)
			
			draw_text(x_+w_,y_+TEXT_HEIGHT*i_,tally_scores[i_]);
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

	}
});

state.add_child("level_tally_start","level_tally_scores", {
	enter: function(){
		tallying = true;
		tally_duration = GAME_SPEED * 0.5;
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
		
		var val_ = tally_t / tally_duration;
		tally_score			= floor(lerp(tally_score_prev,0,val_))
		tally_score_time	= floor(lerp(tally_score_time_prev,0,val_))
		tally_score_snacks	= floor(lerp(tally_score_snacks_prev,0,val_))
		tally_score_total	= floor(lerp(0,tally_score_total_new,val_));
	},
});

state.add_child("level_tally_start","level_tally_anykey", {
	enter: function(){
	},
	step: function(){
		if(!transition_in && InputCheck(INPUT_VERB.ACCEPT)){
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

#endregion


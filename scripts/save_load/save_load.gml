function settings_load(){
	
	ini_open("settings");
		global.music_lvl = ini_read_real("prefs","music",1);
		global.sound_lvl = ini_read_real("prefs","sound",1);
		global.fancy_effects = ini_read_real("prefs","fancy_effects",1);
	ini_close();
	
	
}
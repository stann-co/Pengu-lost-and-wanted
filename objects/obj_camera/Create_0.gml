/// @description
//var game_res = stanncam_get_preset_resolution(STANNCAM_RES_PRESETS.PLAYSTATION_512_X_224)
stanncam_init(480,270,1920*0.8,1080*0.8);
stanncam_set_keep_aspect_ratio(false);

global.camera = new stanncam(global.game_w, global.game_h);
global.camera.room_constrain = false;
global.camera.bounds_w = 16;
global.camera.bounds_h = 4;
global.camera.spd = 1;
global.camera.spd_threshold = 1;
global.camera.smooth_draw = false;

depth = 16000;

//global.camera_3d = new stanncam_3d(global.game_w, global.game_h);

//background
global.background = function(){ //empty background function, gets replaced in each level

}

bg_layer = -1

state = new SnowState("2D");
state.add("2D", {
	step : function(){
		
	},
	draw : function(){
		global.camera.draw(0,0);
	}
});

state.add("3D", {
	step : function(){
		
	},
	draw : function(){
		global.camera_3d.draw(0,0);
	}
});
	

#region debugging
	//dbg_section("Shaders")
	//dbg_slider(ref_create(self,"blur_steps_D"),0,30);
	//dbg_slider(ref_create(self,"sigma_D"),0,1);
	//dbg_slider(ref_create(camera,"bloom_threshold"),0,1);
	//dbg_slider(ref_create(camera,"bloom_range"),0,1);
	//dbg_slider(ref_create(camera,"bloom_intensity"),0,2);
	//dbg_slider(ref_create(camera,"bloom_darken"),0,1);
	//dbg_slider(ref_create(camera,"bloom_saturation"),0,2);
	
	
	//dbg_slider(ref_create(self, "crt_scale"),0,400,"CRT scale");
	//dbg_slider(ref_create(self, "crt_radius"),0.001,4,"CRT radius");
	//dbg_slider(ref_create(self, "crt_sharpness"),0,4,"CRT sharpness");
	//dbg_slider(ref_create(self, "crt_test1"),0,4,"CRT test1");
	//dbg_slider(ref_create(self, "crt_test2"),0,2,"CRT test2");
#endregion


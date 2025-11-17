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

//layer drawing
sprite_layers = {}

//global.camera.after_move_func = function(){
    //var layers_ = layer_get_all();
    //for (var i_ = 0; i_ < array_length(layers_); i_++) {
        //var layer_ = layers_[i_];
        //var layer_name_ = layer_get_name(layer_);
        //var parralax_ = struct_get_chained(global.level_data,"layers",layer_name_,"parralax");
        //
        //if(parralax_ != undefined){
            //var elements_ = layer_get_all_elements(layer_);
            //var element_type_ = layer_get_element_type(elements_[0]);
            //if(element_type_ == layerelementtype_sprite || element_type_ == layerelementtype_tilemap){
                //
                //var offset_x_ = global.camera.get_x();
                //var offset_y_ = global.camera.get_y();
                //offset_x_ -= offset_x_ * parralax_;
                //offset_y_ -= offset_y_ * parralax_;
                //
                //if(element_type_ == layerelementtype_sprite ){
                    ////offsets sprite layers
                    //for (var s_ = 0; s_ < array_length(elements_); s_++) {
                    	//var sprite_ = elements_[s_];
                        //
                        ////gets default xy position or saves it to a struct for later
                        //var x_ = struct_get_chained(sprite_layers,sprite_,"x");
                        //if(!x_) {
                            //x_ = layer_sprite_get_x(sprite_);
                            //struct_set_chained(sprite_layers,x_,sprite_,"x"); 
                        //}
                        //var y_ = struct_get_chained(sprite_layers,sprite_,"y");
                        //if(!y_){
                            //y_ = layer_sprite_get_y(sprite_);
                            //struct_set_chained(sprite_layers,y_,sprite_,"y");
                        //} 
                        //
                        //layer_sprite_x(sprite_,x_+offset_x_);
                        //layer_sprite_y(sprite_,y_+offset_y_);
                    //}
                    //
                //} else if (element_type_ == layerelementtype_tilemap){
                    ////ofsets tilemap layer
                    //var tilemap_ = layer_tilemap_get_id(layer_);
                    //tilemap_x(tilemap_,offset_x_);
                    //tilemap_y(tilemap_,offset_y_);
                //}
            //}
        //}
    //}
//}

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


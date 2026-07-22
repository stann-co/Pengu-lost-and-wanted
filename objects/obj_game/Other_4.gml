/// @description
global.t = 0;

//TODO i will overhaul level loading completely, and so this will all maybe be removed

//if(global.sidescroller){
    ////global.collision_layers[? COLLISION_LAYERS.A] = layer_tilemap_get_id("collision_A");
    ////global.collision_layers[? COLLISION_LAYERS.B] = layer_tilemap_get_id("collision_B");
    ////global.collision_layers[? COLLISION_LAYERS.C] = layer_tilemap_get_id("collision_C");
	//
	//global.collision_layers[? COLLISION_LAYERS.A] = layer_get_id("collision_A");
	//global.collision_layers[? COLLISION_LAYERS.B] = layer_get_id("collision_B");
	//global.collision_layers[? COLLISION_LAYERS.C] = layer_get_id("collision_C");
	//
    //set_active_collisions(COLLISION_LAYERS.A);
    //
	////error reminders
	//if(room != rm_game && room != rm_intro && (global.collision_layers[? COLLISION_LAYERS.A] == -1)){
		//show_error($"Missing collision layers_ in {room}",true);
	//}
    //
    //#region external layers
    ////additional layers, instances, assets, and tiles are saved externally as json for each level
    ////for layers with parralax
    //global.room_data = {
        //layers : {}
    //};
    //var room_data_ = json_load("room_data/"+room_get_name(room)+".json");
    //if(!is_undefined(room_data_)){
        //global.room_data = room_data_;
        //
        ////adds the extra layers, and all their assets/instances/tilemaps
        ////TODO:
        //var layers_ = struct_get_names(global.room_data.layers);
        //for (var i_ = 0; i_ < array_length(layers_); i_++) {
            //var name_ = layers_[i_];
            //var depth_ = struct_get_chained(global.room_data.layers,name_,"depth");
        	//layer_create(depth_,name_);
            //
            //if(string_starts_with(name_,"asset")){
                //var elements_ = struct_get_chained(global.room_data.layers,name_,"elements");
                //for (var e_ = 0; e_ < array_length(elements_); e_++) {
                    //var element_ = elements_[e_];
                    //
                    //var element_id_ = layer_sprite_create(name_,element_.x,element_.y,element_.sprite_index)
                    //layer_sprite_xscale(element_id_,element_.image_xscale);
                    //layer_sprite_yscale(element_id_,element_.image_yscale);
                    //layer_sprite_angle(element_id_,element_.image_angle);
                    //layer_sprite_alpha(element_id_,element_.image_alpha);
                    //layer_sprite_blend(element_id_,element_.image_blend);
                    //layer_sprite_speed(element_id_,element_.image_speed);
                    //layer_sprite_index(element_id_,element_.image_index);
                //}
            //}
        //}
    //}
    //#endregion
	//
	//// turns off automatic drawing for visual layers, and draws them manually with parralax and shaders
	//var layers_ =  layer_get_all();
	//for (var i_ = 0; i_ < array_length(layers_); ++i_) {
		//var lay_id_ = layers_[i_];
		//var name_ = layer_get_name(lay_id_);
		//
		//if(string_starts_with(name_,"decor")){
			//instance_create_depth(0,0,layer_get_depth(lay_id_),obj_layer_draw,{
				//layer_id : lay_id_,
	        	//type : LAYER_TYPE.TILEMAP,
				//name : name_
			//})
			//layer_set_visible(lay_id_,false);
	    //} else
	    //
	    //if(string_starts_with(name_,"asset")){
			//instance_create_depth(0,0,layer_get_depth(lay_id_),obj_layer_draw,{
				//layer_id : lay_id_,
	        	//type : LAYER_TYPE.ASSET,
				//name : name_
			//})
			//layer_set_visible(lay_id_,false);
	    //}
	//}
//}
//
//#region checkpoint load
//if(global.checkpoint != -1){
	//obj_pengu.x = global.checkpoint.x;	
	//obj_pengu.y = global.checkpoint.y;
	//global.t = global.checkpoint.time;
		//
	//for (var i_ = 0; i_ < array_length(global.checkpoint.taken_points); ++i_) {
		//instance_destroy(global.checkpoint.taken_points[i_]);
	//}
//}
//#endregion
//
//show_collisions(global.show_collisions);
/// @description

//if(layer_exists("background_sprites_1")){
//	layer_set_visible("background_sprites_1",false);
//}

//if(layer_exists("background_sprites_2")){
//	layer_set_visible("background_sprites_2",false);
//}


//if(layer_exists("foreground_sprites_1")){
//	layer_set_visible("foreground_sprites_1",false);
//}

//if(layer_exists("foreground_sprites_2")){
//	layer_set_visible("foreground_sprites_2",false);
//}


#region tiles

//makes special drawing objects for tile layers
var layers =  layer_get_all();
for (var i = 0; i < array_length(layers); ++i) {
    var lay = layers[i];
	var name = layer_get_name(lay);
	if(string_starts_with(name,"decor_")){
		instance_create_depth(0,0,layer_get_depth(lay),obj_layer_draw,{
			lay: lay
		});
	}
}

#endregion
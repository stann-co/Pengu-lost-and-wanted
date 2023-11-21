/// @description

global.camera.move(obj_pengu.x,obj_pengu.y,0);

if(layer_exists("background_sprites_1")){
	layer_set_visible("background_sprites_1",false);
}

if(layer_exists("background_sprites_2")){
	layer_set_visible("background_sprites_2",false);
}


if(layer_exists("foreground_sprites_1")){
	layer_set_visible("foreground_sprites_1",false);
}

if(layer_exists("foreground_sprites_2")){
	layer_set_visible("foreground_sprites_2",false);
}
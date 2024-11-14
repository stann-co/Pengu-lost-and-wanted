/// @description
layer_set_visible(lay,false);

//roughness_strength = 0.75;
//normal_strength = 0.5;
//scale = 1;
//offset_scale = -0.1;
opacity = 1.0

tilemap = layer_tilemap_get_id(lay);
if(tilemap == -1) instance_destroy();

//Inspectron()
//	.Slider("roughness_strength",0,1)
//	.Slider("normal_strength",0,1)
//	.Slider("scale",0,1)
//	.Slider("offset_scale",-1,1)
//	.Slider("opacity",0,1)
//	.render()
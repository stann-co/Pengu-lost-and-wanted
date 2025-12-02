/// @description

if(type == LAYER_TYPE.TILEMAP){
	tilemap = layer_tilemap_get_id(layer_id);
	if(tilemap == -1) instance_destroy();
}
else if(type == LAYER_TYPE.ASSET){
	
}

//layer_set_visible(lay,false);

//roughness_strength = 0.75;
//normal_strength = 0.5;
//scale = 1;
//offset_scale = -0.1;
//opacity = 1.0
//depth_ = 0.05
//texture_offset_scale = -0.5;
//offset2_ = 1;
//
//roughness = 0.6;
//normal = 1.0;
//
//texture_scale = 2;
//texture_offset_x = 0;
//texture_offset_y = 0;

//srf_diffuse = -1;
//srf_maps = -1; //normal x y, roughness, depth
//
//u_texcoord_uv = shader_get_uniform(sh_uv_offset,"u_texcoord_uv");
//
//u_cam_offset = shader_get_uniform(sh_tilemap_fx,"u_cam_offset");
//
//s_tilemap_fx = shader_get_sampler_index(sh_tilemap_fx,"s_tilemap_fx");
//s_texture = shader_get_sampler_index(sh_tilemap_fx,"s_texture");
//
//
//u_depth      = shader_get_uniform(sh_tilemap_fx,"u_depth");
//u_roughness      = shader_get_uniform(sh_tilemap_fx,"u_roughness");
//u_normal      = shader_get_uniform(sh_tilemap_fx,"u_normal");
//
//u_texture_scale   = shader_get_uniform(sh_tilemap_fx,"u_texture_scale");
//u_texture_offset_scale  = shader_get_uniform(sh_tilemap_fx,"u_texture_offset_scale");

//
//Inspectron()
	//.Slider("depth_",0,0.1)
    //.Slider("roughness",0,1)
    //.Slider("normal",0,1)
    //.Slider("texture_offset_scale",-0.5,0)
    //.Slider("texture_scale",0,2)
	//.render()
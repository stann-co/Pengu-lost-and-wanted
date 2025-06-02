/// @description
layer_set_visible(lay,false);

//roughness_strength = 0.75;
//normal_strength = 0.5;
scale = 1;
//offset_scale = -0.1;
opacity = 1.0
depth_ = 0.05
offset_ = 1;
offset2_ = 1;

tilemap = layer_tilemap_get_id(lay);
if(tilemap == -1) instance_destroy();

srf_rgba = -1;
srf_xyrd = -1; //normal x y, roughness, depth

u_texcoord_n = shader_get_uniform(sh_tilemap_channels,"u_texcoord_n");
u_texcoord_r = shader_get_uniform(sh_tilemap_channels,"u_texcoord_r");
u_texcoord_d = shader_get_uniform(sh_tilemap_channels,"u_texcoord_d");

u_cam_offset = shader_get_uniform(sh_tilemap_fx,"u_cam_offset");

s_tilemap_fx = shader_get_sampler_index(sh_tilemap_fx,"s_tilemap_fx");
u_depth      = shader_get_uniform(sh_tilemap_fx,"u_depth");
u_offset      = shader_get_uniform(sh_tilemap_fx,"u_offset");
u_offset2      = shader_get_uniform(sh_tilemap_fx,"u_offset2");

//Inspectron()
//	.Slider("roughness_strength",0,1)
//	.Slider("normal_strength",0,1)
//	.Slider("scale",0,10)
//	.Slider("offset_scale",-1,1)
//	.Slider("opacity",0,1)
//	.render()

Inspectron()
	.Slider("depth_",0,0.1)
    .Slider("offset_",-1,1)
    .Slider("offset2_",-1,1)
	.render()
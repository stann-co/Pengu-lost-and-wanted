/// @description
layer_set_visible(lay,false);

srf_tile = -1;
srf_normal = -1;
//tex_surf = -1;
srf_roughness = -1;

tex_sampler = shader_get_sampler_index(sh_shine,"s_Texture");
normal_sampler = shader_get_sampler_index(sh_shine,"s_Normal");
roughness_sampler = shader_get_sampler_index(sh_shine,"s_Roughness");

u_normal_strength = shader_get_uniform(sh_shine,"u_normal_strength");
u_roughness_strength = shader_get_uniform(sh_shine,"u_roughness_strength");

roughness_strength = 0.75;
normal_strength = 0.15;
scale = 1;
offset_scale = -0.25;

tilemap = layer_tilemap_get_id(lay);
if(tilemap == -1) instance_destroy();

tileset = tilemap_get_tileset(tilemap);

var tileset_name = tileset_get_name(tileset);
tileset_n = asset_get_index(tileset_name+"_n");
tileset_r = asset_get_index(tileset_name+"_r");

//Inspectron()
//	.Slider("roughness_strength",0,1)
//	.Slider("normal_strength",0,1)
//	.Slider("scale",0,4)
//	.Slider("offset_scale",-1,1)
//	.render()
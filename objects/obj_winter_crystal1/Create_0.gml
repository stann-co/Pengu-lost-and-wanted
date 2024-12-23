/// @description
refract_surf = -1;

s_texture = shader_get_sampler_index(sh_refraction,"s_texture");
u_uvs = shader_get_uniform(sh_refraction,"u_uvs");
u_refract = shader_get_uniform(sh_refraction,"u_refract");
u_amount = shader_get_uniform(sh_refraction,"u_amount");

refract = 1.851;
amount = 0.75;

//Inspectron()
//	.Section("crystal")
//	.Slider("refract",-5,5)
//	.Slider("amount",0,1)
//	.render()
/// @description loads 3d cube

gachapon_top = new gltf("gachapon_top.gltf");
gachapon_bottom = new gltf("gachapon_bottom.gltf");

kat_smart = new gltf("kat_smart.gltf");

u_transform = shader_get_uniform(sh_3d_deprecated,"u_Transform");
u_light_pos = shader_get_uniform(sh_3d_deprecated,"light_position");
u_camera_pos = shader_get_uniform(sh_3d_deprecated,"camera_position");
u_refraction = shader_get_uniform(sh_3d_deprecated,"refractive_index");
u_matcapblend = shader_get_uniform(sh_3d_deprecated,"matcap_blend");
s_matcap = shader_get_sampler_index(sh_3d_deprecated,"matcap");



rot = 1;

t = 0;
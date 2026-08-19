/// @description
srf = -1;
srf_normal = -1;
srf_distortion = -1;

s_distortion = shader_get_sampler_index(sh_distortion,"s_Mask");
u_delta = shader_get_uniform(sh_distortion,"u_Delta");
u_distortion = shader_get_uniform(sh_distortion,"u_Distortion");

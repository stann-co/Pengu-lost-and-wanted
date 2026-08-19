global.camera.move(x,y,0);

s_normal = shader_get_sampler_index(sh_cubemap,"s_normal")
u_strength = shader_get_uniform(sh_cubemap,"u_normal_strength");

srf_normal = -1;
srf_tex = -1;

size = 64;
scale = 4;

strength = 1;

Inspectron()
  .Section("chrome ball")
  .SliderInt("size",16,64)
  .Slider("strength",-2,2)
  .render();
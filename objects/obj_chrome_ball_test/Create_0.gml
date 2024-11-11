global.camera.move(x,y,0);

//srf_ball = -1;
//
//radius = 64;
//
//u_zoom1 = shader_get_uniform(sh_chrome_ball,"zoom1");
//u_zoom2 = shader_get_uniform(sh_chrome_ball,"zoom2");
//u_zoom3 = shader_get_uniform(sh_chrome_ball,"zoom3");
//
//
//zoom1 = -0.75;
//zoom2 = 1.5;
//zoom3 = 0.5;

marblesize = 16;

Inspectron()
  .Section("chrome ball")
  .SliderInt("marblesize",8,64)
  //.Slider("zoom1",-2,2)
  //.Slider("zoom2",-2,2)
  //.Slider("zoom3",0,1)
  .render();
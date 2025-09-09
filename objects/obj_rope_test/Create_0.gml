/// @description

//consts
x = 0;
y = -50;

substeps = 1;
segments = 16;
drag = 0.001

rope = verlet_rope(x,y,90,0,segments,substeps);

rope.get_first_point().fixed = true;
rope.get_last_point().mass = 10;

global.camera.move(0,0,0);
global.camera.room_constrain = false;

relative = 1;

 Inspectron()
  .Slider("relative",0,1)
  .render()
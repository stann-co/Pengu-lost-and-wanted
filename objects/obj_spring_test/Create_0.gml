/// @description


x = 0;
y = 0;

body = new verlet(x,y);

body.force(1,0);

global.camera.move(0,0,0);
global.camera.room_constrain = false;

stiffness = 1;
drag = 0;
mass = 1;
dbg_slider(ref_create(self, "stiffness"), 0, 1);
dbg_slider(ref_create(self, "drag"), 0, 1);
dbg_slider(ref_create(self, "mass"), 1, 10);
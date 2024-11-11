/// @description

//consts
x = 0;
y = 100;

substeps = 1;
segments = 16;
drag = 0.0
stiffness = 0.9;
mass = 1;

rod = new verlet_rod(x,y,0,0,segments,substeps);

rod.get_first_point().fixed = true;


var start = rod.get_last_point();
cable = new verlet_rope(start.x,start.y,start.x+20,start.y,6,6);
cable.attach_start(start);

global.camera.move(0,0,0);
global.camera.room_constrain = false;

Inspectron()
	.Slider("drag",0,1)
	.Slider("stiffness",0,1)
	.Slider("mass",0,10)
	.SliderInt("substeps",0,16)
	.render()
/// @description

//consts
x = 0;
y = 100;

substeps = 1;
segments = 16;
drag = 0.0
stiffness = 0.9;
mass = 1;

rod = new VerletRod(x,y,0,0,segments,substeps);

rod.get_first_point().fixed = true;


var start_ = rod.get_last_point();
cable = verlet_rope(start_.x,start_.y,start_.x+20,start_.y,6,6);
cable.attach_start(start_);

target_x = 0;
target_y = 0;

global.camera.move(0,0,0);
global.camera.room_constrain = false;

Inspectron()
	.Slider("drag",0,1)
	.Slider("stiffness",0,1)
	.Slider("mass",0,10)
	.SliderInt("substeps",0,16)
	.render()
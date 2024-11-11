/// @description
global.camera.move(0,0,0);
global.camera.room_constrain = false;

x = 0;
y = 0;

n_strength = 0;
r_strength = 1;
scale = 1;

Inspectron()
	.Slider("n_strength",0,1)
	.Slider("r_strength",0,10)
	.Slider("scale",0,5)
	.render()

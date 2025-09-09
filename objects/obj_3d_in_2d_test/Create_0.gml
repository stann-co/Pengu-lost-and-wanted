/// @description

test = new BBMOD_Model("3D/rig_test.bbmod").freeze();
anim = new BBMOD_Animation("3D/rig_test_move.bbanim");

//Feather ignore once GM2017
test.Materials[@ 0] = new material_animated();

animplayer = new BBMOD_AnimationPlayer(test);
animplayer.change(anim, true);

rot_x = 0;
rot_y = 0;

mx = 0;
my = 0;

depth = global.depth_a;
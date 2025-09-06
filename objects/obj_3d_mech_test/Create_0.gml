/// @description

//3D
ball = new BBMOD_Model("3D/policemech.bbmod").freeze();
ball.Materials[@ 0] = new material(sprite_get_texture(spr_3d_policemech,0))
ball.Materials[@ 1] = new material_policesiren()

rotx = -18;
roty = 0;
rotz = 36;
scale = 32;

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-36,36)
    .SliderInt("roty",-36,36)
    .SliderInt("rotz",-36,36)
    .SliderInt("scale",0,100)
.render()
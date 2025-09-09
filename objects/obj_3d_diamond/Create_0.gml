/// @description

//3D
ball = new BBMOD_Model("3D/3d_pixelart_diamond.bbmod").freeze();
///Feather ignore once GM2017
ball.Materials[@ 0] = new material(sprite_get_texture(spr_3d_pixelart_diamond,0))

rotx = 0;
roty = 0;
rotz = 0;

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-36,36)
    .SliderInt("roty",-36,36)
    .SliderInt("rotz",-36,36)
.render()
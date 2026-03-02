/// @description

//3D
var loaded_ = gltfLoad("3D/3d_diamond.gltf")
mesh = loaded_.meshes[0];
size = meshSize(mesh);
scale = 64 / (max(size.x, size.y));

rotx = 0;
roty = 0;
rotz = 0;

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-36,36)
    .SliderInt("roty",-36,36)
    .SliderInt("rotz",-36,36)
.render()
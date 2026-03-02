/// @description

//3D
var loaded_ = gltfLoad("3D/rig_test.gltf")
//mesh = loaded_.meshes[0];
//skinnedmesh = loaded_.skinnedmesh[0]

skin = new skinnedMesh("armature");
skin.setAnimation("move2");
skin.animate(0)

size = skin.getSize();
scale = 128 / (max(size.x, size.y));

t = 0;
t_max = skin.getAnimationLength();

rotx = 0;
roty = 0;
rotz = 0;

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-90,90)
    .SliderInt("roty",-90,90)
    .SliderInt("rotz",-90,90)
.render()
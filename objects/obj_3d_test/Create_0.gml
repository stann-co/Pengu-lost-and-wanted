/// @description loads 3d cube

// Bad things happen if you turn off the depth buffer in 3D
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);


gachapon_top = new gltf("gachapon_top.gltf");
gachapon_bottom = new gltf("gachapon_bottom.gltf");
u_transform = shader_get_uniform(sh_3d,"u_Transform");

rot = 1;

t = 0;
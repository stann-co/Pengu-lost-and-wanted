/// @description
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

var world_ = gltfMatrixBuild(x,y,0,0,roty,0,SCALE_3D,SCALE_3D,SCALE_3D);
gltfDrawTransformedMat(world_,function(){
	skinned_mesh.draw(sh_3d_skinned_mesh_matcap);
});

var bone_  = skinned_mesh.getBoneModelTransformMatrix("DEF-chest");
bone_ = gltfTranslate(bone_,0,24,6,SCALE_3D);
bone_  = matrix_multiply(bone_,world_);

var x_ = gltfRoomX(bone_);
var y_ = gltfRoomY(bone_);
gpu_set_depth( gltfRoomZ(bone_) -18);

draw_sprite(spr_pengu_sitting,0,x_,y_);

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);

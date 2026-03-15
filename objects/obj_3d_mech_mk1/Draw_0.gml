/// @description
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

gltfDrawTransformed3D(x, y, 0, rotx,roty,rotz, SCALE_3D, function() {
	skinned_mesh.draw(sh_3d_skinned_mesh_matcap)
});
var world_ = matrix_build(x,y,0,rotx,roty+180,rotz+180,SCALE_3D,SCALE_3D,SCALE_3D);
var bone_ = skinned_mesh.getBoneModelTransformMatrix( skinned_mesh.getBoneIndex("DEF-chest") );

var mult_ = matrix_multiply(bone_,world_);

var x_ = mult_[12];
var y_ = mult_[13];
gpu_set_depth(mult_[14]-18);

draw_sprite(spr_pengu_sitting,0,x_,y_-24);

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);




//if(debug_draw){
//	set_draw(RED);
//	draw_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,true);
//	reset_draw();
//}


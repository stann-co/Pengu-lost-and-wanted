/// @description
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

gltfDrawTransformed3D(x, y, 0, rotx,roty,rotz, scale, function() {
	rig.draw(sh_3d_skinned_mesh_matcap)
});

//TODO somehow draw pengu sprite in cockpit

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);

if(debug_draw){
	set_draw(RED);
	draw_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,true);
	reset_draw();
}


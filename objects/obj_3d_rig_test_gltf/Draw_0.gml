/// @description
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    
    drawTransformed3D(x, y, 0, rotx,roty,rotz, scale, function() {
    	skin.draw(sh_3d_skinned_mesh_matcap)
	});

    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
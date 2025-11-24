/// @description
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    
    var scale_ = 100;
    
    new BBMOD_Matrix()
    	.scale_(scale_,scale_,scale_)
        .RotateX(rotx*5)
        .RotateY(roty*5)
        .RotateZ(rotz*5)
    	.Translate(x, y, depth)
    	.ApplyWorld();
    ball.submit();
    new BBMOD_Matrix().ApplyWorld();
    
    shader_reset();
    
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
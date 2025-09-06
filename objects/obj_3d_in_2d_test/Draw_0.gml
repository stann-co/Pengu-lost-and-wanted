/// @description
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

new BBMOD_Matrix()
    .RotateY(180)
    .RotateX(-90)
	.Scale(10, 10, 10)
	.Translate(x, y, depth)
    
	.ApplyWorld();
animplayer.submit();
new BBMOD_Matrix().ApplyWorld();

shader_reset();

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
draw_text(x,y,depth);

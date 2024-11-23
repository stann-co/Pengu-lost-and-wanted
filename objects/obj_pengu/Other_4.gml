/// @description sets depth, and checkpoint pos
depth = global.depth_a;

//resets to active checkpoint if there is any
if(global.level_var.checkpoint != noone){
	x = global.level_var.checkpoint.x;
	y = global.level_var.checkpoint.y;
}

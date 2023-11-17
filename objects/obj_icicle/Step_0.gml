/// @description 

state.step();

//if origin and the icicle iteself is out of view it resets
var y_offset = y - ystart;
if (bounds_out_of_view() && bounds_out_of_view(,,bbox_top-y_offset,bbox_bottom-y_offset)){
	state.change("idle");
}








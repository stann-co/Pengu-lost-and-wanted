/// @desc Function draws self with low opacity if not active
/// @param {bool} _active lower opacity if not active
function debug_draw_self(_active){	
	if(_active){
		draw_self();
		
	} else {
		image_alpha = 0.2;
		draw_self();	
		image_alpha = 1;
	}
}
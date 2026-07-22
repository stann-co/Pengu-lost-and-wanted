//Set specific level step code
function level_snow_train(){
	global.level_step = function(){
		
		var height_ = 4;
		var period_ = 4*SECOND;
		var y_ = animcurve_read(ac_snow_train_shake,0,global.t/period_ mod 1);
		global.camera.offset(0,y_*height_,0);
		
	}
}
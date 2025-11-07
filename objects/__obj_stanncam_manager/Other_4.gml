view_enabled = true;
var _len = array_length(global.stanncams);
for (var i = 0; i < _len; ++i){
<<<<<<< Updated upstream
	if(global.stanncams[i] == -1) continue;
	global.stanncams[i].__check_viewports();
=======
    var _cam = global.stanncams[i];
	if(_cam == -1) continue;
	_cam.__check_viewports();
>>>>>>> Stashed changes
}
__stanncam_update_resolution();

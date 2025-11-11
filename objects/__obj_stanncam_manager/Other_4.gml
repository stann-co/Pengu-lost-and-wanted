view_enabled = true;
var _len = array_length(global.stanncams);
for (var i = 0; i < _len; ++i){
    var _cam = global.stanncams[i];
	if(_cam == -1) continue;
	_cam.__check_viewports();
}
__stanncam_update_resolution();

///@function score_increase(_score,_combo_time)
function score_increase(_score,_combo_time = 0){
	with(obj_game){
		global.score_combo_t = max(_combo_time,global.score_combo_t);
		
		if(_combo_time > 0) global.score_mult ++;
		
		global.score += _score * global.score_mult;
	}
}
///@function score_increase(_score,_multiply)
function score_increase(_score,_combo){
	with(obj_game){
		score_combo_t = score_combo_t_max;
		score_combo += _combo;
		global.score += _score;
	}
}
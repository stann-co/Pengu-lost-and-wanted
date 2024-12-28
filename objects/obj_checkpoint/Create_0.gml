/// @description
triggered = false;
trigger = function(){
	if(!triggered){
		image_index = 1;
		global.active_level.checkpoint = self;
		global.active_level.checkpoint_score = global.score;
		global.active_level.checkpoint_coins = global.coins;
		global.active_level.checkpoint_timer = obj_game.timer;
	}
}
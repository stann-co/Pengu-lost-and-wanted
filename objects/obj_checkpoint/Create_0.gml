event_inherited();

/// @description
triggered = false;
trigger = function(){
	if(!triggered){
		image_index = 1;
		global.level.checkpoint = self;
		global.level.checkpoint_score = global.score;
		global.level.checkpoint_coins = global.coins;
		global.level.checkpoint_timer = obj_game.timer;
	}
}
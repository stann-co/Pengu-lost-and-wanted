/// @description Enemy wave manager
waves = [] //array of portions

//Example 
//waves = [
//	[ //First wave
//		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
//		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
//		1, //1 second delay
//		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
//		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
//	], [//second wave
//		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
//		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
//		2, //2 second delay
//		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
//		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
//	],
//]

//runs when all waves are completed, override with what happens
trigger =  function(){
	
}

t = 0;
index = 0; //enemywave index
wave = 0; //current wave
enemies = [];
wave_pause = 2; //wait between waves in seconds
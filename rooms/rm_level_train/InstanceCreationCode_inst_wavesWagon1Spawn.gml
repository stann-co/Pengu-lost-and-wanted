var left_side_ = inst_wavesWagon1Left;
var right_side_ = inst_wavesWagon1Right;
waves = [
	[
		2,
		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
		function(){
			show_debug_message("after wave!!!");
			inst_wavesWagon1DoorLeft.open_for_time(1.5);
			inst_wavesWagon1DoorRight.open_for_time(1.5);
		}
	], [
		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
		function(){
			inst_wavesWagon1DoorLeft.open_for_time(1.5);
			inst_wavesWagon1DoorRight.open_for_time(1.5);
		}
	],
]

trigger = function(){
	//set collision layer
	collision_layer_switch(obj_pengu,COLLISION_LAYERS.A);	
	
	inst_wavesWagonCameraZone.active = false;
	
	inst_wavesWagon1DoorLeft.active  = true;
	inst_wavesWagon1DoorRight.active = true;
}
var left_side_ = inst_466C7643;
var right_side_ = inst_9EFD95;

waves = [
	[
		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
	], [
		new EnemyWaveSpawn(obj_combattest,left_side_.x,left_side_.y,left_side_.x+128,left_side_.y),
		new EnemyWaveSpawn(obj_combattest,right_side_.x,right_side_.y,right_side_.x-128,right_side_.y),
	],
]

trigger = function(){
	//set collision layer
	collision_layer_switch(obj_pengu,COLLISION_LAYERS.A);	
	
	//deactivate camera zones
	inst_415012DF.active = false;
	inst_E190D31.active = false;
    
    //deactivates collision switch
    inst_306FA046.active = false;
}
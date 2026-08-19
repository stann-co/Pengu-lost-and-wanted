trigger = function(){
	collision_layer_switch(global.controlled,COLLISION_LAYERS.B);
	inst_wavesWagon1Spawn.active = true;
	inst_wavesWagonCameraZone.active = true;
	
	inst_wavesWagon1DoorLeft.active = false;
	inst_wavesWagon1DoorRight.active = false;
	instance_destroy();
}

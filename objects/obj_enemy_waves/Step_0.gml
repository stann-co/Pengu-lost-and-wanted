/// @description
if(active){
	
	//function between waves
	var wave_ = waves[wave];
	if (is_callable(wave_)){
		method_call(wave_)
		wave++;
	}
	
	while (index < array_length(wave_)) {
		var item_ = wave_[index];
		
		if(is_real(item_)){ //index is a delay timer
			if(t < item_*SECOND){
				t++;
				break;
			} else { //delay timer done
				t = 0;
				index++;
			}
		}
		
		//function between items
		else if (is_callable(item_)){
			method_call(item_)
			index++;
			break;
		}
			
		else { //index is EnemyWaveSpawn struct
			var enemy_ = item_.spawn();
			array_push(enemies,enemy_);
			index++;
		}
	}
	
	//wave has fully spawned
	if (index >= array_length(wave_)){
		
		var enemies_left_ = array_length(enemies);
		for (var i_ = 0; i_ < enemies_left_; i_++) {
			//TODO instead of checking if gone, maybe should check if they're marked as defeated, in case they still animate after
			if (!instance_exists(enemies[i_])){
				array_delete(enemies,i_,1);
				break;
			}
		}
		
		if(array_length(enemies) == 0){
			if(t < wave_pause*SECOND) t++;
			else {
				t = 0;
				index = 0;
				enemies = [];
				wave++;
				
				//all waves cleared!
				if(wave >= array_length(waves)){
					trigger();
					instance_destroy();
				}
			}
		}
	}
}
/// @description enemy collision

//you hurt the enemy

if(!other.hurting){	
	//landing on the enemy
	if(airborne && y < other.y && y_speed > 0){	
		invulnerable++
		global.camera.shake_screen(4,game_speed*0.5);
		state.change("enemy_jump");
		double_jump_count = 0;
		dash_air_count = 0;
		other.hurt();
		
	//dashing through the enemy
	} else if(super_speed){	
		global.camera.shake_screen(4,game_speed*0.5);
		other.hurt();
		freeze_frame();
	//the enemy hurts you
	} else if(invulnerable == 0){
		global.camera.shake_screen(4,game_speed*0.5);
		hurt(sign(x-other.x));
	}
}















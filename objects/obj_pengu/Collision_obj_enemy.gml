/// @description enemy collision

//you hurt the enemy

if(!other.hurting){
	global.camera.shake_screen(4,game_speed*0.5);
	
	//landing on the enemy
	if(airborne && y < other.y && y_speed > 0){		
		state.change("enemy_jump");
		other.hurt();
		
	//dashing through the enemy
	} else if(super_speed){	
		other.hurt();
	//the enemy hurts you
	} else {
		state.change("hurt");	
	}
}















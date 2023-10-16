/// @description enemy collision

//you hurt the enemy

//landing on the enemy
if(airborne && y_speed > 0){
	state.change("enemy_jump");
	
	other.hurt();
} else {
	
//the enemy hurts you
	
	
	state.change("hurt");
	
}





















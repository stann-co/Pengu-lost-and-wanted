function set_ground_spd_from_air_spd(){
	if(ground_angle <= 23 || ground_angle >= 339){ //landing on mostly flat surface
		ground_spd = x_speed;
	} else if(ground_angle <= 45 || ground_angle >= 316){ //landing on mostly sloped surface
		if( abs(x_speed) >= abs(y_speed) ){ //moving mostly left/right
			ground_spd = x_speed;	
		} else {
			ground_spd = y_speed * -sign(dsin(ground_angle)) * 0.5;
		}				
	} else { //landing on mostly steep surface
		if( abs(x_speed) >= abs(y_speed) ){ //moving mostly left/right
			ground_spd = x_speed;	
		} else {
			ground_spd = y_speed * -sign(dsin(ground_angle));
		}				
	}
}
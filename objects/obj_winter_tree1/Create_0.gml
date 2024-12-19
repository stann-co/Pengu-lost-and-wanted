/// @description
ps = part_system_create();

colliding = false;


squish_dur = game_speed*0.8;
squish_t = squish_dur;

trigger = function(){
	if(!colliding){
		colliding = true;
		squish_t = 0;
	}
}
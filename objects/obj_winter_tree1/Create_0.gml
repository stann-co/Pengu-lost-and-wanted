/// @description
event_inherited();

ps = part_system_create();

colliding = false;


squish_dur = GAME_SPEED*0.8;
squish_t = squish_dur;

trigger = function(){
	if(!colliding){
		colliding = true;
		squish_t = 0;
	}
}
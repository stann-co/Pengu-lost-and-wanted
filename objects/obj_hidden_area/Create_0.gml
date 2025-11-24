reveal = false;
duration = GAME_SPEED * 0.5;
t = 0;

trigger = function(){
	reveal = true;	
}

if(layer_name == "") show_error("No layer name!",true)
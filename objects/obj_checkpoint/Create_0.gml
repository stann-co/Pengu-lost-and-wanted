/// @description
triggered = false;
trigger = function(){
	if(!triggered){
		image_index = 1;
		global.level_var.checkpoint = self;	
	}
}
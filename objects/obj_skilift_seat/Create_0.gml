/// @description Insert description here
// You can write your code in this editor
t = 0;
moving = false;
seated = false;
trigger = function(){
	if(!moving){
		moving = true;
		seated = true;
		obj_pengu.state.change("skilift");
		obj_pengu.mirror = image_xscale;
		
	}
}









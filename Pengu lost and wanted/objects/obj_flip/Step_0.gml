/// @description ensures the trigger gets reset when no longer colliding with pengu
if(triggered && !place_meeting(x,y,obj_pengu)){
	triggered = false;
}

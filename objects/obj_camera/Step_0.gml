/// @description 

with(obj_pengu){
	var spd = airborne ? point_distance(0,0,x_speed,y_speed) : abs(ground_spd);	
	
	spd = clamp(spd,6,20);
	var zoom_level = map_value(spd,6,20,1,1.4);
	
	other.zoom_level = lerp(other.zoom_level,zoom_level,0.01);
	
	global.camera.zoom(other.zoom_level);
	
}










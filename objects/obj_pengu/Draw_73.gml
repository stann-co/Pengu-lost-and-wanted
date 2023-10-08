/// @description

if(debug){
	//draws vector lines
	
	#region side
	//left
	if(ground_spd < 0){
		draw_set_color(cyan);
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90, sensor_length_push());
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90,-sensor_length_push());
		
		draw_set_color(white);
		draw_circle(x+vec_l.x,y+vec_l.y,1,0);
	}
	
	
	//right
	if(ground_spd > 0){
		draw_set_color(orange);
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90, sensor_length_push());
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90,-sensor_length_push());
		
		draw_set_color(white);
		draw_circle(x+vec_r.x,y+vec_r.y,1,0);
	}
	
	
	#endregion
	
	#region bottom
		if(!airborne || (airborne && y_speed > 0)){
		//bottom left
		draw_set_color(red);
		draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle), sensor_length_vertical());
		draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle),-sensor_length_vertical());
		
		//bottom right
		draw_set_color(blue);
		draw_sensor(x,y,vec_br,snap_to_90(sensor_angle), sensor_length_vertical());
		draw_sensor(x,y,vec_br,snap_to_90(sensor_angle),-sensor_length_vertical());
		
		draw_set_color(white);
		draw_circle(x+vec_br.x,y+vec_br.y,1,0);
		draw_circle(x+vec_bl.x,y+vec_bl.y,1,0);
		
		//bottom sensor
		if(point_sensor(vec_b)){
			draw_set_color(pink);
		} else draw_set_color(white);
		draw_circle(x+vec_b.x,y+vec_b.y,1,0);
	}
	#endregion
	
	#region top
	if(airborne && y_speed < 0){
		//top left{
		draw_set_color(green);
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle), sensor_length_vertical());
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle),-sensor_length_vertical());
		
		//top right
		draw_set_color(yellow);
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle), sensor_length_vertical());
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle),-sensor_length_vertical());
		
		draw_set_color(white);
		
		draw_circle(x+vec_tr.x,y+vec_tr.y,1,0);
		draw_circle(x+vec_tl.x,y+vec_tl.y,1,0);
		
		if(point_sensor(vec_t)) draw_set_color(pink);
		else draw_set_color(white);
		draw_circle(x+vec_t.x,y+vec_t.y,1,0);
		#endregion
	}
	
	draw_set_color(white);
	
	//draw angles
	draw_text(x,y-40,sensor_angle);
	draw_text(x,y-60,snap_to_90(sensor_angle));
}
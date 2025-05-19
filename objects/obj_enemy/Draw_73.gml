/// @description debug drawing
if(global.debug){
	//draws vector lines
	
	#region side
	//left
	if((!airborne && ground_spd < 0) || airborne) { //left
		draw_set_color(cyan);
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90,-sensor_length_base);
		
		draw_set_color(white);
		draw_circle(x+vec_l.x,y+vec_l.y,1,0);
	}
	
	
	//right
	if((!airborne && ground_spd > 0) || airborne){
		draw_set_color(orange);
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90,-sensor_length_base);
		
		draw_set_color(white);
		draw_circle(x+vec_r.x,y+vec_r.y,1,0);
	}
	
	
	#endregion
	
	#region bottom
    //bottom sensor
    if(point_sensor(vec_b)){
        draw_set_color(pink);
    } else draw_set_color(white);
    draw_circle(x+vec_b.x,y+vec_b.y,1,0);
	#endregion
	
	#region top
	if(airborne){
        //top
		if(point_sensor(vec_t)) draw_set_color(pink);
		else draw_set_color(white);
		draw_circle(x+vec_t.x,y+vec_t.y,1,0);
	}
    #endregion
	
	draw_set_color(white);
	
}
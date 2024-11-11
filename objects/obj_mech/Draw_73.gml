/// @description debug drawing
if(debug_draw){
	draw_cross(x,y,20,gray);
	draw_rectangle(x-w_radius,y-h_radius,x+w_radius,y+h_radius,true);
	
	var sensor_length = airborne ? 5+y_speed : sensor_length_base;
	
	draw_set_color(red);
	//bottom
	draw_sensor(x,y,vec_bl,0,sensor_length);
	draw_sensor(x,y,vec_b,0,sensor_length);
	draw_sensor(x,y,vec_br,0,sensor_length);
	
	//left
	draw_sensor(x,y,vec_l,-90,sensor_length);
	//draw_sensor(x,y,vec_lb,-90,sensor_length);
	
	//right
	draw_sensor(x,y,vec_r,90,sensor_length);
	//draw_sensor(x,y,vec_rb,90,sensor_length);
	
	draw_set_color(white);
	
	////leg anchors
	draw_cross(body.x+vec_leg_l.x,body.y+vec_leg_l.y,5,green);
	draw_cross(body.x+vec_leg_r.x,body.y+vec_leg_r.y,5,red);
	
	////feet anchor
	draw_cross(x+vec_foot_l.x,y+vec_foot_l.y,10,green);
	
	draw_rectangle(x+vec_foot_l.x-foot_max_h_dist,	y+vec_foot_l.y-foot_max_v_dist,	x+vec_foot_l.x+foot_max_h_dist,	y+vec_foot_l.y+foot_max_v_dist,	true);
	
	
	draw_cross(x+vec_foot_r.x,y+vec_foot_r.y,10,red);
	
	draw_rectangle(x+vec_foot_r.x-foot_max_h_dist,	y+vec_foot_r.y-foot_max_v_dist,	x+vec_foot_r.x+foot_max_h_dist,	y+vec_foot_r.y+foot_max_v_dist,	true);
	
	
	//draw body parts
	
	draw_cross(body.x,body.y,5);
	
	draw_cross(dome.x,dome.y,5);

	
	
}

/// @description

if(global.debug){
	//draws vector lines
	
	#region side
	//left
	if(ground_spd < 0 || airborne){
		draw_set_color(cyan);
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90, sensor_length_base);
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90,-sensor_length_base);
		
		draw_set_color(white);
		draw_circle(x+vec_l.x,y+vec_l.y,1,0);
	}
	
	
	//right
	if(ground_spd > 0 || airborne){
		draw_set_color(orange);
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90, sensor_length_base);
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90,-sensor_length_base);
		
		draw_set_color(white);
		draw_circle(x+vec_r.x,y+vec_r.y,1,0);
	}
	
	
	#endregion
	
	#region bottom
	if(true){
		//bottom left
		draw_set_color(red);
		draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle),-sensor_length_base);
		
		//bottom right
		draw_set_color(blue);
		draw_sensor(x,y,vec_br,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_br,snap_to_90(sensor_angle),-sensor_length_base);
		
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
	if(airborne){
		//top left{
		draw_set_color(green);
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle),-sensor_length_base);
		
		//top right
		draw_set_color(yellow);
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle),-sensor_length_base);
		
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
	
	draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,image_angle,-1,0.1);
	
	
	//check sides
	if(false){
		var sens = sensor(vec_b,snap_to_90(sensor_angle), sensor_length_base)
		if(sens != noone && sens.inst != noone){
			draw_text(sens.inst.x,sens.inst.y,sens.side);
			
			var inst = sens.inst;
			var x_ = x+sens.vec_sensor.x;
			var y_ = y+sens.vec_sensor.y;
		
			var inst_angle = inst.image_angle
			var contact_vec = new Vector2(x_ -inst.x,y_ -inst.y)
			contact_vec = contact_vec.rotated(inst.image_angle);
			
			//inst.image_angle = 0;
			
			var mid_x = lerp(inst.bbox_left,inst.bbox_right,0.5);
			var mid_y = lerp(inst.bbox_top,inst.bbox_bottom,0.5);
			
			var lt_vec = new Vector2(inst.bbox_left  - mid_x, inst.bbox_top    - mid_y);
			var rt_vec = new Vector2(inst.bbox_right - mid_x, inst.bbox_top    - mid_y);
			var lb_vec = new Vector2(inst.bbox_left  - mid_x, inst.bbox_bottom - mid_y);
			var rb_vec = new Vector2(inst.bbox_right - mid_x, inst.bbox_bottom - mid_y);
			
			//inst.image_angle = inst_angle;
			
			var contact_x = contact_vec.x + x;
			var contact_y = contact_vec.y + y;
			
			sens.side = noone;
			
			var lt_corner = new Vector2(mid_x + (lt_vec.x * 2),mid_y + (lt_vec.y * 2));
			var rt_corner = new Vector2(mid_x + (rt_vec.x * 2),mid_y + (rt_vec.y * 2));
			var lb_corner = new Vector2(mid_x + (lb_vec.x * 2),mid_y + (lb_vec.y * 2));
			var rb_corner = new Vector2(mid_x + (rb_vec.x * 2),mid_y + (rb_vec.y * 2));
			
			draw_set_color(red);		
			draw_triangle(mid_x,mid_y,lt_corner.x,lt_corner.y,rt_corner.x,rt_corner.y,true);
			
			draw_set_color(blue);		
			draw_triangle(mid_x,mid_y,lt_corner.x,lt_corner.y,lb_corner.x,lb_corner.y,true);
			
			draw_set_color(green);		
			draw_triangle(mid_x,mid_y,rt_corner.x,rt_corner.y,rb_corner.x,rb_corner.y,true);
			
			draw_set_color(yellow);		
			draw_triangle(mid_x,mid_y,lb_corner.x,lb_corner.y,rb_corner.x,rb_corner.y,true);
			
			draw_set_color(white);
			
		}
	}
}
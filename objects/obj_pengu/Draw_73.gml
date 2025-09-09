/// @description Debug draw

if(global.debug){
	//draws vector lines
	
	#region side
	//left
	if(ground_spd < 0 || airborne){
		draw_set_color(CYAN);
		draw_sensor(x,y,vec_l,snap_to_90(sensor_angle)-90,-sensor_length_base);
		
		draw_set_color(WHITE);
		draw_circle(x+vec_l.x,y+vec_l.y,1,0);
	}
	
	
	//right
	if(ground_spd > 0 || airborne){
		draw_set_color(ORANGE);
		draw_sensor(x,y,vec_r,snap_to_90(sensor_angle)+90,-sensor_length_base);
		
		draw_set_color(WHITE);
		draw_circle(x+vec_r.x,y+vec_r.y,1,0);
	}
	
	
	#endregion
	
	#region bottom
    
    //bottom left
    if(sensor(vec_bl,snap_to_90(sensor_angle),sensor_length_base,sensor_length_base)){
        draw_set_color(ORANGE);
    } else draw_set_color(WHITE);
    draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle), sensor_length_base);
    draw_sensor(x,y,vec_bl,snap_to_90(sensor_angle),-sensor_length_base);
    
    //bottom right
    if(sensor(vec_br,snap_to_90(sensor_angle),sensor_length_base,sensor_length_base)){
        draw_set_color(BLUE);
    } else draw_set_color(WHITE);
    draw_sensor(x,y,vec_br,snap_to_90(sensor_angle), sensor_length_base);
    draw_sensor(x,y,vec_br,snap_to_90(sensor_angle),-sensor_length_base);
    
    draw_set_color(WHITE);
    draw_circle(x+vec_br.x,y+vec_br.y,1,0);
    draw_circle(x+vec_bl.x,y+vec_bl.y,1,0);
    
    //bottom sensor
    if(point_sensor(vec_b)){
        draw_set_color(PINK);
    } else draw_set_color(WHITE);
    draw_circle(x+vec_b.x,y+vec_b.y,1,0);
	#endregion
	
	#region top
	if(airborne){
		//top left{
		draw_set_color(GREEN);
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_tl,snap_to_90(sensor_angle),-sensor_length_base);
		
		//top right
		draw_set_color(YELLOW);
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle), sensor_length_base);
		draw_sensor(x,y,vec_tr,snap_to_90(sensor_angle),-sensor_length_base);
		
		draw_set_color(WHITE);
		
		draw_circle(x+vec_tr.x,y+vec_tr.y,1,0);
		draw_circle(x+vec_tl.x,y+vec_tl.y,1,0);
		
        //top
		if(point_sensor(vec_t)) draw_set_color(PINK);
		else draw_set_color(WHITE);
		draw_circle(x+vec_t.x,y+vec_t.y,1,0);
		#endregion
	}
	
	draw_set_color(WHITE);
	
	//draw angles
	draw_text(x,y-40,sensor_angle);
	draw_text(x,y-60,snap_to_90(sensor_angle));
	
	draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,image_angle,-1,0.1);
	
	#region attack radius
    
    if(attacking){
        draw_set_color(RED);
        draw_set_alpha(0.5)
        //if attack pos collides with wall, move it back
        var attack_x_ = x+(attack_x*mirror);
        var attack_y_ = y+attack_y;
        if( collision_point(attack_x_,attack_y_,ENTITY_COLLISION_LAYER,true,true) != noone ){
                       attack_x_ = (attack_x_ > x) ? bbox_right : bbox_left;
        }
        draw_circle(attack_x_,attack_y_,attack_radius,false)
        draw_set_color(WHITE);
        draw_set_alpha(1)
    }
    
    if(state.state_is("dash_air_charge")){
        draw_set_color(RED);
        draw_set_alpha(0.5)
        draw_circle(x,y,meteor_radius,false)
        draw_set_color(WHITE);
        draw_set_alpha(1)
    }
    
    #endregion
	
}
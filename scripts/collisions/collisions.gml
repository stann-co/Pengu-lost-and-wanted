
///@function tile_collision()
///@desc returns tile collision
function tile_collision(x_,y_){
	return collision_point(round(x_),round(y_),[global.tile_collisions,obj_collision],true,true);
}

///@function tile_collision_oneway()
///@desc returns if the position contains a oneway tile
function tile_collision_oneway(x_,y_){
	return (collision_point(round(x_),round(y_),[obj_collision_oneway],true,true)!= noone);
}

///@function point_sensor()
///@desc return collision at point
function point_sensor(vec){
	return (tile_collision(x+vec.x,y+vec.y) != noone);
}

///@function sensor()
///@desc returns vector2 with distance to be just next to the surface, or noone
///@param vec_start {Vector2}
///@param dir 0 is down
///@param extention_dist
///@param regression_dist
///@param delta {float} how much the scan point should move when scanning lower is more accurate by slower
function sensor(vec_start,dir,extention_dist,regression_dist = extention_dist,delta = 1){

	var vec_ext = new Vector2(0,extention_dist);
		vec_ext = vec_ext.rotated(-dir);
		
		var vec_reg = new Vector2(0,-(regression_dist+extention_dist));
		vec_reg = vec_reg.rotated(-dir);
	var angle = undefined;
	
	var coll = tile_collision(x+vec_start.x,y+vec_start.y);
	var vec_sensor = vec_start;	
	
	if(coll != noone){	//regression - inside collision
		if(tile_collision(x+vec_start.x + vec_reg.x,y+vec_start.y + vec_reg.y) == noone){ //checks if there's free space to regress towards
			
			var vec_end = vec_start.add(vec_reg);
			do{ //regresses until there's free space
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(tile_collision(x+vec_sensor.x,y+vec_sensor.y) == noone)
			
			var vec_rot_check = vec_sensor.move_toward(vec_start,delta);
			
			angle = tile_rotation(x+vec_rot_check.x,y+vec_rot_check.y);
			coll = tile_collision(x+vec_rot_check.x,y+vec_rot_check.y);
			
			var oneway = tile_collision_oneway(x+vec_rot_check.x,y+vec_rot_check.y);
			
		} else return noone;
	} else {			//extension - outside collision
		if(tile_collision(x+vec_start.x +vec_ext.x,y+vec_start.y +vec_ext.y) != noone){ //checks if there's filled space to extend towards
			
			var vec_end = vec_start.add(vec_ext);
			do{
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(tile_collision(x+vec_sensor.x,y+vec_sensor.y) != noone)
			
			angle = tile_rotation(x+vec_sensor.x,y+vec_sensor.y);			
			var oneway = tile_collision_oneway(x+vec_sensor.x,y+vec_sensor.y);
			coll = tile_collision(x+vec_sensor.x,y+vec_sensor.y);
			
			//when the solid space has been found it regresses back one unit to be next to it
			vec_sensor = vec_sensor.move_toward(vec_start,delta);
			
		} else return noone;
	}
	
	vec_dist = vec_sensor.subtract(vec_start);
	var vec_upright = vec_dist.rotated(dir);
	vec_dist.distance = vec_upright.y;
	vec_dist.oneway = oneway;
	
	vec_dist.x_change = 0;	
	vec_dist.y_change = 0;
	vec_dist.inst = noone;
	
	if(instance_exists(coll)){
		vec_dist.inst = coll;
		var x_ = x+vec_sensor.x;
		var y_ = y+vec_sensor.y;

		var coll_angle = coll.image_angle
		var contact_vec = new Vector2(x_ -coll.x,y_ -coll.y)
		contact_vec = contact_vec.rotated(coll.image_angle);
		
		coll.image_angle = 0//snap_to_90(coll.image_angle);
		
		var lt_vec = new Vector2(coll.bbox_left  - coll.x, coll.bbox_top    - coll.y);
		var rt_vec = new Vector2(coll.bbox_right - coll.x, coll.bbox_top    - coll.y);
		var lb_vec = new Vector2(coll.bbox_left  - coll.x, coll.bbox_bottom - coll.y);
		var rb_vec = new Vector2(coll.bbox_right - coll.x, coll.bbox_bottom - coll.y);
		
		coll.image_angle = coll_angle;
		
		var contact_x = contact_vec.x + x;
		var contact_y = contact_vec.y + y;
		
		if(rectangle_in_circle(x+lt_vec.x,y+lt_vec.y,x+rt_vec.x,y+rt_vec.y,contact_x,contact_y,4) != 0) angle = 0;else
		if(rectangle_in_circle(x+lt_vec.x,y+lt_vec.y,x+lb_vec.x,y+lb_vec.y,contact_x,contact_y,4) != 0) angle = 90;else
		if(rectangle_in_circle(x+rt_vec.x,y+rt_vec.y,x+rb_vec.x,y+rb_vec.y,contact_x,contact_y,4) != 0) angle = 270;else
		if(rectangle_in_circle(x+lb_vec.x,y+lb_vec.y,x+rb_vec.x,y+rb_vec.y,contact_x,contact_y,4) != 0) angle = 180;
					
		angle+=coll.image_angle;
					
		if(angle < 0) angle+=360;
		else if(angle >= 360) angle-=360;
		
		if(object_is_ancestor(coll.object_index,obj_moving_platform)){
			
			contact_vec = new Vector2(x+vec_start.x-coll.x,y+vec_start.y-coll.y)
			var new_contact_vec = contact_vec.rotated(-coll.rot_change);
			
			var rot_x = new_contact_vec.x - contact_vec.x;
			var rot_y = new_contact_vec.y - contact_vec.y;
			
			vec_dist.x_change = coll.x_change + rot_x;	
			vec_dist.y_change = coll.y_change + rot_y;
		}
	} else if(angle == 360){
		angle = snap_to_90(dir);
	}	
	
	vec_dist.angle = angle;

	return vec_dist;	
}

///@function draw_sensor()
///@desc draws a line the same way the sensor code works
///@param vec_start {Vector2}
///@param dir 0 is down
///@param distance
function draw_sensor(x,y,vec_start,dir,distance){
	var vec_dist = new Vector2(0,distance);
		vec_dist = vec_dist.rotated(-dir);
		vec_dist = vec_dist.add(vec_start);
	draw_line(x+vec_start.x,y+vec_start.y,x+vec_dist.x,y+vec_dist.y);
}

///@function tile_rotation()
///@desc gets rotation value from a tile using global.tile_angles
function tile_rotation(x_,y_){
	var inst = tile_collision(x_,y_);
	
	if(inst == noone) show_error("No tile/object",false);
	
	if(!instance_exists(inst)){
		//tiles
		var mx = tilemap_get_cell_x_at_pixel(inst, round(x_), round(y_));
		var my = tilemap_get_cell_y_at_pixel(inst, round(x_), round(y_));
		var tile = tilemap_get(inst, mx, my);
		var tile_index = tile_get_index(tile);
		
		if(tile_index > array_length(global.tile_angles)-1 ) return 0;
		
		//Get's the tile's rotation, which has been pre-set in global.tile_angles
		var rotation = (global.tile_angles[tile_index])
		
		if(rotation != 360){ //360 is a special number for solid blocks, so it doesn't need to get rotated or flipped
			//rotates and flips the rotation if the tile is flipped or rotated
			if (tile_get_rotate(tile)){
				rotation = rotation - 90;
				if (tile_get_mirror(tile))	rotation = -(rotation+180);	
				if (tile_get_flip(tile))	rotation = -rotation;
			} else {
				if (tile_get_mirror(tile))	rotation = -rotation;
				if (tile_get_flip(tile))	rotation = -(rotation+180);
			}
			
			if(rotation < 0) rotation += 360; //ensures the rotation is a positive number
			else if (rotation > 360) rotation -= 360;
		}
		
		return rotation;
	} else {
		//objects and instances
		
		return 360
	}
}

///@function snap_to_90()
///@desc returns rotation snapped to nearest 90deg
function snap_to_90(rotation){
	
	if (rotation < 0) rotation+=360;

	if(rotation <= 45 || rotation >= 315) return 0; //down
	if(rotation > 45 && rotation < 135) return 90; //right
	if(rotation >= 135 && rotation <= 225) return 180; //up
	if(rotation > 225 && rotation < 315) return 270; //left
}
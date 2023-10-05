
///@function tile_collision()
///@desc returns tile collision
function tile_collision(x_,y_){
	return collision_point(round(x_),round(y_),[global.tile_collisions],true,true);
}

///@function sensor()
///@desc returns vector2 with distance to be just next to the surface, or noone
///@param vec_start {Vector2}
///@param dir 0 is down
///@param distance
///@param delta {float} how much the scan point should move when scanning, lower is more accurate by slower
function sensor(vec_start,dir,distance,delta = 1){

	var vec_dist = new Vector2(0,distance);
		vec_dist = vec_dist.rotated(-dir);
	var angle = undefined;
	
	var coll = tile_collision(x+vec_start.x,y+vec_start.y);
	
	var vec_sensor = vec_start;	
	
	if(coll != noone){	//regression - inside collision
		if(!tile_collision(x+vec_start.x -vec_dist.x,y+vec_start.y -vec_dist.y)){ //checks if there's free space to regress towards
			
			var vec_end = vec_start.subtract(vec_dist);
			do{ //regresses until there's free space
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(!tile_collision(x+vec_sensor.x,y+vec_sensor.y))
			
			var vec_rot_check = vec_sensor.move_toward(vec_start,delta);
			
			angle = tile_rotation(x+vec_rot_check.x,y+vec_rot_check.y);
			
		} else return noone;
	} else {			//extension - outside collision
		if(tile_collision(x+vec_start.x +vec_dist.x,y+vec_start.y +vec_dist.y)){ //checks if there's filled space to extend towards
			
			var vec_end = vec_start.add(vec_dist);
			do{
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(tile_collision(x+vec_sensor.x,y+vec_sensor.y))
			
			angle = tile_rotation(x+vec_sensor.x,y+vec_sensor.y);
			
			//when the solid space has been found it regresses back one unit to be next to it
			vec_sensor = vec_sensor.move_toward(vec_start,delta);
			
		} else return noone;
	}
	
	vec_dist = vec_sensor.subtract(vec_start);
	var vec_upright = vec_dist.rotated(dir);
	vec_dist.distance = vec_upright.y;
	
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
	
	if(inst == noone) show_error("No tile",false);
	
	var mx = tilemap_get_cell_x_at_pixel(inst, round(x_), round(y_));
	var my = tilemap_get_cell_y_at_pixel(inst, round(x_), round(y_));
	var tile = tilemap_get(inst, mx, my);
	var tile_index = tile_get_index(tile);

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
	} else {
		return snap_to_90(ground_angle);
	}
	
	return rotation;
}

///@function snap_to_90()
///@desc returns rotation snapped to nearest 90deg
function snap_to_90(rotation){

	if(rotation <= 45 || rotation >= 315) return 0; //down
	if(rotation > 45 && rotation < 135) return 90; //right
	if(rotation >= 135 && rotation <= 225) return 180; //up
	if(rotation > 225 && rotation < 315) return 270; //left
}
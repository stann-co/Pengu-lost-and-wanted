
///@function tile_collision()
///@desc returns tile collision
function tile_collision(x_,y_){
	return collision_point(round(x_),round(y_),[global.tile_collisions,obj_collision],true,true);
}

///@function tile_collision_line()
///@desc returns tile collision
function tile_collision_line(x_,y_,x_2,y_2, _delta = 1){
	var _coll = noone;
	var _vec_start = new Vector2(x_,y_);
	var _vec_end = new Vector2(x_2,y_2);
	
	do{
		_vec_start = _vec_start.move_toward(_vec_end,_delta);
		_coll = tile_collision(_vec_start.x,_vec_start.y);
	}until(_coll !=  noone || (_vec_start.x == _vec_end.x && _vec_start.y == _vec_end.y))
	
	return _coll;
}

///@function point_sensor()

///@function sensor_is_oneway()
///@desc checks is sensor is a oneway
///@param sensor_
function sensor_is_oneway(sensor_){
	return (sensor_ != noone && sensor_.inst != noone && variable_instance_exists(sensor_.inst,"oneway") && sensor_.inst.oneway);
}

///@function sensor_is_destructible()
///@desc checks is sensor is destructible
///@param sensor_
function sensor_is_destructible(sensor_){
	return (sensor_ != noone && sensor_.inst != noone && sensor_.inst.object_index == obj_destructible_block);
}

///@function sensor_is_falling_platform()
///@desc checks is sensor is falling platform
///@param sensor_
function sensor_is_falling_platform(sensor_){
	return (sensor_ != noone && sensor_.inst != noone && sensor_.inst.object_index == obj_falling_platform && sensor_.side == "top");
}

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
///@param delta {float} how much the scan point should move when scanning lower is more accurate but slower
function sensor(vec_start,dir,extention_dist,regression_dist = extention_dist,delta = 1){
	var vec_ext = new Vector2(0,extention_dist);
		vec_ext = vec_ext.rotated(-dir);
		
	var vec_reg = new Vector2(0,-(regression_dist+extention_dist));
		vec_reg = vec_reg.rotated(-dir);
		
	var info;
	
	#region extend regress
	var coll = tile_collision(x+vec_start.x,y+vec_start.y);
	
	var vec_sensor = vec_start;
	
	if(coll != noone){	//regression - inside collision
		if(tile_collision(x+vec_start.x + vec_reg.x,y+vec_start.y + vec_reg.y) == noone){ //checks if there's free space to regress towards
			
			var vec_end = vec_start.add(vec_reg);
			do{ //regresses until there's free space
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(tile_collision(x+vec_sensor.x,y+vec_sensor.y) == noone)
			
			var vec_rot_check = vec_sensor.move_toward(vec_start,delta);
			
			coll = tile_collision(x+vec_rot_check.x,y+vec_rot_check.y);
			angle = tile_rotation(x+vec_rot_check.x,y+vec_rot_check.y,coll);
			
			info = {
				inst : coll,
				angle : angle,
				vec_sensor : vec_sensor
			}
		} else return noone;
	} else {			//extension - outside collision
		
		var vec_end = vec_start.add(vec_ext);
		if(tile_collision_line( x+vec_start.x , y+vec_start.y , x+vec_end.x , y+vec_end.y , delta ) != noone){ //checks if there's filled space to extend towards
			
			do{
				vec_sensor = vec_sensor.move_toward(vec_end,delta);
			}until(tile_collision(x+vec_sensor.x,y+vec_sensor.y) != noone)
			
				
			coll = tile_collision(x+vec_sensor.x,y+vec_sensor.y);
			angle = tile_rotation(x+vec_sensor.x,y+vec_sensor.y,coll);
			
			//when the solid space has been found it regresses back one unit to be next to it
			vec_sensor = vec_sensor.move_toward(vec_start,delta);
			
			info = {
				inst : coll,
				angle : angle,
				vec_sensor : vec_sensor
			}
			
		} else return noone;
	}
	#endregion
	
	var vec_dist = info.vec_sensor.subtract(vec_start);
	info.x = vec_dist.x;
	info.y = vec_dist.y;
	
	var vec_upright = vec_dist.rotated(dir);
	info.distance = vec_upright.y;
	
	info.x_change = 0;	
	info.y_change = 0;
	
	
	if(instance_exists(info.inst)){
		
		//when colliding with an instance, it's internally rotated back to 0 degrees
		//and the sensors origin is used to check which side of the instance it is, left right top bottom
		
		var inst = info.inst;
		var inst_angle = inst.image_angle
		
		var x_ = round(x+vec_start.x+info.x);
		var y_ = round(y+vec_start.y+info.y);
		var contact_vec = new Vector2(x_ -inst.x,y_ -inst.y)
		contact_vec = contact_vec.rotated(inst.image_angle);
		
		var contact_x = contact_vec.x + inst.x;
		var contact_y = contact_vec.y + inst.y;
		
		inst.image_angle = 0;
		
		var mid_x = lerp(inst.bbox_left,inst.bbox_right,0.5);
		var mid_y = lerp(inst.bbox_top,inst.bbox_bottom,0.5);
		
		var lt_vec = new Vector2(inst.bbox_left  - mid_x, inst.bbox_top    - mid_y);
		var rt_vec = new Vector2(inst.bbox_right - mid_x, inst.bbox_top    - mid_y);
		var lb_vec = new Vector2(inst.bbox_left  - mid_x, inst.bbox_bottom - mid_y);
		var rb_vec = new Vector2(inst.bbox_right - mid_x, inst.bbox_bottom - mid_y);
		
		inst.image_angle = inst_angle;
		
		var lt_corner = new Vector2(mid_x + (lt_vec.x * 2),mid_y + (lt_vec.y * 2));
		var rt_corner = new Vector2(mid_x + (rt_vec.x * 2),mid_y + (rt_vec.y * 2));
		var lb_corner = new Vector2(mid_x + (lb_vec.x * 2),mid_y + (lb_vec.y * 2));
		var rb_corner = new Vector2(mid_x + (rb_vec.x * 2),mid_y + (rb_vec.y * 2));
		
		var ver = 0;
		var hor = 0;
		
		info.side = noone;
		if(point_in_triangle(contact_x,contact_y,mid_x,mid_y,lt_corner.x,lt_corner.y,rt_corner.x,rt_corner.y)){
			info.angle = 0;
			info.side = "top";
		}else
		if(point_in_triangle(contact_x,contact_y,mid_x,mid_y,lb_corner.x,lb_corner.y,rb_corner.x,rb_corner.y)){
			info.angle = 180;
			info.side = "bottom";
		}else
		if(point_in_triangle(contact_x,contact_y,mid_x,mid_y,lt_corner.x,lt_corner.y,lb_corner.x,lb_corner.y)){
			info.angle = 90;
			info.side = "left";
		}else
		if(point_in_triangle(contact_x,contact_y,mid_x,mid_y,rt_corner.x,rt_corner.y,rb_corner.x,rb_corner.y)){
			info.angle = 270;
			info.side = "right";
		}
		
		inst.image_angle = inst_angle;
		
		info.angle+=inst.image_angle;
					
		if(info.angle < 0) info.angle+=360;
		else if(info.angle >= 360) info.angle-=360;
		
		if(	object_is_ancestor(inst.object_index,obj_collision_activate) ||
			inst.object_index == obj_collision_activate
			){
			
			contact_vec = new Vector2(x+vec_start.x-inst.x,y+vec_start.y-inst.y)
			var new_contact_vec = contact_vec.rotated(-(inst.image_angle - inst.angle_previous));
			
			var rot_x = new_contact_vec.x - contact_vec.x;
			//var rot_y = new_contact_vec.y - contact_vec.y;
			
			var x_change = (inst.x - inst.xprevious) + rot_x;
			//var y_change = (inst.y - inst.yprevious) + rot_y;
			
			info.x += x_change
			//info.y += y_change
			
			if(!inst.standing_on){
				inst.standing_on = true;
				inst.trigger();
			}
			inst.triggering = true;
			if(inst.parent != noone) inst.parent.triggering = true;
		}
	} else{
		info.inst = noone;
		if(info.angle == 360){
			info.angle = snap_to_90(dir);
		}
		info.side = noone;
	}	

	return info;	
}

///@function draw_sensor()
///@desc draws a line the same way the sensor code works
///@param x
///@param y
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
function tile_rotation(x_,y_,inst){
	
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
	else if (rotation >= 360 ) rotation-=360;

	if(rotation <= 45 || rotation >= 315) return 0; //down
	if(rotation > 45 && rotation < 135) return 90; //right
	if(rotation >= 135 && rotation <= 225) return 180; //up
	if(rotation > 225 && rotation < 315) return 270; //left
}

///@function add_collision_child()
function add_collision_child(_x_offset,_y_offset,_width,_height,_oneway = false){
	var child = instance_create_depth(x+_x_offset,y+_y_offset,global.depth_a,obj_collision_activate);
	child.image_xscale = _width  / sprite_get_width(spr_collision);
	child.image_yscale = _height / sprite_get_height(spr_collision);
	child.x_offset = _x_offset;
	child.y_offset = _y_offset;
	child.oneway = _oneway;
	child.parent = self;	
		
	return child;
}
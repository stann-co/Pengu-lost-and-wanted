enum COLLISION_TYPE {
	TILE,
	OBJECT,
	ALL
}


///@function tile_collision()
///@desc returns tile collision
function tile_collision(_x,_y,_col_type = COLLISION_TYPE.ALL){
    var tile_layer_ = global.collision_layers[? collision_layer];
	switch (_col_type) {
	    case COLLISION_TYPE.TILE:
			return collision_point(round(_x),round(_y),tile_layer_,true,true);
		case COLLISION_TYPE.OBJECT:
	        return collision_point(round(_x),round(_y),obj_collision,true,true);
	    case COLLISION_TYPE.ALL:
	        return collision_point(round(_x),round(_y),[obj_collision,tile_layer_],true,true);
	}
}

///@function tile_collision_line()
///@desc returns tile collision
function tile_collision_line(_x,_y,_x2,_y2,_col_type,_delta = 1){
	var coll_ = noone;
	var vec_start_ = new Vector2(_x,_y);
	var vec_end_ = new Vector2(_x2,_y2);
	
	do{
		vec_start_ = vec_start_.move_toward(vec_end_,_delta);
		coll_ = tile_collision(vec_start_.x,vec_start_.y,_col_type);
	}until(coll_ !=  noone || (vec_start_.x == vec_end_.x && vec_start_.y == vec_end_.y))
	
	return coll_;
}

///@function sensor_trigger()
///@desc run trigger function on instance, returns true if solid
///@param _sensor
function sensor_trigger(_sensor){
	if(_sensor.inst != noone){
		return _sensor.inst.trigger(_sensor.side,id)
	} else return true
}

///@desc return collision at point
function point_sensor(_vec){
	return (tile_collision(x+_vec.x,y+_vec.y,true) != noone);
}

///@function sensor()
///@desc returns vector2 with distance to be just next to the surface, or noone
///@param _vec_start {Vector2}
///@param _dir 0 is down
///@param _extention_dist
///@param _regression_dist
function sensor(_vec_start,_dir,_extention_dist,_regression_dist = _extention_dist){
	var delta_ = 1;
	
	var vec_ext_ = new Vector2(0,_extention_dist);
		vec_ext_ = vec_ext_.rotated(-_dir);
		
	var vec_reg_ = new Vector2(0,-(_regression_dist+_extention_dist));
		vec_reg_ = vec_reg_.rotated(-_dir);
		
	var info_;
	
	#region extend regress
	
	var col_type_ = COLLISION_TYPE.ALL;
	
	var coll_ = tile_collision(x+_vec_start.x,y+_vec_start.y,COLLISION_TYPE.ALL);
	
	var vec_sensor_ = _vec_start;
	
	if(coll_ != noone){	//regression - inside collision
		
		//when regressing, from a solid there's a distinction between tiles and objects
		if(instance_exists(coll_)) col_type_ = COLLISION_TYPE.OBJECT
		else col_type_ = COLLISION_TYPE.TILE
		
		if(tile_collision(x+_vec_start.x + vec_reg_.x,y+_vec_start.y + vec_reg_.y,col_type_) == noone){ //checks if there's free space to regress towards
			
			var vec_end_ = _vec_start.add(vec_reg_);
			do{ //regresses until there's free space
				vec_sensor_ = vec_sensor_.move_toward(vec_end_,delta_);
			}until(tile_collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_) == noone)
			
			var vec_rot_check_ = vec_sensor_.move_toward(_vec_start,delta_);
			
			coll_ = tile_collision(x+vec_rot_check_.x,y+vec_rot_check_.y,col_type_);
			angle = tile_rotation(x+vec_rot_check_.x,y+vec_rot_check_.y,coll_);
			
			info_ = {
				inst : coll_,
				angle : angle,
				vec_sensor_ : vec_sensor_
			}
		} else 
		return noone;
	} else {			//extension - outside collision
		
		var vec_end_ = _vec_start.add(vec_ext_);
		if(tile_collision_line( x+_vec_start.x , y+_vec_start.y , x+vec_end_.x , y+vec_end_.y ,col_type_, delta_ ) != noone){ //checks if there's filled space to extend towards
			
			do{
				vec_sensor_ = vec_sensor_.move_toward(vec_end_,delta_);
			}until(tile_collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_) != noone)
			
				
			coll_ = tile_collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_);
			angle = tile_rotation(x+vec_sensor_.x,y+vec_sensor_.y,coll_);
			
			//when the solid space has been found it regresses back one unit to be next to it
			vec_sensor_ = vec_sensor_.move_toward(_vec_start,delta_);
			
			info_ = {
				inst : coll_,
				angle : angle,
				vec_sensor_ : vec_sensor_
			}
			
		} else 
		return noone;
	}
	#endregion
	
	var vec_dist_ = info_.vec_sensor_.subtract(_vec_start);
	info_.x = vec_dist_.x;
	info_.y = vec_dist_.y;
	
	var vec_upright_ = vec_dist_.rotated(_dir);
	info_.distance = vec_upright_.y; 
	
	info_.x_change = 0;	
	info_.y_change = 0;
	
	
	if(instance_exists(info_.inst)){
		
		//when colliding with an instance, it's internally rotated back to 0 degrees
		//and the sensors origin is used to check which side of the instance it is, left right top bottom
		
		var inst_ = info_.inst;
		var inst_angle_ = inst_.image_angle
		
		var x_ = round(x+_vec_start.x+info_.x);
		var y_ = round(y+_vec_start.y+info_.y);
        
        switch (find_side(x_,y_,info_.inst)) {
        	case SIDES.BOTTOM:
                info_.angle = 180;
                info_.side = SIDES.BOTTOM
                break
            case SIDES.LEFT:
                info_.angle = 90;
                info_.side = SIDES.LEFT
                break
            case SIDES.RIGHT:
                info_.angle = 270;
                info_.side = SIDES.RIGHT
                break
            case SIDES.TOP:
                info_.angle = 0;
                info_.side = SIDES.TOP
                break
        }
		
		info_.angle+=inst_.image_angle;
		if(info_.angle < 0) info_.angle+=360;
		else if(info_.angle >= 360) info_.angle-=360;

	} else{
		info_.inst = noone;
		if(info_.angle == 360){
			info_.angle = snap_to_90(_dir);
		}
		info_.side = noone;
	}	

	return info_;	
}

///@function draw_sensor()
///@desc draws a line the same way the sensor code works
///@param _x
///@param _y
///@param _vec_start {Vector2}
///@param _dir 0 is down
///@param _distance
function draw_sensor(_x,_y,_vec_start,_dir,_distance){
	var vec_dist_ = new Vector2(0,_distance);
		vec_dist_ = vec_dist_.rotated(-_dir);
		vec_dist_ = vec_dist_.add(_vec_start);
	draw_line(_x+_vec_start.x,_y+_vec_start.y,_x+vec_dist_.x,_y+vec_dist_.y);
}

///@function tile_rotation()
///@desc gets rotation_ value from a tile_ using global.tile_angles
function tile_rotation(_x,_y,_inst){
	
	if(_inst == noone) show_error("No tile_/object",false);
	
	if(!instance_exists(_inst)){
		//tiles
		var mx_ = tilemap_get_cell_x_at_pixel(_inst, round(_x), round(_y));
		var my_ = tilemap_get_cell_y_at_pixel(_inst, round(_x), round(_y));
		var tile_ = tilemap_get(_inst, mx_, my_);
		var tile_index_ = tile_get_index(tile_);
		
		if(tile_index_ > array_length(global.tile_angles)-1 ) return 0;
		
		//Get's the tile_'s rotation_, which has been pre-set in global.tile_angles
		var rotation_ = (global.tile_angles[tile_index_])
		
		if(rotation_ != 360){ //360 is a special number for solid blocks, so it doesn't need to get rotated or flipped
			//rotates and flips the rotation_ if the tile_ is flipped or rotated
			if (tile_get_rotate(tile_)){
				rotation_ = rotation_ - 90;
				if (tile_get_mirror(tile_))	rotation_ = -(rotation_+180);	
				if (tile_get_flip(tile_))	rotation_ = -rotation_;
			} else {
				if (tile_get_mirror(tile_))	rotation_ = -rotation_;
				if (tile_get_flip(tile_))	rotation_ = -(rotation_+180);
			}
			
			if(rotation_ < 0) rotation_ += 360; //ensures the rotation_ is a positive number
			else if (rotation_ > 360) rotation_ -= 360;
			
		}
		
		return rotation_;
	} else {
		//objects and instances
		return 360
	}
}

///@function snap_to_90()
///@desc returns _rotation snapped to nearest 90deg
function snap_to_90(_rotation){
	
	if (_rotation < 0) _rotation+=360;
	else if (_rotation >= 360 ) _rotation-=360;

	if(_rotation <= 45 || _rotation >= 315) return 0; //down
	if(_rotation > 45 && _rotation < 135) return 90; //right
	if(_rotation >= 135 && _rotation <= 225) return 180; //up
	if(_rotation > 225 && _rotation < 315) return 270; //left
}

///@function rot_snap_to()
///@desc returns _rotation snapped to nearest _increment
//function rot_snap_to(_rotation,_increment){
//	return round(_rotation / _increment) * _increment
//}

///@function add_collision_child()
function add_collision_child(_x_offset,_y_offset,_width,_height,_oneway = false){
	var child_ = instance_create_depth(x+_x_offset,y+_y_offset,global.depth_a,obj_collision_activate);
	child_.image_xscale = _width  / sprite_get_width(spr_collision);
	child_.image_yscale = _height / sprite_get_height(spr_collision);
	child_.x_offset = _x_offset;
	child_.y_offset = _y_offset;
	child_.parent = self;	
		
	return child_;
}
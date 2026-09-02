enum COLLISION_TYPE {
	TILE,
	OBJECT,
	ALL
}

///@function collision()
///@desc returns tile or instance_collision
function collision(_x,_y,_col_type = COLLISION_TYPE.ALL){
	switch (_col_type) {
	    case COLLISION_TYPE.TILE:
			_tile_collision(_x,_y);
		case COLLISION_TYPE.OBJECT:
			_inst_collision(_x,_y);
	    case COLLISION_TYPE.ALL:
			var coll_ = _inst_collision(_x,_y)
			if (coll_) return coll_;
		
			return _tile_collision(_x,_y);
	}
}

///@function _tile_collision()
///@desc returns tile collision
function _tile_collision(_x,_y){
    var tile_layer_ = layer_tilemap_get_id(global.collision_layers[? collision_layer]);
	return collision_point(round(_x),round(_y),tile_layer_,true,true);
}

///@function _inst_collision()
///@desc returns instance collision
function _inst_collision(_x,_y){
	static coll_list_ = ds_list_create(); //TODO can i actually use static for this? i hope so
	ds_list_clear(coll_list_);
	var coll_count_ = collision_point_list(_x,_y,obj_collision,true,true,coll_list_,false);
	for (var i_ = 0; i_ < coll_count_; i_++) {
		var coll_ = coll_list_[| i_];
		if(coll_.collision_layer == collision_layer){
			return coll_;
		}
	}
	return noone;
}

///@function tile_collision_line()
///@desc returns tile collision
function tile_collision_line(_x,_y,_x2,_y2,_col_type,_delta = 1){
	var coll_ = noone;
	var vec_start_ = new Vector2(_x,_y);
	var vec_end_ = new Vector2(_x2,_y2);
	
	do{
		vec_start_ = vec_start_.move_toward(vec_end_,_delta);
		coll_ = collision(vec_start_.x,vec_start_.y,_col_type);
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
	return (collision(x+_vec.x,y+_vec.y,true) != noone);
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
	
	//TODO is checking if it's a tile or inst ahead of time really neccesary?
	var col_type_ = COLLISION_TYPE.ALL;
	
	var coll_ = collision(x+_vec_start.x,y+_vec_start.y,COLLISION_TYPE.ALL);
	
	var vec_sensor_ = _vec_start;
	
	if(coll_ != noone){	//regression - inside collision
		
		//when regressing, from a solid there's a distinction between tiles and objects
		if(instance_exists(coll_)) col_type_ = COLLISION_TYPE.OBJECT
		else col_type_ = COLLISION_TYPE.TILE
		
		if(collision(x+_vec_start.x + vec_reg_.x,y+_vec_start.y + vec_reg_.y,col_type_) == noone){ //checks if there's free space to regress towards
			
			var vec_end_ = _vec_start.add(vec_reg_);
			do{ //regresses until there's free space
				vec_sensor_ = vec_sensor_.move_toward(vec_end_,delta_);
			}until(collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_) == noone)
			
			var vec_rot_check_ = vec_sensor_.move_toward(_vec_start,delta_);
			
			coll_ = collision(x+vec_rot_check_.x,y+vec_rot_check_.y,col_type_);
			
			info_ = {
				inst : coll_,
				vec_sensor_ : vec_sensor_
				//TODO should it include collision type? it easily could
			}
			
			_tile_rotation(info_,x+vec_rot_check_.x,y+vec_rot_check_.y,x+_vec_start.x,y+_vec_start.y,coll_,_dir);
			

		} else 
		return noone;
	} else { //extension - outside collision
		
		var vec_end_ = _vec_start.add(vec_ext_);
		if(tile_collision_line( x+_vec_start.x , y+_vec_start.y , x+vec_end_.x , y+vec_end_.y ,col_type_, delta_ ) != noone){ //checks if there's filled space to extend towards
			
			do{
				vec_sensor_ = vec_sensor_.move_toward(vec_end_,delta_);
			}until(collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_) != noone)
				
			coll_ = collision(x+vec_sensor_.x,y+vec_sensor_.y,col_type_);
			
			info_ = {
				inst : coll_,
				vec_sensor_ : vec_sensor_.move_toward(_vec_start,delta_), //when the solid space has been found it regresses back one unit to be next to it
			}
			
			_tile_rotation(info_,x+vec_sensor_.x,y+vec_sensor_.y,x+_vec_start.x,y+_vec_start.y,coll_,_dir);
			
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

///@function _tile_rotation()
///@desc gets rotation_ value from a tile_ using global.tile_angles, and finds side when dealing with objects and adds to _info
function _tile_rotation(_info,_x,_y,_x_origin,_y_origin,_inst,_dir){
	var rotation_ = 0;
	
	if(!instance_exists(_inst)){ //Tiles
		var tile_ = tilemap_get_at_pixel(_inst,round(_x),round(_y));

		var tile_index_ = tile_get_index(tile_);

		if(tile_index_ > array_length(global.tile_angles)-1){
			_info.angle = 0;
			_info.side = noone;
			_info.inst = noone;
			return;
		}

		//Get's the tile_'s rotation_, which has been pre-set in global.tile_angles
		rotation_ = (global.tile_angles[tile_index_]);

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
		} else {
			rotation_ = snap_to_90(_dir);
		}
		_info.side = noone;
		_info.inst = noone;

	} else if (_inst.object_index == obj_collision_tile){ //Instance Tiles (tiles that are turned into objects)
		rotation_ = (global.tile_angles[_inst.image_index]);
		if(rotation_ != 360){
			//image_angle is 0 or -90 (see obj_tiles_area's Create_0), flagging
			//whether the source tile was rotated - same role as tile_get_rotate above
			if (_inst.image_angle != 0){
				rotation_ = rotation_ - 90;
				if (_inst.image_xscale != 1) rotation_ = -(rotation_+180);
				if (_inst.image_yscale != 1) rotation_ = -rotation_;
			} else {
				if (_inst.image_xscale != 1) rotation_ = -rotation_;
				if (_inst.image_yscale != 1) rotation_ = -(rotation_+180);
			}
		} else {
			rotation_ = snap_to_90(_dir);
		}
		_info.side = noone;

	} else { //Instance collision
		//uses the final backed-off sensor position (_info.vec_sensor_), not the
		//touching point passed in as _x/_y - right at/inside the boundary is
		//ambiguous for find_side near corners
		var side_x_ = x + _info.vec_sensor_.x;
		var side_y_ = y + _info.vec_sensor_.y;
		//unrounded - find_side compares against a bbox center that's often
		//fractional too (odd sprite dimensions), rounding first only adds
		//error right at the corner boundary where this is already close
		switch (find_side(side_x_,side_y_,_inst)) {
			case SIDES.BOTTOM:
				rotation_ = 180;
				_info.side = SIDES.BOTTOM
				break
			case SIDES.LEFT:
				rotation_ = 90;
				_info.side = SIDES.LEFT
				break
			case SIDES.RIGHT:
				rotation_ = 270;
				_info.side = SIDES.RIGHT
				break
			case SIDES.TOP:
				rotation_ = 0;
				_info.side = SIDES.TOP
				break
		}
		rotation_ += _inst.image_angle;
	}
	
	//ensures the rotation_ is a positive number
	if(rotation_ < 0) rotation_ += 360;
	else if (rotation_ > 360) rotation_ -= 360;
	_info.angle = rotation_;
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
/// ///TODO maybe with new parenting system this is not neccesary??
function add_collision_child(_x_offset,_y_offset,_width,_height,_oneway = false){
	var child_ = instance_create_depth(x+_x_offset,y+_y_offset,global.depth[COLLISION_LAYERS.A],obj_collision_activate);
	child_.image_xscale = _width  / sprite_get_width(spr_collision);
	child_.image_yscale = _height / sprite_get_height(spr_collision);
	child_.x_offset = _x_offset;
	child_.y_offset = _y_offset;
	child_.parent = self;	
		
	return child_;
}

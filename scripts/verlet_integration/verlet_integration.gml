///@function verlet(x_,y_, _mass, _fixed)
function verlet(_x,_y, _mass = 1, _fixed = false) constructor {
	//Written by STANN.co
	//credit appreciated
	
	x = _x;
	y = _y;
	x_prev = x;
	y_prev = y;
	fixed = _fixed;
	mass = _mass;
	
	///@description should be ran in step before any other forces
	///@param drag 0 - 1 dampens movement over time
	static update = function(_drag = 0.01){
		
		var x_vel = (x - x_prev);
		var y_vel = (y - y_prev);
		
		x_prev = x;
		y_prev = y;
		
		x_vel -= x_vel * _drag;
		y_vel -= y_vel * _drag;
		
		//applies force
		x+= x_vel;
		y+= y_vel;
	}
	
	///@description adds a force
	static force = function(_force_x, _force_y){
		if(!fixed){
			x+= _force_x / mass;
			y+= _force_y / mass;
		}
	}
	
	///@description add gravity in a specific direction
	static gravity_force = function(_dir = -90, _force = 0.09807){
		if(!fixed){
			x += lengthdir_x(_force,_dir);
			y += lengthdir_y(_force,_dir);
		}
	}
	
	static set_pos = function(_target_x,_target_y){
		x = _target_x;
		y = _target_y;
	}
	
	static set_pos_fixed = function(_target_x,_target_y){
		x = _target_x;
		y = _target_y;
		x_prev = x;
		y_prev = y;
	}
	
	///@desription a spring implementation aiming for a target, with a stiffness
	///@param target_x
	///@param target_y
	///@param stiffness 0 - 1
	///@param mass
	static spring = function(_target_x,_target_y,_stiffness){
		
		if(!fixed){
			var dist = point_distance(x,y,_target_x,_target_y);
			var dir = point_direction(x,y,_target_x,_target_y);
			
			x += (lengthdir_x(dist,dir) * _stiffness) / mass;
			y += (lengthdir_y(dist,dir) * _stiffness) / mass;
		}
	}
	
	static draw = function(_radius = 1,_x = 0,_y = 0){
		draw_circle(_x+x,_y+y,_radius,0);
	}
	
	static draw_velocity = function(_multiply = 1){
		
		var dist_ = point_distance(x,y,x_prev,y_prev);
		var dir_ = point_direction(x,y,x_prev,y_prev);
		
		var x_ = x + lengthdir_x(-dist_*_multiply,dir_);
		var y_ = y + lengthdir_y(-dist_*_multiply,dir_);
		
		var val_ = min(1,dist_ / 10) * 255;
		
		var color_ = make_color_rgb(val_,255-val_,0);
		var color_prev_ = draw_get_color();
		draw_set_color(color_);
		draw_line(x,y,x_,y_);	
		draw_set_color(color_prev_);
	}
}
	
///@param 1st point
///@param 2nd point
///@param dist by default dist between points
///@param dir by default dir between points
function verlet_line(_p1,_p2,_dist = point_distance(_p1.x,_p1.y,_p2.x,_p2.y), _dir = point_direction(_p1.x,_p1.y,_p2.x,_p2.y) ) constructor {
	p1 = _p1;
	p2 = _p2;
	dist = _dist;
	
	static constrain_length = function(_substeps = 1){
		repeat(_substeps){
			//moves both points to maintain the targeted distance
			var _dist = max(0,point_distance(p1.x,p1.y,p2.x,p2.y) - dist) / 2;
			var _dir  = point_direction(p1.x,p1.y,p2.x,p2.y);		
			
			if(!p1.fixed){
				p1.x += lengthdir_x(_dist,_dir) / p1.mass;
				p1.y += lengthdir_y(_dist,_dir) / p1.mass;
			}
			
			if(!p2.fixed){
				p2.x -= lengthdir_x(_dist,_dir) / p2.mass;
				p2.y -= lengthdir_y(_dist,_dir) / p2.mass;
			}
		}
	}
	
	static get_direction = function(){
		return point_direction(p1.x,p1.y,p2.x,p2.y);
	}
	
	static set_direction = function(_dir_target){
		if(!p2.fixed){
			
			//var dist_ = point_distance(p1.x,p1.y,p2.x,p2.y);
			var dir_current_ = point_direction(p1.x,p1.y,p2.x,p2.y);
			
			var diff = angle_difference(dir_current_,_dir_target) / p2.mass;
			
			var force = dist * degtorad(diff);
			
			p2.x = p1.x + lengthdir_x(dist,dir_current_-diff);
			p2.y = p1.y + lengthdir_y(dist,dir_current_-diff);
			
			//p2.x_prev = p2.x + lengthdir_x(force,_dir_target+90);
			//p2.y_prev = p2.y + lengthdir_y(force,_dir_target+90);
		}
	}
	
	static set_pos = function(_target_x,_target_y){
		var x_ = lerp(p1.x,p2.x,0.5);
		var y_ = lerp(p1.y,p2.y,0.5);
		
		var offset_x_ = _target_x - x_;
		var offset_y_ = _target_y - y_;
		
		p1.x += offset_x_;
		p1.y += offset_y_;
		p2.x += offset_x_;
		p2.y += offset_y_;
	}
	
	static draw = function(_x = 0, _y = 0){
		draw_line(p1.x+_x,p1.y+_y,p2.x+_x,p2.y+_y);	
	}
}



function verlet_rope(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) constructor {
	segment_num = _segment_num;
	substeps = _substeps;
	points = array_create(segment_num+1);
	segments = array_create(segment_num);

	//creates verlet points
	for (var i = 0; i <= segment_num; ++i) {
		var val_ = i / segment_num;
		var x_ = lerp(_start_x,_end_x,val_);
		var y_ = lerp(_start_y,_end_y,val_);
	    points[i] = new verlet(x_,y_);
	}
	
	//creates rope segments
	for (var i = 0; i < segment_num; ++i) {
		var p1_ = points[i];
		var p2_ = points[i+1];
		segments[i] = new verlet_line(p1_,p2_);
	}
	
	//methods	
	static update = function(_drag = 0.01){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].update(_drag);
		}
		
		for (var i = 0; i < segment_num; ++i) {
			segments[i].constrain_length(substeps);
		}
	}
	
	//imagine a rope dangling inside a train, even though the train is moving really fast, the rope wouldn't be stuck to the ceiling
	//you can move the rope with the train with a certain amount
	static move_relative = function(_x,_y,_relative_amount = 1){
		var old_x = get_first_point().x;
		var old_y = get_first_point().y;
		
		var offset_x = _x - old_x;
		var offset_y = _y - old_y;
		
		for (var i = 0; i <= segment_num; ++i) {
		    var p = points[i];
			
			p.x += offset_x * _relative_amount;
			p.y += offset_y * _relative_amount;
			p.x_prev += offset_x * _relative_amount;
			p.y_prev += offset_y * _relative_amount;
		}
		
	}
	
	static attach_start = function(_verlet){
		points[0] = _verlet;
		segments[0].p1 = _verlet;
	}
	
	static gravity_force = function(_dir = -90, _force = 0.09807){
		for (var i = 0; i <= segment_num; ++i) {
			if(!points[i].fixed) points[i].gravity_force(_dir,_force);
		}	
	}
	
	static get_first_point = function(){
		return points[0];
	}
	
	static get_last_point = function(){
		return points[segment_num];
	}
	
	static set_position = function(_start_x,_start_y,_end_x,_end_y){
		for (var i = 0; i <= segment_num; ++i) {
			var p = points[i];
			var v = i / segment_num
			p.x = lerp(_start_x,_end_x,v);
			p.y = lerp(_start_y,_end_y,v);
		}
	}
	
	static draw = function(_x = 0,_y = 0){
		for (var i = 0; i < segment_num; ++i) {
			segments[i].draw(_x,_y);
		}	
	}
	
	static draw_points = function(){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].draw(2);
		}	
	}
	
	static draw_velocity = function(_multiply = 1){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].draw_velocity(_multiply);
		}	
	}
}

function verlet_rod(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) : verlet_rope(_start_x,_start_y,_end_x,_end_y,_segment_num, _substeps) constructor {
	segment_num = _segment_num;
	substeps = _substeps;
	dir = point_direction(_start_x,_start_y,_end_x,_end_y);
	
	//methods	
	static update = function(_drag = 0.01, _stiffness = 0.9){
		
		for (var i = 0; i <= segment_num; ++i) {
			points[i].update((_drag));
		}
		
		for (var i = segment_num-1; i >= 0; --i) {
			segments[i].constrain_length(substeps);
		}
		
		repeat(substeps){
			
			//for each segment sets it's direction to be halfway between next and previous segment's rotation
			//first segment is set to dir
			
			for (var i = 0; i < segment_num; ++i) {
				var segment = segments[i];
				var dir_ = segment.get_direction();
				var dir_prev_ = dir_;
				var dir_next_ = dir_;
				var dir_target_ = dir_;
				
				if(i == 0){
					segment.set_direction(dir)
					
				} else {
					if(i > 0){
						dir_prev_ = segments[i-1].get_direction();
					}
					
					if(i < segment_num-1){
						dir_next_ = segments[i+1].get_direction();
					}
					
					dir_target_ -= ((angle_difference(dir_,dir_prev_) / 2) * _stiffness) / 1;
					dir_target_ -= ((angle_difference(dir_,dir_next_) / 2) * _stiffness) / 1;
					segment.set_direction(dir_target_);
				}
			}
		}
	}
}



///@function verlet(_x,_y, _mass, _fixed)
function Verlet(_x,_y, _mass = 1, _fixed = false) constructor {
	//Written by STANN.co
	//credit appreciated
	
	x = _x;
	y = _y;
	x_prev = x;
	y_prev = y;
	fixed = _fixed;
	mass = _mass;
    
    __still_count = 10;
	
	///@description should be ran in step before any other forces
	///@param drag 0 - 1 dampens movement over time
	///@function updaate(_drag)
	static update = function(_drag = 0.01){
		
		var x_vel_ = (x - x_prev);
		var y_vel_ = (y - y_prev);
		
		x_prev = x;
		y_prev = y;
		
		x_vel_ -= x_vel_ * _drag;
		y_vel_ -= y_vel_ * _drag;
		
		//applies force_
		x+= x_vel_;
		y+= y_vel_;
	}
	
	///@description adds a force_
	static force_ = function(_force_x, _force_y){
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
    
	///@description check if point is mostly still_
	static is_still = function(){
		var x_vel_ = (x - x_prev);
		var y_vel_ = (y - y_prev);
		var threshold_ = 0.02;
		var still_ = (abs(x_vel_) <= threshold_) && (abs(y_vel_) <= threshold_)
		
		//must remain still_ for a few frames, to account for velocity being 0 when swinging
		if(still_){
			if(__still_count > 0) __still_count--;
			else return true;
		} else __still_count = 10;
		
		return false;
			
	}
	
	///@description a spring implementation aiming for a target, with a stiffness
	///@param target_x
	///@param target_y
	///@param stiffness 0 - 1
	///@param mass
	static spring = function(_target_x,_target_y,_stiffness){
		
		if(!fixed){
			var dist_ = point_distance(x,y,_target_x,_target_y);
			var dir_ = point_direction(x,y,_target_x,_target_y);
			
			x += (lengthdir_x(dist_,dir_) * _stiffness) / mass;
			y += (lengthdir_y(dist_,dir_) * _stiffness) / mass;
		}
	}
	
    ///@description draw points
	static draw = function(_radius = 1,_x = 0,_y = 0){
		draw_circle(_x+x,_y+y,_radius,0);
	}
	
    ///@description draw velocity vectors
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

///@description binds a line between two verlet points
///@param 1st point
///@param 2nd point
///@param dist by default dist between points
///@param dir by default dir between points
function VerletLine(_p1,_p2,_dist = point_distance(_p1.x,_p1.y,_p2.x,_p2.y), _dir = point_direction(_p1.x,_p1.y,_p2.x,_p2.y) ) constructor {
	p1 = _p1;
	p2 = _p2;
	dist = _dist;
	
	static constrain_length = function(_substeps = 1){
		repeat(_substeps){
			//moves both points to maintain the targeted distance
			var dist_ = max(0,point_distance(p1.x,p1.y,p2.x,p2.y) - dist) / 2;
			var dir_  = point_direction(p1.x,p1.y,p2.x,p2.y);		
			
			if(!p1.fixed){
				p1.x += lengthdir_x(dist_,dir_) / p1.mass;
				p1.y += lengthdir_y(dist_,dir_) / p1.mass;
			}
			
			if(!p2.fixed){
				p2.x -= lengthdir_x(dist_,dir_) / p2.mass;
				p2.y -= lengthdir_y(dist_,dir_) / p2.mass;
			}
		}
	}
	
	static get_direction = function(){
		return point_direction(p1.x,p1.y,p2.x,p2.y);
	}
	
	static set_direction = function(_dir_target){
		if(!p2.fixed){
			
			var dir_current_ = point_direction(p1.x,p1.y,p2.x,p2.y);
			
			var diff_ = angle_difference(dir_current_,_dir_target) / p2.mass;
			
			var force_ = dist * degtorad(diff_);
			
			p2.x = p1.x + lengthdir_x(dist,dir_current_-diff_);
			p2.y = p1.y + lengthdir_y(dist,dir_current_-diff_);
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

function verlet_rope(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) {
	var points_ = array_create(_segment_num+1);

	//creates verlet points
	for (var i_ = 0; i_ <= _segment_num; ++i_) {
		var val_ = i_ / _segment_num;
		var x_ = lerp(_start_x,_end_x,val_);
		var y_ = lerp(_start_y,_end_y,val_);
	    points_[i_] = new Verlet(x_,y_);
	}
	
	return new VerletRopePoints(points_,_substeps)
}

//define rope points manually
function VerletRopePoints(_points, _substeps = 10) constructor { //figure out better way to do these typa functions with inheritance
	substeps = _substeps;
	points = _points;
	segment_num = array_length(points)-1;
	segments = array_create(segment_num);
	
	//creates rope segments
	for (var i_ = 0; i_ < segment_num; ++i_) {
		var p1_ = points[i_];
		var p2_ = points[i_+1];
		segments[i_] = new VerletLine(p1_,p2_);
	}
	
	//methods	
	static update = function(_drag = 0.01){
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			points[i_].update(_drag);
		}
		
		for (var i_ = 0; i_ < segment_num; ++i_) {
			segments[i_].constrain_length(substeps);
		}
	}
    
	static is_still = function(){
		var still_ = true;
		for (var i_ = 0; i_ < array_length(points); ++i_) {
		    var p_ = points[i_];
			if(p_.is_still() == false){
				still_ = false
				break;
			}
		}
		return still_;
	}
	
	//imagine a rope dangling inside a train, even though the train is moving really fast, the rope wouldn't be stuck to the ceiling
	//you can move the rope with the train with a certain amount
	static move_relative = function(_x,_y,_relative_amount = 1){
		var old_x_ = get_first_point().x;
		var old_y_ = get_first_point().y;
		
		var offset_x_ = _x - old_x_;
		var offset_y_ = _y - old_y_;
		
		for (var i_ = 0; i_ <= segment_num; ++i_) {
		    var p_ = points[i_];
			
			p_.x += offset_x_ * _relative_amount;
			p_.y += offset_y_ * _relative_amount;
			p_.x_prev += offset_x_ * _relative_amount;
			p_.y_prev += offset_y_ * _relative_amount;
		}
		
	}
	
	static attach_start = function(_verlet){
		points[0] = _verlet;
		segments[0].p1 = _verlet;
	}
	
	static gravity_force = function(_dir = -90, _force = 0.09807){
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			if(!points[i_].fixed) points[i_].gravity_force(_dir,_force);
		}	
	}
	
	static get_first_point = function(){
		return points[0];
	}
	
	static get_last_point = function(){
		return points[segment_num];
	}
	
	static set_position = function(_start_x,_start_y,_end_x,_end_y){
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			var p_ = points[i_];
			var v_ = i_ / segment_num
			p_.x = lerp(_start_x,_end_x,v_);
			p_.y = lerp(_start_y,_end_y,v_);
		}
	}
	
	static draw = function(_x = 0,_y = 0){
		for (var i_ = 0; i_ < segment_num; ++i_) {
			segments[i_].draw(_x,_y);
		}	
	}
	
	static draw_points = function(){
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			points[i_].draw(2);
		}	
	}
	
	static draw_velocity = function(_multiply = 1){
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			points[i_].draw_velocity(_multiply);
		}	
	}
}

function VerletRod(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) constructor {
	var points_ = array_create(_segment_num+1);

	//creates verlet points
	for (var i_ = 0; i_ <= _segment_num; ++i_) {
		var val_ = i_ / _segment_num;
		var x_ = lerp(_start_x,_end_x,val_);
		var y_ = lerp(_start_y,_end_y,val_);
	    points_[i_] = new Verlet(x_,y_);
	}
	
	return new VerletRodPoints(points_,_substeps)
}

function VerletRodPoints(_points, _substeps = 10) : VerletRopePoints(_points, _substeps) constructor {
	dir = point_direction(points[0].x,points[0].y,points[1].x,points[1].y);
	
	//methods	
	static update = function(_drag = 0.01, _stiffness = 0.9){
		
		for (var i_ = 0; i_ <= segment_num; ++i_) {
			points[i_].update((_drag));
		}
		
		for (var i_ = segment_num-1; i_ >= 0; --i_) {
			segments[i_].constrain_length(substeps);
		}
		
		repeat(substeps){
			
			//for each segment_ sets it's direction to be halfway between next and previous segment_'s rotation
			//first segment_ is set to dir
			
			for (var i_ = 0; i_ < segment_num; ++i_) {
				var segment_ = segments[i_];
				var dir_ = segment_.get_direction();
				var dir_prev_ = dir_;
				var dir_next_ = dir_;
				var dir_target_ = dir_;
				
				if(i_ == 0){
					segment_.set_direction(dir)
					
				} else {
					if(i_ > 0){
						dir_prev_ = segments[i_-1].get_direction();
					}
					
					if(i_ < segment_num-1){
						dir_next_ = segments[i_+1].get_direction();
					}
					
					dir_target_ -= ((angle_difference(dir_,dir_prev_) / 2) * _stiffness) / 1;
					dir_target_ -= ((angle_difference(dir_,dir_next_) / 2) * _stiffness) / 1;
					segment_.set_direction(dir_target_);
				}
			}
		}
	}
    
    static is_still = function(){
		var still_ = true;
		for (var i_ = 0; i_ < array_length(points); ++i_) {
		    var p_ = points[i_];
			if(p_.is_still() == false){
				still_ = false
				break;
			}
		}
		return still_;
	}
}



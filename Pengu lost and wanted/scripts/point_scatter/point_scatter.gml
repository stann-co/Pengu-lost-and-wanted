function point_scatter(_points,_auto_collect = true, _scoring = true){
	var counter_ = 0;
	var angle_ = 184;
	var flip_ = false;
	var spd_ = 6;
	
	
	repeat(_points) {
		//create point_
		var point_ = instance_create_depth(x,y,depth,obj_coin);
		//point_.fired = true;
		point_.xspeed = cos(angle_) * spd_;
		point_.yspeed = -sin(angle_) * spd_;
		point_.scoring = _scoring;
		point_.state.change("physics");
		if(_auto_collect){
			point_.alarm[0] = SECOND*0.25;	
		}
		
		//flips around with every ring
		if(flip_){
			point_.xspeed = point_.xspeed * -1;
			angle_ += 240;
		}
		
		//toggles flip_
		flip_ = !flip_;
		
		//increment counter_
		counter_++;
		
		//if halfway start second circle with lower speed
		if(counter_ == 16){
			spd_ = 4;
			angle_ = 184; //reset the angle_
		}
	}
	
}
function point_scatter(points,auto_collect = true, scoring = true){
	var counter = 0;
	var angle = 184;
	var flip = false;
	var spd = 6;
	
	
	repeat(points) {
		//create point
		var point = instance_create_depth(x,y,depth,obj_coin);
		//point.fired = true;
		point.xspeed = cos(angle) * spd;
		point.yspeed = -sin(angle) * spd;
		point.scoring = scoring;
		point.state.change("physics");
		if(auto_collect){
			point.alarm[0] = game_speed*0.25;	
		}
		
		//flips around with every ring
		if(flip){
			point.xspeed = point.xspeed * -1;
			angle += 240;
		}
		
		//toggles flip
		flip = !flip;
		
		//increment counter
		counter++;
		
		//if halfway start second circle with lower speed
		if(counter == 16){
			spd = 4;
			angle = 184; //reset the angle
		}
	}
	
}
/// @description

// Inherit the parent event
event_inherited();

if(main_pole){
	seat = instance_create_depth(point1.x,point1.y,depth,obj_skilift_seat);
	seat.pole = self;
	
	seat.point1 = point1;
	seat.point2 = point2;
	
	seat.duration = seat_duration;
	
	activation_link(id,other_pole.id,seat.id);
}


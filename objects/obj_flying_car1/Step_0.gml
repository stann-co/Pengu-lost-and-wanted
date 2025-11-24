/// @description
if(CAN_MOVE){

phys.update(0);
phys.spring(xstart,ystart,0.1);

last_x = x;
last_y = y;

x = phys.x;
y = phys.y;

if(standing_on){
	var x_dist = x - obj_pengu.x;
	var new_angle = x_dist / 10;

	image_angle = new_angle;

} else image_angle = 0;


//child.move_to_parent();
}
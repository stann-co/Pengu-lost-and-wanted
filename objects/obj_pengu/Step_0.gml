/// @description

//input

var input_h = (input_check("right") - input_check("left")) * 2;

ground_spd = input_h; 

hspd = ground_spd;

x += hspd;

//right
vec_r = new Vector2(w_radius,0);
//left
vec_l = new Vector2(-w_radius,0);

//bottom
vec_b = new Vector2(0,h_radius);
//top
vec_t = new Vector2(0,-h_radius);

//bottom left
vec_bl = vec_b.add(vec_l);
//bottom right
vec_br = vec_b.add(vec_r);

//floor collision check
if(bl_collide() || br_collide()) { //if colliding push up from ground
	var vec_push = new Vector2(0,-1);
	vec_push = vec_push.rotated(ground_angle);	
	do{
		x += vec_push.x;
		y += vec_push.y;
	} until(!bl_collide() && !br_collide());

} else if(!bl_collide() && !br_collide()){ //if not colliding push down to meet ground
	var vec_push = new Vector2(0,1);
	vec_push = vec_push.rotated(ground_angle);	

	do{ //goes down until there's collision, then pushes up again one pixel
		x += vec_push.x;
		y += vec_push.y;
	} until(bl_collide() || br_collide());
	x -= vec_push.x;
	y -= vec_push.y;
}
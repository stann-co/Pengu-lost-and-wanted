/// @description
dir = 0;

t = 0
launch_speed = 0;
duration = game_speed*2;

grabbed_on = false;

springing = false;

ball_vec = new Vector2(0,0);

trigger = function(){
	if(!springing){
		with(obj_pengu){
			state.change("spring_ball");
			other.dir = point_direction(0,0,x_speed,y_speed);
			
			other.launch_speed = max(other.minimum_speed,point_distance(0,0,x_speed,y_speed));
			
			image_angle = other.dir+90;
		}
		
		grabbed_on = true;
		springing = true;
	}
}







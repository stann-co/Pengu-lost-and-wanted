/// @description
duration = duration_seconds * game_speed;
pause_duration = pause_duration_seconds * game_speed;
offset_duration = offset_duration_seconds * game_speed;

t = global.t + offset_duration mod duration;
t_pause = 0;
t_offset = 0;

start_rotation = image_angle;

rotation = image_angle;

start_rot_ =  start_rotation;
end_rot_ = end_rotation;

start_x_ = x;
start_y_ = y;

if(info_target != -1){
	end_x_ = info_target.x;
	end_y_ = info_target.y;
}

forward = true;

last_x = x;
last_y = y;
last_rot = image_angle;

x_change = 0;
y_change = 0;
rot_change = 0;
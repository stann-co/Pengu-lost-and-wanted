/// @description

draw_circle(x,y,5,false);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

var cam_ = global.camera.cam_id;

var cam_x_ = global.game_w/2	+ global.camera.get_x();
var cam_y_ =	-(global.game_h/2 + global.camera.get_y());

var view_mat_ = camera_get_view_mat(cam_);
var proj_mat_ = camera_get_proj_mat(cam_);

show_debug_message($"{ global.camera.x},{ global.camera.y}")
camera_set_view_mat(cam_, matrix_build_lookat(cam_x_,-100, cam_y_,cam_x_,0,cam_y_, 0, 0, -1));

//camera_set_proj_mat(cam_, matrix_build_projection_perspective_fov(20, global.game_w / global.game_h, 1, 32000));

camera_set_proj_mat(cam_, matrix_build_projection_ortho(global.game_w,global.game_h,1,32000));

camera_apply(cam_);


//draw_clear(WHITE)
shader_set(sh_3d_deprecated)

matrix_set(matrix_world,matrix_build_identity());

shader_set_uniform_f(u_light_pos,10,-10,0);
shader_set_uniform_f(u_camera_pos,0,-10,0);
shader_set_uniform_f(u_refraction,1.0/1.33);
shader_set_uniform_f(u_matcapblend,0.0);

var tex_ = sprite_get_texture(spr_matcap_bubble,0);
texture_set_stage(s_matcap,tex_);

shader_set_uniform_matrix(u_transform)

matrix_set(matrix_world,matrix_build(x,0,-y,0,0,rot,1,1,1));

vertex_submit(kat_smart.vbuff, pr_trianglelist, -1);

matrix_set(matrix_world,matrix_build_identity());
rot++

shader_reset()

camera_set_view_mat(cam_, view_mat_);
camera_set_proj_mat(cam_, proj_mat_);
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);

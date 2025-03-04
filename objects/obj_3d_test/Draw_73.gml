/// @description

draw_circle(x,y,5,false);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

var cam = global.camera.cam_id;

var cam_x = global.game_w/2	+ global.camera.get_x();
var cam_y =	-(global.game_h/2 + global.camera.get_y());

var view_mat = camera_get_view_mat(cam);
var proj_mat = camera_get_proj_mat(cam);

show_debug_message($"{ global.camera.x},{ global.camera.y}")
camera_set_view_mat(cam, matrix_build_lookat(cam_x,-100, cam_y,cam_x,0,cam_y, 0, 0, -1));

//camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(20, global.game_w / global.game_h, 1, 32000));

camera_set_proj_mat(cam, matrix_build_projection_ortho(global.game_w,global.game_h,1,32000));

camera_apply(cam);


//draw_clear(white)
shader_set(sh_3d_deprecated)

matrix_set(matrix_world,matrix_build_identity());

shader_set_uniform_f(u_light_pos,10,-10,0);
shader_set_uniform_f(u_camera_pos,0,-10,0);
shader_set_uniform_f(u_refraction,1.0/1.33);
shader_set_uniform_f(u_matcapblend,0.0);

var tex = sprite_get_texture(spr_matcap_bubble,0);
texture_set_stage(s_matcap,tex);

shader_set_uniform_matrix(u_transform)

matrix_set(matrix_world,matrix_build(x,0,-y,0,0,rot,1,1,1));

vertex_submit(kat_smart.vbuff, pr_trianglelist, -1);

matrix_set(matrix_world,matrix_build_identity());
rot++

shader_reset()

camera_set_view_mat(cam, view_mat);
camera_set_proj_mat(cam, proj_mat);
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);

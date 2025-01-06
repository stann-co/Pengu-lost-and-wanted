/// @description

var camera = camera_get_active();
camera_set_view_mat(camera, matrix_build_lookat(0, -60, 10, 0,0,0 , 0, 0, -1));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(50, window_get_width() / window_get_height(), 1, 32000));

//camera_set_proj_mat(camera, matrix_build_projection_ortho(window_get_width(),window_get_height(),1,32000));

camera_apply(camera);

draw_clear(white)
shader_set(sh_3d)




var anim = gachapon_top.animations[0];
matrix_set(matrix_world,anim.get(t / game_speed));
shader_set_uniform_matrix(u_transform)
matrix_set(matrix_world,matrix_build_identity());
matrix_set(matrix_world,matrix_build(0,0,0,0,0,rot,1,1,1));
vertex_submit(gachapon_top.vbuff, pr_trianglelist, -1);

anim = gachapon_bottom.animations[0];
matrix_set(matrix_world,anim.get(t / game_speed));
shader_set_uniform_matrix(u_transform)
matrix_set(matrix_world,matrix_build_identity());
matrix_set(matrix_world,matrix_build(0,0,0,0,0,rot,1,1,1));
vertex_submit(gachapon_bottom.vbuff, pr_trianglelist, -1);

matrix_set(matrix_world,matrix_build_identity());
rot++

//matrix_set(matrix_world,matrix_build(0,0,0,0,rot,rot*0.8,1,1,1));
//rot++;

shader_reset()


t ++;
t = t mod (anim.duration * game_speed);
/// @description


                                     
var camx = global.camera.get_x();   
var camy = global.camera.get_y();

var _tileset = tilemap_get_tileset(tilemap);
var tileset_name = tileset_get_name(_tileset);
var uvs = tileset_get_uvs(_tileset)

var margin = 16;

if(!surface_exists(srf_rgba)){
    srf_rgba = surface_create(global.game_w+margin*2,global.game_h+margin*2);
}
surface_set_target(srf_rgba);
draw_clear_alpha(black,0);

draw_tilemap(tilemap,-camx+margin,-camy+margin);

surface_reset_target();

if(!surface_exists(srf_xyrd)){
    srf_xyrd = surface_create(global.game_w+margin*2,global.game_h+margin*2);
}
surface_set_target(srf_xyrd);



draw_clear_alpha(black,0);
shader_set(sh_tilemap_channels);

#region get normal roughness depth coord offsets
//gets normal sprite coordinate offset
var _tileset_n = asset_get_index(tileset_name+"_n");
if(_tileset_n != -1){
	var uvs_n = tileset_get_uvs(_tileset_n)
	shader_set_uniform_f(u_texcoord_n,uvs[0]-uvs_n[0],uvs[1]-uvs_n[1]);
} else shader_set_uniform_f(u_texcoord_n,-1);

//gets normal sprite coordinate offset
var _tileset_r = asset_get_index(tileset_name+"_r");
if(_tileset_r != -1){
	var uvs_r = tileset_get_uvs(_tileset_r)
	shader_set_uniform_f(u_texcoord_r,uvs[0]-uvs_r[0],uvs[1]-uvs_r[1]);
} else shader_set_uniform_f(u_texcoord_r,-1);

//gets depth sprite coordinate offset
var _tileset_d = asset_get_index(tileset_name+"_d");
if(_tileset_d != -1){
	var uvs_d = tileset_get_uvs(_tileset_d)
	shader_set_uniform_f(u_texcoord_d,uvs[0]-uvs_d[0],uvs[1]-uvs_d[1]);
} else shader_set_uniform_f(u_texcoord_d,-1);
#endregion

gpu_set_texfilter(true);

gpu_set_blendmode_ext(bm_one,bm_zero);
draw_tilemap(tilemap,-camx+margin,-camy+margin);


gpu_set_texfilter(false);


shader_reset();
surface_reset_target();

gpu_set_blendmode(bm_normal);

shader_set(sh_tilemap_fx);

var fx_tex = surface_get_texture(srf_xyrd);
texture_set_stage(s_tilemap_fx,fx_tex);

shader_set_uniform_f(u_depth,depth_);
shader_set_uniform_f(u_offset,offset_);
shader_set_uniform_f(u_offset2,offset2_);
shader_set_uniform_f(u_cam_offset,camx-margin,camy-margin);

draw_surface(srf_rgba,camx-margin,camy-margin);
show_debug_message(camx)

shader_reset();


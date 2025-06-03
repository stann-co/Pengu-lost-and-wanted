/// @description


                                     
var camx = global.camera.get_x();   
var camy = global.camera.get_y();

var _tileset = tilemap_get_tileset(tilemap);
var tileset_name = tileset_get_name(_tileset);
var uvs = tileset_get_uvs(_tileset)

var margin = 16;

#region diffuse surface
if(!surface_exists(srf_diffuse)){
    srf_diffuse = surface_create(global.game_w+margin*2,global.game_h+margin*2);
}
surface_set_target(srf_diffuse);
draw_clear_alpha(black,0);

draw_tilemap(tilemap,-camx+margin,-camy+margin);

surface_reset_target();

#endregion

#region get normal roughness depth coord offsets

if(!surface_exists(srf_maps)){
    srf_maps = surface_create(global.game_w+margin*2,global.game_h+margin*2);
}
surface_set_target(srf_maps);

draw_clear_alpha(black,0);

shader_set(sh_uv_offset);

//gets normal sprite coordinate offset
var _tileset_maps = asset_get_index(tileset_name+"_maps");
if(_tileset_maps != -1){
	var uvs_maps = tileset_get_uvs(_tileset_maps)
	shader_set_uniform_f(u_texcoord_uv,uvs[0]-uvs_maps[0],uvs[1]-uvs_maps[1]);
} else shader_set_uniform_f(u_texcoord_uv,-1);

gpu_set_blendmode_ext(bm_one,bm_zero);

draw_tilemap(tilemap,-camx+margin,-camy+margin);
gpu_set_blendmode(bm_normal);

shader_reset();

surface_reset_target();

#endregion

shader_set(sh_tilemap_fx);

var fx_tex = surface_get_texture(srf_maps);
texture_set_stage(s_tilemap_fx,fx_tex);

var shine_tex = sprite_get_texture(spr_reflection_2,0);

texture_set_stage(s_texture,shine_tex);

shader_set_uniform_f(u_depth,depth_);
shader_set_uniform_f(u_roughness,roughness);
shader_set_uniform_f(u_normal,normal);

shader_set_uniform_f(u_cam_offset,camx-margin,camy-margin);

shader_set_uniform_f(u_texture_offset_scale,texture_offset_scale);
shader_set_uniform_f(u_texture_scale,texture_scale);

draw_surface(srf_diffuse,camx-margin,camy-margin);
show_debug_message(camx)

shader_reset();

